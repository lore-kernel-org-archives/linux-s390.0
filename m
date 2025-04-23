Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4025C804
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403358; cv=none; b=TsxH6WXQsZXEYzPaaPZYpud1PHIarbsr6EfmZ+a205+b3nZxnFWd9ETM60WVs5pQuons5Do5VTNeG8sbYBjcNr7AXG3LHLi8xxYivcHhuTkILm0um+9UWQX307NMv86gqcWNtsUJz9UGPPk/Wjqqezpew1XsA3FoceiwWFCKBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403358; c=relaxed/simple;
	bh=u90DkGJHd03+dXu2R2Tv4CFJJDxkDOap6r+1mCOfWnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtcIjoTU8zPaizPhU4iLqcy/s4xWUgEIhGTbTbo5CbTWYTmPx0lMGnh8E1DZ5lATrKVGYaO9vygVsWG9GWG1IEpybY7TSyoJomZNV9Qk5X8Oe0kjKKwv2K7yq6uYN8mxnDMuACg1d20JqKZ5E68sSFjY0C57Nxu+Newc+3TgX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=apwWZuJF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="apwWZuJF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NA417d024477;
	Wed, 23 Apr 2025 10:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ok3HxG9dbo2okbIgz
	6uRowsUwoxwuQiFRoVeO8LnITY=; b=apwWZuJFhJU0V2RZ34+ixtv/dHeYR3yAI
	P4LegiQFMIgdYSZkjNnjei6rueX1qXKRtPpZlus1jBMzbtrSqW20EHhfUcqsDdcz
	oFYK93BywNKeAQ+TEdsGC9nvESbSpoaSd0eDYNDFaaa0a5EkekQtLtWpvxKtIF2D
	3dicHp0j83RuHVhGB5vt0W92JExVaWAnS4DST3SvUfvFEG5Zzs3/SdfiktsGn4KC
	mtqogDFjDVAs5ROUBxdMBJ7FuIbX2vvrBmolpJpfzVV5WRLsPUHiKGRkzh29AEjQ
	0zfg+pmw4Vk4/AlLhm73RhreVGvSIPF8gmu4E7yhHYv1VUkDs+ugQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jr1dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6TmxR022271;
	Wed, 23 Apr 2025 10:15:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxah5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFnSo56557992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F0A2004D;
	Wed, 23 Apr 2025 10:15:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B40520049;
	Wed, 23 Apr 2025 10:15:48 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 22/25] s390/pkey: Use preallocated memory for retrieve of UV secret metadata
Date: Wed, 23 Apr 2025 12:15:31 +0200
Message-ID: <20250423101535.143137-23-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=6808bdd9 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=1jaWCiF71yEpXFdmnB4A:9
X-Proofpoint-GUID: Q2X6gTp1W3iOJQkW2NUEYy6ooSgbBBXZ
X-Proofpoint-ORIG-GUID: Q2X6gTp1W3iOJQkW2NUEYy6ooSgbBBXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX38zzS+r/51mi xyRcJuLCo/YfiJRvZs801iAZQjo63WYO4ENBYC0d0fH9xBpWPQOfOIZ3IhfKwdHmZT6kU9VUT5G 8Tz6uP4+sU9lI2OFODhy22y0Ak2L7LnZqHaC3dF1Jcdh+zslp6X2ikDsDTwtWLNPFnDTHCCsRfQ
 xTcge5SSxfRsyd/jS3EsZLZIkVJvZrIRS0Vjzb0q8VtKSmifqSF8ERYPnAnMJIqR/50B5OgLt6/ PHhgM9vbSIe5Hg9xSu7c3sDoWguwqKMgvl+erJ+lNex62Qn63NC7j0qbRrkvy8JDOpNE7AX7HED SQCSrFRgjWj+ix4A6i28IclROTAMKDXRB4UVmHe/p4EQdb3vobRkr1Itb6mBmxamW7/K6UV09se
 2KTiIGfIMhLdbXU5A0jq11k5dJHcxOT/tOZ7sH/KmFf9eDnDmM2aiYad5jN83rs4KTQlvzI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

