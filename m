Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED825B0BE
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059397; cv=none; b=qdK5p5xf0g6bTWPAB8+/1u0D4OUZZjqgH/iuFXvZSG8C77ZmrYYb0mDksI6H0n8HZT/IY8rk/vAyc0umaUiJt2RaH/bZpc0VgdvSp4NsB6t1B42OrjuNZZ0V6RzM0LnaVFQ7DJyFW/58yMFdTplP3ISmB25RjHngeyUprrYIZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059397; c=relaxed/simple;
	bh=qxL4lJARFJsM5VOa2oANkO5gnVKjhePxLBvV0Y+8LUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfrW1LvQr+wx0sKjBnc0YDv3z8c/56JKmOHCt43FJWwJMWvCODSD21aN20OVQwjih76LJVVs7GcoJqxYn/QzgwDJNiQec9vbLc9+RqN1+OU42DHZD8bDHDjcusVtYz08fi4WYXwx//KS7EDFqQyvuYOuQ5LULAatBZnaj1+1WDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGOs8ZD4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGOs8ZD4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05TGN2980281
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5WXC8q91IFZF9F3Ie5iKsJbH5D2JghvWlW8WqDLx5
	1c=; b=gGOs8ZD4YQ5o47PFJwETfOqC14KR7DN30VkTOYsqhEZBAfB2Pxw0k0R1G
	REg4zm8AZZ6WkeDFuJoqzMNRDO0QmWGYqkw4RXddBIoluv9iTTNl4UrDODVkOsDD
	7l5PeahjGlfEcQ1LEdFfE9ktcyJjHOJNAQCKichAjKm6LacjpEHD2DQKYbeLSaWj
	xf0vJHl6lBAfACHan8AGt5rfqQDUlujMjEmYsnAi88mgr53LlGs3CfumU1YYQhPB
	y9EK23WnKgE/sy+GqnIEjw6jZjMKFuANGmja4B8INV2H+REjQZvYegrj3rH7P19o
	SmkJsnAj67BMdbZlRnA71rvsHsjPw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv43fg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5ZcKY2002798
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjrnch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h3gQ49218046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81DD52004B;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D9A20049;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v6 0/5] s390/sclp: Misc fixes
Date: Tue, 22 Sep 2026 08:42:58 +0200
Message-ID: <20260922064303.524293-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nyymo4MRtKIlDYM1_ndlZ60-Tpbz2VhU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX4+1PT5FpfUu1
 bDzV6Wz82ycj8pw0t6kYlVjwjWapvDwBBjp0UbWz0Vm1n3sf75oblKkK07Ji0wE/ZtLiGGrZeAe
 Hr646oZeGO0I8CtJyg64v7Des739Un4=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2237d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=67BLDgbx8QTdBiVmwgYA:9
X-Proofpoint-GUID: nyymo4MRtKIlDYM1_ndlZ60-Tpbz2VhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX+8ebpMYSpQ5T
 R/dVOh+zLdjm2FOy43naV5j0K3f+jK1zyn/Kz2NLwP7R3ktvdP7bUTaegdF0XWAKbabeTZ2iZdO
 +c2AaIwNz85s7g7wVMcC2Vn2x8XWH1H4tAyLoknwEK1iDRxYMgMKsw5nUxuZx+wDQjxrfWKq/hB
 CYb3Cjq6pEdPBVxUmSPr66rq0sdNTKIKaqOIdssrU9yLKlvWa0Faas1IytlQcKm4kAgMtRWt2TC
 98I2loj1WLiVDtsqxdhKa3kqX/PIo4vTkrSpPHqZKN/FcMxAjZSG4XdvxPifQZH7PPgiEcFpE48
 duhAKFFVC/jUPRIGmjQ+wUpPqF6OGuxVWgdfjKVGyJFUei/d8UboXqrAHuCrAW23uLy0MEsx9rF
 HVx9H5aec+4/cDkGaALA5wADRRVOjkQvPV4TVJCHZ5aQloomZosoI0dQ91g60Yv612wZPHGQMVg
 EKDNxVuqpcIWiEsTw1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220093

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

 drivers/s390/char/sclp.c     | 33 +++++++++++++++++++++++----------
 drivers/s390/char/sclp.h     | 24 ++++++++++++++++--------
 drivers/s390/char/sclp_ocf.c |  4 ++--
 drivers/s390/char/sclp_tty.c | 24 +++++++++---------------
 4 files changed, 50 insertions(+), 35 deletions(-)

-- 
2.53.0

