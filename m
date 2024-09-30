Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E511917FB;
	Mon, 30 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702360; cv=none; b=TWufvcxgzLfX/MhN1Z8coaiSnz+TtO9PGZCdmOQ+Vj0RWAVpTe60hsqEXQ3bd2/cV4npUNe9+r5FbgSfdUppUojbXanOt2NHGbJIS3KuZgCVyQtELto3VQxTnv4yTaajAs8dUNapkgIN5KzWytUBsecRK/MJpBntwEFGy6VJvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702360; c=relaxed/simple;
	bh=O9OZxtpsVV9NWutSd1wKJ39pXnqPj2/MJUfDnIS2QV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iwyq1AtkojyLTcVhdTkuyJsjRI5Qc/Bu/1VEMbvl7hUgVm2IiVZWQjSIsi591+6xTFof8aoL3kd1sHR2rA+SkfL1NEBM9maHZ0cS16bh75mWtadSIraAi+rW3OiHYCOaJCF6naN+5zrqti3rNrCbS9KuejZ/LExmton9EOLEJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rlmbov/f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rlmbov/f"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBjnFi010428;
	Mon, 30 Sep 2024 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=WoxA8hlr0RcUf
	3J8FKaH1r9nXy+CmYr1IfgzJh32180=; b=Rlmbov/fmfigwOMtQ3cDLgZyA+fvc
	fJG4/dIapmttXqGvKLENSEnlZxon4tURWoNImeB4jZlY+qYgP1WhGtR+rThRlhWv
	zCfxTf6BSo/RrW1ijdrtTlo66YBVh8qcTrXeZoVFedmbM3/QUzu7vWH8o00m7cuJ
	9LmuJH2X5MSWEEhaPgb6Hyn4tvlp5eYOd7cgZD/5n8lVUWxtG05L9wtqUZwB6fri
	1AmS9O0l/HXo6aI0YnprPWlPffRc2e+WOEZ99ZsQEOMwZuaa0xfVIynH9w96OONG
	jbf+1gIcZssMeDDV6N4Li3/99Kxq883VZlZbPZteoK68UBfX92C8APH5Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khr27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB7TR2014151;
	Mon, 30 Sep 2024 13:19:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjxkmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJBHD50659798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B333E2004B;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786092004F;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
