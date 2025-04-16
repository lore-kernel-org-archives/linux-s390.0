Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BE219302
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811904; cv=none; b=W1KrzIThZMwyhQTQX4BJWyZhGfQvwrMVVWJWcnbScbx2qFz4Xm0720eHSqo6YUX2F/lpnOFBr1hMl/4sLiVieW/CuSPwmdy9X7KhOnU1zKH1pLV7crruVH9mVjtMowB08hcaHZ2J16G1mZx7KBFpxTHuCyRHj9rfH8tAC9ohsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811904; c=relaxed/simple;
	bh=ISiHYjqxvjuqXImLCuEAuWiQFl6ZW1KwD7XscIpSshI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcGapZy/rZmu1gNQQQefNTh/ag/kmL/MZIILRLAT1R5LwOh2p6YrRnorKcQDG/RqtjX2gdHA+DwQzQSCILYGSKImqbXLimhwJFA4DGgEPbjQxJlyBKOwgS0M/Mqvpm3QqAv5+wC4bwtrPdXdVHzvFOnrTOVXjz+WioRTDAOMCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBFgso8Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBFgso8Q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9ejMX018309;
	Wed, 16 Apr 2025 13:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0xbNcA9386SR3u9HM
	FmxE6BNB5l8J6lx7Z+kOTKGqLY=; b=BBFgso8QAYuuFjaihBrD57WoPQK2r2vvQ
	mE++fj5NpOuzSpMC6NrHeML3/D76Oy4E2B1wiC9bEJpJRwuEftOKuqGN8CzFF0iD
	+Ubr512+8kDhZFk2RxurCn9LPwUQ1sxlV3EXhNxZeKYE15dDFYIxf7PonV5JY/nK
	5tcZ10HivrFl0uhHZMDsHtN+Gd59COt/WtPz7VMRuLcyvJPCUddEGiEQsz2WdqBY
	6HBYiGnwfFH9yHUg3Byk0CAWHnNLtnoUgdal7O1IbJbwqDjlAKGDib3fhFGuAhte
	eee97yIf26d1aQKclrEqMp28YuVMsWOEXhN4efEnl81JRjdpYMLXA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gc60g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GCN2K2016431;
	Wed, 16 Apr 2025 13:58:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4605728839-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwGPg41943430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74AA120040;
	Wed, 16 Apr 2025 13:58:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6DB920043;
	Wed, 16 Apr 2025 13:58:15 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:15 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 23/25] s390/uv: Remove uv_get_secret_metadata function
Date: Wed, 16 Apr 2025 15:57:58 +0200
Message-ID: <20250416135801.133909-24-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Q-QCj_gXG8CGVwmYmW2GwaD7cpnncG_f
X-Proofpoint-GUID: Q-QCj_gXG8CGVwmYmW2GwaD7cpnncG_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=884 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

The uv_get_secret_metadata() in-kernel function was only
offered and used by the pkey uv handler. Remove it as there
is no customer any more.

Suggested-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Holger Dengler <dengler@linux.ibm.com>
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

