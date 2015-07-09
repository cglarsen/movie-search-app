//
//  ViewController.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 03/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSSearchViewController.h"
#import <ReactiveCocoa.h>
#import "View+MASAdditions.h"
#import "AFNetworking.h"
#import "MSMovie.h"
#import "MSMovieTableViewCell.h"

@interface MSSearchViewController () <UISearchBarDelegate>
@property (weak, nonatomic) MSSearchViewModel *viewModel;
@property (strong, nonatomic) UITextField *searchTextField;
@property (strong, nonatomic) UIActivityIndicatorView *searchingIndicator;
@end

@implementation MSSearchViewController

- (instancetype)initWithViewModel:(MSSearchViewModel *)viewModel {
    self = [super init];
    if (self ) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup layout
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,40)];
    [self styleTextField:self.searchTextField];
    self.tableView.tableHeaderView = self.searchTextField;
    
    self.searchingIndicator = [[UIActivityIndicatorView alloc] init];
    [self.view addSubview:self.searchingIndicator];
    [self.searchingIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.searchTextField.mas_centerX);
        make.right.equalTo(self.searchTextField.mas_right).with.offset(-5.0);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    
    //Indicate ok lenght
    @weakify(self)
    [[self.searchTextField.rac_textSignal
      map:^id(NSString *text) {
          return [self isValidSearchText:text] ?
          [UIColor whiteColor] : [UIColor yellowColor];
      }]
     subscribeNext:^(UIColor *color) {
         @strongify(self)
         self.searchTextField.backgroundColor = color;

     }];
    
    [self bindingViewModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MSMovieTableViewCell *cell = (MSMovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MSMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   MSMovie *movie = self.viewModel.movies[indexPath.row];
    cell.movieTitleLabel.text = movie.movieTitle;
    
    if (![movie.releaseDateString isKindOfClass:[NSNull class]]){
    if ([movie.releaseDateString length] >= 4)
        cell.yearLabel.text = [NSString stringWithFormat:@"Year: %@", [movie.releaseDateString substringToIndex:4]];
    else
        cell.yearLabel.text = @"Year: ?";
    }
    cell.posterImage.image = nil;
    
    //i might break mvvm here?
    //going trough viewmodel to set table images
    
    [[[self.viewModel signalForLoadingImage:movie.posterImageUrl]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(UIImage *image) {
         cell.posterImage.image = image;
     }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // execute the command
    [self.viewModel.selectedMovieCommand execute:self.viewModel.movies[indexPath.row]];
}

#pragma mark ()

- (void)bindingViewModel {
    //Binding search text
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
    
    //Binding movie search array
    [RACObserve(self.viewModel, movies) subscribeNext:^(NSArray *movies) {
        [self.tableView reloadData];
    }];
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

- (void)styleTextField:(UITextField *)textField {
    CALayer *textFieldLayer = textField.layer;
    textFieldLayer.borderColor = [UIColor grayColor].CGColor;
    textFieldLayer.borderWidth = 1.0f;
    textFieldLayer.cornerRadius = 0.0f;
    textField.placeholder=@"search";
    //fix to add left paddding
    UIView *paddingTxtfieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];// what ever you want
    textField.leftView = paddingTxtfieldView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

@end
