//  RequestHelper.h

#import "AFHTTPSessionManager.h"
#import "baseURL.h"

@interface RequestHelper : AFHTTPSessionManager
+ (RequestHelper *)sharedHTTPClient;
/*
 * Ejecuta un request GET al servidor con la URL proporcionada y ejecuta los bloques proporcionados en caso de error o éxito en el rquest.
 *
 * @param url dirección a la que se hace el request
 * @param completion bloque de código que se ejecuta cuando el request es exitoso
 * @param failure bloque de código que se ejecuta cuando el request falla
 *
 * @return NSSURLSessionDataTask se regresa referencia de la task para poder cancelar si hay requests subsecuentes
 */
- (NSURLSessionDataTask*) get:(NSString *)path completion:(void (^)(id responseObject))completion failure:(void (^)(NSError * error))failure;

/*
 * Inicializa una instancia de AFHTTPSessionManager con la url proporcionada
 * @param url la dirección base
 * @param configuration The configuration used to create the managed session.
 */
- (instancetype)initWithBaseURL:(NSURL *)url;
@end