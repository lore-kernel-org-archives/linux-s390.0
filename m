Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D1223DD2
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403357; cv=none; b=lf/BS8MwpoCYFZxNyxpI8zX5k2QHfmTQZ6TtLxN40KUMJJKqMgPb6+XabVi+BSkU5gzZJ7i4tapG3gGmTjf8k8TEuMwZE/ahYrihApMDnVNVDpgwrDxZ7tjsCTSawj4EIzMB94RWijMyY+VgL9oolwkQnIjnyxl50pRtyP4Bevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403357; c=relaxed/simple;
	bh=ISiHYjqxvjuqXImLCuEAuWiQFl6ZW1KwD7XscIpSshI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKJ9ODkT+XVoYRVBg3vFCS0/6dN6uYsyjyYiDk+eGyOjHuRjWLDe9OpV4P0Ze60g41aX6JybbEwRVGa7fYtnRXGuTR2luGD7qXbNAaUC/gIu4LLTFt3Vqnkidd9Crj9w1UWlZsJa0T5dobhW6AN19DmIoSTxamd/vG7TJ/zBE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJHUKU5p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJHUKU5p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fhXX002038;
	Wed, 23 Apr 2025 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0xbNcA9386SR3u9HM
	FmxE6BNB5l8J6lx7Z+kOTKGqLY=; b=IJHUKU5p2HsdSVqjX0RZrdI1HdrupLCTb
	FxUdLEOaRrgwBs4oExqiNoYwSDDsjPGgLMZMQ48x0nn1gGwKNyDEKDex1ph3ub9K
	ZNvrsSNYF+aiD9olaaQ+hkccXoEOd94z4kQ215rMJ0lNJUvEB9TVS6KeWxk/oH2O
	w6ssoNH5biTSseXDfXbow1KFOOtb1Z5NCKQEtjn1tNM+l7N3k4B2xBOzEGeBV/Kz
	D1vNY2AwDCtryX/sz+6V3zhTpHOPis5Wj64H0GZ+L2r0FRrjz0IURmSGzp/ER41p
	q7yrCIbWf1slOyfS+jC/4c1c3burC9eSF9Xf1ClamSlqZxSuSwFqA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpt2pur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6Telp004062;
	Wed, 23 Apr 2025 10:15:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfyth3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFneN56557994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE4272004D;
	Wed, 23 Apr 2025 10:15:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C3E320049;
	Wed, 23 Apr 2025 10:15:49 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 23/25] s390/uv: Remove uv_get_secret_metadata function
Date: Wed, 23 Apr 2025 12:15:32 +0200
Message-ID: <20250423101535.143137-24-freude@linux.ibm.com>
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
X-Proofpoint-GUID: FfX0QwIUiQt4bnT9JkDxaps1b1PXGm8A
X-Proofpoint-ORIG-GUID: FfX0QwIUiQt4bnT9JkDxaps1b1PXGm8A
X-Authority-Analysis: v=2.4 cv=a/Qw9VSF c=1 sm=1 tr=0 ts=6808bdda cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=M5ODTVqq-DlaZZw1mYcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX21YDwi93xDiJ t5Npvra+mvHWK4BegRrdUs9x80Kq7pQt50PiXeDjcLMHwH6pF+GjDJKdArLyZfAP24bPRURVk1S 516zTGZAW5u905Zq1S/m1RZtxy5hREND2GhfL9Xr0lQUhXlbM3okZm8PDOJbmlUDgsX2n0exTNW
 vKSXR+wNJEgOl2xz2f/5WlapwJDDFk+44M+c+OHfx69p1TeDOyHIvJbN/0SBCHciPDW2cDeTquM iJ7ds33cETmTPehz0KM8wG/jE/k9BDSG69Sm3bu/7px44o+7nZ62arnL9EL52WleQTT1AB72J3d ntyArrnbu2X3NRwG56MbKf969sQcF2yeGgMUUFHzAZBWNl9i7cuvJsEhp4hh2IoIHIb2DlfJvol
 zRhnIxsIEx9xjN3aYvZt3vpVWfGdTRd8LgxIBqQeoqSfecsEu6LOeYyJ9vfZ42tbEILwEn9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=884
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

