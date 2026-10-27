Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097637;
	b=ECDr6blFMZVRvXnbG/NYBhDNk1FyQ9Qc0sDF3wtqIOhvyLE815x9Yv4GkwWPT2VvEenT
	 B7mFDr9yWZhZo7jXndBFlQFzqyQXFlbZpfzxa6sJRvQAhPIPWJageuvvlBqGHrjXeAKlW
	 N7SmUZSWehusLWdzZcchEzDTTbmqBm+NKDu0ock6jIPbKSmUiynWOmnuuOALCaeeXLLWI
	 zGyHIfWiRPw6Tat5/G1Tf1gAzbLl27hGxrdh70qn4tePjGxjIvWWZMs+oU7idZN34kVG+
	 +kh0xLTdy2ZqFBPGsdGJ0vcjdqxbtBQN8mapkkrTNLlmnUd2Z9gsJTO3yr45qLf8/LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097637;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8Q/Jat3yzKq4FPQC4RlRdHS03yO6DMG19bO/rgGz1ww=;
	b=rBZRO2Ia9qlqneSvKWLhfsX9/WDLlpkKB02j4l/oNBUv7TKk9ebgIctIdyDm+M/liuKK
	 Njc+vm/oXO7dOL+adQPsZ4rNMWGRkS1ulbN4hDWdll8LGnmNw92gAyXrYVIaB7v3cxcra
	 Yre20P+W/gzw1Q/HNZ7S5SLRSO3fayXbOP6ZbmO1SoFzqa2aPSW2NNIF4WFTquPk2gZe2
	 4JWfTvQ1sTsFA6enzJ9MfmpAXdzU01gXhw3RENjydtnugwD96pSohhycTxevZ7EjMVFRk
	 GANTxbKgp2x0NZR4YpN4ZQsPXC6JxC5SKYjfTABOL4i2JtGsdvSHuxFsMXkxxS2qvJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="pXuo0/FU";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A63606A31E
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pXuo0/FU
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5i2Qi1621759
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8Q/Jat3yzKq4FPQC4RlRdHS03yO6
	DMG19bO/rgGz1ww=; b=pXuo0/FU+oh713qoOLzHy9BtfPP1CoXMNJVhTyYfwpxw
	Y2rn3YdsDS/k+uTiy0NXT3++RnNGtq5RPhInaXwnh0bsP2qxx6ZOE5sV52IEjsOw
	hbh5nukt6DEmbxOEP1Uaq61LeGt+VfhCX8/WTp8GYtOycS4i7+Z0+lLngIoYv/gi
	ivMVJqw2tlX8EUjNoUtoungZp8/kPK4ziWCaILmEUTVOBRIU9P5SXxf2zcA6dVnF
	PSNHJGqvEIeGkqH3n5AO8UHe2Pd8jxhYT6FMTPlZsvxWWgK6uY7hTu8zNiRdQFDD
	B9mUCSOhmL0TYLWrAHATmmXaK2Fe031breIkMQpD8Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63xx88-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:40:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RASnaf3745267
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:40:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh27ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:40:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RAeUs748955772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 10:40:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B09F2004F;
	Tue, 27 Oct 2026 10:40:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B82BE20040;
	Tue, 27 Oct 2026 10:40:29 +0000 (GMT)
