Return-Path: <linux-kernel-owner+w=401wt.eu-S934665AbXKPOfv@vger.kernel.org>
Message-Id: <20071116143320.980985765@de.ibm.com>
References: <20071116142942.978412023@de.ibm.com>
Date: Fri, 16 Nov 2007 15:29:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] sclp: sysfs interface for SCLP cpi
Content-Disposition: inline; filename=100-sclp-sysfs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/Makefile       |    2 
 drivers/s390/char/sclp_cpi.c     |  246 +-----------------------
 drivers/s390/char/sclp_cpi_sys.c |  390 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/char/sclp_cpi_sys.h |   15 +
 4 files changed, 422 insertions(+), 231 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/Makefile	2007-11-16 14:27:46.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_info.o sclp_config.o sclp_chp.o
+	 sclp_info.o sclp_config.o sclp_chp.o sclp_cpi_sys.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
diff -urpN linux-2.6/drivers/s390/char/sclp_cpi.c linux-2.6-patched/drivers/s390/char/sclp_cpi.c
--- linux-2.6/drivers/s390/char/sclp_cpi.c	2007-11-16 14:27:32.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi.c	2007-11-16 14:27:46.000000000 +0100
@@ -1,255 +1,41 @@
 /*
- * Author: Martin Peschke <mpeschke@de.ibm.com>
- * Copyright (C) 2001 IBM Entwicklung GmbH, IBM Corporation
+ *  drivers/s390/char/sclp_cpi.c
+ *    SCLP control programm identification
  *
- * SCLP Control-Program Identification.
+ *    Copyright IBM Corp. 2001, 2007
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Michael Ernst <mernst@de.ibm.com>
  */
 
-#include <linux/version.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <asm/ebcdic.h>
-#include <asm/semaphore.h>
-
-#include "sclp.h"
-#include "sclp_rw.h"
-
-#define CPI_LENGTH_SYSTEM_TYPE	8
-#define CPI_LENGTH_SYSTEM_NAME	8
-#define CPI_LENGTH_SYSPLEX_NAME	8
-
-struct cpi_evbuf {
-	struct evbuf_header header;
-	u8	id_format;
-	u8	reserved0;
-	u8	system_type[CPI_LENGTH_SYSTEM_TYPE];
-	u64	reserved1;
-	u8	system_name[CPI_LENGTH_SYSTEM_NAME];
-	u64	reserved2;
-	u64	system_level;
-	u64	reserved3;
-	u8	sysplex_name[CPI_LENGTH_SYSPLEX_NAME];
-	u8	reserved4[16];
-} __attribute__((packed));
-
-struct cpi_sccb {
-	struct sccb_header header;
-	struct cpi_evbuf cpi_evbuf;
-} __attribute__((packed));
-
-/* Event type structure for write message and write priority message */
-static struct sclp_register sclp_cpi_event =
-{
-	.send_mask = EVTYP_CTLPROGIDENT_MASK
-};
+#include <linux/version.h>
+#include "sclp_cpi_sys.h"
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Identify this operating system instance "
+		   "to the System z hardware");
+MODULE_AUTHOR("Martin Peschke <mpeschke@de.ibm.com>, "
+	      "Michael Ernst <mernst@de.ibm.com>");
 
-MODULE_AUTHOR(
-	"Martin Peschke, IBM Deutschland Entwicklung GmbH "
-	"<mpeschke@de.ibm.com>");
-
-MODULE_DESCRIPTION(
-	"identify this operating system instance to the S/390 "
-	"or zSeries hardware");
+static char *system_name = "";
+static char *sysplex_name = "";
 
-static char *system_name = NULL;
 module_param(system_name, charp, 0);
 MODULE_PARM_DESC(system_name, "e.g. hostname - max. 8 characters");
-
-static char *sysplex_name = NULL;
-#ifdef ALLOW_SYSPLEX_NAME
 module_param(sysplex_name, charp, 0);
 MODULE_PARM_DESC(sysplex_name, "if applicable - max. 8 characters");
