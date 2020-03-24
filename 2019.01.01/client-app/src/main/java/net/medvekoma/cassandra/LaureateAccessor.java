package net.medvekoma.cassandra;

import com.datastax.driver.mapping.Result;
import com.datastax.driver.mapping.annotations.Accessor;
import com.datastax.driver.mapping.annotations.Param;
import com.datastax.driver.mapping.annotations.Query;

@Accessor
public interface LaureateAccessor {

    @Query("SELECT * FROM laureates WHERE year=2002")
    Result<Laureate> getYear2002();

    @Query("SELECT * FROM laureates WHERE year=?")
    Result<Laureate> getByYear(int year);

    @Query("SELECT * FROM laureates WHERE borncountrycode=:country")
    Result<Laureate> getByCountry(@Param("country") String country);
}
