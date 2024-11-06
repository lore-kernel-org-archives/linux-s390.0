Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1C1DED58;
	Wed,  6 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895936; cv=none; b=PSEIq9eAU/I34Bz4hhRXq5VN4Ob6ivR4doBTM+TJH+31fg1X1cdxO5U5Ic2v0H5mWd0Juyo/mDsJ+gGyAR1rjAFJT9PM8w007zolT5Uuu/ZvCFqGdll0ttsaSrxiGiEqEd6DjsbH9JdZCJbapd9UPTgsOvwn4kdBnG3hMSxVH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895936; c=relaxed/simple;
	bh=/b8UrPQJwW2sNhuczGQ6b+KXkJ3vIhF9YdXxffKTmG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzS4+ERB3TdxvAWv2L1xTYmncEd8Ozuu2ouAX0Gr9l+7VljNeXyn7v6vjF2+7H+/kyE5kg5y97eWWGCcqHmP1eDRbeIrXDB6Evsp72tD4+NniffgwJTqzvzrR0lT7iLr6hMCZbutjKgNjPzouqVnKwhpvKg/VQda1EGsSdoZIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h4Lb0/eh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h4Lb0/eh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CA1Vq000422;
	Wed, 6 Nov 2024 12:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a6pb5bfwDq7BZ2tyP
	J6CcAP5nys9lC/eq4N0Yls3VuI=; b=h4Lb0/ehSuxiIyFH1hqA4UkZ+wTQU9L9j
	Z+vKpItO/NfJVMiRZaD8iU/x8QuJR8+kvxwpIAPjmOdAwo61yCfi8I85JW2YKlW1
	DBCsYUJavqkHNOwzhcJRAQIZKwpBLb6motZchBiGPTLnNvdzGU6QKLng7z9Hbt0Q
	HE29HCCrlPIbrIwGsUrFfJ3Um/tiMNEfOs2l10Kabl1tU6/ef6xSnTUxggUe/zXJ
	nHg8dtMkjFyIi9V6RlqPgVPNScxf1y/U47lMk0t6Cip+Ab8Vx5UZP5E6hGuk/ljc
	BzFkE71A6pgH30kfirnkxzP0Cy5IwkK7VeHnCsmSziIkHqrKVp/7A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r87j82jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 12:25:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A66HMEi019503;
	Wed, 6 Nov 2024 12:25:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj61sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 12:25:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6CPTt746006628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 12:25:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C9CC20043;
	Wed,  6 Nov 2024 12:25:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA33020040;
	Wed,  6 Nov 2024 12:25:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 12:25:28 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: seiden@linux.ibm.com
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, ifranzki@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, schlameuss@linux.ibm.com
Subject: [PATCH v4] s390/uvdevice: Support longer secret lists
Date: Wed,  6 Nov 2024 13:25:28 +0100
Message-ID: <20241106122528.1690511-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104153609.1361388-1-seiden@linux.ibm.com>
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ppiVV3jiZgRR6qu3n-yisE5lW2Ds6s5k
X-Proofpoint-ORIG-GUID: ppiVV3jiZgRR6qu3n-yisE5lW2Ds6s5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=906 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060099

Enable the list IOCTL to provide lists longer than one page (85 entries).
The list IOCTL now accepts any argument length in page granularity.
It fills the argument up to this length with entries until the list
ends. User space unaware of this enhancement will still receive one page
of data and an uv_rc 0x0100.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
v4: add r-b, remove WARN

 drivers/s390/char/uvdevice.c | 69 ++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 1f90976293e8..c5c8dd13590a 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -297,6 +297,41 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/*
+ * Do the actual secret list creation. Calls the list secrets UVC until there
+ * is no more space in the user buffer, or the list ends.
+ */
+static int uvio_get_list(void *zpage, struct uvio_ioctl_cb *uv_ioctl)
+{
+	const size_t data_off = offsetof(struct uv_secret_list, secrets);
+	u8 __user *user_buf = (u8 __user *)uv_ioctl->argument_addr;
+	struct uv_secret_list *list = zpage;
+	u16 num_secrets_stored = 0;
+	size_t user_off = data_off;
+	size_t copy_len;
+
+	do {
+		uv_list_secrets(list, list->next_secret_idx, &uv_ioctl->uv_rc,
+				&uv_ioctl->uv_rrc);
+		if (uv_ioctl->uv_rc != UVC_RC_EXECUTED &&
+		    uv_ioctl->uv_rc != UVC_RC_MORE_DATA)
+			break;
+
+		copy_len = sizeof(list->secrets[0]) * list->num_secr_stored;
+		if (copy_to_user(user_buf + user_off, list->secrets, copy_len))
+			return -EFAULT;
+
+		user_off += copy_len;
+		num_secrets_stored += list->num_secr_stored;
+	} while (uv_ioctl->uv_rc == UVC_RC_MORE_DATA &&
+		 user_off + sizeof(*list) <= uv_ioctl->argument_len);
+
+	list->num_secr_stored = num_secrets_stored;
+	if (copy_to_user(user_buf, list, data_off))
+		return -EFAULT;
+	return 0;
+}
+
 /** uvio_list_secrets() - perform a List Secret UVC
  * @uv_ioctl: ioctl control block
  *
@@ -308,6 +343,12 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
  *
  * The argument specifies the location for the result of the UV-Call.
  *
+ * Argument length must be a multiple of a page.
+ * The list secrets IOCTL will call the list UVC multiple times and fill
+ * the provided user-buffer with list elements until either the list ends or
+ * the buffer is full. The list header is merged over all list header from the
+ * individual UVCs.
+ *
  * If the List Secrets UV facility is not present, UV will return invalid
  * command rc. This won't be fenced in the driver and does not result in a
  * negative return value.
@@ -318,31 +359,21 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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
+	void *zpage = NULL;
+	int rc;
 
-	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
+	if (uv_ioctl->argument_len == 0 ||
+	    uv_ioctl->argument_len % UVIO_LIST_SECRETS_LEN != 0)
 		return -EINVAL;
 
-	secrets = kvzalloc(UVIO_LIST_SECRETS_LEN, GFP_KERNEL);
-	if (!secrets)
+	zpage = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!zpage)
 		return -ENOMEM;
 
-	uvcb.addr = (u64)secrets;
-	uv_call_sched(0, (u64)&uvcb);
-	uv_ioctl->uv_rc = uvcb.header.rc;
-	uv_ioctl->uv_rrc = uvcb.header.rrc;
-
-	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
-		ret = -EFAULT;
+	rc = uvio_get_list(zpage, uv_ioctl);
 
-	kvfree(secrets);
-	return ret;
+	free_page((unsigned long)zpage);
+	return rc;
 }
 
 /** uvio_lock_secrets() - perform a Lock Secret Store UVC
-- 
2.45.2

