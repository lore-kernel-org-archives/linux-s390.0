Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236117E016;
	Thu, 24 Oct 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751208; cv=none; b=D6/DRjXBLfqHKJKvBm08+abCj0QV+TJL2xx2NQBv9J7zwcGRPaVPyGBlKytsutonpTQJGcZBdYFVtmR3g5y5B8iEZRORXRIyGPjbCukyvTWKSJtpaDGlGicUfJ51TvgqBPP3c/prVwyJCTFTLvS0DaZDreMSE4B5LgmBjoL+tA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751208; c=relaxed/simple;
	bh=k9OKe48qASrXfyx949DVS+U/DUt07afEMHXpcHHAUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo7iOzzTbaAkUPKynsVxvNDxaCUT9w2uRyA1qmEQ8K2E2LlO64Cc8HxbP3V9/0UnJY9iia0JsxBC9ch8DTtLooBJ8sNVCpJAJFgy01ojCq8uwck7KA+EkYhsOYoePdDEb2fe/WQImxXEYRVIbhdAKGGUzk90VFqEcq8AAUBYTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HnrgWN44; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HnrgWN44"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O0v5rD028145;
	Thu, 24 Oct 2024 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pbDVWllb5Ued5pX1d
	Ab+ymjDkErCfAX4KoycJqg1iyQ=; b=HnrgWN44eAhucDxlxUGzoGn+R+sapX9Wl
	vfdYQEmBWsHScuMiW6y/xGwkvZ0iGI8RVCzaQrxUgIxdeYk/DaPv1zC5aW+brLPX
	9t33kPMrT0dOIud8Ig1rBzFX8YWjkIUdykspk2t4MIt5x0pSepuOVbmPGnYA7PEU
	ycNXGr93pTS6QPCQea7Ei3nmi8qiKRZDhfzy9Rfo9NhQV9gO660K9A4LfmjKMN5u
	HeCO5/tUnmPK+0tpMCLt0tt98+pDs1Uid/BvDBxGcYLsR7HMCjabDjZBddA5RudD
	a3NTbuOVmfsvvkzyEczKuDLrnqxAD7O7G/BmuUcILgcWZyMY5tWlA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafpw34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2k2o9014565;
	Thu, 24 Oct 2024 06:26:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7xwvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O6Qdi011338206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 06:26:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4205D20040;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C02E20043;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v5 2/6] s390/uv: Retrieve UV secrets support
Date: Thu, 24 Oct 2024 08:26:34 +0200
Message-ID: <20241024062638.1465970-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024062638.1465970-1-seiden@linux.ibm.com>
References: <20241024062638.1465970-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kyTHoP0RE64J3CdEzeyWa3IzKWRK1RYf
X-Proofpoint-GUID: kyTHoP0RE64J3CdEzeyWa3IzKWRK1RYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=702 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240047

Provide a kernel API to retrieve secrets from the UV secret store.
Add two new functions:
* `uv_get_secret_metadata` - get metadata for a given secret identifier
* `uv_retrieve_secret` - get the secret value for the secret index

