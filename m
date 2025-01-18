Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68284A28;
	Sat, 18 Jan 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737197152; cv=none; b=BBSS6+H4p2xSlBoOhNOnpNSSpTjOnG5NzyqHz06pCp+SVnbRI3sfK9LU/gH0HSiFAtHosAPzrsdT2OC5uKYeGnKo2oZD6XP86raAfLlanHo2pEgNStiSA3Oqee1l72PT3gKawEGibLeHN9pXz1670wU0Pc1dFr47BqEToQVx7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737197152; c=relaxed/simple;
	bh=zUjXLePSY9awsTFm2r3Ka8Kh2aSslBSis6F9l/Rgmr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TwNYOMmTt5Tjmh7flKvBEAmiS4IWanIMVJ4V7giHT9+ktEBC641F1WdCZR1zLb6hs4gumbl1us2MiUG903jW1S/+p2ZAxMvoHQ+7b5MeOiOVfRLCcB6QfHPNtbp0M6PPuPNmE6NdBqpHX+LHIf3x/3MuDgXGnUmaTRaflnsw5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=siLyL7EM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="siLyL7EM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50I8WxJr028831;
	Sat, 18 Jan 2025 10:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fYhaMtrxgvvO2Y3OMOmi6OfN2Og3
	5TmoxZSAnkSLEJI=; b=siLyL7EM5IRcvzaOP4U8lfs42g6z3ygqNsERZaIWv8E/
	vQk7zBOzPOskho9g+Pn18DZeHBjyuRiFiqAHlYPv8SB4/EoXvfipsgJ2d/YvvV8M
	iDhyUnypkMf45e8Ip/I93zSOy8EzAsEmQOstlGQCiO1MCoezlGrZiH7otNwlXQl4
	LuhOnelzTLCD5j0PRB0Hdsj22EGoRkZU/QD9DB80ZK46WY7JCuozQ/rLgVq4gAf4
	luxvweCvKsAbtJlFp3QJOsXaAvMWSqFuPzqp0d7Mn4l8BH2VaN/AWaZ4DN4pfBqj
	OXx8shLAmzV8juFd4Sv3hoXpfIPUszvF8gT/rLwMXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4485w9rvaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:45:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50I7TPWN005740;
	Sat, 18 Jan 2025 10:45:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4487xh0hvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:45:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50IAjhVY36503982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Jan 2025 10:45:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52292004B;
	Sat, 18 Jan 2025 10:45:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A7720043;
	Sat, 18 Jan 2025 10:45:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 18 Jan 2025 10:45:43 +0000 (GMT)
Date: Sat, 18 Jan 2025 11:45:42 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.14 merge window
Message-ID: <Z4uGVvRYa1JaoGWy@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oE4vdUdJq7_CoFN4PSaufHNiI59VT6e2
X-Proofpoint-GUID: oE4vdUdJq7_CoFN4PSaufHNiI59VT6e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501180083

Hi Linus,

please pull s390 updates for the 6.14 merge window.

Thanks,
Alexander

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-1

for you to fetch changes up to 26701574cee6777f867f89b4a5c667817e1ee0dd:

  s390/futex: Fix FUTEX_OP_ANDN implementation (2025-01-15 17:12:31 +0100)

----------------------------------------------------------------
s390 updates for 6.14 merge window

- Select config option KASAN_VMALLOC if KASAN is enabled

- Select config option VMAP_STACK unconditionally

- Implement arch_atomic_inc() / arch_atomic_dec() functions
  which result in a single instruction if compiled for z196
  or newer architectures

- Make layering between atomic.h and atomic_ops.h consistent

- Comment s390 preempt_count implementation

- Remove pre MARCH_HAS_Z196_FEATURES preempt count implementation

- GCC uses the number of lines of an inline assembly to calculate
  number of instructions and decide on inlining. Therefore remove
  superfluous new lines from a couple of inline assemblies.

- Provide arch_atomic_*_and_test() implementations that allow the
  compiler to generate slightly better code.

- Optimize __preempt_count_dec_and_test()

- Remove __bootdata annotations from declarations in header files

- Add missing include of <linux/smp.h> in abs_lowcore.h to provide
  declarations for get_cpu() and put_cpu() used in the code

- Fix suboptimal kernel image base when running make kasan.config

- Remove huge_pte_none() and huge_pte_none_mostly() as are identical
  to the generic variants

- Remove unused PAGE_KERNEL_EXEC, SEGMENT_KERNEL_EXEC,
  and REGION3_KERNEL_EXEC defines

- Simplify noexec page protection handling and change the page,
  segment and region3 protection definitions automatically if the
  instruction execution-protection facility is not available

- Save one instruction and prefer EXRL instruction over EX in
  string, xor_*(), amode31 and other functions