Date: Mon, 30 Sep 2024 15:19:08 +0200
Message-ID: <20240930131909.2079965-6-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: LK5_ys1Bm_5I_IlUN4zh_51KpwDW1JPV
X-Proofpoint-ORIG-GUID: LK5_ys1Bm_5I_IlUN4zh_51KpwDW1JPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
this accepts an index as the first two bytes of the provided page as an
input. This index is then taken as the index offset for the list UVC to
receive later entries for the list.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h |  4 ++
 drivers/s390/char/uvdevice.c          | 96 ++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index 72c188f7819f..9891cce99c23 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -72,6 +72,7 @@ struct uvio_uvdev_info {
 #define UVIO_ADD_SECRET_MAX_LEN		0x100000
 #define UVIO_LIST_SECRETS_LEN		0x1000
 #define UVIO_RETR_SECRET_MAX_LEN	0x2000
+#define UVIO_LIST_SECRETS_EXT_LEN	UVIO_LIST_SECRETS_LEN
 
 #define UVIO_DEVICE_NAME "uv"
 #define UVIO_TYPE_UVC 'u'
@@ -83,6 +84,7 @@ enum UVIO_IOCTL_NR {
 	UVIO_IOCTL_LIST_SECRETS_NR,
 	UVIO_IOCTL_LOCK_SECRETS_NR,
 	UVIO_IOCTL_RETR_SECRET_NR,
+	UVIO_IOCTL_LIST_SECRETS_EXT_NR,
 	/* must be the last entry */
 	UVIO_IOCTL_NUM_IOCTLS
 };
@@ -94,6 +96,7 @@ enum UVIO_IOCTL_NR {
 #define UVIO_IOCTL_LIST_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_IOCTL_LOCK_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
 #define UVIO_IOCTL_RETR_SECRET		UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_IOCTL_LIST_SECRETS_EXT	UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_EXT_NR)
 
 #define UVIO_SUPP_CALL(nr)		(1ULL << (nr))
 #define UVIO_SUPP_UDEV_INFO		UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
@@ -102,5 +105,6 @@ enum UVIO_IOCTL_NR {
 #define UVIO_SUPP_LIST_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_SUPP_LOCK_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
 #define UVIO_SUPP_RETR_SECRET		UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_SUPP_LIST_SECRETS_EXT	UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_EXT_NR)
 
 #endif /* __S390_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index b200dd2164db..c92ce39b22c6 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -41,6 +41,7 @@ static const u32 ioctl_nr_to_uvc_bit[] __initconst = {
 	[UVIO_IOCTL_LIST_SECRETS_NR] = BIT_UVC_CMD_LIST_SECRETS,
 	[UVIO_IOCTL_LOCK_SECRETS_NR] = BIT_UVC_CMD_LOCK_SECRETS,
 	[UVIO_IOCTL_RETR_SECRET_NR] = BIT_UVC_CMD_RETR_ATTEST,
+	[UVIO_IOCTL_LIST_SECRETS_EXT_NR] = BIT_UVC_CMD_LIST_SECRETS,
 };
 
 static_assert(ARRAY_SIZE(ioctl_nr_to_uvc_bit) == UVIO_IOCTL_NUM_IOCTLS);
@@ -297,6 +298,44 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/* The actual list(_ext) IOCTL.
+ * If list_ext is true, the first two bytes of the user buffer set the starting index of the
+ * list-UVC
+ */
+static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
+{
+	void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
+	u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
+	u16 start_idx = 0;
+	u8 *secrets = NULL;
+	int ret;
+
+	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
+		return -EINVAL;
+
+	BUILD_BUG_ON(UVIO_LIST_SECRETS_LEN != PAGE_SIZE);
+	secrets = (u8 *)get_zeroed_page(GFP_KERNEL);
+	if (!secrets)
+		return -ENOMEM;
+
+	// The extended call accepts an u16 index as input
+	ret = -EFAULT;
+	if (list_ext) {
+		if (get_user(start_idx, user_index))
+			goto err;
+	}
+
+	uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc);
+
+	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
+		goto err;
+	ret = 0;
+
+err:
+	free_pages((unsigned long)secrets, 0);
+	return ret;
+}
+
 /** uvio_list_secrets() - perform a List Secret UVC
  * @uv_ioctl: ioctl control block
  *
@@ -318,31 +357,7 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
  */
 static int uvio_list_secrets(struct uvio_ioctl_cb *uv_ioctl)
 {
-	void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
-	struct uv_cb_guest_addr uvcb = {
-		.header.len = sizeof(uvcb),
-		.header.cmd = UVC_CMD_LIST_SECRETS,
-	};
-	void *secrets = NULL;
-	int ret = 0;
-
-	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
-		return -EINVAL;
-
-	secrets = kvzalloc(UVIO_LIST_SECRETS_LEN, GFP_KERNEL);
-	if (!secrets)
-		return -ENOMEM;
-
-	uvcb.addr = (u64)secrets;
-	uv_call_sched(0, (u64)&uvcb);
-	uv_ioctl->uv_rc = uvcb.header.rc;
-	uv_ioctl->uv_rrc = uvcb.header.rrc;
-
-	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
-		ret = -EFAULT;
-
-	kvfree(secrets);
-	return ret;
+	return list_secrets(uv_ioctl, false);
 }
 
 /** uvio_lock_secrets() - perform a Lock Secret Store UVC
@@ -432,6 +447,34 @@ static int uvio_retr_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/** uvio_list_secrets_ext() - perform a List Secret UVC with a starting index
+ * @uv_ioctl: ioctl control block
+ *
+ * uvio_list_secrets_ext() performs the List Secret Ultravisor Call. It verifies
+ * that the given userspace argument address is valid and its size is sane.
+ * Every other check is made by the Ultravisor (UV) and won't result in a
+ * negative return value. It builds the request, performs the UV-call, and
+ * copies the result to userspace.
+ *
+ * The argument specifies the location for the result of the UV-Call.
+ * The first two bytes of the argument specify the starting index of the list.
+ * This should be zero for the first IOCTL. If UV reports more data (rc UVC_RC_MORE_DATA)
+ * another list_ext IOCTL with a higher starting index shows the following
+ * entries of the secret list.
+ *
+ * If the List Secrets UV facility is not present, UV will return invalid
+ * command rc. This won't be fenced in the driver and does not result in a
+ * negative return value.
+ *
+ * Context: might sleep
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_list_secrets_ext(struct uvio_ioctl_cb *uv_ioctl)
+{
+	return list_secrets(uv_ioctl, true);
+}
+
 static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp,
 				     unsigned long cmd)
 {
@@ -488,6 +531,9 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case UVIO_IOCTL_RETR_SECRET_NR:
 		ret = uvio_retr_secret(&uv_ioctl);
 		break;
+	case UVIO_IOCTL_LIST_SECRETS_EXT_NR:
+		ret = uvio_list_secrets_ext(&uv_ioctl);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.43.0

