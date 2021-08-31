//
//  SearchSuggestionTableViewContrllerTableViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit
import MapKit

class SearchSuggestionTableViewContrller: UITableViewController {
    
    private var searchCompleter: MKLocalSearchCompleter?
    private var searchResults: [MKLocalSearchCompletion]?
    private var currentPlaceMark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.register(SuggestedCompletionTableViewCell.self, forCellReuseIdentifier: SuggestedCompletionTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startProvidingCompletions()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopProvidingCompletions()
    }
    
    private func startProvidingCompletions() {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
    }
}

extension SearchSuggestionTableViewContrller {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCompletionTableViewCell.identifier, for: indexPath) as? SuggestedCompletionTableViewCell else {
            return SuggestedCompletionTableViewCell()
        }
        
        if let suggestion = searchResults?[indexPath.row] {
            cell.textLabel?.text = suggestion.title
            cell.imageView?.image = UIImage(named: "marker.png")
        }
        return cell
    }
}

extension SearchSuggestionTableViewContrller {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults?[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult ?? MKLocalSearchCompletion())
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard error == nil else {
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
        }
        
        // MapViewController에게 위도, 경도 데이터 넘겨줘야 한다.
        // MainSearchSceneFlowCoordinator를 통해 데이터 넘겨주고 MapViewController로 이동?
    }
}

extension SearchSuggestionTableViewContrller: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter?.queryFragment = searchController.searchBar.text ?? ""
    }
}

extension SearchSuggestionTableViewContrller: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
}

private class SuggestedCompletionTableViewCell: UITableViewCell {
    
    static let identifier = "SuggestedCompletionTableViewCellReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