- Create /dev/diag misc device to fetch diagnose specific
  information from the kernel and provide it to userspace

- Retrieve electrical power readings using DIAGNOSE 0x324 ioctl

- Make ccw_device_get_ciw() consistent and use array indices
  instead of pointer arithmetic

* s390/qdio: Move memory alloc/pointer arithmetic for slib and sl into one place

- The sysfs core now allows instances of 'struct bin_attribute' to be
  moved into read-only memory. Make use of that in s390 code

- Add missing TLB range adjustment in pud_free_tlb()

- Improve topology setup by adding early polarization detection

- Fix length checks in codepage_convert() function

- The generic bitops implementation is nearly identical to the s390 one.
  Switch to the generic variant and decrease a bit the kernel image size

- Provide an optimized arch_test_bit() implementation which makes use of
  flag output constraint. This generates slightly better code

- Provide memory topology information obtanied with DIAGNOSE 0x310
  using ioctl.

- Various other small improvements, fixes, and cleanups

These changes were added with a merge of  'pci-device-recovery' branch

- Add PCI error recovery status mechanism

- Simplify and document debug_next_entry() logic

- Split private data allocation and freeing out of debug file
  open() and close() operations

- Add debug_dump() function that gets a textual representation
  of a debug info (e.g. PCI recovery hardware error logs)

- Add formatted content of pci_debug_msg_id to the PCI report

----------------------------------------------------------------
Alexander Gordeev (2):
      Merge branch 'pci-device-recovery' into features
      s390/tlb: Add missing TLB range adjustment

Benjamin Block (3):
      s390/qdio: Rename feature flag aif_osa to aif_qdio
      s390/cio: Use array indices instead of pointer arithmetic
      s390/qdio: Move memory alloc/pointer arithmetic for slib and sl into one place

Heiko Carstens (18):
      s390/Kconfig: Select KASAN_VMALLOC if KASAN is enabled
      s390/Kconfig: Select VMAP_STACK unconditionally
      s390/setup: Cleanup stack_alloc() and stack_free()
      s390/atomic: Implement arch_atomic_inc() / arch_atomic_dec()
      s390/atomic: Consistent layering between atomic.h and atomic_ops.h
      s390/preempt: Add comments
      s390/preempt: Remove special pre MARCH_HAS_Z196_FEATURES implementation
      s390/preempt: Adjust coding style
      s390: Remove superfluous new lines from inline assemblies
      s390/atomic: Provide arch_atomic_*_and_test() implementations
      s390/preempt: Optimize __preempt_count_dec_and_test()
      s390/mm/hugetlbfs: Remove huge_pte_none() / huge_pte_none_mostly()
      s390/mm: Remove incorrect comment
      s390/mm: Remove unused PAGE_KERNEL_EXEC and friends
      s390/mm: Simplify noexec page protection handling
      s390/bitops: Switch to generic bitops
      s390/bitops: Provide optimized arch_test_bit()
      s390/futex: Fix FUTEX_OP_ANDN implementation

Mete Durlu (2):
      s390/topology: Improve topology detection
      s390/diag: Add memory topology information via diag310

Niklas Schnelle (6):
      s390/pci: Report PCI error recovery results via SCLP
      s390/debug: Simplify and document debug_next_entry() logic
      s390/debug: Split private data alloc/free out of file operations
      s390/debug: Add debug_dump() to write debug view to a string buffer
      s390/debug: Add a reverse mode for debug_dump()
      s390/pci: Add pci_msg debug view to PCI report

Sumanth Korikkar (3):
      s390/diag: Create misc device /dev/diag
      s390/diag324: Retrieve power readings via diag 0x324
      s390/diag: Move diag.c to diag specific folder

Sven Schnelle (7):
      s390/lib: Use exrl instead of ex in string functions
      s390/lib: Use exrl instead of ex in xor functions
      s390/stackleak: Use exrl instead of ex in __stackleak_poison()
      s390/amode31: Use exrl instead of ex
      s390/ebcdic: Use exrl instead of ex
      s390/ebcdic: Fix length check in codepage_convert()
      s390/ebcdic: Fix length decrement in codepage_convert()

Thomas Weißschuh (5):
      s390/crypto/cpacf: Constify 'struct bin_attribute'
      s390/ipl: Constify 'struct bin_attribute'
      s390/pci: Constify 'struct bin_attribute'
      s390/sclp: Constify 'struct bin_attribute'
      s390/pkey: Constify 'struct bin_attribute'

