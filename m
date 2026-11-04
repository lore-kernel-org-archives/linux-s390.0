Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784300;
	b=ie4zMQb70GHDLvCsM04Xb7Y3WYosmrcUZ+KbzMwtJUBeaLkfxg+H/9djFcPMx2U+KMYK
	 Zs1l0mHZeRjVm1WW0ia174YlYMO8O8rLgjklBqjFLrZCEKxF0+17pN2g3XsNFPQa8mLJw
	 PKh/ePnfD12OMODfldEgy/mnAKxpsi+rzSQDtngbRAeQ5/6y0xW0YrbPcLmKPyX9TsqyD
	 Ge9GvWW54tsN+BVigNBdJ2zKyHKpBduow4hVqgKP+8gynYYEjkV56/eQp+IOSNaVyTQcn
	 T6TEekxyJXaujtySLu34sCe/T1Mr1ww3ipWvCieDidFJonC3v+KIsvVVeCxSxtI6CSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784300;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Zw1ATC30/MvcXhHjYm+mddFqE0zSbiZXJNyOFl8pdDw=;
	b=xrERAJoivGo6ZHxvWuFYB9WTjAxCaQjPYRE7MCMCC1/4vcaOWtQWg7/sz8b6RDcP447z
	 SMO3BmwvjS2FBIOM6Rc1AZNIkcqMHIQ4AUlCYs0s1ecIhg1XmxtqhjQI7sTXp2OUb5PKx
	 18PQgceSW1jCyemSstpj3JuQ93ZOVxEgyWV3u9ll/ctRpwogW9WDWxqjgAdHIB9LNY3zv
	 5MRnNS2yDu9g1JAqsBhTW+gvVqzh2WoVUMwquFSS8DfTdA/ZVOBRGl7buDV6lJFaPxsMw
	 HsVy313DMjnPn5l4rdFjUvVnJawXIacXL5AwMUlSpvVTSC5h9icudW2S2liqI2HI6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ifbku6M5;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A771606A31B
	for <linux-s390@vger.kernel.org>; Wed,  4 Nov 2026 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A771606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ifbku6M5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48ib6e093659
	for <linux-s390@vger.kernel.org>; Wed, 4 Nov 2026 09:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Zw1ATC30/MvcXhHjYm+mddFqE0zS
	biZXJNyOFl8pdDw=; b=Ifbku6M5SP7mLxI0KOHCZ2yS1DiSdnJtMRps8GIfGUmw
	2QYUx6Mlnr1azNFkJsGaxognH/bOW3+SkxzxGmWT49BGfLyqBFQBNm4vjv0EHnYt
	GGzQLDtP0QnSYskAVwQMrPZ855bVat+gMs9s4bAaab6zV7NTA4+SDqbfEPmwnSsP
	Rf5J7vQinfgUgbv50QOs3Y2iBYWCQX5TWtKc2wNzrTBD7b/21EBvYHR0iif1uuCG
	tHRtAuie3kw9f3OTmpwNcToKfx9E6zTU7mclSfPmf7VbQtGZHdkYRj16jn/STRbR
	pW7Y0ifQ5SbzZUUjNrOjTWrvJY63HvueRHtPmbC5XQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ys2m06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 09:24:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48JuOG3779840
	for <linux-s390@vger.kernel.org>; Wed, 4 Nov 2026 09:24:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrcddye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 09:24:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A49OrPm37552456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 09:24:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2980720043;
	Wed,  4 Nov 2026 09:24:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B2E20040;
	Wed,  4 Nov 2026 09:24:52 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 09:24:52 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 04 Nov 2026 10:24:16 +0100
Subject: [PATCH v5] s390/diag204: Add common diag204 interface with caching
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
Message-Id: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PzQrCMAzA8VeRnq00WbtST76HeOhHpgHdZJtDk
 b273fCgQzz+A/mRPEVHLVMntqunaGngjps6h1mvRDz5+kiSU26BCktQ4GRif0SluYn9WepUOVL
 OV+isyCvXliq+z9z+kPvEXd+0j1kfYJq+IYRvaACpJJpSm+BsqDTtzlzf7hsOl01sLmLCBvwEc
 AFgBiwZ7xLEhOB/AcU/oMhAREMWtLVF+fMC/QnYBaBlfsqQU8GUABiWwDiOLwbO3qdvAQAA
