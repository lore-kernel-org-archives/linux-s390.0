Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669800;
	b=zXdO744w6w2DtUOk3d9qP0CQ2s3SVDaTWCGamthGwoPy34kR1wfNgHWERQdZjfPGT5SQ
	 uvCv8kiaJCbipgVX2nmAOtBJ/c8qoDBnQ6NbUueVACZsBazk54KLc+uqVVjPCtQmJXxXP
	 O41K8iuGiLtMlsEv6khKf9fFqfYvuhmPWs+qweFNLxHHdQbh7ZCj4VCu/rkXjoUJh2oJD
	 rOo8FyQGcUBpCXOqIXxKEuI2pfGiT/cRwRMWE3hEv6gYVdRqnGowPOFnqUqdHy4k09KoS
	 jV9+elfXAYM5YL0OSI4lAz+h6c+FfrFNweWBAqtPyhp6P9eajcGDYpO7s8dSXiE+dZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=j/txBritH/NTbxK7x/GjkYoISqUOk+SN2UYkA/51YJE=;
	b=u/SxeAr9k2Oqdv2lYphUFZ12jfghNpqdeVrGVsg+LWNaMDAs9nTJW7jB+OwjzfTZlATJ
	 kbxiJbVMn5RXqoNudekIBpgtL4URkSqV52KGxQbKm+gqpNLfaMQB+vzn8a7jTR0eOboHw
	 BlzQ+OWFlJEIJjnjYBXkJtsW8DvOMwifqNVEGQrrLz5V/cf/zMjI/DV/decFwItf8VIe1
	 t5AFobfyJmPGEx4OxKFxPIHxn1PaiRvYocQvKGWjQYG43VQbrNRfz2fX7m/zzjgu3+Iwu
	 NZDfSr/HEIzPtxrdTHdSD1GUJTMu+yCzIYIAUL+4rWI1bzPvg5o1Hz5MiPp52z9AXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dq6bM0Q4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B41606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dq6bM0Q4
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MAEAfE3739273
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=j/txBritH/NTbxK7x/GjkYoISqUO
	k+SN2UYkA/51YJE=; b=Dq6bM0Q4M+fba20bAfsSmec26FWiWR+KsayHJVAPNgi/
	NzQh/KRRrVn0efvcpsVWCfDtvM1de8EXT2rmixs3oAjrec8qJeIrC35mRQY+y9jS
	pOX+DKq6fR8CvSfTDSxQSoQy97Z2nA09azZnyVFzZUIVgaXm2yjLgRt4v5fo7Kxk
	gGOTnF9KgJqQI5rJX3cmv4vznJw3NJEV7fvFeJTk1S85qjKY2P07VntaCkDxAaNN
	0AiKoPzPfV0EnIJVf1kPYh8TosOTCdqqe2RJ4SGY+s107qvix6Wbx1X7ZNC3Hgtw
	m3qXeEEaAExGq0fUWnbp9++CGO22/RefrS/x5LZJjw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5axej6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4uq1337802
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqhytx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MBns4831523546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 11:49:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859DD20049;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B9C20040;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v2 0/3] s390: Diag204 Rework
Date: Thu, 22 Oct 2026 13:49:44 +0200
Message-Id: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMQQqDMBCF4avIrBtJhqikq95DXKiZ6ICaklixi
 HdvKt10+T943wGRAlOEe3ZAoI0j+yUF3jLox3YZSLBNDSixVFIZYbkdUGr2/ToJbZ0haVqHpoJ
 0eQZyvF9c3aQeOa4+vC99U9/1B6H6hzYlpMCi1EVnqs5peky8vPacuznv/QzNeZ4fDF0e6KwAA
 AA=
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfX16vxpy5u014d
 wsQDn1zstDCxsveFTizoQhNheYMOMq/uE6nSZoll/Tp9S1aysCErOmXR4vHTXmRp2D5ETLIb8XD
 Os96WG+RDgrQBYskIgS6VZ1lVf3KnLOSlhpuwAh/luLJ8dCyQkCne2ankORCCcAZIUpjFuPDc9r
 e+UWsB/oxv7H+KqJySdtRiep4Dm76bhqafApxbJqEErFe6MSoOKzPA00UQ6cXurRCdQNS6zjpb/
 Ror4WyP7CZ1+b8lnAIWvmrIvx6Mu8ZiDlCgkvq3F7YF8XPtA/Zm4yuCIH5RKZXJDPeixSuNbGjP
 apP4pKN2zHFpubnGgpLTOv2Jnx4DOEnB/8jcdto0g3gx3b1IZsO9yMmaDUEr0r/FlsArEGAKJWm
 u1FMGPtHzT6Dk42BW8WW4UuZ6fCzew==
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad9f867 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Y2AKg0tF5yCgsJeplLoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfX48daGncFnOuy
 l6Iu3w3jM8DkzwLWFv9rhPEdxhOmrcCstKb/4QFOTFKzzxDGNydzs/HbVzlmAOIyMTxdTA6b2hj
 JGiwCGHF8A6KsZCmxkrsHCGG+ufLZYs=
