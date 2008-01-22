From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Tue, 22 Jan 2008 19:43:27 +0000
Subject: [PATCH] [S390]: constify function pointer tables
Message-Id: <Pine.LNX.4.64.0801222043120.5722@fbirervta.pbzchgretzou.qr>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
---
 arch/s390/crypto/prng.c        |    2 +-
 arch/s390/kernel/setup.c       |    2 +-
 drivers/s390/block/dasd_proc.c |    2 +-
 drivers/s390/char/tape_proc.c  |    2 +-
 drivers/s390/char/vmur.c       |    2 +-
 drivers/s390/char/zcore.c      |    2 +-
 drivers/s390/cio/blacklist.c   |    2 +-
 drivers/s390/net/qeth_proc.c   |    4 ++--
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 8eb3a1a..da1580f 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -146,7 +146,7 @@ static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
 	return ret;
 }
 
-static struct file_operations prng_fops = {
+static const struct file_operations prng_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &prng_open,
 	.release	= NULL,
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 577aa7d..38b601e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -996,7 +996,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 static void c_stop(struct seq_file *m, void *v)
 {
 }
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start	= c_start,
 	.next	= c_next,
 	.stop	= c_stop,
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index ac7e8ef..3a3c9a9 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -137,7 +137,7 @@ static void dasd_devices_stop(struct seq_file *m, void *v)
 {
 }
 
-static struct seq_operations dasd_devices_seq_ops = {
+static const struct seq_operations dasd_devices_seq_ops = {
 	.start		= dasd_devices_start,
 	.next		= dasd_devices_next,
 	.stop		= dasd_devices_stop,
diff --git a/drivers/s390/char/tape_proc.c b/drivers/s390/char/tape_proc.c
index cea49f0..c9b96d5 100644
--- a/drivers/s390/char/tape_proc.c
+++ b/drivers/s390/char/tape_proc.c
@@ -97,7 +97,7 @@ static void tape_proc_stop(struct seq_file *m, void *v)
 {
 }
 
-static struct seq_operations tape_proc_seq = {
+static const struct seq_operations tape_proc_seq = {
 	.start		= tape_proc_start,
 	.next		= tape_proc_next,
 	.stop		= tape_proc_stop,
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index d70a6e6..7689b50 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -759,7 +759,7 @@ static loff_t ur_llseek(struct file *file, loff_t offset, int whence)
 	return newpos;
 }
 
-static struct file_operations ur_fops = {
+static const struct file_operations ur_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = ur_open,
 	.release = ur_release,
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 7073daf..f523501 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -470,7 +470,7 @@ static loff_t zcore_lseek(struct file *file, loff_t offset, int orig)
 	return rc;
 }
 
-static struct file_operations zcore_fops = {
+static const struct file_operations zcore_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= zcore_lseek,
 	.read		= zcore_read,
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index bd5f16f..e8597ec 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -348,7 +348,7 @@ cio_ignore_write(struct file *file, const char __user *user_buf,
 	return user_len;
 }
 
-static struct seq_operations cio_ignore_proc_seq_ops = {
+static const struct seq_operations cio_ignore_proc_seq_ops = {
 	.start = cio_ignore_proc_seq_start,
 	.stop  = cio_ignore_proc_seq_stop,
 	.next  = cio_ignore_proc_seq_next,
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index f1ff165..46ecd03 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -146,7 +146,7 @@ qeth_procfile_seq_show(struct seq_file *s, void *it)
 	return 0;
 }
 
-static struct seq_operations qeth_procfile_seq_ops = {
+static const struct seq_operations qeth_procfile_seq_ops = {
 	.start = qeth_procfile_seq_start,
 	.stop  = qeth_procfile_seq_stop,
 	.next  = qeth_procfile_seq_next,
@@ -264,7 +264,7 @@ qeth_perf_procfile_seq_show(struct seq_file *s, void *it)
 	return 0;
 }
 
-static struct seq_operations qeth_perf_procfile_seq_ops = {
+static const struct seq_operations qeth_perf_procfile_seq_ops = {
 	.start = qeth_procfile_seq_start,
 	.stop  = qeth_procfile_seq_stop,
 	.next  = qeth_procfile_seq_next,
-- 
1.5.3.4
