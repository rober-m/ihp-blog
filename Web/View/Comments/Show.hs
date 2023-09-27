module Web.View.Comments.Show where
import Web.View.Prelude

newtype ShowView = ShowView { comment :: Comment }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Comment</h1>
        <p>{comment}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Post" $ ShowPostAction comment.postId
                            , breadcrumbText "Show Comment"
                            ]
