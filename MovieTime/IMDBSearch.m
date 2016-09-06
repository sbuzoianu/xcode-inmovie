//
//  IMDBMovies.m
//  MovieTime
//
//  Created by Buzoianu Stefan on 31/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "IMDBSearch.h"
#import "+IMDBSearchDelegate.h"

#define API_TITLE_PARAMS @"&aka=0&business=0&seasons=0&seasonYear=0&technical=0&filter=2&exactFilter=0&limit=10&forceYear=0&trailers=1&movieTrivia=0&awards=0&moviePhotos=0&movieVideos=0&actors=0&biography=0&uniqueName=0&filmography=0&bornAndDead=0&starSign=0&actorActress=0&actorTrivia=0&similarMovies=0&adultSearch=0&goofs=0&keyword=1&quotes=1&fullSize=0&companyCredits=0";

#define API_IDIMDB_PARAMS @"&aka=0&business=0&seasons=0&seasonYear=0&technical=0&filter=2&exactFilter=0&limit=1&forceYear=0&trailers=0&movieTrivia=0&awards=0&moviePhotos=0&movieVideos=0&actors=1&biography=1&uniqueName=1&filmography=0&bornAndDead=1&starSign=1&actorActress=0&actorTrivia=0&similarMovies=0&adultSearch=0&goofs=0&keyword=0&quotes=0&fullSize=0&companyCredits=0";

@implementation IMDBSearch

- (void)searchDatasByTitle:(NSString *)title
{
    title = [title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString *apiURI = API_URI;
    NSString *apiToken = API_TOKEN;
    NSString *apiParams = API_TITLE_PARAMS;
    
    NSString *uriString = [NSString stringWithFormat:@"%@%@&title=%@&token=%@", apiURI, apiParams, title, apiToken];
    NSURL *url = [NSURL URLWithString:uriString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error)
        {
            if(error)
                [self.delegate fetchingJSONFailedWithError:error];
            else [self.delegate receivedJSONWithData:data];
        }
    ] resume];
}

- (void)loadActorsPropertyByMovie:(IMDBMovieDataModel *)movie
{
    NSString *apiURI = API_URI;
    NSString *apiToken = API_TOKEN;
    NSString *apiParams = API_IDIMDB_PARAMS;
    
    NSString *imdbID = [movie valueForKey:@"idIMDB"];
    
    NSString *uriString = [NSString stringWithFormat:@"%@%@&idIMDB=%@&token=%@", apiURI, apiParams, imdbID, apiToken];
    NSURL *url = [NSURL URLWithString:uriString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if(error)
              [self.delegate fetchingJSONFailedWithError:error];
          else [self.delegate receivedActorsJSONWithData:data forMovie:movie];
      }
    ] resume];
}

@end