With those two functions one can extract the secret for a given secret
id, if the secret is retrievable.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 136 ++++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/uv.c      | 129 ++++++++++++++++++++++++++++++++++-
 2 files changed, 262 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 94ff58336e8e..f063e21d898d 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -2,7 +2,7 @@
 /*
  * Ultravisor Interfaces
  *
- * Copyright IBM Corp. 2019, 2022
+ * Copyright IBM Corp. 2019, 2024
  *
  * Author(s):
  *	Vasily Gorbik <gor@linux.ibm.com>
@@ -62,6 +62,7 @@
 #define UVC_CMD_ADD_SECRET		0x1031
 #define UVC_CMD_LIST_SECRETS		0x1033
 #define UVC_CMD_LOCK_SECRETS		0x1034
+#define UVC_CMD_RETR_SECRET		0x1035
 
 /* Bits in installed uv calls */
 enum uv_cmds_inst {
@@ -95,6 +96,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_ADD_SECRET = 29,
 	BIT_UVC_CMD_LIST_SECRETS = 30,
 	BIT_UVC_CMD_LOCK_SECRETS = 31,
+	BIT_UVC_CMD_RETR_SECRET = 33,
 };
 
 enum uv_feat_ind {
@@ -318,7 +320,6 @@ struct uv_cb_dump_complete {
  * A common UV call struct for pv guests that contains a single address
  * Examples:
  * Add Secret
- * List Secrets
  */
 struct uv_cb_guest_addr {
 	struct uv_cb_header header;
@@ -327,6 +328,91 @@ struct uv_cb_guest_addr {
 	u64 reserved28[4];
 } __packed __aligned(8);
 
+#define UVC_RC_RETR_SECR_BUF_SMALL	0x0109
+#define UVC_RC_RETR_SECR_STORE_EMPTY	0x010f
+#define UVC_RC_RETR_SECR_INV_IDX	0x0110
+#define UVC_RC_RETR_SECR_INV_SECRET	0x0111
+
+struct uv_cb_retr_secr {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u16 secret_idx;
+	u16 reserved1a;
+	u32 buf_size;
+	u64 buf_addr;
+	u64 reserved28[4];
+}  __packed __aligned(8);
+
+struct uv_cb_list_secrets {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u8  reserved18[6];
+	u16 start_idx;
+	u64 list_addr;
+	u64 reserved28[4];
+} __packed __aligned(8);
+
+enum uv_secret_types {
+	UV_SECRET_INVAL = 0x0,
+	UV_SECRET_NULL = 0x1,
+	UV_SECRET_ASSOCIATION = 0x2,
+	UV_SECRET_PLAIN = 0x3,
+	UV_SECRET_AES_128 = 0x4,
+	UV_SECRET_AES_192 = 0x5,
+	UV_SECRET_AES_256 = 0x6,
+	UV_SECRET_AES_XTS_128 = 0x7,
+	UV_SECRET_AES_XTS_256 = 0x8,
+	UV_SECRET_HMAC_SHA_256 = 0x9,
+	UV_SECRET_HMAC_SHA_512 = 0xa,
+	/* 0x0b - 0x10 reserved */
+	UV_SECRET_ECDSA_P256 = 0x11,
+	UV_SECRET_ECDSA_P384 = 0x12,
+	UV_SECRET_ECDSA_P521 = 0x13,
+	UV_SECRET_ECDSA_ED25519 = 0x14,
+	UV_SECRET_ECDSA_ED448 = 0x15,
+};
+
+/**
+ * uv_secret_list_item_hdr - UV secret metadata.
+ * @index: Index of the secret in the secret list.
+ * @type: Type of the secret. See `enum uv_secret_types`.
+ * @length: Length of the stored secret.
+ */
+struct uv_secret_list_item_hdr {
+	u16 index;
+	u16 type;
+	u32 length;
+} __packed __aligned(8);
+
+#define UV_SECRET_ID_LEN 32
+/**
+ * uv_secret_list_item - UV secret entry.
+ * @hdr: The metadata of this secret.
+ * @id: The ID of this secret, not the secret itself.
+ */
+struct uv_secret_list_item {
+	struct uv_secret_list_item_hdr hdr;
+	u64 reserverd08;
+	u8 id[UV_SECRET_ID_LEN];
+} __packed __aligned(8);
+
+/**
+ * uv_secret_list - UV secret-metadata list.
+ * @num_secr_stored: Number of secrets stored in this list.
+ * @total_num_secrets: Number of secrets stored in the UV for this guest.
+ * @next_secret_idx: positive number if there are more secrets available or zero.
+ * @secrets: Up to 85 UV-secret metadata entries.
+ */
+struct uv_secret_list {
+	u16 num_secr_stored;
+	u16 total_num_secrets;
+	u16 next_secret_idx;
+	u16 reserved_06;
+	u64 reserved_08;
+	struct uv_secret_list_item secrets[85];
+} __packed __aligned(8);
+static_assert(sizeof(struct uv_secret_list) == PAGE_SIZE);
+
 static inline int __uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
@@ -383,6 +469,48 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd, u16 *rc, u16 *rrc)
 	return cc ? -EINVAL : 0;
 }
 
+/**
+ *  uv_list_secrets() - Do a List Secrets UVC.
+ *
+ *  @buf: Buffer to write list into; size of one page.
+ *  @start_idx: The smallest index that should be included in the list.
+ *		For the fist invocation use 0.
+ *  @rc: Pointer to store the return code or NULL.
+ *  @rrc: Pointer to store the return reason code or NULL.
+ *
+ *  This function calls the List Secrets UVC. The result is written into `buf`,
+ *  that needs to be at least one page of writable memory.
+ *  `buf` consists of:
+ *  * %struct uv_secret_list_hdr
+ *  * %struct uv_secret_list_item (multiple)
+ *
+ *  For `start_idx` use _0_ for the first call. If there are more secrets available
+ *  but could not fit into the page then `rc` is `UVC_RC_MORE_DATA`.
+ *  In this case use `uv_secret_list_hdr.next_secret_idx` for `start_idx`.
+ *
+ *  Context: might sleep.
+ *
+ *  Return: The UVC condition code.
+ */
+static inline int uv_list_secrets(struct uv_secret_list *buf, u16 start_idx,
+				  u16 *rc, u16 *rrc)
+{
+	struct uv_cb_list_secrets uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_LIST_SECRETS,
+		.start_idx = start_idx,
+		.list_addr = (u64)buf,
+	};
+	int cc = uv_call_sched(0, (u64)&uvcb);
+
+	if (rc)
+		*rc = uvcb.header.rc;
+	if (rrc)
+		*rrc = uvcb.header.rrc;
+
+	return cc;
+}
+
 struct uv_info {
 	unsigned long inst_calls_list[4];
 	unsigned long uv_base_stor_len;
@@ -469,6 +597,10 @@ static inline int uv_remove_shared(unsigned long addr)
 	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
 }
 
