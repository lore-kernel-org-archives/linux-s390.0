From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 27 Nov 2009 06:35:17 +0000
Subject: [PATCH] seq_file: convert drivers/s390/
Message-Id: <20091127063517.GA25983@x200.malnet.ru>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/s390/block/dasd_proc.c   |  109 ++++++++++++++----------------
 drivers/s390/crypto/zcrypt_api.c |  139 +++++++++++++++++----------------------
 2 files changed, 114 insertions(+), 134 deletions(-)

--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -167,51 +167,32 @@ static const struct file_operations dasd_devices_file_ops = {
 	.release	= seq_release,
 };
 
-static int
-dasd_calc_metrics(char *page, char **start, off_t off,
-		  int count, int *eof, int len)
-{
-	len = (len > off) ? len - off : 0;
-	if (len > count)
-		len = count;
-	if (len < count)
-		*eof = 1;
-	*start = page + off;
-	return len;
-}
-
 #ifdef CONFIG_DASD_PROFILE
-static char *
-dasd_statistics_array(char *str, unsigned int *array, int factor)
+static void dasd_statistics_array(struct seq_file *m, unsigned int *array, int factor)
 {
 	int i;
 
 	for (i = 0; i < 32; i++) {
-		str += sprintf(str, "%7d ", array[i] / factor);
+		seq_printf(m, "%7d ", array[i] / factor);
 		if (i == 15)
-			str += sprintf(str, "\n");
+			seq_putc(m, '\n');
 	}
-	str += sprintf(str,"\n");
-	return str;
+	seq_putc(m, '\n');
 }
 #endif /* CONFIG_DASD_PROFILE */
 
