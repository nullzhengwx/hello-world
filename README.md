# hello-world
just a hello-world repository
this is my hello-world repository!
this is my first-time to edit for commit;


/**
 * 是否开启API版本控制
 */
@Target(ElementType.TYPE)
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Import(ApiAutoConfiguration.class)
public @interface EnableApiVersion {
}


@Data
public class ApiItem implements Comparable<ApiItem> {
    private int high = 1;
 
    private int mid = 0;
 
    private int low = 0;
 
    public static final ApiItem API_ITEM_DEFAULT = ApiConverter.convert(ApiVersionConstant.DEFAULT_VERSION);
 
    public ApiItem() {
    }
 
    @Override
    public int compareTo(ApiItem right) {
        if (this.getHigh() > right.getHigh()) {
            return 1;
        } else if (this.getHigh() < right.getHigh()) {
            return -1;
        }
 
        if (this.getMid() > right.getMid()) {
            return 1;
        } else if (this.getMid() < right.getMid()) {
            return -1;
        }
        if (this.getLow() > right.getLow()) {
            return 1;
        } else if (this.getLow() < right.getLow()) {
            return -1;
        }
       
        return 0;
    }
 
}
 
                                                  
                                           
public class ApiConverter {
 
    public static ApiItem convert(String api) {
        ApiItem apiItem = new ApiItem();
        if (StringUtils.isBlank(api)) {
            return apiItem;
        }
 
        String[] cells = StringUtils.split(api, ".");
        apiItem.setHigh(Integer.parseInt(cells[0]));
        if (cells.length > 1) {
            apiItem.setMid(Integer.parseInt(cells[1]));
        }
 
        if (cells.length > 2) {
            apiItem.setLow(Integer.parseInt(cells[2]));
        }
        
        return apiItem;
    }
 
}
  
  public interface RequestCondition<T> {
 
 /**
  * 方法和类上都存在相同的条件时的处理方法
  */
 T combine(T other);
 
 /**
  * 判断是否符合当前请求，返回null表示不符合
  */
 @Nullable
 T getMatchingCondition(HttpServletRequest request);
 
 /**
  *如果存在多个符合条件的接口，则会根据这个来排序，然后用集合的第一个元素来处理
  */
 int compareTo(T other, HttpServletRequest request);
  
  
   
@Slf4j
public class ApiCondition implements RequestCondition<ApiCondition> {
 
    public static ApiCondition empty = new ApiCondition(ApiConverter.convert(ApiVersionConstant.DEFAULT_VERSION));
 
    private ApiItem version;
 
    private boolean NULL;
 
    public ApiCondition(ApiItem item) {
        this.version = item;
    }
 
    public ApiCondition(ApiItem item, boolean NULL) {
        this.version = item;
        this.NULL = NULL;
    }
 
    /**
     * <pre>
     *     Spring先扫描方法再扫描类，然后调用{@link #combine}
     *     按照方法上的注解优先级大于类上注解的原则处理，但是要注意如果方法上不定义注解的情况。
     *     如果方法或者类上不定义注解，我们会给一个默认的值{@code empty},{@link ApiHandlerMapping}
     * </pre>
     * @param other 方法扫描封装结果
     * @return
     */
    @Override
    public ApiCondition combine(ApiCondition other) {
        // 选择版本最大的接口
        if (other.NULL) {
            return this;
        }
        return other;
    }
 
    @Override
    public ApiCondition getMatchingCondition(HttpServletRequest request) {
        if (CorsUtils.isPreFlightRequest(request)) {
            return empty;
        }
        String version = request.getHeader(ApiVersionConstant.API_VERSION);
        // 获取所有小于等于版本的接口;如果前端不指定版本号，则默认请求1.0.0版本的接口
        if (StringUtils.isBlank(version)) {
            log.warn("未指定版本，使用默认1.0.0版本。");
            version = ApiVersionConstant.DEFAULT_VERSION;
        }
        ApiItem item = ApiConverter.convert(version);
        if (item.compareTo(ApiItem.API_ITEM_DEFAULT) < 0) {
            throw new IllegalArgumentException(String.format("API版本[%s]错误，最低版本[%s]", version, ApiVersionConstant.DEFAULT_VERSION));
        }
        if (item.compareTo(this.version) >= 0) {
            return this;
        }
        return null;
    }
 
    @Override
    public int compareTo(ApiCondition other, HttpServletRequest request) {
        // 获取到多个符合条件的接口后，会按照这个排序，然后get(0)获取最大版本对应的接口.自定义条件会最后比较
        int compare = other.version.compareTo(this.version);
        if (compare == 0) {
            log.warn("RequestMappingInfo相同，请检查！version:{}", other.version);
        }
        return compare;
    }
 
}
  
   
public class ApiHandlerMapping extends RequestMappingHandlerMapping {
    @Override
    protected RequestCondition<?> getCustomTypeCondition(Class<?> handlerType) {
        return buildFrom(AnnotationUtils.findAnnotation(handlerType, ApiVersion.class));
    }
 
    @Override
    protected RequestCondition<?> getCustomMethodCondition(Method method) {
        return buildFrom(AnnotationUtils.findAnnotation(method, ApiVersion.class));
    }
 
    private ApiCondition buildFrom(ApiVersion platform) {
        return platform == null ? getDefaultCondition() :
                new ApiCondition(ApiConverter.convert(platform.value()));
    }
 
    private ApiCondition getDefaultCondition(){
        return new ApiCondition(ApiConverter.convert(ApiVersionConstant.DEFAULT_VERSION),true);
    }
}

public class ApiAutoConfiguration implements WebMvcRegistrations {
 
    @Override
    public RequestMappingHandlerMapping getRequestMappingHandlerMapping() {
        return new ApiHandlerMapping();
    }
 
}