+int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			   struct uv_secret_list_item_hdr *secret);
+int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
+
 extern int prot_virt_host;
 
 static inline int is_prot_virt_host(void)
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9646f773208a..cb9cb3f47471 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -2,7 +2,7 @@
 /*
  * Common Ultravisor functions and initialization
  *
- * Copyright IBM Corp. 2019, 2020
+ * Copyright IBM Corp. 2019, 2024
  */
 #define KMSG_COMPONENT "prot_virt"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
@@ -787,3 +787,130 @@ static int __init uv_info_init(void)
 	return rc;
 }
 device_initcall(uv_info_init);
+
+/*
+ * Find the secret with the secret_id in the provided list.
+ *
+ * Context: might sleep.
+ */
+static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
+			       const struct uv_secret_list *list,
+			       struct uv_secret_list_item_hdr *secret)
+{
+	u16 i;
+
+	for (i = 0; i < list->total_num_secrets; i++) {
+		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) == 0) {
+			*secret = list->secrets[i].hdr;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+/*
+ * Do the actual search for `uv_get_secret_metadata`.
+ *
+ * Context: might sleep.
+ */
+static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		       struct uv_secret_list *list,
+		       struct uv_secret_list_item_hdr *secret)
+{
+	u16 start_idx = 0;
+	u16 list_rc;
+	int ret;
+
+	do {
+		uv_list_secrets(list, start_idx, &list_rc, NULL);
+		if (list_rc != UVC_RC_EXECUTED && list_rc != UVC_RC_MORE_DATA) {
+			if (list_rc == UVC_RC_INV_CMD)
+				return -ENODEV;
+			else
+				return -EIO;
+		}
+		ret = find_secret_in_page(secret_id, list, secret);
+		if (ret == 0)
+			return ret;
+		start_idx = list->next_secret_idx;
+	} while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
+
+	return -ENOENT;
+}
+
+/**
+ * uv_get_secret_metadata() - get secret metadata for a given secret id.
+ * @secret_id: search pattern.
+ * @secret: output data, containing the secret's metadata.
+ *
+ * Search for a secret with the given secret_id in the Ultravisor secret store.
+ *
+ * Context: might sleep.
+ *
+ * Return:
+ * * %0:	- Found entry; secret->idx and secret->type are valid.
+ * * %ENOENT	- No entry found.
+ * * %ENODEV:	- Not supported: UV not available or command not available.
+ * * %EIO:	- Other unexpected UV error.
+ */
+int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			   struct uv_secret_list_item_hdr *secret)
+{
+	struct uv_secret_list *buf;
+	int rc;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rc = find_secret(secret_id, buf, secret);
+	kfree(buf);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
+
+/**
+ * uv_retrieve_secret() - get the secret value for the secret index.
+ * @secret_idx: Secret index for which the secret should be retrieved.
+ * @buf: Buffer to store retrieved secret.
+ * @buf_size: Size of the buffer. The correct buffer size is reported as part of
+ * the result from `uv_get_secret_metadata`.
+ *
+ * Calls the Retrieve Secret UVC and translates the UV return code into an errno.
+ *
+ * Context: might sleep.
+ *
+ * Return:
+ * * %0		- Entry found; buffer contains a valid secret.
+ * * %ENOENT:	- No entry found or secret at the index is non-retrievable.
+ * * %ENODEV:	- Not supported: UV not available or command not available.
+ * * %EINVAL:	- Buffer too small for content.
+ * * %EIO:	- Other unexpected UV error.
+ */
+int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size)
+{
+	struct uv_cb_retr_secr uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_RETR_SECRET,
+		.secret_idx = secret_idx,
+		.buf_addr = (u64)buf,
+		.buf_size = buf_size,
+	};
+
+	uv_call_sched(0, (u64)&uvcb);
+
+	switch (uvcb.header.rc) {
+	case UVC_RC_EXECUTED:
+		return 0;
+	case UVC_RC_INV_CMD:
+		return -ENODEV;
+	case UVC_RC_RETR_SECR_STORE_EMPTY:
+	case UVC_RC_RETR_SECR_INV_SECRET:
+	case UVC_RC_RETR_SECR_INV_IDX:
+		return -ENOENT;
+	case UVC_RC_RETR_SECR_BUF_SMALL:
+		return -EINVAL;
+	default:
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL_GPL(uv_retrieve_secret);
-- 
2.45.2

