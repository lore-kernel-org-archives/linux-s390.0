Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9702356A4;
	Thu,  9 Oct 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015570; cv=none; b=prnFsjOdm1iFeLuLsDB/BEW2iaJTLZGKAoiIdmw56bPOVksMvfPt4+QdkvAyUCNbj9MyQa8pwe0tdBzYSH73aL+h5D6LLcQUtTnuXNFFokZbm2HMGjWPiS5kmntnqYakTtvgtvDJoHFCuR6vlmyRaxFrn6qlCHasPqzVXXGnECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015570; c=relaxed/simple;
	bh=45nNAoQGKtadmqf2Ak7vryY8e3EJQ9Aj+sUMt3/oGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=abC/ncTU8p4wP0K1sG2t6esBIUYcpjKlSjMzoTyknx/iW/1i5ytB8xEHj9P/p71tD1yYTy4FcvT6oKlvi8ZJjrISKsCt0A8PEpfBn7ncGKsvhZZV48aQCmVl9sX0+uR67Iefu1vPEPA85mhRvaYlSXwHNGhukORaUaf03h8AQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZrCtuG8e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZrCtuG8e"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599624Fv006940;
	Thu, 9 Oct 2025 13:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=mthYkcBEuDs3m/Wi46Wttt4Onn/F2+zboQP8q2j4Vmk=; b=ZrCtuG8e
	S+LvNDfE87mkW060Mc+Zpjldj1mZX5RexsYkkGFEKfBJ46CGtNjusywk+Mq0eVEe
	/G5kiF4eudK30GlmFzXlkxkq5Uw+zbamD1x5lqlkLraYVYHoP3JkwYMg4lZbof44
	3l/9UwHnFeZWNuxgQEvf+Wz0e18pHhm51IlDSEbY03pT2DyT7l/xn0va3wEfwJ7L
	zM0si7ze6PbYtKMUSMN4uh3sv4X+9aNa/UNPLndcLnYBYqhJhEu6yqbxdc4K4XMe
	wxNJX37Rgdl4iiVG8KqA1iru3+zDieZCNTGH11lUfbx273zZwsuC2yIN/h624oFQ
	L/opcwmAAOHKsw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv804xf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:12:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CQu68008390;
	Thu, 9 Oct 2025 13:12:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanvma5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:12:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599DCf3r30736764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 13:12:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EA2520098;
	Thu,  9 Oct 2025 13:12:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858CC20097;
	Thu,  9 Oct 2025 13:12:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Oct 2025 13:12:41 +0000 (GMT)
Date: Thu, 9 Oct 2025 15:12:40 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.18 merge window
Message-ID: <20251009131240.3363697A73-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e7b4ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pThvB05L-iGNMOYvOaIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OxsjEDYFDGrcOc3KwBap-jR_XElGugoj
X-Proofpoint-ORIG-GUID: OxsjEDYFDGrcOc3KwBap-jR_XElGugoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX03nNgTnNDbt9
 MbvSIZiq4zHohvasE3zUtoiASwP1ZBqJ/oWKlbgVlRfF6RS3zRLeZ90hoClMWZcSp9Rv8oT8JxD
 Ykc7JVFhHGw+Xc6Z5PT5UqEt+/EUnVuU40N11SCBhER2j0Lu5vJlRDmnOQKhj2VXeBLB0GWR1Tq
 ZGucFM14GevVcc/Y0+yZ4urVPolaHWj9mQzZXgmreP4l7Ob/AT6P9/jd6UHOOy2q9m5sxGeJCCG
 jgNhDg+piVHsAFY44MjdrK6ptC473s5Ckti3j33YLdRhOsTJ0Jmt7v/2mqKeC1pEEybcJT2nBGY
 PxVeJC8rsi0S7Q79rn1kE2wPX/sHqePvlJeX8PYyea9Sl02EbI0+goG5ESXM74l0vmWbdYFJAyY
 Ra7MvZtaRS0vk9tDRyBSA9UKChKeCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121

Hi Linus,

please pull more s390 updates and fixes for the 6.18 merge window.

Thanks,
Alexander

