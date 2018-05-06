const BASE_URL = '/api/tasks';

const _makeRequest = ({ method, body, endpoint }) => {
  return fetch(endpoint, {
    credentials: 'same-origin',
    headers: {
      'content-type': 'application/json'
    },
    method: method,
    ...(body && { body: body }),
  }).then(response => response.json())
    .then(data => data);
};

export default class TaskApi {
  fetchItems() {
    return _makeRequest({
      method: 'GET',
      endpoint: BASE_URL
    });
  }

  createItem(item) {
    return _makeRequest({
      method: 'POST',
      endpoint: BASE_URL
    });
  }

  deleteItem(item) {
    return _makeRequest({
      method: 'DELETE',
      endpoint: `${BASE_URL}/${item.id}`
    });
  }

  updateItem(item) {
    return _makeRequest({
      method: 'PUT',
      endpoint: `${BASE_URL}/${item.id}`,
      body: JSON.stringify({
        task: item
      })
    });
  }
};
