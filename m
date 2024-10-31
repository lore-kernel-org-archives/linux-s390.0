Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9F19538D;
	Thu, 31 Oct 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368739; cv=none; b=ld0rCyOR5uDpQ+fxVppx06ZeT0dU1+F/JjkUMDJ9L+5LmBWIGyi1QosmHlGAzMDqbaN2/UKrc50ZKKvG7P1ZoeJR9YQSttbYPkwPRbQLtTdqyJpv15fTqtq0/CJ8tLhmql1rMNH9++2XRpAwWCat0Uqn8YhfaNfvWk3yRQEy4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368739; c=relaxed/simple;
	bh=+ayMeQelMoVwDcllnti8Ixel1VjIXot/5wDHLedscUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw/7Zj0o2EINQyqGM4NbjkQ1s1haxDhhEEnUwOjHM0FkCcBcZj5aAhoyXWWpMQQGA5407MiT34FcHWhA9AF+nandh6VksEw+kTihgiYvQUZxzxCxNQEFu6njK7k7dVjQa5QIj3t+FvBWIhXMZ6lzPq+0ppT/hfpYEr8vZnPD5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eXRlWaiE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXRlWaiE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V2jCEc000381;
	Thu, 31 Oct 2024 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XP3siNQlvKdGFWT11pXCzmzCXCjXmKichlPYLUtej
	JM=; b=eXRlWaiEICtdKZRRheV6PLGPj0rV4kfKpMXgylIrBoaz6yzJZmwwpY4RB
	nQ21heiameNEE01rV5W/dK0CQOnK4BlCjftkMAzJg8y3JB3LjhGoZuWqWEAVvekw
	dBVSdgNJOn4cnOK0qoQhIE5JT1V2CfQra4EjNpYF+e86ofaRETLVaJU1iqRGPz1b
	HNdBNuiycaXHA7y/B6WKumA4vU/7OCc/lp0p7E3V9n+pw768HlbB0W6QwuQv1Wzp
	hwEzdFTWFWGD5XNpbxlJtf/reo5Kd0fNCfPSrgO8vsmvlsfZsSUkVtO2U1BsrGyK
	Oq/ySKs8dqCqgDkVNSOM5yLOdjoQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65q8vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 09:58:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49V60oRX024560;
	Thu, 31 Oct 2024 09:58:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjm0v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 09:58:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49V9wpUG39321910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 09:58:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D59E2029F;
	Thu, 31 Oct 2024 09:35:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4746B2029D;
	Thu, 31 Oct 2024 09:35:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2024 09:35:41 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
Subject: [PATCH v2] s390/uvdevice: Support longer secret lists
Date: Thu, 31 Oct 2024 10:35:41 +0100
Message-ID: <20241031093541.1641849-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YPwz-f_llA14oVPVsJVOhwrb3eT1WLYl
X-Proofpoint-GUID: YPwz-f_llA14oVPVsJVOhwrb3eT1WLYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=937
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310074

Enable the list IOCTL to provide lists longer than on page (85 entries).
The list IOCTL accepts argument length up to 8 pages in page granularity
and will fill the argument up to this length with entries until the list
ends. User space unaware of this enhancement will still receive one page
of data and an uv_rc 0x0100.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
Reworked the whole list-creation loop. Hardened+simplified the implementation.
Now, only the actual data filled by the CP is copied to userspace.

 arch/s390/include/uapi/asm/uvdevice.h |  1 +
 drivers/s390/char/uvdevice.c          | 72 ++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index 4947f26ad9fb..c584250d4a35 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -71,6 +71,7 @@ struct uvio_uvdev_info {
 #define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
 #define UVIO_ADD_SECRET_MAX_LEN		0x100000
 #define UVIO_LIST_SECRETS_LEN		0x1000
+#define UVIO_LIST_SECRETS_MAX_LEN	0x8000
 #define UVIO_RETR_SECRET_MAX_LEN	0x2000
 
 #define UVIO_DEVICE_NAME "uv"
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 1f90976293e8..667d573e54b0 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -297,6 +297,43 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/*
+ * Do the actual secret list creation. Calls the list-UVC until there is no more
+ * space in the user buffer, or the list ends.
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
+ * Argument len must be a multiple of a page; 1-8 pages allowed.
+ * The list secrets IOCTL will call the list UVC multiple times and fill
+ * the provided user-buffer with list elements until either the list ends or
+ * the buffer is full. The list header is merged over all list header from the
+ * individual UVCs.
+ *
  * If the List Secrets UV facility is not present, UV will return invalid
  * command rc. This won't be fenced in the driver and does not result in a
  * negative return value.
@@ -318,31 +361,22 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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
+	    uv_ioctl->argument_len % UVIO_LIST_SECRETS_LEN != 0 ||
+	    uv_ioctl->argument_len > UVIO_LIST_SECRETS_MAX_LEN)
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