The following changes since commit 088bb10e37252034ec58a6152f20bfdc8a837f54:

  s390/mm: Add memory allocation profiling hooks (2025-09-25 14:28:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-2

for you to fetch changes up to deabb34b66b96c941ac0b3d01a6a6804c3274a78:

  s390/uv: Fix comment of uv_find_secret() function (2025-10-08 13:58:37 +0200)

----------------------------------------------------------------
more s390 updates for 6.18 merge window

- Compile the decompressor with -Wno-pointer-sign flag to avoid
  a clang warning

- Fix incomplete conversion to flag output macros in __xsch(),
  to avoid always zero return value instead of the expected
  condition code

- Remove superfluous newlines from inline assemblies to improve
  compiler inlining decisions

- Expose firmware provided UID Checking state in sysfs regardless
  of the device presence or state

- CIO does not unregister subchannels when the attached device is
  invalid or unavailable. Update the purge function to remove I/O
  subchannels if the device number is found on cio_ignore list

- Consolidate PAI crypto allocation and cleanup paths

- The uv_get_secret_metadata() function has been removed some few
  months ago, remove also the function mention it in a comment

----------------------------------------------------------------
Heiko Carstens (3):
      s390: Add -Wno-pointer-sign to KBUILD_CFLAGS_DECOMPRESSOR
      s390/cio/ioasm: Fix __xsch() condition code handling
      s390: Remove superfluous newlines from inline assemblies

Ramesh Errabolu (1):
      s390/pci: Expose firmware provided UID Checking state in sysfs

Thomas Huth (1):
      s390/uv: Fix comment of uv_find_secret() function

Thomas Richter (1):
      s390/pai_crypto: Consolidate PAI crypto allocation and cleanup paths

Vineeth Vijayan (1):
      s390/cio: Update purge function to unregister the unused subchannels

 arch/s390/Makefile                  |   1 +
 arch/s390/hypfs/hypfs_sprp.c        |   2 +-
 arch/s390/include/asm/ap.h          |  18 +++---
 arch/s390/include/asm/atomic_ops.h  |  28 +++++-----
 arch/s390/include/asm/barrier.h     |   8 +--
 arch/s390/include/asm/bitops.h      |   2 +-
 arch/s390/include/asm/checksum.h    |   2 +-
 arch/s390/include/asm/cmpxchg.h     |  12 ++--
 arch/s390/include/asm/cpacf.h       |  24 ++++----
 arch/s390/include/asm/ctlreg.h      |   8 +--
 arch/s390/include/asm/fpu-insn.h    |  36 ++++++------
 arch/s390/include/asm/kvm_para.h    |   2 +-
 arch/s390/include/asm/pci.h         |  10 ++++
 arch/s390/include/asm/percpu.h      |   8 +--
 arch/s390/include/asm/processor.h   |   2 +-
 arch/s390/include/asm/rwonce.h      |   2 +-
 arch/s390/include/asm/spinlock.h    |   2 +-
 arch/s390/include/asm/stacktrace.h  |   4 +-
 arch/s390/include/asm/string.h      |   2 +-
 arch/s390/include/asm/syscall.h     |   2 +-
 arch/s390/include/asm/timex.h       |   2 +-
 arch/s390/kernel/diag/diag310.c     |   2 +-
 arch/s390/kernel/diag/diag324.c     |   2 +-
 arch/s390/kernel/perf_pai_crypto.c  | 106 +++++++++++++++---------------------
 arch/s390/kernel/setup.c            |   2 +-
 arch/s390/kernel/skey.c             |   2 +-
 arch/s390/kernel/smp.c              |   2 +-
 arch/s390/kernel/uv.c               |   4 +-
 arch/s390/kvm/kvm-s390.c            |   6 +-
 arch/s390/lib/spinlock.c            |   6 +-
 arch/s390/lib/string.c              |   8 +--
 arch/s390/lib/test_unwind.c         |   4 +-
 arch/s390/lib/xor.c                 |   8 +--
 arch/s390/mm/maccess.c              |   2 +-
 arch/s390/mm/pgalloc.c              |   2 +-
 arch/s390/pci/pci.c                 |   4 ++
 arch/s390/pci/pci_insn.c            |   4 +-
 arch/s390/pci/pci_sysfs.c           |  25 +++++++++
 drivers/s390/char/sclp_early_core.c |   2 +-
 drivers/s390/cio/cmf.c              |   2 +-
 drivers/s390/cio/device.c           |  37 ++++++++-----
 drivers/s390/cio/ioasm.c            |   7 +--
 42 files changed, 223 insertions(+), 191 deletions(-)
