import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:morror_wall/controllers/browser_controller.dart';
import 'package:morror_wall/utils/widgets/app_widgets.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(onRefresh: () async {
      await Provider.of<BrowserController>(context).webViewController?.reload();
    });
  }

  @override
  void dispose() {
    pullToRefreshController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BrowserController browserControllerR =
        Provider.of<BrowserController>(context);
    BrowserController browserControllerW =
        Provider.of<BrowserController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: (val) {
            final searchText =
                browserControllerW.searchTextController.text.trim();
            // browserControllerW.mainURL = searchText;
            if (searchText.isNotEmpty) {
              browserControllerR.searchMainURL(search: searchText);
              browserControllerW.webViewController?.loadUrl(
                urlRequest: URLRequest(
                  url: WebUri(browserControllerW.mainURL!),
                ),
              );
            } else {
              print('search text is empty ==============');
            }
          },
          controller: browserControllerW.searchTextController,
          decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: IconButton(
                  onPressed: () {
                    final searchText =
                        browserControllerW.searchTextController.text.trim();
                    browserControllerW.mainURL = searchText;
                    if (searchText.isNotEmpty) {
                      browserControllerR.saveSearchHistory(value: searchText);
                      browserControllerW.webViewController?.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri(browserControllerW.mainURL!),
                        ),
                      );
                    } else {
                      print('search text is empty ==============');
                    }
                  },
                  icon: const Icon(Icons.search))),
        ),
        actions: [
          IconButton(
              onPressed: () {
                browserControllerW.webViewController?.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () {
                browserControllerW.webViewController?.reload();
              },
              icon: const Icon(Icons.refresh_rounded)),
          IconButton(
              onPressed: () {
                browserControllerW.webViewController?.goForward();
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        expand: false,
                        builder: (context, scrollController) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.search),
                                    const Text(
                                      ' Search History',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        browserControllerR.clearSearchHistory();
                                        Navigator.pop(context);
                                      },
                                      label: const Text('Clear'),
                                      icon: const Icon(Icons.clear),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                browserControllerW.searchHistory.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: browserControllerW
                                              .searchHistory.length,
                                          itemBuilder: (context, index) {
                                            final historyItem =
                                                browserControllerW
                                                    .searchHistory[index];
                                            return ListTile(
                                              onTap: () {
                                                browserControllerR
                                                    .searchMainURL(
                                                        search: historyItem);
                                                Navigator.pop(context);
                                              },
                                              title: Text(historyItem),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    browserControllerR
                                                        .removeSearchHistory(
                                                            index: index);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete)),
                                            );
                                          },
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "No Any SearchHistory Yet... 😓😓",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.search),
                    Text(
                      'Search History',
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        expand: false,
                        builder: (context, scrollController) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.bookmark_add_outlined),
                                    Text(
                                      ' BookMarks',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                browserControllerW.searchHistory.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: browserControllerW
                                              .bookMark.length,
                                          itemBuilder: (context, index) {
                                            final url = browserControllerW
                                                .bookMark[index];
                                            return GestureDetector(
                                              onTap: () {
                                                print(
                                                    '===========${browserControllerW.bookMark}');
                                                browserControllerW
                                                    .webViewController
                                                    ?.loadUrl(
                                                  urlRequest: URLRequest(
                                                      url: WebUri.uri(
                                                          Uri.parse(url))),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  browserControllerW
                                                      .bookMark[index],
                                                  style: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    browserControllerR
                                                        .removeBookMark(
                                                            index: index);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "No Any Bookmarks Yet... 😓😓",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () async {
                          Uri? uri = await browserControllerW.webViewController
                              ?.getUrl();
                          if (uri != null) {
                            String url = uri.toString();
                            browserControllerW.bookMarkURL = url;
                            if (!browserControllerW.bookMark.contains(url)) {
                              browserControllerR.saveBookMark(url: url);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Bookmark added!")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Bookmark already exists!")),
                              );
                            }
                          } else {
                            print('===== Invalid or null URL');
                          }
                        },
                        child: Icon(browserControllerW.bookMark
                                .contains(browserControllerW.bookMarkURL)
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined)),
                    const Text(
                      "All BookMark",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => popUpMenu(context: context),
                  );
                },
                child: const Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.screen_search_desktop_outlined),
                    Text(
                      'Search Engine',
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Share.shareUri(Uri.parse(browserControllerW.mainURL));
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.share_outlined),
                    Text(
                      'Share',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      browserControllerR.toggleTheme();
                    },
                    child: Icon(
                      browserControllerW.isDark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                  ),
                  const Text('Theme'),
                ],
              ))
            ],
          ),
        ],
      ),
      body: Consumer<BrowserController>(
        builder: (context, provider, child) => InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(provider.mainURL),
          ),
          onLoadStop: (controller, uri) async {
            await pullToRefreshController?.endRefreshing();
          },
          onLoadStart: (controller, url) async {
            // browserControllerW.webViewController = controller;
            await pullToRefreshController?.beginRefreshing();
          },
          onWebViewCreated: (controller) {
            provider.webViewController = controller;
          },
          pullToRefreshController: pullToRefreshController,
        ),
      ),
    );
  }
}
