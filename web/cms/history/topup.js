(function() {

    var db = {

        loadData: function(filter) {
            return $.grep(this.clients, function(client) {
                return (!filter.Phone || client.Phone.indexOf(filter.Phone) > -1)
                    && (!filter.Time || client.Money.indexOf(filter.Time) > -1)
                    && (!filter.TopUpAt || client.TopUpAt.indexOf(filter.TopUpAt) > -1)
                    && (!filter.Telco || client.Telco.indexOf(filter.Telco) > -1);
            });
        },

        insertItem: function(insertingClient) {
            this.clients.push(insertingClient);
        },

        updateItem: function(updatingClient) { },

        deleteItem: function(deletingClient) {
            var clientIndex = $.inArray(deletingClient, this.clients);
            this.clients.splice(clientIndex, 1);
        }

    };

    window.db = db;

}());