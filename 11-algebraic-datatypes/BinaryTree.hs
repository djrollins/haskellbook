data BinaryTree a =
      Leaf
    | Node (BinaryTree a) a (BinaryTree a)
    deriving (Eq, Ord, Show)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
    | b == a = Node left a right
    | b < a  = Node (insert' b left) a right
    | b > a  = Node left a (insert' b right)

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) =
    Node (mapTree f left) (f a) (mapTree f right)

testTree' :: BinaryTree Integer
testTree' =
    Node (Node Leaf 3 Leaf) 2 (Node Leaf 4 Leaf)

expectedTree :: BinaryTree Integer
expectedTree =
    Node (Node Leaf 4 Leaf) 3 (Node Leaf 5 Leaf)

mapOkay =
    if mapTree (+1) testTree' == expectedTree
    then print "yup!"
    else error "test failed!"

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left a right) =
    a : (preorder left ++ preorder right)

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left a right) =
    inorder left ++ [a] ++ inorder right

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node left a right) =
    postorder left ++ postorder right ++ [a]

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

testPreorder :: IO ()
testPreorder =
    if preorder testTree == [2, 1, 3]
    then putStrLn "Preorder fine!"
    else putStrLn "Bad news bears."

testInorder :: IO ()
testInorder =
    if inorder testTree == [1, 2, 3]
    then putStrLn "Inorder fine!"
    else putStrLn "Bad news bears."

testPostorder :: IO ()
testPostorder =
    if postorder testTree == [1, 3, 2]
    then putStrLn "Postorder fine!"
    else putStrLn "postorder failed check"

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f acc tree = foldr f acc (inorder tree)

testFoldTree :: IO ()
testFoldTree =
    if (foldTree (+) 0 testTree) == 6
    then putStrLn "foldTree fine!"
    else putStrLn "foldTree failed check"

main :: IO ()
main = do
    testPreorder
    testInorder
    testPostorder
    testFoldTree