-#endif
-
-/* use default value for this field (as well as for system level) */
-static char *system_type = "LINUX";
-
-static int
-cpi_check_parms(void)
-{
-	/* reject if no system type specified */
-	if (!system_type) {
-		printk("cpi: bug: no system type specified\n");
-		return -EINVAL;
-	}
-
-	/* reject if system type larger than 8 characters */
-	if (strlen(system_type) > CPI_LENGTH_SYSTEM_NAME) {
-		printk("cpi: bug: system type has length of %li characters - "
-		       "only %i characters supported\n",
-		       strlen(system_type), CPI_LENGTH_SYSTEM_TYPE);
-		return -EINVAL;
-	}
-
-	/* reject if no system name specified */
-	if (!system_name) {
-		printk("cpi: no system name specified\n");
-		return -EINVAL;
-	}
-
-	/* reject if system name larger than 8 characters */
-	if (strlen(system_name) > CPI_LENGTH_SYSTEM_NAME) {
-		printk("cpi: system name has length of %li characters - "
-		       "only %i characters supported\n",
-		       strlen(system_name), CPI_LENGTH_SYSTEM_NAME);
-		return -EINVAL;
-	}
-
-	/* reject if specified sysplex name larger than 8 characters */
-	if (sysplex_name && strlen(sysplex_name) > CPI_LENGTH_SYSPLEX_NAME) {
-		printk("cpi: sysplex name has length of %li characters"
-		       " - only %i characters supported\n",
-		       strlen(sysplex_name), CPI_LENGTH_SYSPLEX_NAME);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static void
-cpi_callback(struct sclp_req *req, void *data)
-{
-	struct semaphore *sem;
-
-	sem = (struct semaphore *) data;
-	up(sem);
-}
-
-static struct sclp_req *
-cpi_prepare_req(void)
-{
-	struct sclp_req *req;
-	struct cpi_sccb *sccb;
-	struct cpi_evbuf *evb;
-
-	req = kmalloc(sizeof(struct sclp_req), GFP_KERNEL);
-	if (req == NULL)
-		return ERR_PTR(-ENOMEM);
-	sccb = (struct cpi_sccb *) __get_free_page(GFP_KERNEL | GFP_DMA);
-	if (sccb == NULL) {
-		kfree(req);
-		return ERR_PTR(-ENOMEM);
-	}
-	memset(sccb, 0, sizeof(struct cpi_sccb));
-
-	/* setup SCCB for Control-Program Identification */
-	sccb->header.length = sizeof(struct cpi_sccb);
-	sccb->cpi_evbuf.header.length = sizeof(struct cpi_evbuf);
-	sccb->cpi_evbuf.header.type = 0x0B;
-	evb = &sccb->cpi_evbuf;
-
-	/* set system type */
-	memset(evb->system_type, ' ', CPI_LENGTH_SYSTEM_TYPE);
-	memcpy(evb->system_type, system_type, strlen(system_type));
-	sclp_ascebc_str(evb->system_type, CPI_LENGTH_SYSTEM_TYPE);
-	EBC_TOUPPER(evb->system_type, CPI_LENGTH_SYSTEM_TYPE);
-
-	/* set system name */
-	memset(evb->system_name, ' ', CPI_LENGTH_SYSTEM_NAME);
-	memcpy(evb->system_name, system_name, strlen(system_name));
-	sclp_ascebc_str(evb->system_name, CPI_LENGTH_SYSTEM_NAME);
-	EBC_TOUPPER(evb->system_name, CPI_LENGTH_SYSTEM_NAME);
-
-	/* set system level */
-	evb->system_level = LINUX_VERSION_CODE;
-
-	/* set sysplex name */
-	if (sysplex_name) {
-		memset(evb->sysplex_name, ' ', CPI_LENGTH_SYSPLEX_NAME);
-		memcpy(evb->sysplex_name, sysplex_name, strlen(sysplex_name));
-		sclp_ascebc_str(evb->sysplex_name, CPI_LENGTH_SYSPLEX_NAME);
-		EBC_TOUPPER(evb->sysplex_name, CPI_LENGTH_SYSPLEX_NAME);
-	}
-
-	/* prepare request data structure presented to SCLP driver */
-	req->command = SCLP_CMDW_WRITE_EVENT_DATA;
-	req->sccb = sccb;
-	req->status = SCLP_REQ_FILLED;
-	req->callback = cpi_callback;
-	return req;
-}
-
-static void
-cpi_free_req(struct sclp_req *req)
-{
-	free_page((unsigned long) req->sccb);
-	kfree(req);
-}
 
-static int __init
-cpi_module_init(void)
+static int __init cpi_module_init(void)
 {
-	struct semaphore sem;
-	struct sclp_req *req;
-	int rc;
-
-	rc = cpi_check_parms();
-	if (rc)
-		return rc;
-
-	rc = sclp_register(&sclp_cpi_event);
-	if (rc) {
-		/* could not register sclp event. Die. */
-		printk(KERN_WARNING "cpi: could not register to hardware "
-		       "console.\n");
-		return -EINVAL;
-	}
-	if (!(sclp_cpi_event.sclp_send_mask & EVTYP_CTLPROGIDENT_MASK)) {
-		printk(KERN_WARNING "cpi: no control program identification "
-		       "support\n");
-		sclp_unregister(&sclp_cpi_event);
-		return -EOPNOTSUPP;
-	}
-
-	req = cpi_prepare_req();
-	if (IS_ERR(req)) {
-		printk(KERN_WARNING "cpi: couldn't allocate request\n");
-		sclp_unregister(&sclp_cpi_event);
-		return PTR_ERR(req);
-	}
-
-	/* Prepare semaphore */
-	sema_init(&sem, 0);
-	req->callback_data = &sem;
-	/* Add request to sclp queue */
-	rc = sclp_add_request(req);
-	if (rc) {
-		printk(KERN_WARNING "cpi: could not start request\n");
-		cpi_free_req(req);
-		sclp_unregister(&sclp_cpi_event);
-		return rc;
-	}
-	/* make "insmod" sleep until callback arrives */
-	down(&sem);
-
-	rc = ((struct cpi_sccb *) req->sccb)->header.response_code;
-	if (rc != 0x0020) {
-		printk(KERN_WARNING "cpi: failed with response code 0x%x\n",
-		       rc);
-		rc = -ECOMM;
-	} else
-		rc = 0;
-
-	cpi_free_req(req);
-	sclp_unregister(&sclp_cpi_event);
-
-	return rc;
+	return sclp_cpi_set_data(system_name, sysplex_name, "LINUX",
+				 LINUX_VERSION_CODE);
 }
 
-
 static void __exit cpi_module_exit(void)
 {
 }
 
-
-/* declare driver module init/cleanup functions */
 module_init(cpi_module_init);
 module_exit(cpi_module_exit);
-
diff -urpN linux-2.6/drivers/s390/char/sclp_cpi_sys.c linux-2.6-patched/drivers/s390/char/sclp_cpi_sys.c
--- linux-2.6/drivers/s390/char/sclp_cpi_sys.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi_sys.c	2007-11-16 14:27:46.000000000 +0100
@@ -0,0 +1,390 @@
+/*
+ *  drivers/s390/char/sclp_cpi_sys.c
+ *    SCLP control program identification sysfs interface
+ *
+ *    Copyright IBM Corp. 2001, 2007
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Michael Ernst <mernst@de.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/kmod.h>
+#include <linux/timer.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <asm/ebcdic.h>
+#include <asm/sclp.h>
+#include "sclp.h"
+#include "sclp_rw.h"
+#include "sclp_cpi_sys.h"
+
+#define CPI_LENGTH_NAME 8
+#define CPI_LENGTH_LEVEL 16
+
+struct cpi_evbuf {
+	struct evbuf_header header;
+	u8	id_format;
+	u8	reserved0;
+	u8	system_type[CPI_LENGTH_NAME];
+	u64	reserved1;
+	u8	system_name[CPI_LENGTH_NAME];
+	u64	reserved2;
+	u64	system_level;
+	u64	reserved3;
+	u8	sysplex_name[CPI_LENGTH_NAME];
+	u8	reserved4[16];
+} __attribute__((packed));
+
+struct cpi_sccb {
+	struct sccb_header header;
+	struct cpi_evbuf cpi_evbuf;
+} __attribute__((packed));
+
+static struct sclp_register sclp_cpi_event = {
+	.send_mask = EVTYP_CTLPROGIDENT_MASK,
+};
+
+static char system_name[CPI_LENGTH_NAME + 1];
+static char sysplex_name[CPI_LENGTH_NAME + 1];
+static char system_type[CPI_LENGTH_NAME + 1];
+static u64 system_level;
+
+static void set_data(char *field, char *data)
+{
+	memset(field, ' ', CPI_LENGTH_NAME);
+	memcpy(field, data, strlen(data));
+	sclp_ascebc_str(field, CPI_LENGTH_NAME);
+}
+
+static void cpi_callback(struct sclp_req *req, void *data)
+{
+	struct completion *completion = data;
+
+	complete(completion);
+}
+
+static struct sclp_req *cpi_prepare_req(void)
+{
+	struct sclp_req *req;
+	struct cpi_sccb *sccb;
+	struct cpi_evbuf *evb;
+
+	req = kzalloc(sizeof(struct sclp_req), GFP_KERNEL);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+	sccb = (struct cpi_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sccb) {
+		kfree(req);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* setup SCCB for Control-Program Identification */
+	sccb->header.length = sizeof(struct cpi_sccb);
+	sccb->cpi_evbuf.header.length = sizeof(struct cpi_evbuf);
+	sccb->cpi_evbuf.header.type = 0x0b;
+	evb = &sccb->cpi_evbuf;
+
+	/* set system type */
+	set_data(evb->system_type, system_type);
+
+	/* set system name */
+	set_data(evb->system_name, system_name);
+
+	/* set sytem level */
+	evb->system_level = system_level;
+
+	/* set sysplex name */
+	set_data(evb->sysplex_name, sysplex_name);
+
+	/* prepare request data structure presented to SCLP driver */
+	req->command = SCLP_CMDW_WRITE_EVENT_DATA;
+	req->sccb = sccb;
+	req->status = SCLP_REQ_FILLED;
+	req->callback = cpi_callback;
+	return req;
+}
+
+static void cpi_free_req(struct sclp_req *req)
+{
+	free_page((unsigned long) req->sccb);
+	kfree(req);
+}
+
+static int cpi_req(void)
+{
+	struct completion completion;
+	struct sclp_req *req;
+	int rc;
+	int response;
+
+	rc = sclp_register(&sclp_cpi_event);
+	if (rc) {
+		printk(KERN_WARNING "cpi: could not register "
+			"to hardware console.\n");
+		goto out;
+	}
+	if (!(sclp_cpi_event.sclp_send_mask & EVTYP_CTLPROGIDENT_MASK)) {
+		printk(KERN_WARNING "cpi: no control program "
+			"identification support\n");
+		rc = -EOPNOTSUPP;
+		goto out_unregister;
+	}
+
+	req = cpi_prepare_req();
+	if (IS_ERR(req)) {
+		printk(KERN_WARNING "cpi: could not allocate request\n");
+		rc = PTR_ERR(req);
+		goto out_unregister;
+	}
+
+	init_completion(&completion);
+	req->callback_data = &completion;
+
+	/* Add request to sclp queue */
+	rc = sclp_add_request(req);
+	if (rc) {
+		printk(KERN_WARNING "cpi: could not start request\n");
+		goto out_free_req;
+	}
+
+	wait_for_completion(&completion);
+
+	if (req->status != SCLP_REQ_DONE) {
+		printk(KERN_WARNING "cpi: request failed (status=0x%02x)\n",
+			req->status);
+		rc = -EIO;
+		goto out_free_req;
+	}
+
+	response = ((struct cpi_sccb *) req->sccb)->header.response_code;
+	if (response != 0x0020) {
+		printk(KERN_WARNING "cpi: failed with "
+			"response code 0x%x\n", response);
+		rc = -EIO;
+	}
+
+out_free_req:
+	cpi_free_req(req);
+
+out_unregister:
+	sclp_unregister(&sclp_cpi_event);
+
+out:
+	return rc;
+}
+
+static int check_string(const char *attr, const char *str)
+{
+	size_t len;
+	size_t i;
+
+	len = strlen(str);
+
+	if ((len > 0) && (str[len - 1] == '\n'))
+		len--;
+
+	if (len > CPI_LENGTH_NAME)
+		return -EINVAL;
+
+	for (i = 0; i < len ; i++) {
+		if (isalpha(str[i]) || isdigit(str[i]) ||
+		    strchr("$@# ", str[i]))
+			continue;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void set_string(char *attr, const char *value)
+{
+	size_t len;
+	size_t i;
+
+	len = strlen(value);
+
+	if ((len > 0) && (value[len - 1] == '\n'))
+		len--;
+
+	for (i = 0; i < CPI_LENGTH_NAME; i++) {
+		if (i < len)
+			attr[i] = toupper(value[i]);
+		else
+			attr[i] = ' ';
+	}
+}
+
+static ssize_t system_name_show(struct kset *kset, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n", system_name);
+}
+
+static ssize_t system_name_store(struct kset *kset, const char *buf,
+	size_t len)
+{
+	int rc;
+
+	rc = check_string("system_name", buf);
+	if (rc)
+		return rc;
+
+	set_string(system_name, buf);
+
+	return len;
+}
+
+static struct subsys_attribute system_name_attr =
+	__ATTR(system_name, 0644, system_name_show, system_name_store);
+
+static ssize_t sysplex_name_show(struct kset *kset, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n", sysplex_name);
+}
+
+static ssize_t sysplex_name_store(struct kset *kset, const char *buf,
+	size_t len)
+{
+	int rc;
+
+	rc = check_string("sysplex_name", buf);
+	if (rc)
+		return rc;
+
+	set_string(sysplex_name, buf);
+
+	return len;
+}
+
+static struct subsys_attribute sysplex_name_attr =
+	__ATTR(sysplex_name, 0644, sysplex_name_show,
+	sysplex_name_store);
+
+static ssize_t system_type_show(struct kset *kset, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n", system_type);
+}
+
+static ssize_t system_type_store(struct kset *kset, const char *buf,
+	size_t len)
+{
+	int rc;
+
+	rc = check_string("system_type", buf);
+	if (rc)
+		return rc;
+
+	set_string(system_type, buf);
+
+	return len;
+}
+
+static struct subsys_attribute system_type_attr =
+	__ATTR(system_type, 0644, system_type_show, system_type_store);
+
+static ssize_t system_level_show(struct kset *kset, char *page)
+{
+	unsigned long long level = system_level;
+
+	return snprintf(page, PAGE_SIZE, "%#018llx\n", level);
+}
+
+static ssize_t system_level_store(struct kset *kset, const char *buf,
+	size_t len)
+{
+	unsigned long long level;
+	char *endp;
+
+	level = simple_strtoull(buf, &endp, 16);
+
+	if (endp == buf)
+		return -EINVAL;
+	if (*endp == '\n')
+		endp++;
+	if (*endp)
+		return -EINVAL;
+
+	system_level = level;
+
+	return len;
+}
+
+static struct subsys_attribute system_level_attr =
+	__ATTR(system_level, 0644, system_level_show,
+	system_level_store);
+
+static ssize_t set_store(struct kset *kset, const char *buf,
+	size_t len)
+{
+	int rc;
+
+	rc = cpi_req();
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+static struct subsys_attribute set_attr =
+	__ATTR(set, 0200, NULL, set_store);
+
+static struct attribute *cpi_attrs[] = {
+	&system_name_attr.attr,
+	&sysplex_name_attr.attr,
+	&system_type_attr.attr,
+	&system_level_attr.attr,
+	&set_attr.attr,
+	NULL,
+};
+
+static struct attribute_group cpi_attr_group = {
+	.attrs = cpi_attrs,
+};
+
+static decl_subsys(cpi, NULL, NULL);
+
+int sclp_cpi_set_data(const char *system, const char *sysplex, const char *type,
+		      const u64 level)
+{
+	int rc;
+
+	rc = check_string("system_name", system);
+	if (rc)
+		return rc;
+	rc = check_string("sysplex_name", sysplex);
+	if (rc)
+		return rc;
+	rc = check_string("system_type", type);
+	if (rc)
+		return rc;
+
+	set_string(system_name, system);
+	set_string(sysplex_name, sysplex);
+	set_string(system_type, type);
+	system_level = level;
+
+	return cpi_req();
+}
+EXPORT_SYMBOL(sclp_cpi_set_data);
+
+static int __init cpi_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&cpi_subsys);
+	if (rc)
+		return rc;
+
+	rc = sysfs_create_group(&cpi_subsys.kobj, &cpi_attr_group);
+	if (rc)
+		firmware_unregister(&cpi_subsys);
+
+	return rc;
+}
+
+__initcall(cpi_init);
diff -urpN linux-2.6/drivers/s390/char/sclp_cpi_sys.h linux-2.6-patched/drivers/s390/char/sclp_cpi_sys.h
--- linux-2.6/drivers/s390/char/sclp_cpi_sys.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi_sys.h	2007-11-16 14:27:46.000000000 +0100
@@ -0,0 +1,15 @@
+/*
+ *  drivers/s390/char/sclp_cpi_sys.h
+ *    SCLP control program identification sysfs interface
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Michael Ernst <mernst@de.ibm.com>
+ */
+
+#ifndef __SCLP_CPI_SYS_H__
+#define __SCLP_CPI_SYS_H__
+
+int sclp_cpi_set_data(const char *system, const char *sysplex,
+		      const char *type, u64 level);
+
+#endif	 /* __SCLP_CPI_SYS_H__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
