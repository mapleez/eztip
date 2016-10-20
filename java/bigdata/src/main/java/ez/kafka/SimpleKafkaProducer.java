package ez.kafka;

import java.util.Properties;
// import java.util.Arrays;

/* Producer */
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.KafkaProducer;

import kafka.serializer.StringEncoder;

//import kafka.consumer.Consumer;
//import kafka.consumer.ConsumerConfig;

/* Customer */
// import org.apache.kafka.clients.consumer.KafkaConsumer;
// import org.apache.kafka.clients.consumer.ConsumerRecord;
// import org.apache.kafka.clients.consumer.ConsumerRecords;

public class SimpleKafkaProducer {

	private String zk;
	private String broker;
	private String topic;
	/* The producer core. */
	private Producer <String, String> prod;
	// private volatile boolean canRun;

	public SimpleKafkaProducer (String zk, String broker, String topic) {
		/* example = "192.168.1.30:2181,192.168.1.31:2181,192.168.1.32:2181"; */
		this.zk = zk;
		/* example = "192.168.1.30:9092,192.168.1.31:9092,192.168.1.32:9092"; */
		this.broker = broker;
		/* a simple topic string. */
		this.topic = topic;

		Properties props = new Properties ();
		props.put ("zookeeper.connect",zk );
		props.put ("serializer.class", StringEncoder.class.getName ());  
		props.put ("metadata.broker.list", broker);
		props.put ("bootstrap.servers", broker);
		props.put ("acks", "all");
		props.put ("retries", 0);
		props.put ("batch.size", 16384);
		props.put ("linger.ms", 1);
		props.put ("buffer.memory", 33554432);
		props.put ("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		props.put ("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		
		prod = new KafkaProducer <String, String> (props);
	}

	/* This method will block the main thread. */
	public void produce () throws Exception {
		int i = 0;
		for (; i < Integer.MAX_VALUE; i ++) {
			if (i > Integer.MAX_VALUE - 20) i = 0;
			String data = Integer.toString (i) + "=>" + Integer.toString (i);
			prod.send (new ProducerRecord <String, String> 
				(topic, Integer.toString(i), data));
			// System.out.println (data);
			// Thread.sleep (1000);
		}
		prod.close ();
	}

	/* This method will start a new thread and produce data. */
	public void asyncProduce () throws Exception {
		new Thread () {
			public void run () {
				// while (canRun) {
				try {
					produce ();
				} catch (Exception ex) {
					// TODO...
					ex.printStackTrace ();
				}
				// }
			}
		}.start ();
	}

	/* Only for testing */
	public static void main (String [] args) {
		// Producer <String, String> prod = create_producer ();
		SimpleKafkaProducer prod = 
			new SimpleKafkaProducer ("localhost:2181", "localhost:9092", "testtopic");
		try {
			prod.produce ();
		} catch (Exception ex) {
			ex.printStackTrace ();
		}
	}

}

