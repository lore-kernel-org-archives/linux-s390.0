Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B09265CA7
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207409; cv=none; b=fhEiwfR1Hgka5qlO1bBRNFvIJGfFgzfAdchAgl0IKECmq2Mrz8N+ucREp2hwT4xgjjQxzcoKmDNDaDSo9oNPX4Aia7BvfDRCVfB+TO4VOK3nTN8rFQleXxym9usGnh2lsyxSNFT1GdaLtGvErNBOV4l5LQXZjI8EKC9jjuJj8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207409; c=relaxed/simple;
	bh=7M5hlyu1p7Edq4RudT/Wv5k0Stby/6wUFNaJ/OAMt+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kehoe2qA8LergKNCJrZjqiUoZgEOGhW/XvM5OSHPqbe/FPDyo7wkzB6KZZrWtO3bDCRDfuT2Ip3/Jod13w6NCkqePBRFBtj8ehI4yQcKyptClIU8OBukIU2nV00ks+o1a6OLw+61q3+/+as7JsMqlcjwZvTqaYttcfHmcsZ5k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nOibuESG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nOibuESG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53990d6c008966;
	Wed, 9 Apr 2025 14:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VWm0ce7ij5BHa4tSb
	qs2IYHJfGCIXmsqBUNYeNKAkh4=; b=nOibuESG34PKpvrNJsFNEXBkJ25Lk71WE
	9kJiu6y+oi12BnRJCYqQwkbxADbO8fPJ9Ll5tfwM1GHVuj79o4hiVMc+qQ9WLH/p
	5KSyC9zfnDz9GGuqH7xfaSCMva9bKsAAX66phdTG1Sv0+6LW7/g0WKuVCLCOHZxB
	pnLcWV7aiY5EEo1rwEXIJFVymPkLaUMegjLBwD7W+UvMM+DMRZb0daYgn6i2JXjT
	oZb61x3qID4tk5/0oQjJjOieGuI5zqTZnRcvlzAzpjkvhCDlkZSKEhxpA9K/Rn1T
	MQDFXJCSZnQk+cI1VhqL1hic1d9pwkP/teE2Cqtb/kZKN3W6dpiqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr40yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539A9let017447;
	Wed, 9 Apr 2025 14:03:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kqucs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3KO756295920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C27A2004B;
	Wed,  9 Apr 2025 14:03:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF36720043;
	Wed,  9 Apr 2025 14:03:19 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 21/24] s390/uv: Rename find_secret() to uv_find_secret() and publish
Date: Wed,  9 Apr 2025 16:03:02 +0200
Message-ID: <20250409140305.58900-22-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jdPf8PYWEKhRvn8ZkWXEvLe8gaK-UZMb
X-Proofpoint-GUID: jdPf8PYWEKhRvn8ZkWXEvLe8gaK-UZMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=660 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

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
---
 arch/s390/include/asm/uv.h |  3 +++
 arch/s390/kernel/uv.c      | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index b11f5b6d0bd1..8d7e00fa2bf0 100644
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
index 9f05df2da2f7..4acbbdff568f 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -681,12 +681,15 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 
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
@@ -708,6 +711,7 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(uv_find_secret);
 
 /**
  * uv_get_secret_metadata() - get secret metadata for a given secret id.
@@ -733,7 +737,7 @@ int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
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

