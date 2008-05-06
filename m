Return-Path: <linux-kernel-owner+w=401wt.eu-S1765673AbYEFQGa@vger.kernel.org>
Message-Id: <20080506155111.731614953@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/8] cio: Fix parsing mechanism for blacklisted devices.
Content-Disposition: inline; filename=004-cio-blacklist.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

New format cssid.ssid.devno is now parsed correctly.

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |  324 ++++++++++++++++++++++---------------------
 1 file changed, 170 insertions(+), 154 deletions(-)

Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -19,6 +19,7 @@
 
 #include <asm/cio.h>
 #include <asm/uaccess.h>
+#include <asm/cio.h>
 
 #include "blacklist.h"
 #include "cio.h"
@@ -43,163 +44,169 @@ typedef enum {add, free} range_action;
  * Function: blacklist_range
  * (Un-)blacklist the devices from-to
  */
-static void
-blacklist_range (range_action action, unsigned int from, unsigned int to,
-		 unsigned int ssid)
-{
-	if (!to)
-		to = from;
-
-	if (from > to || to > __MAX_SUBCHANNEL || ssid > __MAX_SSID) {
-		printk (KERN_WARNING "cio: Invalid blacklist range "
-			"0.%x.%04x to 0.%x.%04x, skipping\n",
-			ssid, from, ssid, to);
-		return;
+static int blacklist_range(range_action action, unsigned int from_ssid,
+			   unsigned int to_ssid, unsigned int from,
+			   unsigned int to, int msgtrigger)
+{
+	if ((from_ssid > to_ssid) || ((from_ssid == to_ssid) && (from > to))) {
+		if (msgtrigger)
+			printk(KERN_WARNING "cio: Invalid cio_ignore range "
+			       "0.%x.%04x-0.%x.%04x\n", from_ssid, from,
+			       to_ssid, to);
+		return 1;
 	}
-	for (; from <= to; from++) {
+
+	while ((from_ssid < to_ssid) || ((from_ssid == to_ssid) &&
+	       (from <= to))) {
 		if (action == add)
-			set_bit (from, bl_dev[ssid]);
+			set_bit(from, bl_dev[from_ssid]);
 		else
-			clear_bit (from, bl_dev[ssid]);
+			clear_bit(from, bl_dev[from_ssid]);
+		from++;
+		if (from > __MAX_SUBCHANNEL) {
+			from_ssid++;
+			from = 0;
+		}
 	}
+
+	return 0;
 }
 
-/*
- * Function: blacklist_busid
- * Get devno/busid from given string.
- * Shamelessly grabbed from dasd_devmap.c.
- */
-static int
-blacklist_busid(char **str, int *id0, int *ssid, int *devno)
+static int pure_hex(char **cp, unsigned int *val, int min_digit,
+		    int max_digit, int max_val)
 {
-	int val, old_style;
-	char *sav;
+	int diff;
+	unsigned int value;
 
-	sav = *str;
+	diff = 0;
+	*val = 0;
 
-	/* check for leading '0x' */
-	old_style = 0;
-	if ((*str)[0] == '0' && (*str)[1] == 'x') {
-		*str += 2;
-		old_style = 1;
-	}
-	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		goto confused;
-	val = simple_strtoul(*str, str, 16);
-	if (old_style || (*str)[0] != '.') {
-		*id0 = *ssid = 0;
-		if (val < 0 || val > 0xffff)
-			goto confused;
-		*devno = val;
-		if ((*str)[0] != ',' && (*str)[0] != '-' &&
-		    (*str)[0] != '\n' && (*str)[0] != '\0')
-			goto confused;
-		return 0;
+	while (isxdigit(**cp) && (diff <= max_digit)) {
+
+		if (isdigit(**cp))
+			value = **cp - '0';
+		else
+			value = tolower(**cp) - 'a' + 10;
+		*val = *val * 16 + value;
+		(*cp)++;
+		diff++;
 	}
-	/* New style x.y.z busid */
-	if (val < 0 || val > 0xff)
-		goto confused;
-	*id0 = val;
-	(*str)++;
-	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		goto confused;
-	val = simple_strtoul(*str, str, 16);
-	if (val < 0 || val > 0xff || (*str)++[0] != '.')
-		goto confused;
-	*ssid = val;
-	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		goto confused;
-	val = simple_strtoul(*str, str, 16);
-	if (val < 0 || val > 0xffff)
-		goto confused;
-	*devno = val;
-	if ((*str)[0] != ',' && (*str)[0] != '-' &&
-	    (*str)[0] != '\n' && (*str)[0] != '\0')
-		goto confused;
+
+	if ((diff < min_digit) || (diff > max_digit) || (*val > max_val))
+		return 1;
+
 	return 0;
-confused:
-	strsep(str, ",\n");
-	printk(KERN_WARNING "cio: Invalid cio_ignore parameter '%s'\n", sav);
-	return 1;
 }
 
-static int
-blacklist_parse_parameters (char *str, range_action action)
+static int parse_busid(char *str, int *cssid, int *ssid, int *devno,
+		       int msgtrigger)
 {
-	int from, to, from_id0, to_id0, from_ssid, to_ssid;
+	char *str_work;
+	int val, rc, ret;
+
+	rc = 1;
 
-	while (*str != 0 && *str != '\n') {
-		range_action ra = action;
-		while(*str == ',')
-			str++;
-		if (*str == '!') {
-			ra = !action;
-			++str;
+	if (*str == '\0')
+		goto out;
+
+	/* old style */
+	str_work = str;
+	val = simple_strtoul(str, &str_work, 16);
+
+	if (*str_work == '\0') {
+		if (val <= __MAX_SUBCHANNEL) {
+			*devno = val;
+			*ssid = 0;
+			*cssid = 0;
+			rc = 0;
 		}
+		goto out;
+	}
 
-		/*
-		 * Since we have to parse the proc commands and the
-		 * kernel arguments we have to check four cases
-		 */
-		if (strncmp(str,"all,",4) == 0 || strcmp(str,"all") == 0 ||
-		    strncmp(str,"all\n",4) == 0 || strncmp(str,"all ",4) == 0) {
-			int j;
-
-			str += 3;
-			for (j=0; j <= __MAX_SSID; j++)
-				blacklist_range(ra, 0, __MAX_SUBCHANNEL, j);
+	/* new style */
+	str_work = str;
+	ret = pure_hex(&str_work, cssid, 1, 2, __MAX_CSSID);
+	if (ret || (str_work[0] != '.'))
+		goto out;
+	str_work++;
+	ret = pure_hex(&str_work, ssid, 1, 1, __MAX_SSID);
+	if (ret || (str_work[0] != '.'))
+		goto out;
+	str_work++;
+	ret = pure_hex(&str_work, devno, 4, 4, __MAX_SUBCHANNEL);
+	if (ret || (str_work[0] != '\0'))
+		goto out;
+
+	rc = 0;
+out:
+	if (rc && msgtrigger)
+		printk(KERN_WARNING "cio: Invalid cio_ignore device '%s'\n",
+		       str);
+
+	return rc;
+}
+
+static int blacklist_parse_parameters(char *str, range_action action,
+				      int msgtrigger)
+{
+	int from_cssid, to_cssid, from_ssid, to_ssid, from, to;
+	int rc, totalrc;
+	char *parm;
+	range_action ra;
+
+	totalrc = 0;
+
+	while ((parm = strsep(&str, ","))) {
+		rc = 0;
+		ra = action;
+		if (*parm == '!') {
+			if (ra == add)
+				ra = free;
+			else
+				ra = add;
+			parm++;
+		}
+		if (strcmp(parm, "all") == 0) {
+			from_cssid = 0;
+			from_ssid = 0;
+			from = 0;
+			to_cssid = __MAX_CSSID;
+			to_ssid = __MAX_SSID;
+			to = __MAX_SUBCHANNEL;
 		} else {
-			int rc;
-
-			rc = blacklist_busid(&str, &from_id0,
-					     &from_ssid, &from);
-			if (rc)
-				continue;
-			to = from;
-			to_id0 = from_id0;
-			to_ssid = from_ssid;
-			if (*str == '-') {
-				str++;
-				rc = blacklist_busid(&str, &to_id0,
-						     &to_ssid, &to);
-				if (rc)
-					continue;
-			}
-			if (*str == '-') {
-				printk(KERN_WARNING "cio: invalid cio_ignore "
-					"parameter '%s'\n",
-					strsep(&str, ",\n"));
-				continue;
+			rc = parse_busid(strsep(&parm, "-"), &from_cssid,
+					 &from_ssid, &from, msgtrigger);
+			if (!rc) {
+				if (parm != NULL)
+					rc = parse_busid(parm, &to_cssid,
+							 &to_ssid, &to,
+							 msgtrigger);
+				else {
+					to_cssid = from_cssid;
+					to_ssid = from_ssid;
+					to = from;
+				}
 			}
-			if ((from_id0 != to_id0) ||
-			    (from_ssid != to_ssid)) {
-				printk(KERN_WARNING "cio: invalid cio_ignore "
-				       "range %x.%x.%04x-%x.%x.%04x\n",
-				       from_id0, from_ssid, from,
-				       to_id0, to_ssid, to);
-				continue;
-			}
-			blacklist_range (ra, from, to, to_ssid);
 		}
+		if (!rc) {
+			rc = blacklist_range(ra, from_ssid, to_ssid, from, to,
+					     msgtrigger);
+			if (rc)
+				totalrc = 1;
+		} else
+			totalrc = 1;
 	}
-	return 1;
+
+	return totalrc;
 }
 
-/* Parsing the commandline for blacklist parameters, e.g. to blacklist
- * bus ids 0.0.1234, 0.0.1235 and 0.0.1236, you could use any of:
- * - cio_ignore=1234-1236
- * - cio_ignore=0x1234-0x1235,1236
- * - cio_ignore=0x1234,1235-1236
- * - cio_ignore=1236 cio_ignore=1234-0x1236
- * - cio_ignore=1234 cio_ignore=1236 cio_ignore=0x1235
- * - cio_ignore=0.0.1234-0.0.1236
- * - cio_ignore=0.0.1234,0x1235,1236
- * - ...
- */
 static int __init
 blacklist_setup (char *str)
 {
-	return blacklist_parse_parameters (str, add);
+	CIO_MSG_EVENT(6, "Reading blacklist parameters\n");
+	if (blacklist_parse_parameters(str, add, 1))
+		return 0;
+	return 1;
 }
 
 __setup ("cio_ignore=", blacklist_setup);
@@ -223,27 +230,23 @@ is_blacklisted (int ssid, int devno)
  * Function: blacklist_parse_proc_parameters
  * parse the stuff which is piped to /proc/cio_ignore
  */
-static void
-blacklist_parse_proc_parameters (char *buf)
+static int blacklist_parse_proc_parameters(char *buf)
 {
-	if (strncmp (buf, "free ", 5) == 0) {
-		blacklist_parse_parameters (buf + 5, free);
-	} else if (strncmp (buf, "add ", 4) == 0) {
-		/* 
-		 * We don't need to check for known devices since
-		 * css_probe_device will handle this correctly. 
-		 */
-		blacklist_parse_parameters (buf + 4, add);
-	} else {
-		printk (KERN_WARNING "cio: cio_ignore: Parse error; \n"
-			KERN_WARNING "try using 'free all|<devno-range>,"
-				     "<devno-range>,...'\n"
-			KERN_WARNING "or 'add <devno-range>,"
-				     "<devno-range>,...'\n");
-		return;
-	}
+	int rc;
+	char *parm;
+
+	parm = strsep(&buf, " ");
+
+	if (strcmp("free", parm) == 0)
+		rc = blacklist_parse_parameters(buf, free, 0);
+	else if (strcmp("add", parm) == 0)
+		rc = blacklist_parse_parameters(buf, add, 0);
+	else
+		return 1;
 
 	css_schedule_reprobe();
+
+	return rc;
 }
 
 /* Iterator struct for all devices. */
@@ -327,6 +330,8 @@ cio_ignore_write(struct file *file, cons
 		 size_t user_len, loff_t *offset)
 {
 	char *buf;
+	size_t i;
+	ssize_t rc, ret;
 
 	if (*offset)
 		return -EINVAL;
@@ -335,16 +340,27 @@ cio_ignore_write(struct file *file, cons
 	buf = vmalloc (user_len + 1); /* maybe better use the stack? */
 	if (buf == NULL)
 		return -ENOMEM;
+	memset(buf, 0, user_len + 1);
+
 	if (strncpy_from_user (buf, user_buf, user_len) < 0) {
-		vfree (buf);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out_free;
 	}
-	buf[user_len] = '\0';
 
-	blacklist_parse_proc_parameters (buf);
+	i = user_len - 1;
+	while ((i >= 0) && (isspace(buf[i]) || (buf[i] == 0))) {
+		buf[i] = '\0';
+		i--;
+	}
+	ret = blacklist_parse_proc_parameters(buf);
+	if (ret)
+		rc = -EINVAL;
+	else
+		rc = user_len;
 
+out_free:
 	vfree (buf);
-	return user_len;
+	return rc;
 }
 
 static const struct seq_operations cio_ignore_proc_seq_ops = {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