X-Change-ID: 20261019-diag204ioctl-4df9e09af297
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeaf9ea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=4317F_GKwKSssVzsLFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX5lJPyM/EJU3U
 5KOda2nmYVeEO+dkSuUhzC8NYkWVNt8ic6S1od5wbmuZv2yR16zXF5ELG/VHrVzA4w3s8KZEoMv
 MmkDkznhQ9K3KkVkr1Ev6oD+RPPtQiY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX0/zMGSZusP0f
 ZFABSKFHtGgW4fdZPS5J/WTRw4qKG788bXMbpVjHLLUyJ6h4QOU+3MJCNYINORpp152Hhp7qzjR
 T8an3Zt9858V/ueEuqpr+Es3/UkDP7FDMsOuYQDGG0N8tZIV4csV8ot11n6tfblvttjoLCrfupw
 9OuRfZvb/yqgsTEK+j3KqApLT0oiQesP3paqRT3LHCkhAdBbJD9BnTDngemuSY1jFu5XgWvFmjU
 UWnUFhx5jkK5WOTJwa1vgb6dUyB6wBAP5LUW+dvh3wYawo3WmO6VraLcVVMn2iWHHXUlmZXTFaD
 9Tj/jQzBxWKWbkT7bVv/VkzMPB9lS3wX79YSJtpXnja/eMB/9f21jmAaSckZ6C1cDFj/S3r9Ngm
 YzDfm9TIY+rSDPTGmbgWmsP7XhFViVDsrL6rP80s8DNDg19QWA2uBivd9VHn2CwsJoEeDGfdDvT
 zhRxMTA2oG/4l5WQJog==
X-Proofpoint-GUID: VA4ZelkacXy7Gqwp_5CxGXK1qE-nxOVI
X-Proofpoint-ORIG-GUID: VA4ZelkacXy7Gqwp_5CxGXK1qE-nxOVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040036

diag204 is currently used by hypfs and sthyi, each with its own probe,
buffer allocation, and store logic. This duplicates the subcode and
data format selection and lets any caller issue a diag204 whenever it
likes, which is costly on the hypervisor side.

Add a common implementation in arch/s390/kernel/diag/diag204.c and
convert hypfs and sthyi to it.

The supported subcode (7, 6 or 4) and data format are probed once in an
arch_initcall. As a consequence, all kernel configurations, including
those without hypfs, now probe diag204 at boot.

diag204_store() serves data from a cache that is valid for one second.
When the cache is stale, only one caller at a time refreshes it by
issuing diag204. Other callers wait on the mutex and then use the
fresh data. Within the validity period no new diag204 is issued, which
limits the rate of diag204 calls. An idle cache is dropped by a delayed
work after 10 seconds to not hold on to the buffer indefinitely.

If allow_busy is set, the diag204 busy-indication bit is passed to the
hypervisor, the updater may return -EBUSY, and concurrent callers
return -EBUSY immediately instead of waiting. Otherwise callers wait
on a killable mutex and get -EINTR if interrupted.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
v5:
- Return valid error codes via diag204's sthyi to KVM guests.
- Rework diag204 access and remove busy polling mechanism in favor of
  simplicity.
- Remove temp buffer allocation during cache update.
- Keep the original busy looping function for diag204 users in
  arch/s390/hypfs.
- Return -EBUSY earlier when allow_busy is specified and mutex cannot
  be taken.
- Include mutex.h, ktime.h and init.h  explicitly and remove timer.h
- Improve function comments and add kernel-doc style comments.
- Rename g_cache to diag204_cache_info.
- Put diag204_init to an earlier initcall to establish diag204 before
  other dependent device_initcall() sites.
- Revert unintentional change of busy wait interval.
- Improve commit message accuracy.
- Other trivial changes related to v5 rework.

v4:
- Drop diag204's IOCTL interface patch as there is no users right now.
- Refactor diag204_store() function and utilize wait_event()/wake_up()
  pairs.
- Remove check for the case where user specifies allow_busy but
  busy indication facility is not present. Automatically fallback to
  blocking case.
- Remove diag204_probe() and put its logic to diag204_init().
- More small changes to keep the added line count low.
- Squash patch 1 and 2 

v3:
- Fix memory leak of extended buffer in diag204_probe() in fallback case
  (Sashiko)
- Add an ioctl definition for userspace to extract diag204 subcode
  (Sashiko)
