package ez.kafka;

import java.util.Properties;
import java.util.Arrays;

import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;

import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;

public class SimpleKafkaConsumer {

	private String broker;
	private String zk;
	private String topic;

	public void create_customer () throws Exception {
		int times = 1000;
		Properties props = new Properties();
		//	     props.put("group.id", "test");
		props.put("enable.auto.commit", "true");
		props.put("auto.commit.interval.ms", "1000");
		props.put("session.timeout.ms", "30000");
		props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		//	     props.put("zookeeper.connect", zk);//声明zk
		props.put ("bootstrap.servers", broker);
		props.put ("bootstrap.servers", broker);
		props.put("group.id", "group2");  
		//	        return Consumer.createJavaConsumerConnector(new ConsumerConfig(properties));  
		KafkaConsumer<String, String> consumer = new KafkaConsumer<String, String> (props);
		// consumer.subscribe(Arrays.asList ("foo", "bar")); /* add topic */
		consumer.subscribe (Arrays.asList (topic));
		while (true) {
						ConsumerRecords<String, String> records = consumer.poll (100);
						System.out.println ("sd");
						for (ConsumerRecord<String, String> record : records)
										System.out.printf ("offset = %d, key = %s, value = %s\n", record.offset(), record.key(), record.value());
						// times --;
						//	         Thread.sleep (1000);
		}
		// consumer.close ();
	}
}



