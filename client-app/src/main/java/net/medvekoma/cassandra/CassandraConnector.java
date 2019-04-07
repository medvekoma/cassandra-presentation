package net.medvekoma.cassandra;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Session;

import java.util.Set;

import static java.lang.System.out;

public class CassandraConnector {

    private Cluster cluster;
    private Session session;

    public void connect(final String node, final String keyspace) {

        cluster = Cluster.builder()
            .addContactPoint(node)
            .build();

        final Metadata metadata = cluster.getMetadata();
        out.printf("Connected to cluster: %s\n", metadata.getClusterName());
        Set<Host> hosts = metadata.getAllHosts();
        for (final Host host : hosts) {
            out.printf("Host: %s\tRack: %s\tDC: %s\n", host.getAddress(), host.getRack(), host.getDatacenter());
        }

        this.session = cluster.connect(keyspace);
    }

    public Session getSession(){
        return this.session;
    }

    public void close(){
        this.cluster.close();
    }
}
