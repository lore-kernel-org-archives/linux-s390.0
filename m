Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684172;
	b=D18oqtus82NoFLmNeqDH2c6hDf4Fiob0nx9RNG8fuz4D7Rrxio60675EPy8sDxkVEixJ
	 BTQt1INBLuy/DW7AfZit4RcRtUnnD3NnSWPT4NkkuPqVfDNx+D+1rccRQK0kCNkxrIBBV
	 4fkvzmNBvLFf/F2jY1G5rZ2WWwNfv7y0sA8IJIQG5tC9PH3YNWc2T0mrCttSPsQYp5ff4
	 i5k5GxZwJ7znXOpNfVRSUXecfqEdjYb5BmJSmUhibRwbbhMUjGL+WWD+IbRMKBcFcopxS
	 fynN2QM0qzcVQoJWblwImIyILyAKWH5jxjmajNiQ1ZC8DUdRbDJmFRMDsPLUF9kv1bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sCYQVWdE2EbJjiuxll699p3+CJulbX79Av8gQOs+tYY=;
	b=o7N29lNkaMCjb1xfSxrYx7sBL2B5nbXZ4N0CDTedVMOzSk1Y7hzyhZA9QLQTHtWx3XIq
	 hQ1kcjtxV3lhzvJmOVDAJ2o39E2PCXSo62zzM+iHGzhnlbnr6GAqBT925yIj8QMkTo+7z
	 RzOU2p0DAP0zzCKeLC6zC34HBZhoBrVT4x3glqzgjdnQp3/f21bcKZwQluh0AEJcTFQqq
	 ZuSqza7IyDB0vteNMpdX1QOi83sbnmG6728hnCRGiEXMHIY3BsKC/MlwOIFgn1Qc3Focs
	 pcU4ItffQXSUHKOmVxDvbUJuYWr9bz9HBiF7zf8gd4YhGnbdbvVWKMuD+AlKJndInNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XVtb8VVU;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4F606A31F
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E4F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XVtb8VVU
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEF1723184236
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sCYQVW
	dE2EbJjiuxll699p3+CJulbX79Av8gQOs+tYY=; b=XVtb8VVUU+WSsW7WroJjun
	jfRwfvPb1gwffQDqOcO2VjJ9PsBVr4uDLkgUQtenGX/k4oVgeLepYs5XVjHQJwoN
	gq0TCO87oI8bG2pfDUdOSDpEeB6Lge+d5zHCvyNjEG5pzeqxPGMkG50w14yeb4o0
	KdVL3YNLVYVIL7+3BjrXoUKcdEp8DPXIZLR2ppSqj8R2nKb+SKo54XZiVdUmP61b
	jtyY3qTt13eURckirjEO3AHB3iGClh1h84OlPDK3cjm+YEI3887oJRp3RE/nqLuG
	jPt17dQm2oDQCuafKc4XibiL0mbFnGyoXGJLH6eqQS4oZq3w+6QhLUY4OOTZT+HA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58fhb0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEuMUm699980
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn068d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFnPXf17105404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:49:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E6220049;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 990F02005A;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 22 Oct 2026 17:48:56 +0200
Subject: [PATCH v3 2/3] s390/diag204: Replace diag204 users with new
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
Message-Id: <20261022-diag204ioctl-v3-2-c25e7147736e@linux.ibm.com>
References: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfXx+alatcpKOCd
 yXZ4XQvNmqxQW5wYQPXWcevCOR9GrXdztvXkL0k/dWcjmruQSsYsUPzGhmiYS8FGDEQ0032AJiZ
 w7C5RzE3g24sW17WECKGXRJopNpbR40=
X-Proofpoint-GUID: 3IcAMfa_GxhpKwBoE9dfoKyypw3igTVd
X-Proofpoint-ORIG-GUID: 3IcAMfa_GxhpKwBoE9dfoKyypw3igTVd
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ada308a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tT9EuM5j7Eg1edUW3BgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX2hx9fKM+/1+A
 +bA/PJ2UB9KbWT8IsUO/yQiAbo0TYZnCSRiUOEg1A8pndpiAOOu/rNeCNCAlBPkc8l5VeMYu2jj
 Mf+GelA3QoHW4aMXPyLazRd57WnMd4HxsaLWM03ryxjbNch9Q60j0bt3go39rHBPJ/WYsyflgut
 j3U2AHMmtYnx0hg5VPOiOvdZPnY3Dd+FEKxsHuruXLF39aq+AJh58l9P81AI3CipmV5UWSBwmTD
 upVFDrEcAkjFYCbCDCsSi9tOMyjtbr03oVYQ8I7wYPMikiuPyYQpaB03QpsP7dtzPis6yW4mw1q
 UeBG4tKuVZ3wHFdQSBC7umY1mZimzArOz/hRNd4C4Y7TMHMINRdmhUbL+BhffAvYeU9SeggL+eV
 wxvxDECJHc7IQ0ZKfnAgevYfqWRWELpLsKYDdkhGQVDM+BVM0m3ZWZX+gklnZUn1T/f5uzVyQO2
 n7OSmu7t6Hl9dBu3CfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

Replace the existing diag204 users in kernelspace with the new diag204
interface.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c    | 140 ++++------------------------------------
 arch/s390/hypfs/hypfs_diag.h    |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c |   9 ++-
 arch/s390/include/asm/diag.h    |   1 -
 arch/s390/kernel/diag/Makefile  |   2 +-
 arch/s390/kernel/sthyi.c        |  30 +++------
 6 files changed, 29 insertions(+), 157 deletions(-)

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
index 39621c326010..2ce9119abe99 100644
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
+	rc = diag204_store(buffer, 1, 1);
+	if (rc < 0)
 		return rc;
-
 	systems_dir = hypfs_mkdir(root, "systems");
 	if (IS_ERR(systems_dir))
 		return PTR_ERR(systems_dir);
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 8669cfa039d3..ca78ca45a8a2 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -121,7 +121,6 @@ enum diag204_sc {
 
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
index 5eae2e25997a..9adb26588d5b 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -305,29 +305,19 @@ static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 
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
+	if (diag204_get_subcode() != DIAG204_SUBC_STIB7)
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
@@ -462,7 +452,7 @@ static int fill_dst(void *dst, u64 *rc)
 	fill_hdr(sctns);
 	fill_stsi(sctns);
 	fill_diag(sctns, diag204_buf);
-	vfree(diag204_buf);
+	diag204_free_buffer(diag204_buf);
 	return 0;
 }
 

-- 
2.56.0

