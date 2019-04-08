package net.medvekoma.cassandra;

import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Session;
import com.datastax.driver.mapping.Mapper;
import com.datastax.driver.mapping.MappingManager;
import com.datastax.driver.mapping.Result;

import static java.lang.System.out;

public class Main {

    public static void main(final String[] args) {

        try(CassandraConnector connector = new CassandraConnector("localhost", "nobel")) {
            connector.displayMetadata();
            runExampleQuery(connector.getSession());
            runAccessorQueries(connector.getSession());
        } catch (RuntimeException queryException) {
            out.println(">>>>>> ERROR: Querying by country requires an index. Create it with");
            out.println("cqlsh> CREATE INDEX ON nobel.laureates(borncountrycode);");
        }
    }

    private static void runExampleQuery(Session session) {
        ResultSet results = session.execute("SELECT * FROM laureates WHERE year=2002");

        MappingManager mappingManager = new MappingManager(session);
        Mapper<Laureate> mapper = mappingManager.mapper(Laureate.class);
        Result<Laureate> laureates = mapper.map(results);

        printLaureates(laureates, "manual mapping");
    }

    private static void runAccessorQueries(Session session) {
        MappingManager mappingManager = new MappingManager(session);
        LaureateAccessor accessor = mappingManager.createAccessor(LaureateAccessor.class);

        Result<Laureate> laureates = accessor.getYear2002();
        printLaureates(laureates, "year 2002");

        laureates = accessor.getByYear(2010);
        printLaureates(laureates, "year 2010");

        // requires index
        // CREATE INDEX ON laureates(borncountrycode);
        laureates = accessor.getByCountry("HU");
        printLaureates(laureates, "from Hungary");
    }

    private static void printLaureates(Result<Laureate> laureates, String header) {

        out.printf("--- %s ---\n", header);

        for (Laureate laureate: laureates) {
            out.print(laureate);
        }
    }
}
