Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DA13D891
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727097; cv=none; b=hvEwZZ3j27sOtTPqvv/+G/gvIPXpxEBr2xKCeFzic/qUGL+oSpeHE9XKiuMKznxgZvR+t/OFrz/BktGOODZEtAMCCUHZ9nl830OVn/QWPsHhaAgWErVdokmQ6UpGi5lwhG0UY/xiM5SMx3azszoRAPAZA1a+8V0ysKBkOUY5fXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727097; c=relaxed/simple;
	bh=2+PH3jIAcOGtSPe6Kys0pAk+C2MxvMB/D+UTMegPad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSBH8WzLsUMjqMB0iHhjIzlJ8NtIGMG5hVKwxtj3JIQf3gLrQrU7XMDLhJvoj0S5Ju0DTWnADhLYm+Ds8IlhYVPI1KAz8f8pkw7OQKjcLJjtcaWOp/wYQV35rNQhmfD6qgrgJZGB4k58gwOzwMGdxkwt77WSc8phLAMbTy5/ovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BqbpizFb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BqbpizFb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9Oj2v019347;
	Tue, 15 Apr 2025 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cd5g21oy8inYU3bpI
	CeBytVjlYP5QbW2IgArhe1WcCA=; b=BqbpizFb0WIMc1CbqG5lNuan97R3hWzXH
	BXQmfD4VgfTZap5mLpcfS2kK9Za30c+1nOePmVoXK9N8rDQht561sHH8DA2V5e8A
	Sb+4uK5Ym39Nofplgqg/3dxWR+v/7wJIIbMfzQ/y1VcEyhhFl6oR0L8rUTJJmn7Y
	IW+JtgEqMCY3JFt3yyroumV2p8GsSC+p2uAikhCxvYpLjawWQErVrPv52QtBRpGj
	d+/A7Y4sIvHgNd/lDQWXO8R5r43pOeOllsiOMN7U23llajd6jI0aBTkP+JulNAnn
	OQP5SqEUiN7MrcNyFZMDd9C+PDRcUXjYNMuiaonXYCMfsLCTv0CLg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af544py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FEO801017174;
	Tue, 15 Apr 2025 14:24:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kucfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOmOC34406726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BEB82004D;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0AF52004F;
	Tue, 15 Apr 2025 14:24:47 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 21/25] s390/uv: Rename find_secret() to uv_find_secret() and publish
Date: Tue, 15 Apr 2025 16:24:34 +0200
Message-ID: <20250415142438.118474-22-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: LWCPeJv7e5cMEj9vulApn99pw0sZoeVR
X-Proofpoint-GUID: LWCPeJv7e5cMEj9vulApn99pw0sZoeVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=841 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

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

