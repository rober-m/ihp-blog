module Web.Controller.Comments where

import Web.Controller.Prelude
import Web.View.Comments.Edit
import Web.View.Comments.New
import Web.View.Comments.Show

instance Controller CommentsController where
    action NewCommentAction { postId } = do
        let comment = newRecord
                |> set #postId postId
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    redirectTo EditCommentAction { .. }

    action CreateCommentAction = do
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render NewView { .. }
                Right comment -> do
                    comment <- comment |> createRecord
                    setSuccessMessage "Comment created"
                    redirectTo $ ShowPostAction comment.postId

    action DeleteCommentAction { commentId } = do
        comment <- fetch commentId
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        redirectTo $ ShowPostAction comment.postId

buildComment comment = comment
    |> fill @["postId", "author", "body"]
