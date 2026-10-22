Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684171;
	b=1yyYx7ot9WQym0/Yidh8pBAGSJh8dTqNvCpfwU2nRt5R4DQBCq3JxbrGz6EFe8brmf2Q
	 PtGSfBr6p+7UuhgDhnMd7GERBq2yP8mlDCyHd+XYFDkOvoWdiRgeIlq7nwdU484GkWEfV
	 A0T5ngk6mplwgWazma5r2tNfJz3baCh1++yTePdh4QzDw3xpP2nBDDi4tnuc8HiHP1/6w
	 DF/ZLOdkW3qY8WNzPwO1BCiFvf9Dbe3znFMbPQc9ulD2uJvNtV7wROF2b+wtJu4xmZyv6
	 KiZtfOcdY1RO3oUzJt4cdKT7HJo2uLcE4TugMsEgp0w9CYnQPt8Zhe2N5ne1DWMOEMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684171;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fhv3uxXeskhgcQ3z2C0kOfOsTs+SCUJ3wi3rNCvORrs=;
	b=DLQYvb1B9svlOWmwfBuyVlMyZzan4n9GiAvWaQDL/gBPIB5046+H0BbWYC7lrjes89f6
	 0lz33+JsPN4uK/jBEz1pjF+cPsymUA1TFus+/hnFRCOCHM31E1pl6gLC3FN04YGzB8ea4
	 4sct7+KGpJME9kkp5MO1zUb3DFpcrg67428atHSQ0ZQ3jo764YV0wAF3ubKDyy7sAYWBS
	 t6e1yNb40/iSj9BXXCyMGuq6ykenEvTRtC6opU4BVkL0+dlK3YS8ues4rz5sri4nFn2qw
	 xtIbn8vdL9Hj5us4fu+oenqMYUJN23jrcscaDpWX2rCefxU0zZuaa6/xkQRlngHH5sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V10Gkt03;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AB606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E34AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V10Gkt03
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEH8r2644096
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fhv3uxXeskhgcQ3z2C0kOfOsTs+S
	CUJ3wi3rNCvORrs=; b=V10Gkt03MUrMEFnsYW+wEuCBeqdl2Cnia9/WMLV2GIib
	s1IXTq4+I3LVaEwHkMhgvxmU91UvQ7MFOL0yjclWrg4usvGOhsWsfESUK0Tr4otT
	A8EqMsp5nrr+TaQaqWOD2HHjMa4JjjUG3jV/30gOXs+Z7BkSmt8Pl/PbeCF/0PYi
	nL4slSyn1d4FpXG/PEQPhH74xt+a8zhFPIzCxC+wderosTgi0pJYt4LbLvTR+1O1
	AHxB1TZ0iVAf7ELw3zt+dqEkBH1dzaBZqhQYTZrkfmdzW0XmArLI8NzwP8Hq97LI
	mWNprLUU37z5CXAqOsjQtVk48cQVBYUPxOfj3+h2Lg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5br2b3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEuK3H699927
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn068b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFnPL017105400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:49:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6541D2004D;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368A32004B;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v3 0/3] s390: Diag204 Rework
Date: Thu, 22 Oct 2026 17:48:54 +0200
Message-Id: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MSw6CMBSF4a2Yji1prwVSR+7DOCh9wE2AmhYbD
 GHvFuJAGf4nOd9Cog1oI7meFhJswoh+zHE5n4ju1NhaiiY3AQYVZ1xSg6oFJtDrqafCOGmZVA5
 kTfLlGazDeefuj9wdxsmH964nvq1fCPg/lDhlFMpKlI2sGyfsrcfxNRfYDIX2A9mwBL8AHADIQ
 G1LJQ3XBrg6Auu6fgAy0fRv7QAAAA==
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
X-Proofpoint-GUID: beImvRVPDYezozpQstJSyxvp2DIwn45u
X-Proofpoint-ORIG-GUID: beImvRVPDYezozpQstJSyxvp2DIwn45u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX+Jvf5IKyjWyJ
 Kyk+9XbdxJFhV/2jNTt+vbDDIqPm5osZoo5/bz1miexFz/1pzQWwWaf0yG4IzEpAvoqwlUYRuLk
 CJMAekbeY+lE5ws3FS4NH6zxo2Xast4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX/Zeve0Coopwu
 jZq9XwvS4bJY9kiQzjNIGcLdtGwWwALzkP1HV1CUZUR5Yq7x4DiU7zkogBZm41i2FeOVvlflBjZ
 6L1KnJ3OOw9+ZRQZVqnGtUuW52CLvxIFbfj2Y4tXS2KMCOsG4OVeT0F2WZLr+Xnu/A7bOHpEdvQ
 Go6aJK++WaD149jc7RPVVPTPau+/x0E2JJ4SMjdExlOsd/nm+CguxCE+S2Oq3PU4Ja44Oqz5rp/
 ZAWZNVWXDukQlhsi1ml1Pkp5tnaIfiw0udhiAS978vKnmhcWtJt7D3h2jQK+ixE8mOqcGAoROAN
 mQ2oEZwInl+CjBS0kczOLik0xCi2Qgl3BsRUhDi/l+nigG25jNKvPuKFiWvR2u7wxwIIeTSYE66
 SD2t5VeI0IL6CTEzpdPUHegmLkIEFzcJ6d7FbSviy8rxH1n1pj6VGPKz1O7KmIPy5NmhOrSbPwh
 djbu9dLi7p2i3IdPMwQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ada308a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EcEuDiExmaErzBHbJwMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220062

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
DIAG_204_GET_SUBCODE enables users from userspace to figure out which
diag204 subcode is being used to fetch data. Using the subcode users can
determine which data types need to be mapped to the diag204 buffer.
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

---
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Mete Durlu (3):
      s390/diag204: Introduce diag204 rework
      s390/diag204: Replace diag204 users with new implementation
      s390/diag: Add diag204 IOCTL to diag misc device

 arch/s390/hypfs/hypfs_diag.c       | 140 ++-------------
 arch/s390/hypfs/hypfs_diag.h       |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c    |   9 +-
 arch/s390/include/asm/diag.h       |   8 +-
 arch/s390/include/uapi/asm/diag.h  |   9 +
 arch/s390/kernel/diag/Makefile     |   2 +-
 arch/s390/kernel/diag/diag204.c    | 343 +++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |   4 +
 arch/s390/kernel/diag/diag_misc.c  |   9 +
 arch/s390/kernel/sthyi.c           |  30 ++--
 10 files changed, 401 insertions(+), 157 deletions(-)

