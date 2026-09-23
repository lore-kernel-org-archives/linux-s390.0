Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028C455181
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149218; cv=none; b=cyo8UGKkWJ6hVsr8WprPHHTWEVQgvcqSIxguW3uoitJAdb7467g6u0+oB8EOIoZg0YKuF2NZACUDtllR8149ff6cQSvmvYqAgSojqfH9xkYoKI7MeVOVOSsmp7wAjo9D5JWsaQJTUTIj0ebyeHtaZ5mauU+DJUm2ef+8r0i98fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149218; c=relaxed/simple;
	bh=6tkfvwvhV206T9WzF//fvA1D2jl7ot9szRK3Ode3etM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKYMU4RLU82E0ANF62uEV/fLKuOM0SFm5N8mb7ubXG6CDXPcxq3UigeBQmaNc5HgaPWpsStzHhZqMAfFPJwEfc45b705X5ft5q8Hia0qMFes/AWUzFprwFzBzrJlUyBSslR74hHu0lcczBPyscA//NLlfcIoH1INnSS3Sg1P+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PF7U1gzU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PF7U1gzU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N77YLP2759764
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vkL/ejhZusl03xFDdQIekadPwdjay726AMNL36b5h
	3g=; b=PF7U1gzUqdy+lqjLGIKlTvm5IZTquP7uNkocKFpZw+vuubUD3UbY0QLnG
	P0aNVYr0Sw2OG2x5UeOM003RC3s7412f4XxNXHem13Ov2ZK+j5HexcwK4lEPxZdW
	N0geCI2sw0q7bR7qtDnupQAtg3O6Fot/UXxbi9pWDp4h2QdZfHwe9UAPGseZXhsz
	qlthop0FuH9gkHsQlL8nVPxj1nv5djLXfsReKmMrwCMl7YNFscMXhAwdLcuIvcAn
	qEGdfDQJFH7ci71QNS/HImk1mmIpsppHMNRoB5IeaK6YcA9WGzX4SRHAHuoWH2ir
	cybr/4yyj+Mc569hijpf6rgHkAy+w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv9feh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HWa04066140
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vncej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e6Tr44368230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D76742004D;
	Wed, 23 Sep 2026 07:40:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B338E2004B;
	Wed, 23 Sep 2026 07:40:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 07:40:06 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v7 0/5] s390/sclp: Misc fixes
Date: Wed, 23 Sep 2026 09:40:01 +0200
Message-ID: <20260923074006.3962077-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dppS_124hTU3UYnvs7h0XzRFgzaIxhkS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfXyUYHm5IoZ3cT
 xJZU5VBxOlLGCQ9sgqGrGR/ig3fNOfkU9pX9MpiRlhDJ4yW2RAGqpf2QrH4T9xG6ULNyzBC3E2o
 3EgzhYskW0z6wgOqRJWLIT8CyhKBHcI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab3825c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=E0fA2fgX6Qsn16Cr5gUA:9
X-Proofpoint-GUID: dppS_124hTU3UYnvs7h0XzRFgzaIxhkS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfXzqbp6MZD8QNi
 K3jSzhiHhkp4Hju66Nx1hNh7ehchk1XWvGzyz5QGeMvFj0i6Y9pVX7L3JWgsYUHQRycj95OhmtC
 eLTaNkgEE/mJ6hvi5YD4bwPJM/yeAD1L+lUbwFOqbXZSKdhHhuY726Ezn65HWaqhWm2dzDWsNFY
 QaTYm36xVMXC0tKNARccLe6AUQpY+K8WpCeYJ7w/W0qwE3kKDIeyLUFH4IPBRqJhm0rxHLljMZC
 YZ//YUHJIGUvhW0y2KVif+Vi2025BdCkQWpq8Ayl0EwCMvZYMEYpUx+WNKL2cZ6VtXdMRmrt/oj
 kFcVPTSiBE9PwQTOiQXVQ9cgHddDbIlGdELAfYj90myk1kPbMIaa0rlKBbeFlUHd5dlgVy1F7C9
 fkRSeW/B9EWDlen9fNkvsz5/IlrbudBhVfV4bqpvnVI959RAN7VM1owGXpOVC2ZyMKLVqEqNsVs
 U3MGfzbC567OIK9U96A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230030

This series consists of several fixes for the s390 SCLP driver.

* The first patch makes sclp_dispatch_evbufs() more safe while parsing event buffers
  contained in a received SCCB buffer.
