import requests
from bs4 import BeautifulSoup
url = 'https://pic.netbian.com/4kmeinv/'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
}
response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.text, 'lxml')
img_list = soup.find_all('img')
for img in img_list:
    img_url = img['src']
    img_name = img_url.split('/')[-1]
    img_data = requests.get(img_url, headers=headers).content
    with open(img_name, 'wb') as f:
        f.write(img_data)