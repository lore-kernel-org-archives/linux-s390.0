Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D613186E20
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501799; cv=none; b=qcXsRkzMU5LprP+Vu0alSVenzCVFnYIvr1zSwWhUQtU5G1A1P50p7ULmmjjFNjxrKD3v2rqf0ZHzu2PPu3GMVWFt/WSnqsH2u84zuzNFkcAVc3yyjh/YumGFmgiqsttOibbyySEpn0f2mUxZoU+XRrHExlODIRfKzrQwnCeNtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501799; c=relaxed/simple;
	bh=ISiHYjqxvjuqXImLCuEAuWiQFl6ZW1KwD7XscIpSshI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4uPlcYJFqUKny+23SEBEF7H1ZUj7IbTza6tAJjIESjT5tWkzP5wEYi/vtEa0O6TgRyNX1VKx2EBsNLR20B7mdSAMB/ABqXP/GPAHqvrp0aH6xwQf9EVjWYQyTMDqzNwt6TnCi95/oxVr5/VImrxz1QWpIPrL2w5xeO8JzfsKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XMgC09yR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XMgC09yR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OB6uog006230;
	Thu, 24 Apr 2025 13:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0xbNcA9386SR3u9HM
	FmxE6BNB5l8J6lx7Z+kOTKGqLY=; b=XMgC09yRO2npv0J0nkNwLwUaUny/PEpHl
	9FAofVby790OO75PzYeflGDBunzJ4VithroJWIvyuTUb7jabdm5YPHEeMSSszkPW
	0LR5UACj149KcoXck58dmYKbBnyopi8oeG0Gj+jiNoIk71VP5BL7jizMJuSI4SxS
	R8Lwqle0Cfen6S/X0aVNu0T3J4APcse+JouuviEgjKyNfeQbC8AKxFwwdHcJCNNT
	FwP9sW/876JO5eumcdWWS/OE3XPpz7jIauNSkL3CptgB4h0IhTXBCUtChbsb2qZ1
	//qo/7RfoHQNYLoeox+3v22q7//fMEOK3BQBjW3yobhMDbU2OZzrg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60u8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBbxiO005844;
	Thu, 24 Apr 2025 13:36:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxgd4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaVAI49021326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C51D2004D;
	Thu, 24 Apr 2025 13:36:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF5122004E;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 23/25] s390/uv: Remove uv_get_secret_metadata function
Date: Thu, 24 Apr 2025 15:36:17 +0200
Message-ID: <20250424133619.16495-24-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=680a3e63 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=M5ODTVqq-DlaZZw1mYcA:9
X-Proofpoint-GUID: uZPhGifkftnAe1r3pVu9QIvIyYY2yZKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4OCBTYWx0ZWRfXxXVT6Vn10dAQ X0J6SwjktEG/Os4Q42dAQ6jgUSTfFdrRYtmLeqE4Gh8TvWixCckWkg3Q00q/RFOjkz6Cf+i8oYk EefJBL72Ecsgl8MZAe+X6i/cE9LjHR6qcCW5DlBtvgKxD/dFvk+5NLAc9TWyJeLhpaF+TiMEpMC
 j6VDpgw3Q9ApvrmVujf0uthBmglodVZ33k+DmCEDO8GvWv4BmbkdoZlaZYy0YbCw9SQbJ5JKACL 5xFlUfyN6jaDg21RwYsUyndmyYpe+3/w91IFI6JVIXruomRkI4iRbiE2rpBvpK7CDNeiRwX20k0 jjTvxOiaRP7m3gaHfsH1ifWZCPWo9nso2ALQwu+N+dpVTFE9VoRhi14c2AdKZ9Vq79+S+UjhbbQ
 IHjnSvS3bw9dKrNOXIkBJaiTcEgZZpYCPsbWbOFCJgH0PnbmO574IeKejivJ8XJI08w2kdU6
X-Proofpoint-ORIG-GUID: uZPhGifkftnAe1r3pVu9QIvIyYY2yZKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=884 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240088

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

