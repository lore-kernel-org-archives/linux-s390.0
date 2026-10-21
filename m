Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578504;
	b=cMXmJmpNXMxVnM+ulf2PATwokh3qu5JN8pmYdq0ZQ+4kFgUSB8fzbERwXqz9x1Tmfoct
	 lzFRcayndxSvBT43vOvunvd4x9ZXFJB3aV6g9I+TTK9PSfO1D6ULM1iA8Terowp78w+Az
	 WnVtNc+DdsiJPdP0uVQslYPuBk+WOEPDaYoVS6tHZJawr3R+C+ev177Me+3Gg4Xl+zxi6
	 fB/TU/aytvSDVL4+0mdTsH1nCsphkYD5aT+RpmBML1vWgQbd+ATyMeYkVmdAWCkNzgmTI
	 73m4M9JpNokUGTE/2oHHLOf8wyXxjQmrArMxV8QEjZMVRnuHHv0yv0pXCS64CDJOvdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ddpxYY1cgJNVj9XTLO0yc9fY2je8Mr3k4CDUXt3zZZ4=;
	b=TrXNCb7G93KvWJh+MOR1WPHrk+GLRy4lCjwTKgRl01t867APSBgwwA4iZK2+Q7xaL1z5
	 lN3+riPvt9JHEF+/Z6NnLk2jAjyHS8dlnufNjJ0GisriZ/Uq+dFCU8aPm4/dvKZnUHeVV
	 cKsGwEVmszi4UShKsVt08BEFwoam5aEfnhItFKgt3EsLS4GHw/peKQczHPlHuwtiQ4ohA
	 6m0khF8G/SejqsRmW07Xg5FN4hqsUYsKm7uXYNKg0lWsL4ayiJ57RpyMdhjPMOMMLvZf9
	 jEkav+pfjtrEgCFstRj2RuT0qlSO9ACPhXK6sWCnzB9SQxH8vMUUP8ZGDnVpFN0IWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I693x7nH;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927C606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3927C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I693x7nH
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LAELMH905852
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ddpxYY
	1cgJNVj9XTLO0yc9fY2je8Mr3k4CDUXt3zZZ4=; b=I693x7nHdcjsQGRkgFevK0
	1TRKOnTd47qAZA9bG2DkSaPdjJpNpQwlkLfGx1a+rvHtFmNh1UTYFWLhZuRsLS27
	qWopb1yg2rEaIYGIoXCP1q4k5c7BfCsddufcy5nmkTHZ5rLULyd2GOfzUPvSk1K5
	l5V2bclhNujWLVIkkHzMyDUQ4E40YpDsTspCvM4hCoh869OEkGHNMs8Ki6m74B7I
	GxEKQic1LRgFucDcrskSnfEdu/FD4NhU3CQ3DbmfOtzA77KoOClYHiofvVJ5NoZ6
	zvjPm2tnMLk492Umagkvzrg2T9lwwl55rrWp8dl25cNy8hRGc5fO/y46lZlaGIZQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a0337-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA53hp1739231
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss2fxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LASIkx48431404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 10:28:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70BA20043;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8A92004F;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 21 Oct 2026 12:28:09 +0200
Subject: [PATCH 2/3] s390/diag204: Replace diag204 users with new
 implementation
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-diag204ioctl-v1-2-25645b97bf4e@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX5Ww055WkIL2F
 +yoi+06ddIpl8rccvIvyuX2fCY+GOIzZSnGWcS0a+u3NgXkwTJHr8XySuDiIRsCZTTkUx633TCO
 92tv4wDjCd0Wjf2MaPYhf60nRLeEAGlEW9ZXPS3PjESEeF7mMVmEoeO8eVmGr2SmucBbYLREOri
 cDLHiQ50VdYBgHAB/5YksoQ+xvuxIzCvGxWbAxcdKfHkCHThKKBH3e+gPOqBwIzvmDWymQwts/0
 U3aTWZPEq7nnWZdbURVfNvcouo2ulZbgR3dBayijgD0Mj2N+Bw87MQpub5M3v4CiJr+3Tn9+S8m
 gUHLfqN3lz7ulezJLo+668z7X68FutoXFzriq2339MLxc0RIeX5MU3pgB7MZYx+C73z8niAkz+t
 dcmXvohpGDh7nVvw+DK/B8x+0gPhpBXP5Rmoawh24t8EjI+kV95LH0LpGDXcww4sTvyB012V8uU
 SQQiz6XuotCLJBhnw+Q==
