//
//  ArtistDetailViewController.m
//  FavoriteArtists
//
//  Created by Bohdan Tkachenko on 11/30/20.
//

#import "ArtistDetailViewController.h"
#import "Artist.h"
#import "ArtistController.h"

@interface ArtistDetailViewController () <UISearchBarDelegate>

@property (nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) IBOutlet UILabel *artistNameLabel;
@property (nonatomic) IBOutlet UILabel *foundedLabel;
@property (nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation ArtistDetailViewController

@synthesize artistController;

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate = self;
    [self detailMode];
    self.saveButton.enabled = NO;
    self.saveButton.tintColor = UIColor.clearColor;
    [self updateViews];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = searchBar.text;
    if (searchTerm) {
        [ArtistController searchArtistsWithSearchTerm:searchTerm completionHandler:^(Artist *artist, NSError *error) {
            if (!artist) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Results Found"
                                                                               message:@"Oops...No Artists Found by that name"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *button = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:button];
                [self presentViewController:alert animated:YES completion:nil];
            }
            self.artist = artist;
            [self updateViews];
            self.saveButton.enabled = YES;
            self.saveButton.tintColor = UIColor.blueColor;
        }];
    }
}

- (IBAction)saveButton:(id)sender
{
    [self.artistController.artists addObject:self.artist];
    [self.artistController saveToPersistentStore];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateViews {
    if (self.artist) {
        self.title = self.artist.artistName;
        self.artistNameLabel.textColor = UIColor.blackColor;
        self.foundedLabel.textColor = UIColor.blackColor;
        self.artistNameLabel.text = self.artist.artistName;
        if (self.artist.formedYear > 0) {
            self.foundedLabel.text = [NSString stringWithFormat:@"%d", self.artist.formedYear];
        } else {
            self.foundedLabel.text = @"unknown year";
            self.foundedLabel.textColor = UIColor.grayColor;
        }
        self.descriptionTextView.text = self.artist.biography;
    } else {
        self.descriptionTextView.text = @"";
        self.artistNameLabel.textColor = UIColor.grayColor;
        self.foundedLabel.textColor = UIColor.grayColor;
    }
}

- (void)detailMode {
    if (self.artist) {
        self.searchBar.hidden = YES;
    } else {
        self.searchBar.hidden = NO;
    }
}

@end