* The second patch introduces the macro sclp_gds_for_each() to safely iterate over
  GDS {sub}vectors and serves to improve error handling in sclp_find_gds_{sub}vector()
  to prevent out-of-range memory read and potential infinite loops
  when a malformed event buffer is received from SCLP.
* The third patch reuses the macro sclp_gds_for_each() in SCLP TTY introduced in the first patch
  to replace manual and error-prone iteration over entries of a GDS {sub}vector to fix
  the same issues addressed in the first patch.
* The fourth patch fixes 2 potential illegal memory accesses when reading
  the value from a GDS subvector in SCLP event buffers sent by OCF.
* The fifth patch fixes race situations with in-flight callbacks and sclp_unregister() calls.

Changes since v6
----------------
- Rework the patch "s390/sclp: Make parsing of received event buffers more robust"
  - Move event buffer header checks into the parsing loop to make code more readable as suggested by Peter
  - Add check for SCCB buffer length as suggested by Peter
  - Return with -EINVAL from sclp_dispatch_evbufs() if SCCB or event buffer checks fail
  - Improved commit message

Changes since v5
----------------
- Added patch "s390/sclp: Make parsing of received event buffers more robust"
  - Reported by Sashiko
- Rework the patch "s390/sclp: Introduce macro sclp_gds_for_each()"
  - Explicit cast of start and end parameters to void* removing the need
    for the caller to use extra void* variables for start and end, and also
    protecting from mistakes when using non-void* variables when calculating n
- Rework the patch "s390/sclp_ocf: Fix computation of length of GDS values"
  - Improved commit description as suggested by Peter

Changes since v4
----------------
- Drop patch "s390/sclp: Drop volatile type class from SCLP state variables"
  - There are several doubts to it being correct in all situations
- Introduce the macro sclp_gds_for_each()
  - Reusable and safe iteration over GDS {sub}vectors
  - Make use of sclp_gds_for_each() in SCLP TTY
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
  - Remove waiting for SCLP mask and reading states to become idle from sclp_register() on sclp_init_mask() failure
    - First, it is incorrect to sleep in sclp_register() which is called from atomic context
      - sclp_console_init() -> sclp_rw_init() -> sclp_register()
      - sclp_vt220_con_init() -> __sclp_vt220_init() -> sclp_register()
    - Second, it is redundant because no race situation can occur if sclp_init_mask() fails because
      in that case no events can be received from SCLP due to SCLP receive event mask update performed
      in sclp_init_mask() having failed
  - Add might_sleep() to sclp_unregister() to indicate that the function could potentially sleep
  - Adjust coding style of function sclp_unregister()
- Add "Fixes" tag where necessary

Changes since v3
----------------
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
  - Shorten and reword the commit description
  - Replace wake_up_all_locked() with wake_up_all()
  - Replace sclp_init_state with sclp_mask_state in wait queue condition
  - Call wake_up_all() unconditionally
  - Add call to wake_up_call() in sclp_init_mask() after updating sclp_mask_state 

Changes since v2
----------------
- Add 2 new patches:
  - s390/sclp: Drop volatile type class from SCLP state variables
  - s390/sclp: Improve robustness of sclp_find_gds_{sub}vector()
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_unregister() returns"
  to implement Peter Oberparleiter's suggestion with a global wait queue and checking
  the state variables as its condition. It turns out the implementation with a single completion
  per struct sclp_register is inadequate because theoretically the callback state_change_fn() and receive_fn()
  could get invoked in parallel, however unlikely. Furthermore, the same race situation might happen
  with sclp_register() too. 

Changes since v1
----------------
- Drop redundant empty lines in sclp.c
- Make commit message more verbose for the fix in sclp.c

Alexander Egorenkov (5):
  s390/sclp: Make parsing of received event buffers more robust
  s390/sclp: Introduce macro sclp_gds_for_each()
  s390/sclp_tty: Make use of sclp_gds_for_each()
  s390/sclp_ocf: Fix computation of length of GDS values
  s390/sclp: Ensure no callback gets called after sclp_unregister()
    returns

 drivers/s390/char/sclp.c     | 42 +++++++++++++++++++++++++++---------
 drivers/s390/char/sclp.h     | 24 ++++++++++++++-------
 drivers/s390/char/sclp_ocf.c |  4 ++--
 drivers/s390/char/sclp_tty.c | 24 ++++++++-------------
 4 files changed, 59 insertions(+), 35 deletions(-)

-- 
2.53.0