X-Proofpoint-ORIG-GUID: nj7y16vGaLQoGkrM-VzCFgvF93O-WMdv
X-Proofpoint-GUID: nj7y16vGaLQoGkrM-VzCFgvF93O-WMdv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX2Hjb5fz/IyaW
 2j/dFFXZXxCsv+HpbEA/5JMue6GhVqZ28vV2qiEt3bz+6X6sPQQEnNVfrdKiJ4baLusKQDpsGt6
 7BI3cYXkyXquR0v2OnR2crURDgFqMio=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad893c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=tT9EuM5j7Eg1edUW3BgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210040

Replace the existing diag204 users in kernelspace with the new diag204
interface.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c    | 140 ++++------------------------------------
 arch/s390/hypfs/hypfs_diag.h    |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c |   9 ++-
 arch/s390/include/asm/diag.h    |   1 -
 arch/s390/kernel/diag/Makefile  |   2 +-
 arch/s390/kernel/sthyi.c        |  28 +++-----
 6 files changed, 27 insertions(+), 157 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 08777f57bd24..c3eebe4667fa 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -22,139 +22,24 @@
 
 #define DBFS_D204_HDR_VERSION	0
 
-static enum diag204_sc diag204_store_sc;	/* used subcode for store */
-static enum diag204_format diag204_info_type;	/* used diag 204 data format */
-
 static void *diag204_buf;		/* 4K aligned buffer for diag204 data */
-static int diag204_buf_pages;		/* number of pages for diag204 data */
-
-enum diag204_format diag204_get_info_type(void)
-{
-	return diag204_info_type;
-}
-
-static void diag204_set_info_type(enum diag204_format type)
-{
-	diag204_info_type = type;
-}
-
-/* Diagnose 204 functions */
-/*
- * For the old diag subcode 4 with simple data format we have to use real
- * memory. If we use subcode 6 or 7 with extended data format, we can (and
- * should) use vmalloc, since we need a lot of memory in that case. Currently
- * up to 93 pages!
- */
 
-static void diag204_free_buffer(void)
+static void hypfs_diag204_free_buffer(void)
 {
-	vfree(diag204_buf);
+	diag204_free_buffer(diag204_buf);
 	diag204_buf = NULL;
 }
 
-void *diag204_get_buffer(enum diag204_format fmt, int *pages)
+void *hypfs_diag204_get_buffer(void)
 {
-	if (diag204_buf) {
-		*pages = diag204_buf_pages;
+	if (diag204_buf)
 		return diag204_buf;
-	}
-	if (fmt == DIAG204_INFO_SIMPLE) {
-		*pages = 1;
-	} else {/* DIAG204_INFO_EXT */
-		*pages = diag204((unsigned long)DIAG204_SUBC_RSI |
-				 (unsigned long)DIAG204_INFO_EXT, 0, NULL);
-		if (*pages <= 0)
-			return ERR_PTR(-EOPNOTSUPP);
-	}
-	diag204_buf = __vmalloc_node(array_size(*pages, PAGE_SIZE),
-				     PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
-				     __builtin_return_address(0));
+	diag204_buf = diag204_allocate_buffer();
 	if (!diag204_buf)
 		return ERR_PTR(-ENOMEM);
-	diag204_buf_pages = *pages;
 	return diag204_buf;
 }
 