Received: from [9.68.17.252] (unknown [9.68.17.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 10:40:29 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 27 Oct 2026 11:40:25 +0100
Subject: [PATCH v4] s390/diag204: Introduce diag204 rework
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
Message-Id: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OywqDMBCF4VeRrBtJxmhIV32P0kVMRh3wUtSKR
 Xz3RumiN7r8D8zHLGzAnnBgx2hhPU40UNeGUIeIucq2JXLyoRkIyKSQhnuyJQhFnRtrrnxhUBh
 bgNEsnFx7LGjeufMldEXD2PX3XZ/ktj4hkO/QJLngkGYqzY3OC4WnmtrbHFPexK5r2IZN8ArAB
 wAB0Jha46XzIO0vIPkHJAFwkKKWSusk+/pgXdcHoJV/2i4BAAA=
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MCBTYWx0ZWRfX0+yXzSdwqNkU
 /7qSGmJrhF0Uzqz4UW7xsVdAa89jnYhEU70qe7kHABEIUK9WxXzjThEm82p3bQmX+lc8nsSzxV9
 oknWUlRaC8m2fKfD4Y0NXTyPvodnhS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MCBTYWx0ZWRfX8QTC3GwMNZy2
 LY/lYZsKdTLDQEw74M3kdeJy6uTRak9/NHKNHILbspEteYFRZEFiuKgc8e0yXFADhO2OUvWQ5Bb
 LUBgIcMUDzAuXhedWVfVI8PGOqbwi0EzPbsgZI3SyWf2AuSi3nJpnSd1rAMg2HkHh94dNoECYr4
 VAe7Im1pVCv/xuif7d5X7ZOZQhRKs4b6DET5SrXocfl09bSe3Z0h/La68NPa07rQTUHkmnu6sLY
 8/NtlD2UHzpt0le2/ID4J0aI6a64k1cO2Shp9faa0l+RqneqVDCBT0gKJ3+0jqc/HnZlqCGqD6H
 kTHsc+cXebbhNEzPeU1JPQQ5eF/DW2jph0eHbZ7ThXDhwlw3JLIn4zALjgaqpxT8JD426SN7+jD
 wzpZ6QYF3Yh/DlrMp4qM8JmHevhzrOJXZwdxqIBqCf9bfFIy3+YwVkPUJs4U1MclK5drB27QhhW
 9zNNqZL6ftp5y7QxdhQ==
X-Proofpoint-ORIG-GUID: NBpjflSJKxLX-2BO7pPizpWpolEPXKrn
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae07fa3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=4317F_GKwKSssVzsLFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NBpjflSJKxLX-2BO7pPizpWpolEPXKrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270040

diag204 is an expensive call, limit its invocation to once per
second at most for all users. Use a caching mechanism to provide diag204
data at demand. Cache buffer gets freed by a delayed work function if
diag204 data is not fetched after a certain amount of time.
Replace the existing diag204 users in kernelspace with the new diag204
interface.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
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

v2: 
- prevent redundant work rearm after cache free in diag204_work_fn().
  (Sashiko)
- always fallback to subcode 4 in diag204_probe(). (Sashiko)
- fix errno check during busy wait loop and prevent uncessary
  sleeps. (Sashiko)
- simplify diag204 cache update function, allow for diag to return busy
  even when diag cache is empty. (Sashiko)
- add a check for diag204 subcode in sthyi as it depends on subcode 7
  being available. (Sashiko)
- remove CAP_SYS_ADMIN check in IOCTL handler (Hendrik Brueckner)
- add missing READ_ONCE() to g_cache.timestamp
- schedule delayed work only after a successful cache update
- rebase patches

Changes from the earlier series;
* Address mutex lockdep issues (Sumanth Korikkar)
* Add permission check for IOCTL (Sumanth Korikkar)
* Pass buffers set to 0 when calling diag (Sumanth Korikkar)

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
	int rc = diag204_store(buf, allow_busy, allow_busy_wait);

	/* Do whatever with the diag data*/

	diag204_free_buffer(buf);
...

Most of the details of diag204 is now hidden away. Initial probing and
availability check is done via a device_initcall().

Implementation
========================================================================
Initial checks for diag204 support, determining which subcode to use and
querying page count required to hold diag data are all done in a
device_initcall() once. Page count returned is the maximum amount
required for that CEC, subcodes and pages required should stay the same
during runtime.

Diag204 should be rate limited to a diag call per second at most.
In order to achive the rate limiting while also allowing users to
acquire data a caching mechanism similar to Sumanth's diag324
implementation with commit 90e6f191e1ee ("s390/diag324: Retrieve power
readings via diag 0x324") is proposed.
When the cache is valid users can take a mutex copy the cache and
release. If the cache is expired, only the first user trying to acquire
it should update it and after the update wake up any subsequent readers
waiting to read the cache.

The caching mechanism is slightly more complicated to allow support for
interruptible busy waiting. When diag204's busy indication facility is
installed users can specify a flag to put diag204_store() into a
sleepable and interruptible loop that lasts until diag204 is no longer
busy. This way the amount of diag calls and system calls from userspace
are reduced.
If busy indication facility is not present default fallback is the
blocking diag204 call as before. Users don't get an indication about
this.(IMO, it wouldn't be useful)

Diag204 calls are serialized with a mutex and cache updates are
protected with help of a flag. Since busy wait loops can sleep they have
to release the mutex before sleep. The updating cache flag comes in
here, it is only modified when the mutex is being held and if a cache
update is taking place.

Utilizing diag204 arms a work function which periodically checks if the
current cache is expired. If it finds that the cache is expired, it
frees the cache buffer and stops.

Considerations
========================================================================
* At the moment diag204 size request returns a page count requirement of
  423. That is the maximum amount of space needed currently for a CEC to
  service diag204.
  With this series at times there will be ~6Mb (1.6Mb for each; cache,
  temp, user buffer...) memory allocated for diag204 data per lpar.
---
 arch/s390/hypfs/hypfs_diag.c    | 139 ++-------------------
 arch/s390/hypfs/hypfs_diag.h    |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c |   9 +-
 arch/s390/include/asm/diag.h    |   8 +-
 arch/s390/kernel/diag/Makefile  |   2 +-
 arch/s390/kernel/diag/diag204.c | 271 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/sthyi.c        |  30 ++---
 7 files changed, 306 insertions(+), 157 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 08777f57bd24..68fa85690580 100644
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
@@ -173,19 +58,19 @@ static int dbfs_d204_create(void **data, void **data_free_ptr, size_t *size)
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
@@ -202,7 +87,7 @@ __init int hypfs_diag_init(void)
 {
 	int rc;
 
-	if (diag204_probe()) {
+	if (!diag204_is_available()) {
 		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
@@ -219,6 +104,6 @@ __init int hypfs_diag_init(void)
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
index 1416ee1ad323..ca78ca45a8a2 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -121,7 +121,6 @@ enum diag204_sc {
 
 #define DIAG204_SUBCODE_MASK 0xffff
 #define DIAG204_BIF_BIT 0x80000000
-#define DIAG204_BUSY_WAIT (HZ / 10)
 
 /* The two available diag 204 data formats */
 enum diag204_format {
@@ -336,6 +335,13 @@ static inline bool diag204_has_bif(void)
 	return sclp.has_diag204_bif;
 }
 
+int diag204_store(void *buf, int allow_busy, int allow_busy_wait);
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
index 000000000000..a68961bb8998
--- /dev/null
+++ b/arch/s390/kernel/diag/diag204.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Request CPU utilization information from underlying diag 0x204 facility.
+ *
+ * Copyright IBM Corp. 2026
+ */
+
+#define pr_fmt(fmt) "diag204: " fmt
+
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/vmalloc.h>
+#include <linux/wait.h>
+
+#include <asm/diag.h>
+
+#define DIAG204_WORK_DELAY (HZ * 10)
+
+struct diag204_cache {
+	wait_queue_head_t wq;		/* wait queue for tasks waiting update */
+	ktime_t timestamp;		/* cache expiration time */
+	enum diag204_format type;	/* used diag204 data format */
+	enum diag204_sc subcode;	/* used diag204 subcode for store */
+	int pages;			/* number of pages for diag204 data */
+	void *buf;			/* page aligned diag204 buffer */
+	bool has_bif;			/* busy indication facility flag */
+	bool updating;			/* ongoing cache update indicator */
+};
+
+static struct diag204_cache g_cache;
+static DEFINE_MUTEX(diag204_mutex);
+
+static void diag204_work_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(diag204_work, diag204_work_fn);
+
+bool diag204_is_available(void)
+{
+	return g_cache.pages > 0;
+}
+
+enum diag204_format diag204_get_info_type(void)
+{
+	return g_cache.type;
+}
+
+enum diag204_sc diag204_get_subcode(void)
+{
+	return g_cache.subcode;
+}
+
+int diag204_get_buf_size(void)
+{
+	return g_cache.pages * PAGE_SIZE;
+}
+
+void diag204_free_buffer(void *buf)
+{
+	if (buf)
+		vfree(buf);
+}
+
+static void *__diag204_allocate_buffer(int pages)
+{
+	return __vmalloc_node(array_size(pages, PAGE_SIZE), PAGE_SIZE,
+			      GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+			      __builtin_return_address(0));
+}
+
+void *diag204_allocate_buffer(void)
+{
+	return __diag204_allocate_buffer(g_cache.pages);
+}
+
+static int diag204_is_cache_valid(void)
+{
+	if (!READ_ONCE(g_cache.buf))
+		return 0;
+	if (ktime_after(ktime_get(), READ_ONCE(g_cache.timestamp)))
+		return 0;
+	return 1;
+}
+
+static void diag204_replace_cache(void *buf)
+{
+	ktime_t expire = 0;
+
+	diag204_free_buffer(READ_ONCE(g_cache.buf));
+	WRITE_ONCE(g_cache.buf, buf);
+	if (buf)
+		expire = ktime_add_ns(ktime_get(), NSEC_PER_SEC);
+	WRITE_ONCE(g_cache.timestamp, expire);
+}
+
+static void diag204_work_fn(struct work_struct *work)
+{
+	mutex_lock(&diag204_mutex);
+	if (!READ_ONCE(g_cache.buf))
+		goto unlock;
+	if (diag204_is_cache_valid())
+		goto rearm;
+	if (READ_ONCE(g_cache.updating))
+		goto rearm;
+	diag204_replace_cache(NULL);
+	wake_up_all(&g_cache.wq);
+	goto unlock;
+rearm:
+	mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
+unlock:
+	mutex_unlock(&diag204_mutex);
+}
+
+static int diag204_update_cache(int allow_busy, int allow_busy_wait)
+{
+	unsigned long subcode;
+	void *buf;
+	int rc;
+
+	buf = diag204_allocate_buffer();
+	if (!buf)
+		return -ENOMEM;
+	subcode = g_cache.type | g_cache.subcode;
+	if (g_cache.has_bif && allow_busy)
+		subcode |= DIAG204_BIF_BIT;
+	WRITE_ONCE(g_cache.updating, true);
+	mutex_unlock(&diag204_mutex);
+	do {
+		rc = diag204(subcode, g_cache.pages, buf);
+		if (!allow_busy_wait || rc != -EBUSY)
+			break;
+		if (signal_pending(current)) {
+			rc = -ERESTARTSYS;
+			break;
+		}
+		schedule_timeout_interruptible(HZ);
+	} while (1);
+	mutex_lock(&diag204_mutex);
+	if (rc >= 0) {
+		diag204_replace_cache(buf);
+		mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
+	} else {
+		diag204_free_buffer(buf);
+	}
+	WRITE_ONCE(g_cache.updating, false);
+	return rc;
+}
+
+/*
+ * diag204_store() provides users data retrieved from the diag204 facility.
+ * Since diag204 is an expensive call to make, it is limited to a call per
+ * second for now.
+ * diag204_store() first checks if diag204 cache is present and valid. If the
+ * cache is valid, it copies the contents to the users buffer.
+ * If the cache is expired, it first updates the cache and then proceeds with
+ * the same copy operation.
+ *
+ * @buf: Users have to manage their own buffers by using
+ * diag204_allocate_buffer() and diag204_free_buffer().
+ *
+ * @allow_busy: If diag204 supports busy indication facility(bif), users can
+ * specify diag204 to  return BUSY instead of blocking until data becomes ready.
+ *
+ * @allow_busy_wait: If users allow diag204 to use bif, they would also get
+ * the option to specify an interruptible wait behavior by allowing busy wait.
+ * This enables users to interrupt diag204 waiting period via signals.
+ */
+int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
+{
+	int rc;
+
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	if (!allow_busy && allow_busy_wait)
+		return -EOPNOTSUPP;
+	if (!buf)
+		return -ENOMEM;
+	rc = 0;
+	while (1) {
+		rc = mutex_lock_interruptible(&diag204_mutex);
+		if (rc)
+			return rc;
+		/* Exit loop with lock taken if there is no concurrent update */
+		if (!READ_ONCE(g_cache.updating))
+			break;
+		mutex_unlock(&diag204_mutex);
+		if (allow_busy && !allow_busy_wait)
+			return -EBUSY;
+		/* Update in progress, wait until flag is cleared */
+		rc = wait_event_interruptible(g_cache.wq, !READ_ONCE(g_cache.updating));
+		if (rc)
+			return rc;
+	}
+	if (diag204_is_cache_valid()) {
+		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
+		mutex_unlock(&diag204_mutex);
+		return rc;
+	}
+	/* Update the cache and wake up tasks waiting for the update */
+	rc = diag204_update_cache(allow_busy, allow_busy_wait);
+	if (rc >= 0)
+		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
+	mutex_unlock(&diag204_mutex);
+	wake_up_all(&g_cache.wq);
+	return rc;
+}
+
+/*
+ * diag204_init() has to find out, which type of diagnose 204 implementation
+ * we have on the machine. Currently there are three possible scanarios:
+ *   - subcode 4   + simple data format (only one page)
+ *   - subcode 4-6 + extended data format
+ *   - subcode 4-7 + extended data format
+ *
+ * Subcode 5 is used to retrieve the size of the data, provided by subcodes
+ * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
+ * to subcode 6 it provides also information about secondary cpus.
+ * In order to get as much information as possible, we first try
+ * subcode 7, then 6 and if both fail, we use subcode 4.
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
+	g_cache.pages = pages;
+	g_cache.subcode = subcode;
+	g_cache.type = type;
+	g_cache.has_bif = diag204_has_bif();
+	init_waitqueue_head(&g_cache.wq);
+fail_store:
+	vfree(buf);
+fail_alloc:
+	return rc;
+}
+device_initcall(diag204_init);
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
 



