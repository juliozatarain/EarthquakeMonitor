
//  RequestHelper.m

#import "RequestHelper.h"

@implementation RequestHelper
+ (RequestHelper *)sharedHTTPClient
{
    static RequestHelper *_sharedHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    return _sharedHTTPClient;
}
- (NSURLSessionDataTask*) get:(NSString *)path completion:(void (^)(id responseObject))completion failure:(void (^)(NSError * error))failure {
    return [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion)
            completion(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
            failure(error);
    }];
}
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}
@end
