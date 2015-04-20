---
layout: post
title: Self Sizing UICollectionView Cell
categories: code
logo: /assets/img/posts/Dynamic_Size_UICollectionView_Cell_Logo.png
priority: 1
excerpt: <p>A tutorial for creating UICollectionViewCells that are dynamically sized to fit their content.</p>
---
In short:
We're going to see how to configure the UICollectionView objects to allow cells that resize themselves based on their content. See example project and template code at [GitHub](https://github.com/eithanshavit/ContentAwareCollectionCell).

![Example of dynamic size UICollectionViewCell](/assets/img/posts/Dynamic_Size_UICollectionView_Cell_Example.gif)

`UICollectionView` is an extremely powerful class and I find myself using it a lot. Sometimes even just for a simple list, instead of `UITableView`. I'm a big fan of Auto Layout, but for critical views such as reusable cells, I prefer to layout manually (check out [Swift CGRect Extensions](https://github.com/eithanshavit/SwiftCGRectExtensions) for helpful manual layout methods).

Using `UICollectionView` is straightforward when you follow the docs. There is however a topic that is not covered; how to create cells that dictate their own size in a flow layout. This is useful for texts or photos for example, that don't always fit in a predefined rectangle. It's not a very difficult task, but it requires a lot of scaffolding and time.

This is a brief overview of how to achieve that, and a simple example project that can also be used as a template to bootstrap you next `UICollectionView`.

## Approach

When the flow layout calls its `UICollectionViewDelegateFlowLayout` delegate with `collectionView(_:layout:sizeForItemAtIndexPath:)`, we have yet to dequeue a reusable cell, and we can't use the cell's layout to determine the necessary size to return to the flow layout.

We're going to have our `UICollectionViewDataSource` keep a cache of *prototype cells*, one for each reuse identifier we have. When time comes and `UICollectionViewDelegateFlowLayout` is asked for the cell's size, we'll fetch our prototype cell and ask it what size it prefers given the size constraints the flow layout dictates.

## Protocols

There are many ways to implement the data path described above. To maintain consistency across classes and projects I've decided to anchor my preferred method in two protocols. These are of course not necessary, we could create super classes or other mechanisms, but I find protocols helpful with readability and development guidance.

{% highlight swift %}
protocol ContentAwareCollectionViewDataSource {
  func configuredCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell
}

protocol ContentAwareCollectionViewCell {
  func configure(#model: AnyObject, prototype: Bool)
  func fittedSizeForConstrainedSize(constrainedSize: CGSize) -> CGSize
}
{% endhighlight %}

Let's see what each protocol and method does. Three main objects interact to determine each cell's size:

### 1. UICollectionViewDelegateFlowLayout
This guy is being asked by the flow layout to provide the cell's size in `collectionView(_:layout:sizeForItemAtIndexPath:)`. If we configure its data source to implement `ContentAwareCollectionViewDataSource`, then the flow layout delegate (could be your UIViewController) can ask the data source to fetch a configured cell by calling:

{% highlight swift %}
prototypeCell = myDataSource.configuredCellForIndexPath(indexPath, prototype: true)
{% endhighlight %}

Now that we have a prototype cell, all we have to do is ask the cell to decide what size is a best fit based on constraints given by the flow delegate. So for example, if we wanted the cell to figure out its size so that it fits the width of a 1/3rd of the width of its superview (for a grid view with 3 cells in each row) we can call:

{% highlight swift %}
let width = collectionView.bounds.width / 3.0
let height = CGFloat.max
let constrainedSize = CGSize(width: width, height: height)
return cell.fittedSizeForConstrainedSize(constrainedSize)
{% endhighlight %}

And that's basically it for the flow delegate, we've returned the right dynamic size using a cached prototype cell. In practice it's useful to also cache the returned size, so it's not computed every time while the collection view doesn't change. See the example project for a full implementation.

### 2. UICollectionViewDataSource
Other than providing standard data source functionality, by adhering to the `ContentAwareCollectionViewDataSource` protocol, the data source promises to handle everything necessary to provide a configured prototype cell of the right kind given an `NSIndexPath`. Internally it fetches or creates an appropriate cell, and configures it with its model:
{% highlight swift %}
func configuredCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell {
  let cow = dataForIndexPath(indexPath)
  let cell = fetchProtoypeCellForIndexPath(indexPath)
  cell.configure(model: cow, prototype: true)
  return cell
}
{% endhighlight %}


### 3. UICollectionViewCell
Finally we have our cell view. It's playing a crucial role by adopting the `ContentAwareCollectionViewCell` and implementing the two methods:

`configure(#model: AnyObject, prototype: Bool)` is simple, it will configure the cell based on its model. In addition, it's useful to know whether or not this cell is a prototype cell. For a prototype cell, you don't want to draw any unnecessary view, just figure out their size.

`fittedSizeForConstrainedSize(constrainedSize: CGSize) -> CGSize` computes the desired cell based on the cell's layout and the `contrainedSize` coming from the flow layout delegate.


## Example and Template
And we're all done. I've created a project with an example of the mechanism described here. It could be easily used as a template to cut and paste if you remove a few additions I created to make it a bit more presentable for this tutorial.
Check it out on [GitHub](https://github.com/eithanshavit/ContentAwareCollectionCell).
