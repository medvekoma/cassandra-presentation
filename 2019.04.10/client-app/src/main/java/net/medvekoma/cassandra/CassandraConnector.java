package net.medvekoma.cassandra;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Session;

import java.util.Set;

import static java.lang.System.out;

class CassandraConnector implements AutoCloseable {

    private Cluster cluster;
    private Session session;

    CassandraConnector(final String node, final String keyspace) {
        this.cluster = Cluster.builder()
            .addContactPoint(node)
            .build();

        this.session = cluster.connect(keyspace);
    }

    void displayMetadata() {
        final Metadata metadata = cluster.getMetadata();
        out.printf("Connected to cluster: %s\n", metadata.getClusterName());
        Set<Host> hosts = metadata.getAllHosts();
        for (final Host host : hosts) {
            out.printf("Host: %s\tRack: %s\tDC: %s\n", host.getAddress(), host.getRack(), host.getDatacenter());
        }
    }

    Session getSession(){
        return this.session;
    }

    public void close(){
        this.session.close();
        this.cluster.close();
    }
}