- Fix unlocked cache access and mutex unlock in diag204_store()
  (Sashiko)
- Replace diag204 ioctl struct data types (Sashiko)
- Change diag204's allow_busy and allow_busy_wait flags for
  hypfs_diag_create_files() to match usecase before the rework (Sashiko)
- Add a check for the case where user specifies allow_busy but
  busy indication facility is not present.

Background
========================================================================
The goal is to create a single source where all relevant diag204
functionality is exposed and managed.

The main problems being addressed are;
* Diag204 is expensive and calling it too frequently should be avoided.
* Diag204 requires a probe phase to utilize properly which means code
  duplication usage for each user.

This is also a prerequisite for utilizing diag204 data in hiperdispatch.

New Diag204 Usage
========================================================================
Users from kernel are now exposed to a couple of common functions 
which should allow for a simpler way of utilizing diag204.
The new streamlined flow now looks like;

...
{
	void *buf = diag204_allocate_buffer();
	rc = diag204_store(buf, allow_busy);
	if (rc) {
		diag204_free_buffer(buf);
		return;
	}
	/* Do whatever with the diag data*/
	diag204_free_buffer(buf);
...

Most of the details of diag204 is now hidden away. Initial probing and
availability check is done via an arch_initcall().

Implementation
========================================================================
Initial checks for diag204 support, determining which subcode to use and
querying page count required to hold diag data are all done in a
arch_initcall() once. Page count returned is the maximum amount
required for that CEC, subcodes and pages required should stay the same
during runtime.

Diag204 should be rate limited to a diag call per second at most.
In order to achieve the rate limiting while also allowing users to
acquire data a caching mechanism similar to Sumanth's diag324
implementation with commit 90e6f191e1ee ("s390/diag324: Retrieve power
readings via diag 0x324") is proposed.

diag204_store() serves data from a cache that is valid for one second.
When the cache is stale, only one caller at a time refreshes it by
issuing diag204. Other callers wait on the mutex and then use the
fresh data. Within the validity period no new diag204 is issued, which
limits the rate of diag204 calls. An unused cache is dropped by a
delayed work after 10 seconds to not hold on to the buffer indefinitely.

If allow_busy is set, the diag204 busy-indication bit is passed to the
diag204 call, the updater may return -EBUSY, and concurrent callers
return -EBUSY immediately instead of waiting. Otherwise callers wait
on a killable mutex and get -EINTR if interrupted.
---
 arch/s390/hypfs/hypfs_diag.c    | 131 +++---------------
 arch/s390/hypfs/hypfs_diag.h    |   5 +-
 arch/s390/hypfs/hypfs_diag_fs.c |   8 +-
 arch/s390/include/asm/diag.h    |   7 +
 arch/s390/kernel/diag/Makefile  |   2 +-
 arch/s390/kernel/diag/diag204.c | 284 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/sthyi.c        |  30 ++---
 7 files changed, 324 insertions(+), 143 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 08777f57bd24..ab20b26eaed8 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -22,137 +22,37 @@
 
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
 
-/* Diagnose 204 functions */
-/*
- * For the old diag subcode 4 with simple data format we have to use real
- * memory. If we use subcode 6 or 7 with extended data format, we can (and
- * should) use vmalloc, since we need a lot of memory in that case. Currently
- * up to 93 pages!
- */
-
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
+int hypfs_diag204_store(void *buf)
 {
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
 	int rc;
 
-	subcode = diag204_get_info_type();
-	subcode |= diag204_store_sc;
-	if (diag204_has_bif())
-		subcode |= DIAG204_BIF_BIT;
 	while (1) {
-		rc = diag204(subcode, pages, buf);
+		rc = diag204_store(buf, true);
 		if (rc != -EBUSY)
 			break;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
 	}
-	return rc < 0 ? rc : 0;
+	return rc;
 }
 
 struct dbfs_d204_hdr {
@@ -173,19 +73,20 @@ static int dbfs_d204_create(void **data, void **data_free_ptr, size_t *size)
 	int rc, buf_size;
 	void *base;
 
-	buf_size = PAGE_SIZE * (diag204_buf_pages + 1) + sizeof(d204->hdr);
+	buf_size = diag204_get_buf_size() + PAGE_SIZE + sizeof(d204->hdr);
 	base = vzalloc(buf_size);
 	if (!base)
 		return -ENOMEM;
 	d204 = PTR_ALIGN(base + sizeof(d204->hdr), PAGE_SIZE) - sizeof(d204->hdr);
-	rc = diag204_store(d204->buf, diag204_buf_pages);
-	if (rc) {
+
+	rc = hypfs_diag204_store(d204->buf);
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
@@ -202,7 +103,7 @@ __init int hypfs_diag_init(void)
 {
 	int rc;
 
-	if (diag204_probe()) {
+	if (!diag204_is_available()) {
 		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
@@ -219,6 +120,6 @@ __init int hypfs_diag_init(void)
 void hypfs_diag_exit(void)
 {
 	hypfs_diag_fs_exit();
-	diag204_free_buffer();
+	hypfs_diag204_free_buffer();
 	hypfs_dbfs_remove_file(&dbfs_file_d204);
 }
diff --git a/arch/s390/hypfs/hypfs_diag.h b/arch/s390/hypfs/hypfs_diag.h
index b5218135b8fe..a4154a68af7e 100644
--- a/arch/s390/hypfs/hypfs_diag.h
+++ b/arch/s390/hypfs/hypfs_diag.h
@@ -12,9 +12,8 @@
 
 #include <asm/diag.h>
 
-enum diag204_format diag204_get_info_type(void);
-void *diag204_get_buffer(enum diag204_format fmt, int *pages);
-int diag204_store(void *buf, int pages);
+void *hypfs_diag204_get_buffer(void);
+int hypfs_diag204_store(void *buf);
 
 int __hypfs_diag_fs_init(void);
 void __hypfs_diag_fs_exit(void);
diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag_fs.c
index 39621c326010..0dede904d80a 100644
--- a/arch/s390/hypfs/hypfs_diag_fs.c
+++ b/arch/s390/hypfs/hypfs_diag_fs.c
@@ -303,13 +303,13 @@ int hypfs_diag_create_files(struct dentry *root)
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
+	rc = hypfs_diag204_store(buffer);
+	if (rc < 0)
 		return rc;
 
 	systems_dir = hypfs_mkdir(root, "systems");
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 1416ee1ad323..a5385fc24155 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -336,6 +336,13 @@ static inline bool diag204_has_bif(void)
 	return sclp.has_diag204_bif;
 }
 
+int diag204_store(void *buf, bool allow_busy);
+enum diag204_format diag204_get_info_type(void);
+enum diag204_sc diag204_get_subcode(void);
+void *diag204_allocate_buffer(void);
+void diag204_free_buffer(void *buf);
+bool diag204_is_available(void);
+int diag204_get_buf_size(void);
 int diag204(unsigned long subcode, unsigned long size, void *addr);
 int diag224(void *ptr);
 int diag26c(void *req, void *resp, enum diag26c_sc subcode);
diff --git a/arch/s390/kernel/diag/Makefile b/arch/s390/kernel/diag/Makefile
index 956aee6c4090..6e255b66be44 100644
--- a/arch/s390/kernel/diag/Makefile
+++ b/arch/s390/kernel/diag/Makefile
@@ -1 +1 @@
-obj-y	:= diag_misc.o diag324.o diag.o diag310.o
+obj-y	:= diag_misc.o diag324.o diag.o diag310.o diag204.o
diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag204.c
new file mode 100644
index 000000000000..dc4b9df8ba92
--- /dev/null
+++ b/arch/s390/kernel/diag/diag204.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Request CPU utilization information from underlying diag 0x204 facility.
+ *
+ * Copyright IBM Corp. 2026
+ */
+
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/mutex.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+
+#include <asm/diag.h>
+
+#define DIAG204_WORK_DELAY (HZ * 10)
+
+struct diag204_cache {
+	ktime_t expires;		/* cache expiration time */
+	enum diag204_format type;	/* used diag204 data format */
+	enum diag204_sc subcode;	/* used diag204 subcode for store */
+	int pages;			/* number of pages for diag204 data */
+	void *buf;			/* page aligned diag204 buffer */
+};
+
+static struct diag204_cache diag204_cache_info;
+static DEFINE_MUTEX(diag204_mutex);
+
+static void diag204_work_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(diag204_work, diag204_work_fn);
+
+/**
+ * diag204_is_available() - Check whether diag204 can be used
+ *
+ * Return:
+ * * true if diag204 is available
+ * * false if diag204 is not supported
+ */
+bool diag204_is_available(void)
+{
+	return diag204_cache_info.pages > 0;
+}
+
+/**
+ * diag204_get_info_type() - Get the diag204 data format in use
+ *
+ * Return: The available diag204 info type, either DIAG204_INFO_SIMPLE or
+ *         DIAG204_INFO_EXT.
+ */
+enum diag204_format diag204_get_info_type(void)
+{
+	return diag204_cache_info.type;
+}
+
+/**
+ * diag204_get_subcode() - Returns highest available diag204 subcode
+ *
+ * Return: The highest subcode supported
+ * * 0 if diag204 is not supported.
+ * * DIAG204_SUBC_STIB4 (simple data format)
+ * * DIAG204_SUBC_STIB6 (extended data format)
+ * * DIAG204_SUBC_STIB7 (extended data format + secondary CPUs)
+ */
+enum diag204_sc diag204_get_subcode(void)
+{
+	return diag204_cache_info.subcode;
+}
+
+/**
+ * diag204_get_buf_size() - Get the size of the diag204 data
+ *
+ * Return: Amount of bytes required to store diag204 data. 0 if diag204 is not
+ *         supported.
+ */
+int diag204_get_buf_size(void)
+{
+	return diag204_cache_info.pages * PAGE_SIZE;
+}
+
+/**
+ * diag204_free_buffer() - Free a diag204 buffer
+ * @buf: Buffer allocated by diag204_allocate_buffer()
+ */
+void diag204_free_buffer(void *buf)
+{
+	vfree(buf);
+}
+
+static void *__diag204_allocate_buffer(int pages)
+{
+	return __vmalloc_node(array_size(pages, PAGE_SIZE),
+			      PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
+			      __builtin_return_address(0));
+}
+
+/**
+ * diag204_allocate_buffer() - Allocate a buffer for diag204
+ *
+ * Allocate a zeroed, page aligned vmalloc'ed buffer of diag204_get_buf_size()
+ * bytes, as required by diag204. The size is determined at initialization
+ * of diag204. Must only be called if diag204_is_available() returns true.
+ *
+ * Context: Can sleep (GFP_KERNEL).
+ * Return: Pointer to the buffer on success, NULL on failure.
+ */
+void *diag204_allocate_buffer(void)
+{
+	return __diag204_allocate_buffer(diag204_cache_info.pages);
+}
+
+static bool diag204_is_cache_valid(void)
+{
+	if (!diag204_cache_info.buf)
+		return false;
+	if (ktime_after(ktime_get(), diag204_cache_info.expires))
+		return false;
+	return true;
+}
+
+static void diag204_work_fn(struct work_struct *work)
+{
+	mutex_lock(&diag204_mutex);
+	if (!diag204_cache_info.buf)
+		goto unlock;
+	if (diag204_is_cache_valid())
+		goto rearm;
+	diag204_free_buffer(diag204_cache_info.buf);
+	diag204_cache_info.expires = 0;
+	diag204_cache_info.buf = NULL;
+	goto unlock;
+rearm:
+	mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
+unlock:
+	mutex_unlock(&diag204_mutex);
+}
+
+static int diag204_update_cache(bool allow_busy)
+{
+	unsigned long subcode;
+	int rc;
+
+	if (!diag204_cache_info.buf)
+		diag204_cache_info.buf = diag204_allocate_buffer();
+	if (!diag204_cache_info.buf)
+		return -ENOMEM;
+	memset(diag204_cache_info.buf, 0, diag204_get_buf_size());
+	subcode = diag204_cache_info.type;
+	subcode |= diag204_cache_info.subcode;
+	if (diag204_has_bif() && allow_busy)
+		subcode |= DIAG204_BIF_BIT;
+	rc = diag204(subcode, diag204_cache_info.pages, diag204_cache_info.buf);
+	if (rc < 0) {
+		diag204_free_buffer(diag204_cache_info.buf);
+		diag204_cache_info.buf = NULL;
+		return rc;
+	}
+	diag204_cache_info.expires = ktime_add_ns(ktime_get(), NSEC_PER_SEC);
+	mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
+	return 0;
+}
+
+/**
+ * diag204_store() - Store diag204 data
+ * @buf:             Diag204 data buffer allocated using
+ *                   diag204_allocate_buffer() or a page aligned, zeroed buffer
+ *                   with a size acquired from diag204_get_buf_size().
+ * @allow_busy:      Allow diag204 to return -EBUSY instead of blocking and
+ *                   return early when there is a concurrent updater.
+ *
+ * Diag204 queries CPU utilization data from the hypervisor. Per CPU
+ * utilization information is returned either only for the current guest
+ * or, with authorization for all guests configured.
+ *
+ * Context: diag204_store() can sleep and holds diag204_mutex to serialize
+ *          diag204 cache access.
+ *
+ * Return:
+ * * 0 on success
+ * * -EOPNOTSUPP diag204 is not supported
+ * * -EINVAL if @buf is NULL
+ * * -ENOMEM if the temporary buffer could not be allocated
+ * * -EBUSY if @allow_busy is set and diag204 or a concurrent cache update
+ *    is busy
+ * * -EINTR if interrupted by a signal
+ */
+int diag204_store(void *buf, bool allow_busy)
+{
+	int rc;
+
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	if (!buf)
+		return -EINVAL;
+	rc = 0;
+	if (allow_busy) {
+		if (!mutex_trylock(&diag204_mutex))
+			return -EBUSY;
+	} else {
+		if (mutex_lock_killable(&diag204_mutex))
+			return -EINTR;
+	}
+	if (diag204_is_cache_valid())
+		goto copy;
+	rc = diag204_update_cache(allow_busy);
+	if (rc)
+		goto out;
+copy:
+	memcpy(buf, diag204_cache_info.buf, diag204_get_buf_size());
+out:
+	mutex_unlock(&diag204_mutex);
+	return rc;
+}
+
+/**
+ * diag204_init() - Probe the supported diag204 implementation
+ *
+ * Determines which type of diagnose 204 implementation is supported.
+ * Currently there are three possible scenarios:
+ *   - subcode 4   + simple data format (only one page)
+ *   - subcode 4-6 + extended data format
+ *   - subcode 4-7 + extended data format
+ *
+ * The data size is requested with subcode 5 and it is sufficient through
+ * the whole runtime of the machine. The data itself is provided by
+ * subcodes 6 and 7. Subcode 7 does the same as subcode 6 but additionally
+ * covers secondary CPUs. Probe subcode 7 first, then 6, and fall back to
+ * subcode 4 with the simple format if neither works.
+ *
+ * Return: 0 on success, -ENOMEM if a probe buffer cannot be allocated,
+ * -EOPNOTSUPP if no subcode works.
+ */
+static int __init diag204_init(void)
+{
+	unsigned long subcode, type;
+	int pages, rc;
+	void *buf;
+
+	pages = diag204((unsigned long)DIAG204_INFO_EXT |
+			(unsigned long)DIAG204_SUBC_RSI, 0, NULL);
+	if (pages > 0) {
+		buf = __diag204_allocate_buffer(pages);
+		if (!buf) {
+			rc = -ENOMEM;
+			goto fail_alloc;
+		}
+		type = DIAG204_INFO_EXT;
+		if (diag204(DIAG204_SUBC_STIB7 | type, pages, buf) >= 0) {
+			subcode = DIAG204_SUBC_STIB7;
+			goto out;
+		}
+		if (diag204(DIAG204_SUBC_STIB6 | type, pages, buf) >= 0) {
+			subcode = DIAG204_SUBC_STIB6;
+			goto out;
+		}
+		vfree(buf);
+	}
+	/* extended data format is not available, fallback to simple */
+	pages = 1;
+	buf = __diag204_allocate_buffer(pages);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto fail_alloc;
+	}
+	type = DIAG204_INFO_SIMPLE;
+	if (diag204(DIAG204_SUBC_STIB4 | type, pages, buf) >= 0) {
+		subcode = DIAG204_SUBC_STIB4;
+		goto out;
+	}
+	rc = -EOPNOTSUPP;
+	goto fail_store;
+out:
+	rc = 0;
+	diag204_cache_info.pages = pages;
+	diag204_cache_info.subcode = subcode;
+	diag204_cache_info.type = type;
+	diag204_cache_info.buf = NULL;
+fail_store:
+	vfree(buf);
+fail_alloc:
+	return rc;
+}
+arch_initcall(diag204_init);
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 5eae2e25997a..b4a419c27389 100644
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
+	rc = diag204_store(diag204_buf, diag204_allow_busy);
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
 

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261019-diag204ioctl-4df9e09af297

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

