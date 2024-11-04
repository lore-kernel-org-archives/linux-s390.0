Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0061C07E5;
	Mon,  4 Nov 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736520; cv=none; b=NlBMizffosPU6FHd3DvCxYAC913brB+u551mvl8mwi2ZXbZoeodxWQFFgOVUXm2Ongi+Acr9FHxw8fn0Ct5h63Im3tO7cjd9np0S/kvbOkENpeikwj/7Jf9+VExquS9FcFYuC+rbwcw9Jd2qUjxbZSFtNfqQhMwEhG8WWB4hc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736520; c=relaxed/simple;
	bh=AKZxtJ4ffU13mmHVTasjpozRFhvW4v2i47Nv2xkHlUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPtsSZog0GqoMI+BHJufatStgq10tNiClLrUKperKyODszwxaXlZtA75JmJzq68MhOKul2dKuVgTi/V1/xIDBzvnfM2ybcm1U8Ir7d6nVMgZ3hrIhqBtpUlH9XmIS8Rdu+Z7csB070AJO9EdRT54/dj/1a+PjqP2cbAlnsyL2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T58QmFrh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T58QmFrh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4FeGol015296;
	Mon, 4 Nov 2024 16:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uCZFnTPm6MfL+4NTgwEJRO4AQGJM7gK8Yn7cfGTQO
	ig=; b=T58QmFrh07lglIZkr4JWJ0o8hwUhsch0SlZUoZoJrCKTNXjjpZC632/ih
	3Qz2KAqmTjoRXqy98xtAgKazkP+/y+vs9Hc8aOuOrYO8+zEjAWpDvebSDmGaxg/N
	ReL4V3B5aIivkui8Nv7C0pH1E/lemZmF3VDflrM208+nQqmLS+4mhxkd26blCotn
	+C/ASbcWH/hI/+oO5173VN/mBlZCjDlDqxqb1yeyWiDBdYhx8iaLKikyauGUgwaT
	JDGrB4KfZSaoviA5b3LN+d1BiUq4JtVV89KjXhAcWqTAPJiKWETJg5yM4EGiVvYM
	mSJnBqitKupLw7OPmklBb27tfx41g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42q14303nw-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 16:08:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4ENdFY023983;
	Mon, 4 Nov 2024 15:36:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxxj6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 15:36:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4Fa9lh33292978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 15:36:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C470320043;
	Mon,  4 Nov 2024 15:36:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5D7F20040;
	Mon,  4 Nov 2024 15:36:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 15:36:09 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
Subject: [PATCH v3] s390/uvdevice: Support longer secret lists
Date: Mon,  4 Nov 2024 16:36:09 +0100
Message-ID: <20241104153609.1361388-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zWPRhq9sGEdPvMOfHW1Z6BAxZL85Wj6f
X-Proofpoint-ORIG-GUID: zWPRhq9sGEdPvMOfHW1Z6BAxZL85Wj6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=826 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040137

Enable the list IOCTL to provide lists longer than one page (85 entries).
The list IOCTL now accepts any argument length in page granularity.
It fills the argument up to this length with entries until the list
ends. User space unaware of this enhancement will still receive one page
of data and an uv_rc 0x0100.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 v3: remove upper boundary (8 pages) for arg len

 drivers/s390/char/uvdevice.c | 71 ++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 1f90976293e8..7551b03d5f99 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -297,6 +297,43 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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
+		WARN_ON(copy_len > sizeof(list->secrets));
+
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
@@ -308,6 +345,12 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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
@@ -318,31 +361,21 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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