Vasily Gorbik (3):
      s390: Remove __bootdata annotations from declarations
      s390/abs_lowcore: Include linux/smp.h for get_cpu() and put_cpu()
      s390: Add KERNEL_IMAGE_BASE to kasan.config

 arch/s390/Kconfig                   |  28 +---
 arch/s390/Makefile                  |   9 --
 arch/s390/boot/boot.h               |   1 -
 arch/s390/boot/startup.c            |  13 +-
 arch/s390/boot/vmem.c               |  20 +--
 arch/s390/configs/kasan.config      |   2 +-
 arch/s390/include/asm/abs_lowcore.h |   4 +-
 arch/s390/include/asm/atomic.h      |  68 ++++++++-
 arch/s390/include/asm/atomic_ops.h  | 121 ++++++++++++----
 arch/s390/include/asm/bitops.h      | 201 ++++----------------------
 arch/s390/include/asm/checksum.h    |   2 +-
 arch/s390/include/asm/css_chars.h   |   2 +-
 arch/s390/include/asm/debug.h       |   7 +
 arch/s390/include/asm/diag.h        |   2 +
 arch/s390/include/asm/ebcdic.h      |  16 +--
 arch/s390/include/asm/fpu-insn.h    |  14 +-
 arch/s390/include/asm/futex.h       |   2 +-
 arch/s390/include/asm/hugetlb.h     |  23 +--
 arch/s390/include/asm/page-states.h |   3 +-
 arch/s390/include/asm/pgtable.h     | 126 ++++++++--------
 arch/s390/include/asm/preempt.h     |  83 ++++-------
 arch/s390/include/asm/processor.h   |   3 +-
 arch/s390/include/asm/sclp.h        |  35 +++++
 arch/s390/include/asm/tlb.h         |   2 +-
 arch/s390/include/uapi/asm/diag.h   |  32 +++++
 arch/s390/kernel/Makefile           |   3 +-
 arch/s390/kernel/abs_lowcore.c      |   1 +
 arch/s390/kernel/cpacf.c            |  36 ++---
 arch/s390/kernel/debug.c            | 241 +++++++++++++++++++++++++------
 arch/s390/kernel/diag/Makefile      |   1 +
 arch/s390/kernel/{ => diag}/diag.c  |   4 +-
 arch/s390/kernel/diag/diag310.c     | 276 ++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag324.c     | 224 +++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h  |  14 ++
 arch/s390/kernel/diag/diag_misc.c   |  63 ++++++++
 arch/s390/kernel/entry.S            |  20 +--
 arch/s390/kernel/ipl.c              | 142 +++++++++----------
 arch/s390/kernel/os_info.c          |   1 +
 arch/s390/kernel/setup.c            |  33 ++---
 arch/s390/kernel/text_amode31.S     |   3 +-
 arch/s390/kernel/topology.c         |  11 ++
 arch/s390/kernel/vdso64/Makefile    |   2 +-
 arch/s390/kernel/vmcore_info.c      |   3 +-
 arch/s390/lib/mem.S                 |  15 +-
 arch/s390/lib/xor.c                 |  61 ++++----
 arch/s390/mm/init.c                 |   9 ++
 arch/s390/mm/maccess.c              |   1 +
 arch/s390/mm/mmap.c                 |  42 +++---
 arch/s390/mm/pageattr.c             |   6 -
 arch/s390/mm/pgtable.c              |   2 -
 arch/s390/mm/vmem.c                 |   8 --
 arch/s390/pci/Makefile              |   2 +-
 arch/s390/pci/pci_event.c           |  21 ++-
 arch/s390/pci/pci_report.c          | 158 +++++++++++++++++++++
 arch/s390/pci/pci_report.h          |  16 +++
 arch/s390/pci/pci_sysfs.c           |  12 +-
 drivers/s390/char/sclp.h            |  18 +--
 drivers/s390/char/sclp_config.c     |   4 +-
 drivers/s390/char/sclp_early.c      |   3 +
 drivers/s390/char/sclp_pci.c        |  19 ---
 drivers/s390/char/sclp_sd.c         |   4 +-
 drivers/s390/cio/device_ops.c       |   2 +-
 drivers/s390/cio/qdio.h             |   9 +-
 drivers/s390/cio/qdio_setup.c       |  21 ++-
 drivers/s390/crypto/pkey_sysfs.c    | 126 ++++++++--------
 65 files changed, 1665 insertions(+), 791 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/diag.h
 create mode 100644 arch/s390/kernel/diag/Makefile
 rename arch/s390/kernel/{ => diag}/diag.c (98%)
 create mode 100644 arch/s390/kernel/diag/diag310.c
 create mode 100644 arch/s390/kernel/diag/diag324.c
 create mode 100644 arch/s390/kernel/diag/diag_ioctl.h
 create mode 100644 arch/s390/kernel/diag/diag_misc.c
 create mode 100644 arch/s390/pci/pci_report.c
 create mode 100644 arch/s390/pci/pci_report.h
