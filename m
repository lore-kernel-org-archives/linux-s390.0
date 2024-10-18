Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAF1E6311;
	Fri, 18 Oct 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242924; cv=none; b=qzlsp4HJMGiImTLX9otW8sKiWWntNNbR6GFJnTGHYlWdtGWXqnkXCyUFUl7AjtVZ3cy5YD3InbdjNGtSb9PXhZYiOS4UZLeKxxxahhOqkpeFOEpoiAkAZVX/UkadyGBgMa6kSFf4M5Gh9MrFrvc7gndCyhsMUvlhI5p/5JHXE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242924; c=relaxed/simple;
	bh=nfk7dt65jJjWZmAtFjmFG6B7l/XhyncOEeN6Nappz88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxcvjhRuc4Pt1B2k6tb2MoR+Srg9evbZDBNB149u3Yvo/Qc6sPdoFviOCpSzPShZeWQsqlYcW/a6ksHiD4nRmKVOpn50TobSvwZUiVS6XnubDWjsX+EU1ko61xNakEXBBveqOxpy5BO7UEaFjEppKzF4X9gTRqN0Po8JMN0eX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hqp/QdfV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hqp/QdfV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSjch015438;
	Fri, 18 Oct 2024 09:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S72ioC8n+E+bZYJOU
	ZR5Re6bzpqAkyOB+MQF1/vD8z8=; b=hqp/QdfVo5LKjJ0mXaNNuTXhdFdgYUon+
	gBHiJ6qOX1gAS7T20tVei2Ptb4GwgkBsoUk9s3xCFQ5/NAFsjmX1ADs0hZG7+/B0
	mfP/Er/xPHN1vGVOk1ATo9A4lm75kKpHffKCpCewk0ha04AI8ArZdtzC7B9jlw1b
	ffp54UWfoUWFiaVzdjHHsXl0wrrLfDAtEH+u69/7IpkhrFm4QBgfaH6GWXUOZ/NX
	1W4yk5FYgMS7EZgj0emxZjgWeExU2Qfjri3v2gQpckOZlZNYEFAT/OYigJ7Sd844
	nbxytlEGFGapuG/KRvI1TDLP4Uc8+C/L1ew4lr4Tb5nfrwJH54XHg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgr7t3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7UkYh006663;
	Fri, 18 Oct 2024 09:15:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283esbr6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I9FHLb42729944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470302004D;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2821F2005A;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 3/6] s390/uvdevice: Add Retrieve Secret IOCTL
Date: Fri, 18 Oct 2024 11:15:13 +0200
Message-ID: <20241018091516.2167885-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018091516.2167885-1-seiden@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: slrt80rT1_rwY5gnSPtcP_6HRJkBDq53
X-Proofpoint-GUID: slrt80rT1_rwY5gnSPtcP_6HRJkBDq53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=849 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180056

Add a new IOCL number to support the new Retrieve Secret UVC for
user-space.
User-space provides the index of the secret (u16) to retrieve.
The uvdevice calls the Retrieve Secret UVC and copies the secret into
the provided buffer if it fits. To get the secret type, index, and size
user-space needs to call the List UVC first.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h |  6 ++-
 drivers/s390/char/uvdevice.c          | 58 ++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index b9c2f14a6af3..2ee5bfc61800 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- *  Copyright IBM Corp. 2022
+ *  Copyright IBM Corp. 2022, 2024
  *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
  */
 #ifndef __S390_ASM_UVDEVICE_H
