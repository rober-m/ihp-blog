module Web.View.Posts.Show where
import qualified Text.MMark as MMark
import Web.View.Prelude

newtype ShowView = ShowView { post :: Post }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{post.title}</h1>
        <p>{timeAgo post.createdAt}</p>
        <p>{renderMarkdown post.body}</p>
        <a href={NewCommentAction}>Add Comment</a>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Posts" PostsAction
                            , breadcrumbText "Show Post"
                            ]

            renderMarkdown :: Text -> Html
            renderMarkdown text = case MMark.parse "" text of
                Left _   -> "Invalid markdown!"
                Right md -> preEscapedToHtml . show . MMark.render $ md
