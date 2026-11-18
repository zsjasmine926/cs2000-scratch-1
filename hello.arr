use context url-file("https://raw.githubusercontent.com/neu-pdi/cs2000-public-resources/refs/heads/main/static/","cs2000.arr")
data Expenses:
  | no-expenses
  | expense(what :: String, dollars :: Number, rest :: Expenses)
end

data Budget:
  | category(name :: String, limit :: Number, spent :: Expenses)
  | committee(name :: String, limit :: Number, left :: Budget, right :: Budget)
end

snacks =
  category("Snacks", 100,
    expense("pizza", 60, expense("juice", 15, expense("cookies", 30, no-expenses))))
prizes = category("Prizes", 50, expense("gift cards", 40, no-expenses))
new-games =
  category("New Games", 150,
    expense("strategy game", 55, expense("card game", 20, no-expenses)))

club = committee("Club", 400, committee("Game Night", 250, snacks, prizes), new-games)

# Q1
fun expense-total(e :: Expenses) -> Number:
  doc: "takes expenses and returns their total, in dollars"
  
  cases (Expenses) e:
    | no-expenses => 0
    | expense(what, dollars, rest) => dollars + expense-total(rest)
  end
  
where:
  expense-total(no-expenses) is 0
  expense-total(expense("gift cards", 40, no-expenses) )is 40
  expense-total(expense("pizza", 60, expense("juice", 15, no-expenses))) is 75
end

# Q2
fun budget-spent(b :: Budget) -> Number:
  doc: "takes a budget and returns the total dollars spent in all of its categories"
  
  cases (Budget) b:
    | category(name, limit, spent) => expense-total(spent)
    | committee(name, limit, left, right) => budget-spent(left) + budget-spent(right)
  end
  
where:
  budget-spent(prizes) is 40
  budget-spent(snacks) is 105
end

#Q3
fun over-limit(b :: Budget) -> List<String>:
  doc: "takes a budget and returns a list of the names of its parts, committees and categories both, that are over their limits"
  cases (Budget) b:
    | category(name, limit, spent) => 
      if expense-total(spent) > limit:
        [list: name]
      else:
        [list: ]
      end
    | committee(name, limit, left, right) => 
      x = if budget-spent(b) > limit:
        [list: name]
      else:
        [list: ]
      end
        x + over-limit(left) + over-limit(right)
  end
where:
  over-limit(prizes) is [list: ]
  over-limit(snacks) is [list: "Snacks"]
end

# Q4
fun add-expense(b :: Budget, name-cate :: String, bought :: String, cost :: Number) -> Budget:
  doc: "returns the budget with the new expense added to the front of that category's expenses"
  
  cases (Budget) b:
    | category(name, limit, spent) => 
      if name-cate == name:
        category(name, limit, expense(bought, cost, spent))
      else:
        b
      end
    | committee(name, limit, left, right) =>
      committee(name, limit, add-expense(left, name-cate, bought, cost), add-expense(right, name-cate, bought, cost))
  end
where:
  add-expense(prizes, "Snacks", "chips", 5) is prizes
end

        

  
