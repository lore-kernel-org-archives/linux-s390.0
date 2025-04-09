Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E36A47
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208121; cv=none; b=lAYoZzhGeZ28ewHJkpoooXJj6yNEl4CZaiIK1KjfiHOaUhSaOlZlOt8pD7orZAudnVDiEvdSEplNo6fFZVusThSi6/CQ3pBhvWGPWf/cWsuFpyca/R2aT9Iz9ypSTlVCTpLcRtzAU4UqxXjRKcpaPpEdyTD38tFUYR/9MkEM2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208121; c=relaxed/simple;
	bh=Yo/3pye5lffkzi47114iMNtgbXMfZ1UjQlBygbfg150=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0INpv0f9WGLQDePRWBPlWqO5l2i79IldOG5xGbbZ++Pgp12W6TKoBiP9G274wWdcTWghTEWPvw1FFtldioIjqBQb+ohOohlpeM/fgaz26cv69nxK9EJ/4MOcSiAjymmsjufQIK8rXjr/cExHvjEnXD07lHKLCCDyzqPtbEavO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ghv7SE11; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ghv7SE11"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399VSTF027302;
	Wed, 9 Apr 2025 14:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w8Vft4GlvwiBBesBp
	xyZU1Cal3W+XQMfLgk64SlYKdo=; b=ghv7SE11xYDOy8i4MJg9NhuiEcwB45lPK
	rquh49078q8MgJqC4yXBOR4lrsfwOQh4gvKxWWOODyKScrbK4of2eWHO2XWW9qFm
	SvbI+r7/34UfzZtoXwKmMAVtYziUdPqcm5QtE+eKZKMns4/LgfyWYu6lS7N07wVX
	sF6S+WC2zueCbHkoNbfORH8cUDYEALFXYHTHhgoGcC1YYGQO5fHYIEz36b0/TKbu
	hH3LHdYXhkT9nT11HHcdLAx05rTLipASq6zVI4Q6kVVDnYE0mBYRhYIbk5uAw7aK
	Znw6OsgBJiZoVLGnWVtj6sK0ITu8ge4wtesXewj2vudPSMTh7etCg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10m2pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:15:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539DfRfY013823;
	Wed, 9 Apr 2025 14:15:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunr1mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:15:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3S8G35324220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DFF82006B;
	Wed,  9 Apr 2025 14:03:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD2A20043;
	Wed,  9 Apr 2025 14:03:20 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:20 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 22/24] s390/pkey: Use preallocated memory for retrieve of UV secret metadata
Date: Wed,  9 Apr 2025 16:03:03 +0200
Message-ID: <20250409140305.58900-23-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409140305.58900-1-freude@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LYTUJlyJdGQvWsKpjU_rqVlc7Tp2rn3a
X-Proofpoint-GUID: LYTUJlyJdGQvWsKpjU_rqVlc7Tp2rn3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

The pkey uv functions may be called in a situation where memory
allocations which trigger IO operations are not allowed. An example:
decryption of the swap partition with protected key (PAES).

The pkey uv code takes care of this by holding one preallocated
struct uv_secret_list to be used with the new UV function
uv_find_secret(). The older function uv_get_secret_metadata()
used before always allocates/frees an ephemeral memory buffer.
The preallocated struct is concurrency protected by a mutex.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
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

