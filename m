Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A731A76DE
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403358; cv=none; b=XHLqN7IaG9A1O57R6+YTnGLWD6sXt8c1htbcHuyb/4IwFVDi7GPrEVP8LNlB485pIkUJoAbxVYwL8pbxkB0q/60ub/tjHaZaSs6QpcT3JPHTYxvd01quTKIYkFoMdqrSPP5b2kkS7qdZpFeMdMh2moLR8w2VDQy6sr5Eoi6I1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403358; c=relaxed/simple;
	bh=2+PH3jIAcOGtSPe6Kys0pAk+C2MxvMB/D+UTMegPad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrCtvuseSyGcP2YR9MtfeknMkcA1LUIlOWlo76G3cWg4mgrGG5Z8Bl/SMQ7S62z9yqKxxIt5Ba9G7ZPdXxKaBojz2hRM9LwogXsMh2IlsGc8Yu7MHNmiGQBVBBYLZid9x3+tsMuk8FUGlJ8mMY4yjira2W84FkkR2fK31V4eEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=er67W56j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="er67W56j"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6frrD007355;
	Wed, 23 Apr 2025 10:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cd5g21oy8inYU3bpI
	CeBytVjlYP5QbW2IgArhe1WcCA=; b=er67W56jRgc55P27ToeHUhl00Duy7HDOf
	aYEhio622mJTJVRbaCDko59/XYDtjeiWz10MUrfinvHIDHy6Esd2s0/31xL/hwtO
	obq3xXMVzdov27gSxVO9/WYO7QuHuYiJfr2wTVtygc66WuDpU424dI0xDXIHv9FX
	JIuQYVOlfuKTlHXM6cwvGBF7FZhHjB67efzKEUe067wodA75Ro2dNxIC/Ex8n7Rg
	1PugrB+efaVmJRGrbsXwiwSc8A4uV5UKWgkPOfcrVFp21tHT9xCdi6GsTdvnygu9
	McDyi5lSbr0GRY77SGWS4t7KcsERXCifrY78fKav7oF9+Z2MwIWWg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6WN8h028407;
	Wed, 23 Apr 2025 10:15:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvjhdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFm6v40042796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 752852004E;
	Wed, 23 Apr 2025 10:15:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0563A20049;
	Wed, 23 Apr 2025 10:15:48 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 21/25] s390/uv: Rename find_secret() to uv_find_secret() and publish
Date: Wed, 23 Apr 2025 12:15:30 +0200
Message-ID: <20250423101535.143137-22-freude@linux.ibm.com>
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
X-Proofpoint-GUID: QD7XF4b-b7JWG8MR_9qMkr65RxeNAFuo
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bdd9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=EUQXMSza6c67mSslqPIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX4NX8om3l7+vt af1T4acGLJHq5DurbZQGR5t/VO3n2ZP5YmAGW9Jlmh6Bw5by2f0RZaizgkIG+pmdIee5EGIfkW+ 1kwGppbHSIJ9Rql3oAtAWZaKlozCIXqHdjT1ocbENPDoyT7e9iUs5Yxm29MWMi0tYrOy9jY+1Qu
 FAbAjaAp1yGvCl3iPi40NGh3JOW1Vb93b818SlOMx3CXZziaNLiEEeE9ylxDliQn0M+LMUCF7pX d67oHNyxxREr7Vl/Cs2wFpWkC/cPWc7jy6jscOmnpqHxSHXLZt8isU5yH/TRizg4jVFxThccscM LOqBkR0Xf8+imFUbQIZpj4shca9kgs6Hr7XFHuNz+Np1AYqTxqhDoWtyD5lDrV57mCEn9NzWR5K
 SaJYCqbAmvEeOy+MEJbb3lrUlSsp2B8Ghj4h356PZW0aoK4jnNKNALK3Qevv0tevs8EW/7U6
X-Proofpoint-ORIG-GUID: QD7XF4b-b7JWG8MR_9qMkr65RxeNAFuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=841 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

Rename the internal UV function find_secret() to uv_find_secret()
and publish it as new UV API in-kernel function.

The pkey uv handler may be called in a do-not-allocate memory
situation where sleeping is allowed but allocating memory which
may cause IO operations is not. For example when an encrypted
swap file is used and the encryption is done via UV retrievable
secrets with protected keys.

The UV API function uv_get_secret_metadata() allocates memory
and then calls the find_secret() function. By exposing the
find_secret() function as a new UV API function uv_find_secret()
it is possible to retrieve UV secret meta data without any
memory allocations from the UV when the caller offers space
for one struct uv_secret_list.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Holger Dengler <dengler@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  3 +++
 arch/s390/kernel/uv.c      | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 46fb0ef6f984..7f53fe755f3f 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -616,6 +616,9 @@ static inline int uv_remove_shared(unsigned long addr)
 	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
 }
 
+int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		   struct uv_secret_list *list,
+		   struct uv_secret_list_item_hdr *secret);
 int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
 			   struct uv_secret_list_item_hdr *secret);
 int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a5d5be8acf4..faac43359e23 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -782,7 +782,12 @@ static int __init uv_sysfs_init(void)
 device_initcall(uv_sysfs_init);
 
 /*
- * Find the secret with the secret_id in the provided list.
+ * Locate a secret in the list by its id.
+ * @secret_id: search pattern.
+ * @list: ephemeral buffer space
+ * @secret: output data, containing the secret's metadata.
+ *
+ * Search for a secret with the given secret_id in the Ultravisor secret store.
  *
  * Context: might sleep.
  */
@@ -803,12 +808,15 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 
 /*
  * Do the actual search for `uv_get_secret_metadata`.
+ * @secret_id: search pattern.
+ * @list: ephemeral buffer space
+ * @secret: output data, containing the secret's metadata.
  *
  * Context: might sleep.
  */
-static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
-		       struct uv_secret_list *list,
-		       struct uv_secret_list_item_hdr *secret)
+int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		   struct uv_secret_list *list,
+		   struct uv_secret_list_item_hdr *secret)
 {
 	u16 start_idx = 0;
 	u16 list_rc;
@@ -830,6 +838,7 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(uv_find_secret);
 
 /**
  * uv_get_secret_metadata() - get secret metadata for a given secret id.
@@ -855,7 +864,7 @@ int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
 	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	rc = find_secret(secret_id, buf, secret);
+	rc = uv_find_secret(secret_id, buf, secret);
 	kfree(buf);
 	return rc;
 }
-- 
2.43.0

