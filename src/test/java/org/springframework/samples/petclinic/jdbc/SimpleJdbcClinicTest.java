package org.springframework.samples.petclinic.jdbc;

import org.springframework.samples.petclinic.AbstractClinicTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;

/**
 * <p>
 * Integration tests for the {@link SimpleJdbcClinic} implementation.
 * </p>
 * <p>
 * "SimpleJdbcClinicTests-context.xml" determines the actual beans to test.
 * </p>
 *
 * @author Thomas Risberg
 */
@ContextConfiguration
@DirtiesContext
public class SimpleJdbcClinicTest extends AbstractClinicTest {

}
