module Web.View.Comments.Edit where
import Web.View.Prelude

newtype EditView = EditView { comment :: Comment }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Comment</h1>
        {renderForm comment}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Post" $ ShowPostAction comment.postId
                , breadcrumbText "Edit Comment"
                ]

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {(textField #postId)}
    {(textField #author)}
    {(textField #body)}
    {submitButton}

|]
