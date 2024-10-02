Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9971D0E17;
	Wed,  2 Oct 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885142; cv=none; b=LewZDsMvsGaCC55G2mJMqU7c2+SjWWSXCIHV2oHghtBFEqKua9PUrT/TEHpx1U7fpQLd6FaQxlb+2OcwlNWxdA7/BumXsFMV6+f/+tX1lvCt/5vgp52odf8wjUAPUDDaRpygs9EW+iub7FA0f+mS4cB21GSc4Q2o9r7K8ExAbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885142; c=relaxed/simple;
	bh=Inh1KSobfWMWsSoqMhnaTIR9CAsUFQlbukZ5okH+/Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2ANOvhcXXF+v3Ul3pi0SbEG4uN9sHeD3+mfYKy52MUI57kL5jhPFMlrhVF5sH37amhaRu4f3Bu842W3wdYlZJPnU8s4nXhO5SQ/nIqn23iutYivPdbR5u6pHs67ZvqJ31hNk7yiiQv6/6SNB54c41v3Uw5q5aOIbqr66wmGaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PbaVQogt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PbaVQogt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Fm3O6013619;
	Wed, 2 Oct 2024 16:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HPf8fU8IGy0sK
	Uml9mZXBjw4pcctP0dr2LxUaDjnmFM=; b=PbaVQogtpGL8MhTP5aDkwo0cZ393v
	mZy6IXoEgh+jckT/YOt7PclA1DSmGw1AVEwv6vyJqpU8TxeJbK3UlTSlgCQDXOUW
	4cTsF/MzWolfvjj9sX9GbgvuVlG9c9eAPAvEW538/KBdRJpXrdxenkGv/DIl7uTG
	N+f3uu4pvdS11AdPCyKYyWYPPTx80QY2BrmQIqpenJSSaUc4gK1Id+mlFmFidUbA
	Yd7EsI6qcBLp1vY/GryQf/3RsLob3eEhTL/uDB1zhRmgAShcO4Kg1LQYGJ6K/JZI
	pU/yN2GIdmUSCilPCmyhGP/BO2h2mjRLfAQ9aJIWttQjvHmQ8glelXT7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42194mg356-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492DnUU7014157;
	Wed, 2 Oct 2024 16:05:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmkb3yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G5YqG20054348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:05:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD5820040;
	Wed,  2 Oct 2024 16:05:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F84D2004B;
	Wed,  2 Oct 2024 16:05:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:05:34 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 3/6] s390/uvdevice: Add Retrieve Secret IOCTL
Date: Wed,  2 Oct 2024 18:05:29 +0200
Message-ID: <20241002160532.2425734-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160532.2425734-1-seiden@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: asIt8sH7fpBlJ_03v1tUADfZw8iOyThT
X-Proofpoint-ORIG-GUID: asIt8sH7fpBlJ_03v1tUADfZw8iOyThT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=804 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

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
index f598edc5f251..aa56d9e1d045 100644
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