X-Proofpoint-ORIG-GUID: ZUx4UhYX0CktwfCM3GzuofP3kXG-z7UJ
X-Proofpoint-GUID: ZUx4UhYX0CktwfCM3GzuofP3kXG-z7UJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610220046

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

Background
========================================================================
The goal is to create a single source where all relevant diag204
functionality is exposed and managed.

The main problems being addressed are;
* Diag204 is expensive and calling it too frequently can cause
  performance issues and also data integrity problems. Rate limiting is
  required.
* Diag204 requires a prep phase to utilize properly which means code
  duplication for each user.
* Diag204's current interface in debugfs may not be easily reachable
  as debugfs is seen as a security vulnarability by some distributions.
  The new IOCTL diag device should offer alternartive for diag204.

This is also a prerequisite for utilizing diag204 data in hiperdispatch.
There are plans to incorporate utilization data for making smarter
decisions.

Patches
========================================================================
Patch 1-2:
This patch is split into two, first half is introducing the new diag204
implementation and the second half is replacing the exisiting users.
This is purely for easier review. Before accepted I expect first two
patches to be squashed.

Patch 1:
The first patch introduces a caching mechanism inspired by Sumanth
Korikkar's diag324 implementation. Data buffer gets cached and cache
access is serialized via mutexes. If unused for a defined period diag204
data cache gets freed by a worker after a delay, that way it is
guaranteed that if an LPAR has no diag204 users, no memory is consumed.

Patch 2:
The second patch adapts the existing diag204 users to the new
interface.

Patch 3:
The third patch brings diag204 functionality to the new diag misc device.
Misc device gets two new magic values for diag204, one to fetch the data
size and the other is to actually get the diag data.
The uapi now has a new struct diag204_request for requesting the data.
Struct holds a pointer address to the userspace buffer and two behavior
altering flags; allow_busy and allow_busy_loop. Impact of said flags
are explained in Considerations section below.

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
required for that CEC, subcodes should also stay the same during
runtime.

Diag204 should be rate limited to a diag call per second at most.
In order to achive the rate limiting while also allowing users to
acquire data a caching mechanism similar to Sumanth's diag324
implementation is proposed.
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

IOCTL Interface
========================================================================
A similar IOCTL interface to existing diag calls is implemented.
Two new ioctl definitions along with a new data struct is added to the
uapi. DIAG204_GET_LEN allows userspace to acquire required buffer
length and DIAG204_GET_BUF fetches the diag204 data.
When issuing an IOCTL call with DIAG204_GET_BUF users have to utilize
the new diag204_request struct to specify the allocated buffer address
along with the allow_busy an allow_busy_wait flags for diag204 store
operation.

Considerations
========================================================================
* At the moment diag204 size request returns a page count requirement of
  423. That is the maximum amount of space needed currently for a CEC to
  service diag204.
  With this series at times there will be ~6Mb (1.6Mb for each; cache,
  temp, user buffer...) memory allocated for diag204 data per lpar.

* With the new IOCTL interface, userspace is defaulted to the
  largest diag204 data request subcode available(from subcodes 4, 6 and
  7 always the largest available is used as it returns more data).
  While this aligns with the existing behavior, question is, would
  there be any value in allowing users to specify which subcode to use?
  Although this also means more complicated implementation.

* A new addition with the IOCTL interface are the allow_busy and
  allow_busy_wait toggles. For sure there is benefit in allowing diag204
  to return BUSY instead of waiting for longer durations when it is not
  ready at the moment. allow_busy_wait adds an interruptable polling
  loop around that, with that mechanism diag204 users from userspace can
  wait for diag204 to return from its BUSY state within the same system
  call. Obviously using only a single system call is better but diag204
  users are not performance critical atm and the same polling can be
  implemented from userspace side. This can help reduce some complexity
  on the kernel code.

Changes from the earlier series;
* Address mutex lockdep issues (Sumanth Korikkar)
* Add permission check for IOCTL (Sumanth Korikkar)
* Pass buffers set to 0 when calling diag (Sumanth Korikkar)

---
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Mete Durlu (3):
      s390/diag204: Introduce diag204 rework
      s390/diag204: Replace diag204 users with new implementation
      s390/diag: Add diag204 IOCTL to diag misc device

 arch/s390/hypfs/hypfs_diag.c       | 140 ++--------------
 arch/s390/hypfs/hypfs_diag.h       |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c    |   9 +-
 arch/s390/include/asm/diag.h       |   8 +-
 arch/s390/include/uapi/asm/diag.h  |   8 +
 arch/s390/kernel/diag/Makefile     |   2 +-
 arch/s390/kernel/diag/diag204.c    | 331 +++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |   3 +
 arch/s390/kernel/diag/diag_misc.c  |   6 +
 arch/s390/kernel/sthyi.c           |  30 ++--
 10 files changed, 384 insertions(+), 157 deletions(-)

