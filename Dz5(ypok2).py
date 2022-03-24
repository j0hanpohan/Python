list = [213.234, 123.45, 54, 34, 66.5334, 75.4, 44.222, 5433.11, 342.33, 35]
message =''
for i in list:
    price = f'{i:.2f}'.split('.')
    message += f"{price[0]} руб {price[1]} коп "
print(message)