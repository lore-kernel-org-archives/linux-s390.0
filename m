Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4818FDA9;
	Mon, 30 Sep 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702360; cv=none; b=HIaL0c0DthbrY8RhjuUG7OK8lzvw+nFTqeweib9JCSforj+4iRGy7yqQ+v9d1bXLwUsZ5anev2JsyI1k0Ie3l6/jeZkhLDB7GErNYADHUNDiusTRIL1PlpSNBhrgWY6i+I/o+sxFSqyf78GBJezrBxhrNeIIK2e6FTGOfrInhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702360; c=relaxed/simple;
	bh=2L1kTdyyC8FES7jRE5UfukPGd/M56OiHf0UhrtC0yFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQxPyaMTAUAla0bpcmtOB/3pp2UdGCqozB3aG3NJoi23AnJiaVqimVP6psTIlyI/6EgMuYB8c75yGgcPL32udt9iBFPo+5PyMKlu4/PcI3N6S8BSz5nKVpH6pRIq/mfJR1dfmrJzaEd52JrN+DIIqYV7pnFXkCTsgMlv5xTZFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JEjPjDVN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JEjPjDVN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TNF9UA020936;
	Mon, 30 Sep 2024 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=omlO6443wsKHh
	W6aGzc7+l3MHwhEODutImFsp7GHX28=; b=JEjPjDVNzL+9YbxHoObqSnv6VNJfs
	m/H1Prgh/ByZzoUQa4NwyYwSdaHXc5+JHAt2zOJzM2lN66sfhS1Y/Gt80IBQKWBc
	ImwlLp7Txa0SXLoJP5hJUo1ECdyy/cCae06OxRYrbMI2SMukXTAvpsk7u8sPYEfg
	CFKPMLnTHeJIyjTDtPWfyCM2sNy8YE267foeMcnJ7BBcaiiktee9lAXSjZ73dbLb
	2DZEFF0uy5pO7Va/Cgp6E9bg5lBHcii3voVOVQAUgJvTM1Arl2TSs0gyc23aJMwh
	wUBAW6l6t9IfHWBQGXgDzDcBRbghpP5s68bKBEPdrX7IeWae0FvfdmqCQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt0b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB7TR1014151;
	Mon, 30 Sep 2024 13:19:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjxkme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJBcQ54264254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29FF520049;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35F92004D;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 3/6] s390/uvdevice: Add Retrieve Secret IOCTL
Date: Mon, 30 Sep 2024 15:19:06 +0200
Message-ID: <20240930131909.2079965-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930131909.2079965-1-seiden@linux.ibm.com>
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aNbzjemHijwcUakIrUDcG8ex_vGY3E0s
X-Proofpoint-GUID: aNbzjemHijwcUakIrUDcG8ex_vGY3E0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=804 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Add a new IOCL number to support the new Retrieve Secret UVC for
user-space.
User-space provides the index of the secret (u16) to retrieve.
The uvdevice calls the Retrieve Secret UVC and copies the secret into
the provided buffer if it fits. To get the secret type, index, and size
user-space needs to call the List UVC first.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h |  4 ++
 drivers/s390/char/uvdevice.c          | 56 +++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index b9c2f14a6af3..70657e87d130 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
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
index 42c9f77f8da0..b200dd2164db 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
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
+ * uvio_retr_secret() - perform a retrieve secret UVC
+ * @uv_ioctl: ioctl control block
+ *
+ * uvio_retr_secret() performs the Retrieve Secret Ultravisor Call.
+ * The first two bytes of the argument specify the index of the secret to be
+ * retrieved. The retrieved secret is copied into the argument buffer if there
+ * is enough space.
+ * The argument length must be at least two bytes and at max 8192
+ *
+ * Context: might sleep
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
2.43.0