-/*
- * diag204_probe() has to find out, which type of diagnose 204 implementation
- * we have on our machine. Currently there are three possible scanarios:
- *   - subcode 4   + simple data format (only one page)
- *   - subcode 4-6 + extended data format
- *   - subcode 4-7 + extended data format
- *
- * Subcode 5 is used to retrieve the size of the data, provided by subcodes
- * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
- * to subcode 6 it provides also information about secondary cpus.
- * In order to get as much information as possible, we first try
- * subcode 7, then 6 and if both fail, we use subcode 4.
- */
-
-static int diag204_probe(void)
-{
-	void *buf;
-	int pages, rc;
-
-	buf = diag204_get_buffer(DIAG204_INFO_EXT, &pages);
-	if (!IS_ERR(buf)) {
-		if (diag204((unsigned long)DIAG204_SUBC_STIB7 |
-			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >= 0) {
-			diag204_store_sc = DIAG204_SUBC_STIB7;
-			diag204_set_info_type(DIAG204_INFO_EXT);
-			goto out;
-		}
-		if (diag204((unsigned long)DIAG204_SUBC_STIB6 |
-			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >= 0) {
-			diag204_store_sc = DIAG204_SUBC_STIB6;
-			diag204_set_info_type(DIAG204_INFO_EXT);
-			goto out;
-		}
-		diag204_free_buffer();
-	}
-
-	/* subcodes 6 and 7 failed, now try subcode 4 */
-
-	buf = diag204_get_buffer(DIAG204_INFO_SIMPLE, &pages);
-	if (IS_ERR(buf)) {
-		rc = PTR_ERR(buf);
-		goto fail_alloc;
-	}
-	if (diag204((unsigned long)DIAG204_SUBC_STIB4 |
-		    (unsigned long)DIAG204_INFO_SIMPLE, pages, buf) >= 0) {
-		diag204_store_sc = DIAG204_SUBC_STIB4;
-		diag204_set_info_type(DIAG204_INFO_SIMPLE);
-		goto out;
-	} else {
-		rc = -EOPNOTSUPP;
-		goto fail_store;
-	}
-out:
-	rc = 0;
-fail_store:
-	diag204_free_buffer();
-fail_alloc:
-	return rc;
-}
-
-int diag204_store(void *buf, int pages)
-{
-	unsigned long subcode;
-	int rc;
-
-	subcode = diag204_get_info_type();
-	subcode |= diag204_store_sc;
-	if (diag204_has_bif())
-		subcode |= DIAG204_BIF_BIT;
-	while (1) {
-		rc = diag204(subcode, pages, buf);
-		if (rc != -EBUSY)
-			break;
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
-	}
-	return rc < 0 ? rc : 0;
-}
-
 struct dbfs_d204_hdr {
 	u64	len;		/* Length of d204 buffer without header */
 	u16	version;	/* Version of header */
@@ -173,19 +58,20 @@ static int dbfs_d204_create(void **data, void **data_free_ptr, size_t *size)
 	int rc, buf_size;
 	void *base;
 
-	buf_size = PAGE_SIZE * (diag204_buf_pages + 1) + sizeof(d204->hdr);
+	buf_size = diag204_get_buf_size();
+	buf_size += PAGE_SIZE + sizeof(d204->hdr);
 	base = vzalloc(buf_size);
 	if (!base)
 		return -ENOMEM;
 	d204 = PTR_ALIGN(base + sizeof(d204->hdr), PAGE_SIZE) - sizeof(d204->hdr);
-	rc = diag204_store(d204->buf, diag204_buf_pages);
-	if (rc) {
+	rc = diag204_store(d204->buf, 1, 1);
+	if (rc < 0) {
 		vfree(base);
 		return rc;
 	}
 	d204->hdr.version = DBFS_D204_HDR_VERSION;
-	d204->hdr.len = PAGE_SIZE * diag204_buf_pages;
-	d204->hdr.sc = diag204_store_sc;
+	d204->hdr.len = diag204_get_buf_size();
+	d204->hdr.sc = diag204_get_subcode();
 	*data = d204;
 	*data_free_ptr = base;
 	*size = d204->hdr.len + sizeof(struct dbfs_d204_hdr);
@@ -202,7 +88,7 @@ __init int hypfs_diag_init(void)
 {
 	int rc;
 
-	if (diag204_probe()) {
+	if (!diag204_is_available()) {
 		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
@@ -219,6 +105,6 @@ __init int hypfs_diag_init(void)
 void hypfs_diag_exit(void)
 {
 	hypfs_diag_fs_exit();
-	diag204_free_buffer();
+	hypfs_diag204_free_buffer();
 	hypfs_dbfs_remove_file(&dbfs_file_d204);
 }
diff --git a/arch/s390/hypfs/hypfs_diag.h b/arch/s390/hypfs/hypfs_diag.h
index b5218135b8fe..6b5bea39b6f9 100644
--- a/arch/s390/hypfs/hypfs_diag.h
+++ b/arch/s390/hypfs/hypfs_diag.h
@@ -12,9 +12,7 @@
 
 #include <asm/diag.h>
 
-enum diag204_format diag204_get_info_type(void);
-void *diag204_get_buffer(enum diag204_format fmt, int *pages);
-int diag204_store(void *buf, int pages);
+void *hypfs_diag204_get_buffer(void);
 
 int __hypfs_diag_fs_init(void);
 void __hypfs_diag_fs_exit(void);
diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag_fs.c
index 39621c326010..13b5a2a4729d 100644
--- a/arch/s390/hypfs/hypfs_diag_fs.c
+++ b/arch/s390/hypfs/hypfs_diag_fs.c
@@ -303,15 +303,14 @@ int hypfs_diag_create_files(struct dentry *root)
 	struct dentry *systems_dir, *hyp_dir;
 	void *time_hdr, *part_hdr;
 	void *buffer, *ptr;
-	int i, rc, pages;
+	int i, rc;
 
-	buffer = diag204_get_buffer(diag204_get_info_type(), &pages);
+	buffer = hypfs_diag204_get_buffer();
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
-	rc = diag204_store(buffer, pages);
-	if (rc)
+	rc = diag204_store(buffer, 0, 0);
+	if (rc < 0)
 		return rc;
-
 	systems_dir = hypfs_mkdir(root, "systems");
 	if (IS_ERR(systems_dir))
 		return PTR_ERR(systems_dir);
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index fe817a7c290d..9b5f5c02dbf3 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -122,7 +122,6 @@ enum diag204_sc {
 
 #define DIAG204_SUBCODE_MASK 0xffff
 #define DIAG204_BIF_BIT 0x80000000
-#define DIAG204_BUSY_WAIT (HZ / 10)
 
 /* The two available diag 204 data formats */
 enum diag204_format {
diff --git a/arch/s390/kernel/diag/Makefile b/arch/s390/kernel/diag/Makefile
index 956aee6c4090..6e255b66be44 100644
--- a/arch/s390/kernel/diag/Makefile
+++ b/arch/s390/kernel/diag/Makefile
@@ -1 +1 @@
-obj-y	:= diag_misc.o diag324.o diag.o diag310.o
+obj-y	:= diag_misc.o diag324.o diag.o diag310.o diag204.o
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 5eae2e25997a..5d9228039ce7 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -305,29 +305,17 @@ static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 
 static void *diag204_get_data(bool diag204_allow_busy)
 {
-	unsigned long subcode;
 	void *diag204_buf;
-	int pages, rc;
-
-	subcode = DIAG204_SUBC_RSI;
-	subcode |= DIAG204_INFO_EXT;
-	pages = diag204(subcode, 0, NULL);
-	if (pages < 0)
-		return ERR_PTR(pages);
-	if (pages == 0)
-		return ERR_PTR(-ENODATA);
-	diag204_buf = __vmalloc_node(array_size(pages, PAGE_SIZE),
-				     PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
-				     __builtin_return_address(0));
+	int rc;
+
+	if (!diag204_is_available())
+		return ERR_PTR(-EOPNOTSUPP);
+	diag204_buf = diag204_allocate_buffer();
 	if (!diag204_buf)
 		return ERR_PTR(-ENOMEM);
-	subcode = DIAG204_SUBC_STIB7;
-	subcode |= DIAG204_INFO_EXT;
-	if (diag204_has_bif() && diag204_allow_busy)
-		subcode |= DIAG204_BIF_BIT;
-	rc = diag204(subcode, pages, diag204_buf);
+	rc = diag204_store(diag204_buf, diag204_allow_busy, 0);
 	if (rc < 0) {
-		vfree(diag204_buf);
+		diag204_free_buffer(diag204_buf);
 		return ERR_PTR(rc);
 	}
 	return diag204_buf;
@@ -462,7 +450,7 @@ static int fill_dst(void *dst, u64 *rc)
 	fill_hdr(sctns);
 	fill_stsi(sctns);
 	fill_diag(sctns, diag204_buf);
-	vfree(diag204_buf);
+	diag204_free_buffer(diag204_buf);
 	return 0;
 }
 

-- 
2.56.0

