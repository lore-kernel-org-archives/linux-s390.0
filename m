Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E54219306
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811904; cv=none; b=OUbNayAB2KYihpi7IE7TbP1MllnnYCAv86/AHz7clpYz3Wsm4waGZ3IZQWiqalFl28BNJBPDbxStAr3rver6zUfqecqj30f1WMPcYc9rSFC/KTuM0D7zCp1v0e94FYOfFvwY8O1tuD6L/9Vt04zn3oySQ6ErbJ/dBs2T3EipzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811904; c=relaxed/simple;
	bh=u90DkGJHd03+dXu2R2Tv4CFJJDxkDOap6r+1mCOfWnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/I7yu7p0D/L5nRgQNDhb1tvmqn2yKa1FKdVuhYreO8OAsx4ggMeZM22opG/DVLtTHq79RYKEuGLaiH94rIdEFruqTrDDL7rgUQKCQlLJqzcSYRh3jHh+yw0W2ggdBmMGh2F6+awTWZzSNQC0ExH6ldKVvFUQ9zxVcL0AmxGTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C+9yrJ1i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C+9yrJ1i"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GARPxn027535;
	Wed, 16 Apr 2025 13:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ok3HxG9dbo2okbIgz
	6uRowsUwoxwuQiFRoVeO8LnITY=; b=C+9yrJ1ijN1HFReUulp9UhbEjGMB+RcTE
	78RRfYCPtT+uyBGylkqZjmwe6fG6YBHvroobfRweBWMEVtuFVZg/ls1dI6eO8jV9
	dlOO3e4SBlmaC17zb0l1GOdoAhgusFV4c7Uzkbs75DAPHdQHf25XslhAYuI7J5Me
	ly6qE6z4C5eWBH+scLNpSmQarYxWehoDsslwbdmdFPN+tjIPZ7JyhBv4nSqxbF78
	5EA9IeEWPZD6le8PBDlIVrayf+8mIPm88//qrEmT42loydkfm5Q/M37uOPccUgDJ
	uoaQOgbDOpRoMwIYAiwSSwtOLNdUeofEsrrR2EaltqCsjUQt7fIvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxbg5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GDn4LI001255;
	Wed, 16 Apr 2025 13:58:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w00spt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwFdq29950474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE612004B;
	Wed, 16 Apr 2025 13:58:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4312920043;
	Wed, 16 Apr 2025 13:58:15 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:15 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 22/25] s390/pkey: Use preallocated memory for retrieve of UV secret metadata
Date: Wed, 16 Apr 2025 15:57:57 +0200
Message-ID: <20250416135801.133909-23-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7JVVWwnGjpcYJoVJY0oFdZSywpBiad4X
X-Proofpoint-GUID: 7JVVWwnGjpcYJoVJY0oFdZSywpBiad4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

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
 drivers/s390/crypto/pkey_uv.c | 38 ++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_uv.c b/drivers/s390/crypto/pkey_uv.c
index 805817b14354..afbdb59c90f5 100644
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
@@ -85,13 +91,26 @@ static bool is_uv_keytype(enum pkey_key_type keytype)
 	}
 }
 
+static int get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			       struct uv_secret_list_item_hdr *secret)
+{
+	int rc;
+
+	mutex_lock(&uv_list_mutex);
+	memset(uv_list, 0, sizeof(*uv_list));
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
 
@@ -225,7 +244,7 @@ static int uv_verifykey(const u8 *key, u32 keylen,
 	if (rc)
 		goto out;
 
-	rc = uv_get_secret_metadata(t->secret_id, &secret_meta_data);
+	rc = get_secret_metadata(t->secret_id, &secret_meta_data);
 	if (rc)
 		goto out;
 
@@ -263,13 +282,23 @@ static struct pkey_handler uv_handler = {
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
@@ -278,6 +307,9 @@ static int __init pkey_uv_init(void)
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