-static int
-dasd_statistics_read(char *page, char **start, off_t off,
-		     int count, int *eof, void *data)
+static int dasd_stats_proc_show(struct seq_file *m, void *v)
 {
-	unsigned long len;
 #ifdef CONFIG_DASD_PROFILE
 	struct dasd_profile_info_t *prof;
-	char *str;
 	int factor;
 
 	/* check for active profiling */
 	if (dasd_profile_level == DASD_PROFILE_OFF) {
-		len = sprintf(page, "Statistics are off - they might be "
+		seq_printf(m, "Statistics are off - they might be "
 				    "switched on using 'echo set on > "
 				    "/proc/dasd/statistics'\n");
-		return dasd_calc_metrics(page, start, off, count, eof, len);
+		return 0;
 	}
 
 	prof = &dasd_global_profile;
@@ -219,47 +200,49 @@ dasd_statistics_read(char *page, char **start, off_t off,
 	for (factor = 1; (prof->dasd_io_reqs / factor) > 9999999;
 	     factor *= 10);
 
-	str = page;
-	str += sprintf(str, "%d dasd I/O requests\n", prof->dasd_io_reqs);
-	str += sprintf(str, "with %u sectors(512B each)\n",
+	seq_printf(m, "%d dasd I/O requests\n", prof->dasd_io_reqs);
+	seq_printf(m, "with %u sectors(512B each)\n",
 		       prof->dasd_io_sects);
-	str += sprintf(str, "Scale Factor is  %d\n", factor);
-	str += sprintf(str,
+	seq_printf(m, "Scale Factor is  %d\n", factor);
+	seq_printf(m,
 		       "   __<4	   ___8	   __16	   __32	   __64	   _128	"
 		       "   _256	   _512	   __1k	   __2k	   __4k	   __8k	"
 		       "   _16k	   _32k	   _64k	   128k\n");
-	str += sprintf(str,
+	seq_printf(m,
 		       "   _256	   _512	   __1M	   __2M	   __4M	   __8M	"
 		       "   _16M	   _32M	   _64M	   128M	   256M	   512M	"
 		       "   __1G	   __2G	   __4G " "   _>4G\n");
 
-	str += sprintf(str, "Histogram of sizes (512B secs)\n");
-	str = dasd_statistics_array(str, prof->dasd_io_secs, factor);
-	str += sprintf(str, "Histogram of I/O times (microseconds)\n");
-	str = dasd_statistics_array(str, prof->dasd_io_times, factor);
-	str += sprintf(str, "Histogram of I/O times per sector\n");
-	str = dasd_statistics_array(str, prof->dasd_io_timps, factor);
-	str += sprintf(str, "Histogram of I/O time till ssch\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time1, factor);
-	str += sprintf(str, "Histogram of I/O time between ssch and irq\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time2, factor);
-	str += sprintf(str, "Histogram of I/O time between ssch "
+	seq_printf(m, "Histogram of sizes (512B secs)\n");
+	dasd_statistics_array(m, prof->dasd_io_secs, factor);
+	seq_printf(m, "Histogram of I/O times (microseconds)\n");
+	dasd_statistics_array(m, prof->dasd_io_times, factor);
+	seq_printf(m, "Histogram of I/O times per sector\n");
+	dasd_statistics_array(m, prof->dasd_io_timps, factor);
+	seq_printf(m, "Histogram of I/O time till ssch\n");
+	dasd_statistics_array(m, prof->dasd_io_time1, factor);
+	seq_printf(m, "Histogram of I/O time between ssch and irq\n");
+	dasd_statistics_array(m, prof->dasd_io_time2, factor);
+	seq_printf(m, "Histogram of I/O time between ssch "
 			    "and irq per sector\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time2ps, factor);
-	str += sprintf(str, "Histogram of I/O time between irq and end\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time3, factor);
-	str += sprintf(str, "# of req in chanq at enqueuing (1..32) \n");
-	str = dasd_statistics_array(str, prof->dasd_io_nr_req, factor);
-	len = str - page;
+	dasd_statistics_array(m, prof->dasd_io_time2ps, factor);
+	seq_printf(m, "Histogram of I/O time between irq and end\n");
+	dasd_statistics_array(m, prof->dasd_io_time3, factor);
+	seq_printf(m, "# of req in chanq at enqueuing (1..32) \n");
+	dasd_statistics_array(m, prof->dasd_io_nr_req, factor);
 #else
-	len = sprintf(page, "Statistics are not activated in this kernel\n");
+	seq_printf(m, "Statistics are not activated in this kernel\n");
 #endif
-	return dasd_calc_metrics(page, start, off, count, eof, len);
+	return 0;
 }
 
-static int
-dasd_statistics_write(struct file *file, const char __user *user_buf,
-		      unsigned long user_len, void *data)
+static int dasd_stats_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dasd_stats_proc_show, NULL);
+}
+
+static ssize_t dasd_stats_proc_write(struct file *file,
+		const char __user *user_buf, size_t user_len, loff_t *pos)
 {
 #ifdef CONFIG_DASD_PROFILE
 	char *buffer, *str;
@@ -310,6 +293,15 @@ out_error:
 #endif				/* CONFIG_DASD_PROFILE */
 }
 
+static const struct file_operations dasd_stats_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dasd_stats_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= dasd_stats_proc_write,
+};
+
 /*
  * Create dasd proc-fs entries.
  * In case creation failed, cleanup and return -ENOENT.
@@ -326,13 +318,12 @@ dasd_proc_init(void)
 					 &dasd_devices_file_ops);
 	if (!dasd_devices_entry)
 		goto out_nodevices;
-	dasd_statistics_entry = create_proc_entry("statistics",
-						  S_IFREG | S_IRUGO | S_IWUSR,
-						  dasd_proc_root_entry);
+	dasd_statistics_entry = proc_create("statistics",
+					    S_IFREG | S_IRUGO | S_IWUSR,
+					    dasd_proc_root_entry,
+					    &dasd_stats_proc_fops);
 	if (!dasd_statistics_entry)
 		goto out_nostatistics;
-	dasd_statistics_entry->read_proc = dasd_statistics_read;
-	dasd_statistics_entry->write_proc = dasd_statistics_write;
 	return 0;
 
  out_nostatistics:
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -33,6 +33,7 @@
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/smp_lock.h>
 #include <asm/atomic.h>
@@ -912,122 +913,104 @@ static struct miscdevice zcrypt_misc_device = {
  */
 static struct proc_dir_entry *zcrypt_entry;
 
-static int sprintcl(unsigned char *outaddr, unsigned char *addr,
-		    unsigned int len)
+static void sprintcl(struct seq_file *m, unsigned char *addr, unsigned int len)
 {
-	int hl, i;
+	int i;
 
-	hl = 0;
 	for (i = 0; i < len; i++)
-		hl += sprintf(outaddr+hl, "%01x", (unsigned int) addr[i]);
-	hl += sprintf(outaddr+hl, " ");
-	return hl;
+		seq_printf(m, "%01x", (unsigned int) addr[i]);
+	seq_putc(m, ' ');
 }
 
-static int sprintrw(unsigned char *outaddr, unsigned char *addr,
-		    unsigned int len)
+static void sprintrw(struct seq_file *m, unsigned char *addr, unsigned int len)
 {
-	int hl, inl, c, cx;
+	int inl, c, cx;
 
-	hl = sprintf(outaddr, "	   ");
+	seq_printf(m, "	   ");
 	inl = 0;
 	for (c = 0; c < (len / 16); c++) {
-		hl += sprintcl(outaddr+hl, addr+inl, 16);
+		sprintcl(m, addr+inl, 16);
 		inl += 16;
 	}
 	cx = len%16;
 	if (cx) {
-		hl += sprintcl(outaddr+hl, addr+inl, cx);
+		sprintcl(m, addr+inl, cx);
 		inl += cx;
 	}
-	hl += sprintf(outaddr+hl, "\n");
-	return hl;
+	seq_putc(m, '\n');
 }
 
-static int sprinthx(unsigned char *title, unsigned char *outaddr,
-		    unsigned char *addr, unsigned int len)
+static void sprinthx(unsigned char *title, struct seq_file *m,
+		     unsigned char *addr, unsigned int len)
 {
-	int hl, inl, r, rx;
+	int inl, r, rx;
 
-	hl = sprintf(outaddr, "\n%s\n", title);
+	seq_printf(m, "\n%s\n", title);
 	inl = 0;
 	for (r = 0; r < (len / 64); r++) {
-		hl += sprintrw(outaddr+hl, addr+inl, 64);
+		sprintrw(m, addr+inl, 64);
 		inl += 64;
 	}
 	rx = len % 64;
 	if (rx) {
-		hl += sprintrw(outaddr+hl, addr+inl, rx);
+		sprintrw(m, addr+inl, rx);
 		inl += rx;
 	}
-	hl += sprintf(outaddr+hl, "\n");
-	return hl;
+	seq_putc(m, '\n');
 }
 
-static int sprinthx4(unsigned char *title, unsigned char *outaddr,
+static void sprinthx4(unsigned char *title, struct seq_file *m,
 		     unsigned int *array, unsigned int len)
 {
-	int hl, r;
+	int r;
 
-	hl = sprintf(outaddr, "\n%s\n", title);
+	seq_printf(m, "\n%s\n", title);
 	for (r = 0; r < len; r++) {
 		if ((r % 8) == 0)
-			hl += sprintf(outaddr+hl, "    ");
-		hl += sprintf(outaddr+hl, "%08X ", array[r]);
+			seq_printf(m, "    ");
+		seq_printf(m, "%08X ", array[r]);
 		if ((r % 8) == 7)
-			hl += sprintf(outaddr+hl, "\n");
+			seq_putc(m, '\n');
 	}
-	hl += sprintf(outaddr+hl, "\n");
-	return hl;
+	seq_putc(m, '\n');
 }
 
-static int zcrypt_status_read(char *resp_buff, char **start, off_t offset,
-			      int count, int *eof, void *data)
+static int zcrypt_proc_show(struct seq_file *m, void *v)
 {
-	unsigned char *workarea;
-	int len;
+	char workarea[AP_DEVICES];
 
-	len = 0;
-
-	/* resp_buff is a page. Use the right half for a work area */
-	workarea = resp_buff + 2000;
-	len += sprintf(resp_buff + len, "\nzcrypt version: %d.%d.%d\n",
+	seq_printf(m, "\nzcrypt version: %d.%d.%d\n",
 		ZCRYPT_VERSION, ZCRYPT_RELEASE, ZCRYPT_VARIANT);
-	len += sprintf(resp_buff + len, "Cryptographic domain: %d\n",
-		       ap_domain_index);
-	len += sprintf(resp_buff + len, "Total device count: %d\n",
-		       zcrypt_device_count);
-	len += sprintf(resp_buff + len, "PCICA count: %d\n",
-		       zcrypt_count_type(ZCRYPT_PCICA));
-	len += sprintf(resp_buff + len, "PCICC count: %d\n",
-		       zcrypt_count_type(ZCRYPT_PCICC));
-	len += sprintf(resp_buff + len, "PCIXCC MCL2 count: %d\n",
+	seq_printf(m, "Cryptographic domain: %d\n", ap_domain_index);
+	seq_printf(m, "Total device count: %d\n", zcrypt_device_count);
+	seq_printf(m, "PCICA count: %d\n", zcrypt_count_type(ZCRYPT_PCICA));
+	seq_printf(m, "PCICC count: %d\n", zcrypt_count_type(ZCRYPT_PCICC));
+	seq_printf(m, "PCIXCC MCL2 count: %d\n",
 		       zcrypt_count_type(ZCRYPT_PCIXCC_MCL2));
-	len += sprintf(resp_buff + len, "PCIXCC MCL3 count: %d\n",
+	seq_printf(m, "PCIXCC MCL3 count: %d\n",
 		       zcrypt_count_type(ZCRYPT_PCIXCC_MCL3));
-	len += sprintf(resp_buff + len, "CEX2C count: %d\n",
-		       zcrypt_count_type(ZCRYPT_CEX2C));
-	len += sprintf(resp_buff + len, "CEX2A count: %d\n",
-		       zcrypt_count_type(ZCRYPT_CEX2A));
-	len += sprintf(resp_buff + len, "requestq count: %d\n",
-		       zcrypt_requestq_count());
-	len += sprintf(resp_buff + len, "pendingq count: %d\n",
-		       zcrypt_pendingq_count());
-	len += sprintf(resp_buff + len, "Total open handles: %d\n\n",
+	seq_printf(m, "CEX2C count: %d\n", zcrypt_count_type(ZCRYPT_CEX2C));
+	seq_printf(m, "CEX2A count: %d\n", zcrypt_count_type(ZCRYPT_CEX2A));
+	seq_printf(m, "requestq count: %d\n", zcrypt_requestq_count());
+	seq_printf(m, "pendingq count: %d\n", zcrypt_pendingq_count());
+	seq_printf(m, "Total open handles: %d\n\n",
 		       atomic_read(&zcrypt_open_count));
 	zcrypt_status_mask(workarea);
-	len += sprinthx("Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) "
+	sprinthx("Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) "
 			"4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A",
-			resp_buff+len, workarea, AP_DEVICES);
+			m, workarea, AP_DEVICES);
 	zcrypt_qdepth_mask(workarea);
-	len += sprinthx("Waiting work element counts",
-			resp_buff+len, workarea, AP_DEVICES);
+	sprinthx("Waiting work element counts",
+			m, workarea, AP_DEVICES);
 	zcrypt_perdev_reqcnt((int *) workarea);
-	len += sprinthx4("Per-device successfully completed request counts",
-			 resp_buff+len,(unsigned int *) workarea, AP_DEVICES);
-	*eof = 1;
-	memset((void *) workarea, 0x00, AP_DEVICES * sizeof(unsigned int));
-	return len;
+	sprinthx4("Per-device successfully completed request counts",
+			 m, (unsigned int *) workarea, AP_DEVICES);
+	return 0;
+}
+
+static int zcrypt_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, zcrypt_proc_show, NULL);
 }
 
 static void zcrypt_disable_card(int index)
@@ -1057,11 +1040,11 @@ static void zcrypt_enable_card(int index)
 	spin_unlock_bh(&zcrypt_device_lock);
 }
 
-static int zcrypt_status_write(struct file *file, const char __user *buffer,
-			       unsigned long count, void *data)
+static ssize_t zcrypt_proc_write(struct file *file, const char __user *buffer,
+				 size_t count, loff_t *pos)
 {
 	unsigned char *lbuf, *ptr;
-	unsigned long local_count;
+	size_t local_count;
 	int j;
 
 	if (count <= 0)
@@ -1110,6 +1093,15 @@ out:
 	return count;
 }
 
+static const struct file_operations zcrypt_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= zcrypt_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= zcrypt_proc_write,
+};
+
 static int zcrypt_rng_device_count;
 static u32 *zcrypt_rng_buffer;
 static int zcrypt_rng_buffer_index;
@@ -1192,14 +1184,11 @@ int __init zcrypt_api_init(void)
 		goto out;
 
 	/* Set up the proc file system */
-	zcrypt_entry = create_proc_entry("driver/z90crypt", 0644, NULL);
+	zcrypt_entry = proc_create("driver/z90crypt", 0644, NULL, &zcrypt_proc_fops);
 	if (!zcrypt_entry) {
 		rc = -ENOMEM;
 		goto out_misc;
 	}
-	zcrypt_entry->data = NULL;
-	zcrypt_entry->read_proc = zcrypt_status_read;
-	zcrypt_entry->write_proc = zcrypt_status_write;
 
 	return 0;
 
