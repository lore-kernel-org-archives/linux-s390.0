Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833B1D63E3;
	Wed, 30 Oct 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276823; cv=none; b=EnXCv7H7Fqsi02aYwXfzPtaAkv6rpAzSMa/ZsPs6VCnZzMrnTf8A8NDxMdBTxu3J1dk41ZFE7du3BLKbmR/17QD0j5cC/mDRPou6uoiFciI/SYHK5CG6gA3xYPakKtah6VbqvfFefFxZ8wRenFjd5qNKGYWtH6u8l+HlOAtkHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276823; c=relaxed/simple;
	bh=6frQp3vk78rTDMfy8Ob6GL6/RN0Pbs9go6Vr1MnLeJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJi9GZwHb6/ilzXcgcJ3sX15jfjvkOlFWeRDpoFD4TbPp9tD8ZDFnDL7pN+KST0MIAH7UF+Bmk4Fekygdnrg9K0XCdJRM4FkdpSWsAhfjv+bg+j7jSJvmm9PT4vPIBTBXNVlOWX2WcmNKxzgsy38HldWy8XmWsvQpVkRqV2KSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DL01gQuw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DL01gQuw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d19X029979;
	Wed, 30 Oct 2024 08:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZWAlq7eMmj/69ECPPqlCPOTGR7kzM4ZEmM3iBTILJ
	2U=; b=DL01gQuwC6yGxt+aDQNDrzdm4H6swiDt1uKF4T8/MxA4rwl7sKTesQ0Z2
	l8pNiHQ2ZheI27XRkAHoFOySX/uzfpZdUtAJfEsetcTkticQkeXqCQfPeFTh2P9N
	UHgW/8kC6602DFAXcG58n659TBkluKWkHSjssKyxb9dIRo0f1xsaJDvmDfILfcGz
	MZSDK4RD2wamYJsspB0zG2TOBR3eUjKRrxu4nDe1jHBEbCf5owj/UJKfQh9h9Io1
	rvSLyr2TNF284CdowU/BxJYmbRYyMKU+WTPH24yBook+2/7gKHNQhaEdD2T2TtPu
	50aglxzAutHQ8bTkYfiSTscQNmgGA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7h0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 08:26:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6MaEx017386;
	Wed, 30 Oct 2024 08:26:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsfccm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 08:26:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U8Qtt457541066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 08:26:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0386420043;
	Wed, 30 Oct 2024 08:26:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E0B20040;
	Wed, 30 Oct 2024 08:26:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 08:26:53 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
Subject: [PATCH v1] s390/uvdevice: Support longer secret lists
Date: Wed, 30 Oct 2024 09:26:53 +0100
Message-ID: <20241030082653.3303713-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rf0bZ5YQjua-XV-ped88rw-qpJOoXWXU
X-Proofpoint-ORIG-GUID: rf0bZ5YQjua-XV-ped88rw-qpJOoXWXU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=616
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300063

Enable the list IOCTL to provide lists longer than on page (85 entries).
The list IOCTL accepts argument length up to 8 pages in page granularity
and will fill the argument up to this length with entries until the list
ends. User space unaware of this enhancement will still receive one page
of data and an uv_rc 0x0100.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---

Janosch picked the rest of this series[1].
This is an alternate approach on how to forward the enhanced list UVC
to userspace without adding a new IOCTL by looping through the list UVCs in kernel space
instead of in userspace. This allows a much cleaner API and
streamlined implementation for both, kernel and userspace.

This patch is based on series [1] without PATCH 5.

[1] https://lore.kernel.org/lkml/20241024062638.1465970-1-seiden@linux.ibm.com/

 arch/s390/include/uapi/asm/uvdevice.h |  1 +
 drivers/s390/char/uvdevice.c          | 74 ++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 19 deletions(-)

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
index 1f90976293e8..9829cf3810a2 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -297,6 +297,45 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/*
+ * Do the actual secret list creation. Calls the list-UVC until there is no more
+ * space in the user buffer, or the list ends.
+ */
+static int uvio_get_list(void *zpage, struct uvio_ioctl_cb *uv_ioctl)
+{
+	u8 __user *user_secrets = (u8 __user *)uv_ioctl->argument_addr;
+	struct uv_secret_list *list = zpage;
+	size_t len = UVIO_LIST_SECRETS_LEN;
+	u16 num_secrets_stored = 0;
+	size_t user_off = 0;
+	size_t list_off = 0;
+
+	do {
+		if (user_off + len > uv_ioctl->argument_len)
+			break;
+		uv_list_secrets(list, list->next_secret_idx, &uv_ioctl->uv_rc,
+				&uv_ioctl->uv_rrc);
+		if (uv_ioctl->uv_rc != UVC_RC_EXECUTED &&
+		    uv_ioctl->uv_rc != UVC_RC_MORE_DATA)
+			break;
+		if (copy_to_user(user_secrets + user_off, (u8 *)list + list_off,
+				 len))
+			return -EFAULT;
+
+		user_off += len;
+		num_secrets_stored += list->num_secr_stored;
+		/* The 2nd,3rd,.. secret list pages will not contain the list header again */
+		list_off = offsetof(struct uv_secret_list, secrets);
+		len = UVIO_LIST_SECRETS_LEN - list_off;
+	} while (uv_ioctl->uv_rc == UVC_RC_MORE_DATA);
+
+	/* Merge headers */
+	list->num_secr_stored = num_secrets_stored;
+	if (copy_to_user(user_secrets, list, list_off))
+		return -EFAULT;
+	return 0;
+}
+
 /** uvio_list_secrets() - perform a List Secret UVC
  * @uv_ioctl: ioctl control block
  *
@@ -308,6 +347,12 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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
@@ -318,31 +363,22 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
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

