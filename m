Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578505;
	b=hloNbFgO5ewyr8er9zIFRtUrBKVj3dEEwakkLFMXtxXPiMkjrMfJ99wG3BHnE5bRj8Q0
	 G4lnCEBBPVjPPmVMhQcPn1wwU/hJ5CakFQVh2X+G+CgqmzP5Sn/bIUiUDSfWmVyYtlNj2
	 KFXD+4CVkq147vAQxeZVTQR7pC2ubPCoP/indPoNfqIX4L4Pdh1B8qS6ZCevnMcLLpejM
	 gF6RJjMbbPqG5TAKZB174uUG3pL5kQDhDfCjzkBAjl+wi6e1zxyaaBEnq3Zh5LUEirAI7
	 IVO4zqcokDSEPpDVHASMViWzCf9VarQV9KtLM7jxrDT+/bjZ0LlM2Y9yRY0A9yfJHyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578505;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4RNQAsq83g4chh/KpAHVnKO0YDJSxCUddz6Vt3QxUi0=;
	b=o/yi/Y9BsfCOpPXPAhOeoMEoUw6o9/3sNhZ0UwDGMwYIb36lKmGfiivs4DuhT8ch3mEW
	 l3WGVfFljILDVuCXQANWqVLQ8x2+Hs8rwGq6/wunexNtiBAbLbZ77Gb22RULbFAe8fIkZ
	 nABo5Y6faemcmaBQDfp82jZeyd79xzmUJ/cgDTwVvnPsmgwb2+df7EPJcKei6Buq+ZaKq
	 LQYa/8AVkH5IbRdvJ3FtF0aIy69KSb0n9dCySWFbT9zAKC/VbBgrQeBLe4qZeUEcWeG2u
	 sgZ8EWzXjtK0z1I8sGmak7S90vk8PjFsENKu/MSLZtk7NuQJ/63h2q8+79m+iN8Pvhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gZ4gJht2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00015606A31A
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00015606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gZ4gJht2
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LAEgmb907735
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=4RNQAsq83g4chh/KpAHVnKO0YDJS
	xCUddz6Vt3QxUi0=; b=gZ4gJht2NKiavVxe+xbV5zZitrnJGZLdmi1L1cf7H2IH
	LgN9l7xPreaOkvweclh0pFTG/+54Lf7F8t70Kqoh6s+tKiZvn41dGFYKk8FSxqZM
	XehuARbGZQcQbAqm7eLRJcRbQPVNf67QwSGHsbcXZXOk72xNvV0ESwlstcmfYRVT
	rtEYzoOg2MUXhXRaFB0y8NTs37Vtq/oioop3lfLvWV6uGahivWlQaGFD+qPDJb6x
	q3svFN5uYbXJI68J5NYc87/pTd51QlPyOmJMxGfT2bdzOrhzZmYH98/wC23thZxN
	wWaFWogQeK7BacY0182JpLZ4OayPDQCwo+YDRGkOdA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a033d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA50pE1739156
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss2fxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LASIJZ50397606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 10:28:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB4220063;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31EE42004E;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH 0/3] s390: Diag204 Rework
Date: Wed, 21 Oct 2026 12:28:07 +0200
Message-Id: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBNUpLCrRAvR0QZCQyMC8e5Jy
 7f4v0HFQlhhZQ0KPlQppwE5MXCHTRE5+WFQQs1SSMM92aiEpuzuk2sfDApjgzILjOQqGOj9d9v
 e+wf2yr/QXgAAAA==
X-Change-ID: 20261019-diag204ioctl-4df9e09af297
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfXy4KyTRokK+OQ
 15sMVHPglOGQvxXHguY6YZkBSrLxI21U+TzBPg6evM1Xi0Yjx5UWqvWL8+U16R9LfSm9DS47CvM
 YzpgX5m8TOvNa4k9kfaTPIqMBwAHMS7wUGsdhWnlKtV1PtZ2ztpndwBz7j7PIy2bQPsX1CkTeKS
 10TbLka9FmrANEHLTKrmG36UZpSxitHA7QF4i5usNCV5EOhOaqk5Sl341meJxb047GWqVI5VDwG
 f1762kes+bceFXWcZWzfYcuuwXKG2Oot/rJCu19YmLJIPNZiDM9/XPXhGJ3H2kaGK/bsBoPJGJy
 WQJcTjC+JKCFLCF5LOO0iWgHWlp/C3f7ggdR+urqxDNjU1RBsJm2rUfrAijk+DyHubjiZwPpX9L
 fO/7d7x12qIHTxLUh7pKqoIDC0ArrlyNXvu55Y4PZBGXsIwedJkXNXUA+a+Nnm71ac0ckw7hZ+w
 UkIifPzXum3IHH7PzxA==
X-Proofpoint-ORIG-GUID: tpwsNffxACZ5eiYY-sF2SrOAQ4x4BLHD
X-Proofpoint-GUID: tpwsNffxACZ5eiYY-sF2SrOAQ4x4BLHD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX3ekdfcPAiUSO
 CAdszNfGzC6rSAjqK8kyxG7vwYdst8+ehFdg62NST1aXmqL+PjeKUk5Aqq/3Af89LeHkgaJHOaT
 MfIkuDfJ/mR2Y2lsboHLQ/wFQ/B1Lzc=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad893c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Y2AKg0tF5yCgsJeplLoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210040

Background
========================================================================
This patch series is another attempt at previous diag204 rework efforts
from 2025: 20250507135250.34199-1-meted@linux.ibm.com
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
The first patch introduces a caching mechanism inspired by Sumanth
Korikkar's diag324 implementation. Data buffer gets cached and cache
access is serialized via mutexes. If unused for a defined period diag204
data cache gets freed by a worker after a delay, that way it is
guaranteed that if an LPAR has no diag204 users, no memory is consumed.
This patch is split into two, first half is introducing the new diag204
implementation and the second half is replacing the exisiting users.
This is purely for easier review. Before pushing I expect first two
patches to be squashed.

The third patch brings diag204 functionality to the new diag misc device.
Misc device gets two new magic values for diag204, one to fetch the data
size and the other is to actually get the diag data.
The uapi now has a new struct diag204_request for requesting the data.
Struct holds a pointer address to the userspace buffer and two behavior
altering flags; allow_busy and allow_busy_loop. Impact of said flags
are explained in Considerations section below.

Proposed Way of Diag204 Usage
========================================================================
Users from kernel and userspace are now exposed to a couple of common
diag204 functions which should allow for a simpler way of utilizing
with diag204.
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
to release the mutex before they sleep. The updating cache flag comes in
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
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222

Mete Durlu (3):
      s390/diag204: Introduce diag204 rework
      s390/diag204: Replace diag204 users with new implementation
      s390/diag: Add diag204 IOCTL to diag misc device

 arch/s390/hypfs/hypfs_diag.c       | 140 ++------------
 arch/s390/hypfs/hypfs_diag.h       |   4 +-
 arch/s390/hypfs/hypfs_diag_fs.c    |   9 +-
 arch/s390/include/asm/diag.h       |   8 +-
 arch/s390/include/uapi/asm/diag.h  |   8 +
 arch/s390/kernel/diag/Makefile     |   2 +-
 arch/s390/kernel/diag/diag204.c    | 382 +++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |   3 +
 arch/s390/kernel/diag/diag_misc.c  |  10 +
 arch/s390/kernel/sthyi.c           |  28 +--
 10 files changed, 437 insertions(+), 157 deletions(-)

