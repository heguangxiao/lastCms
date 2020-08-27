(function() {

    var db = {

        loadData: function(filter) {
            return $.grep(this.clients, function(client) {
                return (!filter.Username || client.Username.indexOf(filter.Username) > -1)
                    && (!filter.CreateAt || client.CreateAt.indexOf(filter.CreateAt) > -1)
                    && (!filter.CreateBy || client.CreateBy.indexOf(filter.CreateBy) > -1)
                    && (!filter.Status || client.Status === filter.Status)
                    && (!filter.Type || client.Type === filter.Type)
                    && (!filter.Role || client.Role.indexOf(filter.Role) > -1);
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