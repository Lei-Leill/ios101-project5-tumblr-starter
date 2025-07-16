//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows for the table.
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure, and return a table view cell for the given row (i.e., `indexPath.row`)
        
        let cell = table_view.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.Label.numberOfLines = 0
        cell.Label.lineBreakMode = .byWordWrapping
        cell.Label.text = post.summary
        
        if let photo = post.photos.first{
            let url = photo.originalSize.url
            NukeExtensions.loadImage(with:url, into:cell.Image_box)
        }
        return cell
    }


    @IBOutlet weak var table_view: UITableView!
    
    private var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        table_view.dataSource = self
        
        fetchPosts()
    }
    



    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in
                    
                    let posts = blog.response.posts
                    self?.posts = posts
                    self?.table_view.reloadData()
                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
