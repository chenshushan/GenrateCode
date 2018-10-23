import com.chen.code.Application;
import com.chen.code.service.ITemplateService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * Created by Administrator on 2017/11/26.
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class JpaTest {

	@Autowired
	ITemplateService templateService;
	@Test
	public void contextLoads() {
		System.out.println(3);
	}

}
