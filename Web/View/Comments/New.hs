module Web.View.Comments.New where
import Web.View.Prelude

newtype NewView = NewView { comment :: Comment }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Comment</h1>
        {renderForm comment}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Post" $ ShowPostAction comment.postId
                , breadcrumbText "New Comment"
                ]

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {(textField #postId)}
    {(textField #author)}
    {(textField #body)}
    {submitButton}

|]
