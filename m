Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66C19C569
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089912; cv=none; b=Ww3FzzETXXtEqC7k4e3MBOIzUJ1k3aorEONmCv1q21PmL1ez+Peqo0Eo8Yuj0OD2xubCgKSc0hWR8fwRcId/KvodM5P1JX9fAb9LZV3GcVQNZ/nF79YrMBkigzVwa/HIusxKWA/gTMqPmGrPhaGo828I4JVh8T/5vxJCt/mzytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089912; c=relaxed/simple;
	bh=rS46q+xu/qqlUjCceBaKN6TsZ6887bylx0gAy75KMnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tttSEvFV7+VHV6oA9FatNVZ1S+H1RhQ5cT+B+rx8IpaxIbYVspGudjyH92Ma0l5gkg98G7lBsrvCjqArupcajNjh+jxtsbYU1qhi+NVZ5JjkIo7INOJd09wkKQZPtgVjjWzpccv9g4N4lWyNtXA5Uw9ML13Na3Y4RhzEJbNUlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TNeMKcxr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TNeMKcxr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8sCJH009505
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lSVtK+gzzSsRvcWjB
	JPPDaHJnfYvxVPMHIMJD6xSpE8=; b=TNeMKcxrimUYvEJXy+T5aQSDfuh+ytEno
	UWiXq7ABWozILWwfe9mOuq1dWOHvtGLw+iNhxrtA94LwIQz3MDWD8FxvSYDgQwBn
	ceqi+18U63HJQE+l+aM64G/KMs8b/Ef+DnlJ8Rsh+OVsXVPmU692gHCjub1eon+S
	mAKx1NgRBECk7FbUrV0EV0re4bkcn7rVEehw1VCF/uHABk/lLo+rr+BeuUHHQcR5
	ivfWWwefiv8mFCtu1v0kHhGfPXflN3i/5eXUZQcSYqp+U0JQx2e4FvXNPAtmsxn7
	FkEayK/l3SzYBrHaF6T3/cvtOGJ2vya2JW3nrbqF8znVs+X7ixrdQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq4tju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52REtoiN025455
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0e5ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52RFcP4540042944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 15:38:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA2120043;
	Thu, 27 Mar 2025 15:38:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0F220040;
	Thu, 27 Mar 2025 15:38:25 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 15:38:25 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v1 1/1] s390/uv: Prealloc and use one work page
Date: Thu, 27 Mar 2025 16:38:24 +0100
Message-ID: <20250327153824.61600-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327153824.61600-1-freude@linux.ibm.com>
References: <20250327153824.61600-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dySe-rqGWkoVq98iEgSaqgJ5TkQgWJNd
X-Proofpoint-GUID: dySe-rqGWkoVq98iEgSaqgJ5TkQgWJNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270105

The pkey handler is calling the uv in some circumstances
where no memory allocation is acceptable. As of now only
the uv_get_secret_metadata() function allocates memory.
As this is exactly one page, lets introduce a pre-allocated
work page and protect the concurrent use with a mutex to
remove dynamic memory allocation and free. This page may be
also used with future extension to the uv code.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9f05df2da2f7..71900ec68a23 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -37,6 +37,13 @@ EXPORT_SYMBOL(uv_info);
 int __bootdata_preserved(prot_virt_host);
 EXPORT_SYMBOL(prot_virt_host);
 
+/*
+ * Need one work page for ephemeral use by uv_get_secret_metadata()
+ * The concurrent use of this page is protected by a mutex.
+ */
+static u8 *work_page;
+static DEFINE_MUTEX(work_page_lock);
+
 static int __init uv_init(phys_addr_t stor_base, unsigned long stor_len)
 {
 	struct uv_cb_init uvcb = {
@@ -61,6 +68,12 @@ void __init setup_uv(void)
 	if (!is_prot_virt_host())
 		return;
 
+	work_page = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!work_page) {
+		pr_warn("Failed to alloc a working memory page\n");
+		return;
+	}
+
 	uv_stor_base = memblock_alloc_try_nid(
 		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
 		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
@@ -80,6 +93,7 @@ void __init setup_uv(void)
 	return;
 fail:
 	pr_info("Disabling support for protected virtualization");
+	free_page((unsigned long)work_page);
 	prot_virt_host = 0;
 }
 
@@ -730,11 +744,11 @@ int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
 	struct uv_secret_list *buf;
 	int rc;
 
-	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	mutex_lock(&work_page_lock);
+	buf = (struct uv_secret_list *)work_page;
 	rc = find_secret(secret_id, buf, secret);
-	kfree(buf);
+	mutex_unlock(&work_page_lock);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
-- 
2.43.0