@@ -71,6 +71,7 @@ struct uvio_uvdev_info {
 #define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
 #define UVIO_ADD_SECRET_MAX_LEN		0x100000
 #define UVIO_LIST_SECRETS_LEN		0x1000
+#define UVIO_RETR_SECRET_MAX_LEN	0x2000
 
 #define UVIO_DEVICE_NAME "uv"
 #define UVIO_TYPE_UVC 'u'
@@ -81,6 +82,7 @@ enum UVIO_IOCTL_NR {
 	UVIO_IOCTL_ADD_SECRET_NR,
 	UVIO_IOCTL_LIST_SECRETS_NR,
 	UVIO_IOCTL_LOCK_SECRETS_NR,
+	UVIO_IOCTL_RETR_SECRET_NR,
 	/* must be the last entry */
 	UVIO_IOCTL_NUM_IOCTLS
 };
@@ -91,6 +93,7 @@ enum UVIO_IOCTL_NR {
 #define UVIO_IOCTL_ADD_SECRET	UVIO_IOCTL(UVIO_IOCTL_ADD_SECRET_NR)
 #define UVIO_IOCTL_LIST_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_IOCTL_LOCK_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_IOCTL_RETR_SECRET	UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
 
 #define UVIO_SUPP_CALL(nr)	(1ULL << (nr))
 #define UVIO_SUPP_UDEV_INFO	UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
@@ -98,5 +101,6 @@ enum UVIO_IOCTL_NR {
 #define UVIO_SUPP_ADD_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_ADD_SECRET_NR)
 #define UVIO_SUPP_LIST_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_SUPP_LOCK_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_SUPP_RETR_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
 
 #endif /* __S390_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index f598edc5f251..1f90976293e8 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright IBM Corp. 2022
+ *  Copyright IBM Corp. 2022, 2024
  *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
  *
  *  This file provides a Linux misc device to give userspace access to some
@@ -40,6 +40,7 @@ static const u32 ioctl_nr_to_uvc_bit[] __initconst = {
 	[UVIO_IOCTL_ADD_SECRET_NR] = BIT_UVC_CMD_ADD_SECRET,
 	[UVIO_IOCTL_LIST_SECRETS_NR] = BIT_UVC_CMD_LIST_SECRETS,
 	[UVIO_IOCTL_LOCK_SECRETS_NR] = BIT_UVC_CMD_LOCK_SECRETS,
+	[UVIO_IOCTL_RETR_SECRET_NR] = BIT_UVC_CMD_RETR_ATTEST,
 };
 
 static_assert(ARRAY_SIZE(ioctl_nr_to_uvc_bit) == UVIO_IOCTL_NUM_IOCTLS);
@@ -379,6 +380,58 @@ static int uvio_lock_secrets(struct uvio_ioctl_cb *ioctl)
 	return 0;
 }
 
+/**
+ * uvio_retr_secret() - perform a retrieve secret UVC.
+ * @uv_ioctl: ioctl control block.
+ *
+ * uvio_retr_secret() performs the Retrieve Secret Ultravisor Call.
+ * The first two bytes of the argument specify the index of the secret to be
+ * retrieved. The retrieved secret is copied into the argument buffer if there
+ * is enough space.
+ * The argument length must be at least two bytes and at max 8192 bytes.
+ *
+ * Context: might sleep.
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_retr_secret(struct uvio_ioctl_cb *uv_ioctl)
+{
+	u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
+	struct uv_cb_retr_secr uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_RETR_SECRET,
+	};
+	u32 buf_len = uv_ioctl->argument_len;
+	void *buf = NULL;
+	int ret;
+
+	if (buf_len > UVIO_RETR_SECRET_MAX_LEN || buf_len < sizeof(*user_index))
+		return -EINVAL;
+
+	buf = kvzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (get_user(uvcb.secret_idx, user_index))
+		goto err;
+
+	uvcb.buf_addr = (u64)buf;
+	uvcb.buf_size = buf_len;
+	uv_call_sched(0, (u64)&uvcb);
+
+	if (copy_to_user((__user void *)uv_ioctl->argument_addr, buf, buf_len))
+		goto err;
+
+	ret = 0;
+	uv_ioctl->uv_rc = uvcb.header.rc;
+	uv_ioctl->uv_rrc = uvcb.header.rrc;
+
+err:
+	kvfree_sensitive(buf, buf_len);
+	return ret;
+}
+
 static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp,
 				     unsigned long cmd)
 {
@@ -432,6 +485,9 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case UVIO_IOCTL_LOCK_SECRETS_NR:
 		ret = uvio_lock_secrets(&uv_ioctl);
 		break;
+	case UVIO_IOCTL_RETR_SECRET_NR:
+		ret = uvio_retr_secret(&uv_ioctl);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.45.2

