//
//  CycleScrollView.m
//  PagedScrollView
//
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
#import "TAPageControl.h"//自定义页码指示器

@interface CycleScrollView () <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray * contentViews;
@property (nonatomic , strong) NSMutableArray * titleArray;
@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) UILabel * titleLabel;//标题
@property (nonatomic , strong) UIPageControl * pageCtl;//页码指示器
@property (nonatomic , strong) TAPageControl * customPageCtl;//自定义页码指示器

@property (nonatomic , strong) NSTimer * animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        
        //页码指示器个数
        _customPageCtl.numberOfPages=_totalPageCount;
        _pageCtl.numberOfPages=_totalPageCount;
        
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration type:(int)type
{
    self = [self initWithFrame:frame type:type];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame type:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = 0xFF;
        _scrollView.contentMode = UIViewContentModeCenter;
        _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(_scrollView.frame), 0);
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        _currentPageIndex = 0;
        
        
        if (type==0) {
            //创建底条
            int bottomBarHeight=30;
            UIView * bottomBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-bottomBarHeight, self.frame.size.width, bottomBarHeight)];
            bottomBar.alpha = 1;
            bottomBar.backgroundColor = CREATECOLOR(172, 172, 172, 1);
            [self addSubview:bottomBar];
            
            //创建标题
            _titleLabel=[ZCControl createLabelWithFrame:CGRectMake(10, 0, self.frame.size.width-15-100, bottomBarHeight) Font:12 Text:nil];
            _titleLabel.textColor=CREATECOLOR(255, 255, 255, 1);
            [bottomBar addSubview:_titleLabel];
            
            //创建页码指示器
            _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width-100, 0, 100, bottomBarHeight)];
            _pageCtl.userInteractionEnabled = NO;
            [bottomBar addSubview:_pageCtl];
        }
        else if (type==1) {
            //创建页码指示器
            _customPageCtl = [[TAPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
            // Custom dot view with image
            _customPageCtl.dotImage = [UIImage imageNamed:@"dotInactive"];
            _customPageCtl.currentDotImage = [UIImage imageNamed:@"dotActive"];
            [self addSubview:_customPageCtl];
        }
        
        
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView * contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [[NSMutableArray alloc]init];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
    
    
    if (self.titleArray == nil) {
        self.titleArray = [[NSMutableArray alloc]init];
    }
    [self.titleArray removeAllObjects];
    
    if (self.fetchTitleLabelAtIndex) {
        [self.titleArray addObject:self.fetchTitleLabelAtIndex(previousPageIndex)];
        [self.titleArray addObject:self.fetchTitleLabelAtIndex(_currentPageIndex)];
        [self.titleArray addObject:self.fetchTitleLabelAtIndex(rearPageIndex)];
        
        _titleLabel.text=[NSString stringWithFormat:@"%@",self.fetchTitleLabelAtIndex(_currentPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        //NSLog(@"next，当前页:%ld",self.currentPageIndex);
        _customPageCtl.currentPage=self.currentPageIndex;
        _pageCtl.currentPage=self.currentPageIndex;
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        //NSLog(@"previous，当前页:%ld",self.currentPageIndex);
        _customPageCtl.currentPage=self.currentPageIndex;
        _pageCtl.currentPage=self.currentPageIndex;
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
//    CGPoint newOffset = CGPointMake(_scrollView.contentOffset.x + CGRectGetWidth(_scrollView.frame), _scrollView.contentOffset.y);
//    
//    [_scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
