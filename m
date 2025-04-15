Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77A27FD70
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727098; cv=none; b=AIbb3DyQ7WGTGr4uPKGCBQeESTLIKQs+CtvRvCvETeCb0KF2TjhCUd+gg8AfjFlNlVYv7OsVHQEkbQYwSMvAedsquGketNGkNCMUIrvgOgLh0ZW8osghI8HnsciTf8t8elxNaYYhH/lcMgACnjOGB5NkEXzmFZSBXarysumEuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727098; c=relaxed/simple;
	bh=tjS64wvuvAwkcnjefJ4vmETjCvkASVzV1O0ANALjGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l94iV4P3NLRhxUIciYiAcYGzxRpX9dx1OKVepMtlNsZ+4Ob+aN7R8+DdPST/w2UFHEwH2M88ooOsVQvdX3s/uUf2A77FWeiFfdqdbOA2uxmwXx5G8xpRfGMNRcBCR61/Iig0ON+79QFaA1bmM30yDowmeIGtO0+T7pYxK+SmH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PCeSN8qB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PCeSN8qB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAf3v6021590;
	Tue, 15 Apr 2025 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KfptMPncFOhkTPMr3
	mU2HRXCLGv3BwBNphAnpUk+mIQ=; b=PCeSN8qBx3QHLilQ3qq6IK3AmHt4h09kW
	233O66r3ZHUUAWd5rekw5yLOCn6qk9gn1OyNBgOVHW8GkBb3mKN5x8hMJbb8JKYO
	oJ2mM3lYe8ak3c0trvhVDMENk3BmRii3T0g/GZlF7xJZbETMyqY5YRzrmiGavvd8
	KY5lpkhSBnbHoc+BP4i3IsfNeuzRE0+2R5J/kuNkWoK3A6AEfvfO+tcAiqLbq3zq
	v15yA5vk8544V0PzYYjbL7eMNajcfJ3Sm/Njw+uZsCOKqLAnZ7E121BhBmq4IcRd
	rT6pfcuOmk95NunvXyGVCTMUmmkhLNgpr4nx+JXAVd18FTESnojCA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq13ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FCZqbb024882;
	Tue, 15 Apr 2025 14:24:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtbtr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOn8H35324254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13D9120040;
	Tue, 15 Apr 2025 14:24:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8AD32004B;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 23/25] s390/uv: Remove uv_get_secret_metadata function
Date: Tue, 15 Apr 2025 16:24:36 +0200
Message-ID: <20250415142438.118474-24-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: agZBoZ1ybyvcOPovTWGdS3YFYS8T8R4y
X-Proofpoint-GUID: agZBoZ1ybyvcOPovTWGdS3YFYS8T8R4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=857 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

The uv_get_secret_metadata() in-kernel function was only
offered and used by the pkey uv handler. Remove it as there
is no customer any more.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Suggested-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  2 --
 arch/s390/kernel/uv.c      | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 7f53fe755f3f..b008402ec9aa 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -619,8 +619,6 @@ static inline int uv_remove_shared(unsigned long addr)
 int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		   struct uv_secret_list *list,
 		   struct uv_secret_list_item_hdr *secret);
-int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
-			   struct uv_secret_list_item_hdr *secret);
 int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
 
 extern int prot_virt_host;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index faac43359e23..4ab0b6b4866e 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -840,36 +840,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 }
 EXPORT_SYMBOL_GPL(uv_find_secret);
 
-/**
- * uv_get_secret_metadata() - get secret metadata for a given secret id.
- * @secret_id: search pattern.
- * @secret: output data, containing the secret's metadata.
- *
- * Search for a secret with the given secret_id in the Ultravisor secret store.
- *
- * Context: might sleep.
- *
- * Return:
- * * %0:	- Found entry; secret->idx and secret->type are valid.
- * * %ENOENT	- No entry found.
- * * %ENODEV:	- Not supported: UV not available or command not available.
- * * %EIO:	- Other unexpected UV error.
- */
-int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
-			   struct uv_secret_list_item_hdr *secret)
-{
-	struct uv_secret_list *buf;
-	int rc;
-
-	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	rc = uv_find_secret(secret_id, buf, secret);
-	kfree(buf);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
-
 /**
  * uv_retrieve_secret() - get the secret value for the secret index.
  * @secret_idx: Secret index for which the secret should be retrieved.
-- 
2.43.0

