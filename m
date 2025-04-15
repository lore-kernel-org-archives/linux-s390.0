Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2998274667
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727097; cv=none; b=dy51ynzP8GNPEmhbewpjSKhL7uS6ujPEOIbhlmifpDEl1zj87PWhgORWGUPzAtDqF5mAbueYnRO1HeUBkHb+oOr7G7vxyti5sSi+C4ceHEtmyzI8spkYkdSlqIvk5zQdKfj+Cx9cpycYIQjcqhIrYvUcF151P+lThPptBn/eW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727097; c=relaxed/simple;
	bh=20QfhvndwwMhmmVKA90/JanmR7VAjGlDlAHyS3imNG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ/YIiQ6vm1YveFc/7y6EupXL20plrRn7w8oWFljetlpRHqq23g0Aj77To2GPTpp3XRlErDXoSpNxFRHe84N4fw/0XEzWNGLrfG6goeSmSLsKk9AORHkwVUxhaiZjBIdjaByT6GRhk1CI2FqeFZkN5B5VDs0Dx/qCMneGspLXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVsK0uig; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVsK0uig"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8ZDl1003764;
	Tue, 15 Apr 2025 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1c0sQb2XOYXQt52Er
	RV+VMzdENVQHmTeXtHxxpa2cMI=; b=fVsK0uigSc+mChi/ixD512eN8pMRNvn7h
	1yn6WehOHI7j69zp2PEGPaSzRUhy0zpRKldUC1561nSXJqJ6l5XWY7ypObEAyawP
	/2fhQ3EGELU7WngVkQ1nSRYInGLzgc6u+rhN8rx4ZT6p7PllDR57MhuqtN/md9Nb
	QAbWyNTi8fGPELjsdwgK4tJR1DLoYRtbCrZxo4FA02UV/JBzJHQTtCkiv+l8jAr4
	ZFxrTQDMZP/yIzNikQDynfWQIYb37Jf2HwHJAM5xFDBd9uxgJIDHsJY7SUYwVj2+
	gss3SFhIIfZ5V+RegEFh1VuYezKztXUmSqJEJZZ16P00x7m5088/w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4619xfv9d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FDrcbj030919;
	Tue, 15 Apr 2025 14:24:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnkjeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOmPe51970426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A793F2004E;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B6020040;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 22/25] s390/pkey: Use preallocated memory for retrieve of UV secret metadata
Date: Tue, 15 Apr 2025 16:24:35 +0200
Message-ID: <20250415142438.118474-23-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415142438.118474-1-freude@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: frmEIhaNl_A49jar9FJmajCgDykbQWFX
X-Proofpoint-GUID: frmEIhaNl_A49jar9FJmajCgDykbQWFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

The pkey uv functions may be called in a situation where memory
allocations which trigger IO operations are not allowed. An example:
decryption of the swap partition with protected key (PAES).

The pkey uv code takes care of this by holding one preallocated
struct uv_secret_list to be used with the new UV function
uv_find_secret(). The older function uv_get_secret_metadata()
used before always allocates/frees an ephemeral memory buffer.
The preallocated struct is concurrency protected by a mutex.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/s390/crypto/pkey_uv.c | 37 ++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_uv.c b/drivers/s390/crypto/pkey_uv.c
index 805817b14354..a91da162e684 100644
--- a/drivers/s390/crypto/pkey_uv.c
+++ b/drivers/s390/crypto/pkey_uv.c
@@ -20,6 +20,12 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("s390 protected key UV handler");
 
+/*
+ * One pre-allocated uv_secret_list for use with uv_find_secret()
+ */
+static struct uv_secret_list *uv_list;
+static DEFINE_MUTEX(uv_list_mutex);
+
 /*
  * UV secret token struct and defines.
  */
@@ -85,13 +91,25 @@ static bool is_uv_keytype(enum pkey_key_type keytype)
 	}
 }
 
+static int get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			       struct uv_secret_list_item_hdr *secret)
+{
+	int rc;
+
+	mutex_lock(&uv_list_mutex);
+	rc = uv_find_secret(secret_id, uv_list, secret);
+	mutex_unlock(&uv_list_mutex);
+
+	return rc;
+}
+
 static int retrieve_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 			   u16 *secret_type, u8 *buf, u32 *buflen)
 {
 	struct uv_secret_list_item_hdr secret_meta_data;
 	int rc;
 
-	rc = uv_get_secret_metadata(secret_id, &secret_meta_data);
+	rc = get_secret_metadata(secret_id, &secret_meta_data);
 	if (rc)
 		return rc;
 
@@ -225,7 +243,7 @@ static int uv_verifykey(const u8 *key, u32 keylen,
 	if (rc)
 		goto out;
 
-	rc = uv_get_secret_metadata(t->secret_id, &secret_meta_data);
+	rc = get_secret_metadata(t->secret_id, &secret_meta_data);
 	if (rc)
 		goto out;
 
@@ -263,13 +281,23 @@ static struct pkey_handler uv_handler = {
  */
 static int __init pkey_uv_init(void)
 {
+	int rc;
+
 	if (!is_prot_virt_guest())
 		return -ENODEV;
 
 	if (!test_bit_inv(BIT_UVC_CMD_RETR_SECRET, uv_info.inst_calls_list))
 		return -ENODEV;
 
-	return pkey_handler_register(&uv_handler);
+	uv_list = kmalloc(sizeof(*uv_list), GFP_KERNEL);
+	if (!uv_list)
+		return -ENOMEM;
+
+	rc = pkey_handler_register(&uv_handler);
+	if (rc)
+		kfree(uv_list);
+
+	return rc;
 }
 
 /*
@@ -278,6 +306,9 @@ static int __init pkey_uv_init(void)
 static void __exit pkey_uv_exit(void)
 {
 	pkey_handler_unregister(&uv_handler);
+	mutex_lock(&uv_list_mutex);
+	kvfree(uv_list);
+	mutex_unlock(&uv_list_mutex);
 }
 
 module_cpu_feature_match(S390_CPU_FEATURE_UV, pkey_uv_init);
-- 
2.43.0

