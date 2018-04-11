import com.chen.code.Application;
import com.chen.code.entity.Template;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import com.chen.code.service.ITemplateService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
		Template template = new Template();
		template.setTemplateName("css");
		template.setTemplatePath("path");
		LocalDate now = LocalDate.now();
		template.setUploadTime(now.plusDays(-10));
		template.setCreatedTime(LocalDateTime.now());
		template.setStatus(EnumBaseStatus.NORMAL);
		template.setModifiedCount(0);
		templateService.save(template);
	}

}
