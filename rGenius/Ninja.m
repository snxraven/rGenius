

#import "Ninja.h"

@implementation Ninja

//The designated initializer
- (instancetype)initWithName:(NSString *)aName
         thumbnail:(NSString *)aThumbnail
             photo:(NSString *)aPhoto
       description:(NSString *)aDescription {
    self = [super init];

    if (self) {
        self.name = aName;
        self.thumbnail = aThumbnail;
        self.photo = aPhoto;
        self.desc = aDescription;
    }

    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [self initWithName:dic[@"name"] thumbnail:dic[@"thumbnail"] photo:dic[@"photo"] description:dic[@"description"]];
    return self;
}

- (instancetype)init {
    self = [self initWithName:@"Undifined" thumbnail:@"Undifined" photo:@"Undifined" description:@"Undifined"];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ : %@", self.name, self.description];
}

@end
