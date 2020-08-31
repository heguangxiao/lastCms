(function() {

    var db = {

        loadData: function(filter) {
            return $.grep(this.clients, function(client) {
                return (!filter.Phone || client.Phone.indexOf(filter.Phone) > -1)
                    && (!filter.Money || client.Money.indexOf(filter.Money) > -1)
                    && (!filter.ChargAt || client.ChargAt.indexOf(filter.ChargAt) > -1)
                    && (!filter.Telco || client.Telco.indexOf(filter.Telco) > -1)
                    && (!filter.TopUpId || client.TopUpId.indexOf(filter.TopUpId) > -1);
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