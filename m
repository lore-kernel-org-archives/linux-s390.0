Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428B1531E8
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501806; cv=none; b=FZpWd1IzaPuHyJ2WvUMfGR3fmCtNYEpWe6hlHws8iCHX4w/i66vSyzQldC7LGYjLBEGS0FLyUy2fxw5HEnc3HKo2xbofh0XcGG/dzFFg58qrJiy4i5yBpWeeDITaBGCNXn9EN9uX2VuEkczzkKwBV6Ps60HiZ8eH21o+YPl4q6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501806; c=relaxed/simple;
	bh=u90DkGJHd03+dXu2R2Tv4CFJJDxkDOap6r+1mCOfWnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUniEmi961jyv1BhoMpvRJPQ2YcJQ8M4zuUUDhj7P8SLTIAYYhQCEIUzOD/3IdjYzN7G5hvxoXg/pvu83Uf3lEfCKHOBJOF4qOb49rAbliVXGwAnOCZ8dJq8Cz78nfLA9KVP4SrJmdEue422gQblz8kGsiYaRBENYJdNeEAJ51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I4CjBoAx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I4CjBoAx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA4At6001165;
	Thu, 24 Apr 2025 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ok3HxG9dbo2okbIgz
	6uRowsUwoxwuQiFRoVeO8LnITY=; b=I4CjBoAxABn4uZiCKT9h2LoqkCnK5knAl
	9qFx67UaCnIagu75PfZtmtGUsdJehJPX3SfDJV2+TO+LPnvpmeLDRZoFIf0gzgDY
	y9oFyQhv+usbBzKuJHvUv5PD6/v4U5YDmwfHBpX7RUuXwiQmKa8UZgffWEY7eBIa
	Zb6FlOYjCEocSMIB8JSq5nvy15ZgDCvY9VI3P5GNxvTsqWzvtx4x66KNq1tldpU9
	D+z1jGQ1aP9aPEtmD/ttJCYS6Q4XRRjvZw+upm/+kQzviXgrKJPHk9ZQkbFQ8iHu
	GvIXq0SMeWBHhqqPh2kDUCbO3NA96k/TQ7GS87+tWwz00F6Yf+5Jw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k10hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBcFUg022313;
	Thu, 24 Apr 2025 13:36:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxgdep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaUEF53150108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD98B20043;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C2302004D;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 22/25] s390/pkey: Use preallocated memory for retrieve of UV secret metadata
Date: Thu, 24 Apr 2025 15:36:16 +0200
Message-ID: <20250424133619.16495-23-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f_yCRElYNKaOA9nxQ91UNCzRzDt8u2js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX42XLDl52y8Sb 0B+L6Aejw5guatYdmZT0zNKEIFikKFUAv+Ols1GUU4ujthVUnx9y1G6G+i2InNeLqUvmPNGdPzX rlN4AIl16zaRTY1j2gEZYw6p48Fjx6zdgZDaSNYiE9zlDZsWTHkAGupW4uvr3JdkUZlul6cg68V
 IZUeiny3ktX9hqXBpGHwZntirmWb4NZ/tFaqvdxCWgup/wDP1Wiw079wNN74ZTlVNEvJIQZEssF QktKLLqZUDqmdgfaWlynA/vcKlFsPbYLNg5jd2LA7MrNsF5VlrZTGdbk3HsTT3YjEdEpIh2d+my Iba3xMKpXhQsYLbr6ZeYLd/50HU5FQFbJFK3dBtKrIvHM0fP/HIfelcaUev8+CSluzY9cOAGk+n
 PZZuf0kN/jKD6h5rWisDDWT/GHQwIMR+zUcFGFLmtPm9vJ8rCuWmksfeMzPxuAQ3OYFIk54P
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680a3e6a cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=1jaWCiF71yEpXFdmnB4A:9
X-Proofpoint-GUID: f_yCRElYNKaOA9nxQ91UNCzRzDt8u2js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

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

