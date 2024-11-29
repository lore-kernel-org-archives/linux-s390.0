Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1128691;
	Fri, 29 Nov 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895152; cv=none; b=DU05V9GbsYeG+fXmWBoQ2U2lgF9WYzsW5VGNxxDGF0lZE/yULJBIkRj9G55mdo1qkoqfAdQILPgK2lxphTOG5wXQ1TxBKZDdyDoXzbsMQMvLyRBhFiiJdtGTKoUIhyOk74ErsefKPWNLIefIiaHVyajw+lRqNO/CIw7I8mXRUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895152; c=relaxed/simple;
	bh=o7W1XPHc0UrSEAIBbp2ndyg4m42IPYJNm2Sn1HvDST8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j2BUNqooOHavyCZPvD5zK24ZYeclQOxQFxfnjGOhblpcKVEW3rExY48P5Oh0HCMYtFus+/1NlQmSKKhJINoyKm8lWgss/gjuMNtkYEfFLLUHftUNjH6eoYKwmBwZ76vmB+kFtdHTPY16Zq3qVnBVp5J8K9Qubwg3oqU10MVDSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hYeP4OAb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hYeP4OAb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT5Tlvm031805;
	Fri, 29 Nov 2024 15:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=XnU3+4szxOoD7IWWIK6VUkloVBGT0gHsfpXNUkEESq0=; b=hYeP4OAb
	lTiKiXoCJQH9AruXPHCgcbOHC0IbtEm8GqIqST3J/E0uL25yc6oPqE67/t/RPHAn
	NOQ3O0GWWvPDJ7omMcz5P3h45xc0NHsVtRF1dsk8vV59iEmDU5PGD2HwZGzsGqEl
	6eGHqvJo2tSjkW+LgCbzoUrBvQhiFLNF7qoGCpNCn0VtuS5i/ay9kUov9ucn9mj3
	/Y2yLysXfjUQUfXoAJuTja8X5YxCpxUp264uVd5eQciNNAxYxFFhvp/WsUjpIiBi
	hgGg53pLPNLH8jQbDEPmtRqdN6SS0VRPegVrvfG1vLUkxfTEeJbCFMAd7MXsqUz4
	EYY5QHLhRAOp2w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436upa5843-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 15:45:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT9khQJ024981;
	Fri, 29 Nov 2024 15:45:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672em2bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 15:45:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ATFjidf53215674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 15:45:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBAD20040;
	Fri, 29 Nov 2024 15:45:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 620E12004B;
	Fri, 29 Nov 2024 15:45:44 +0000 (GMT)
Received: from osiris (unknown [9.179.13.224])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Nov 2024 15:45:44 +0000 (GMT)
Date: Fri, 29 Nov 2024 16:45:42 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.13 merge window
Message-ID: <20241129154542.8578-D-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TaO3FT62_NsZXETtlH5KBxnLROpDloyq
X-Proofpoint-GUID: TaO3FT62_NsZXETtlH5KBxnLROpDloyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290126

Hi Linus,

please pull a couple more s390 updates for the 6.13 merge window.

Thanks,
Heiko

The following changes since commit 3f020399e4f1c690ce87b4c472f75b1fc89e07d5:

  Merge tag 'sched-core-2024-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-11-19 14:16:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-2

for you to fetch changes up to cc00550b2ae7ab1c7c56669fc004a13d880aaf0a:

  Revert "s390/mm: Allow large pages for KASAN shadow mapping" (2024-11-29 13:41:11 +0100)

----------------------------------------------------------------
more s390 updates for 6.13 merge window

- Add swap entry for hugetlbfs support

- Add PTE_MARKER support for hugetlbs mappings; this fixes a regression
  (possible page fault loop) which was introduced when support for
  UFFDIO_POISON for hugetlbfs was added

- Add ARCH_HAS_PREEMPT_LAZY and PREEMPT_DYNAMIC support

- Mark IRQ entries in entry code, so that stack tracers can filter out the
  non-IRQ parts of stack traces. This fixes stack depot capacity limit
  warnings, since without filtering the number of unique stack traces is
  huge

- In PCI code fix leak of struct zpci_dev object, and fix potential double
  remove of hotplug slot

- Fix pagefault_disable() / pagefault_enable() unbalance in
  arch_stack_user_walk_common()

- A couple of inline assembly optimizations, more cmpxchg() to
  try_cmpxchg() conversions, and removal of usages of xchg() and cmpxchg()
  on one and two byte memory areas

- Various other small improvements and cleanups

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/mm: Remove bogus comment in __tlb_flush_mm()

Claudio Imbrenda (1):
      s390/vfio-ap: Remove gmap_convert_to_secure() from vfio_ap_ops

Gerald Schaefer (4):
      s390/mm: Rearrange region-third and segment table entry SW bits
      s390/mm: Introduce region-third and segment table entry present bits
      s390/mm: Introduce region-third and segment table swap entries
      s390/mm: Add PTE_MARKER support for hugetlbfs mappings

Heiko Carstens (14):
      s390/stacktrace: Use break instead of return statement
      s390: Add missing _TIF defines
      s390: Add ARCH_HAS_PREEMPT_LAZY support
      s390/ap: Replace xchg() with WRITE_ONCE()
      KVM: s390: Use try_cmpxchg() instead of cmpxchg() loops
      KVM: s390: Remove one byte cmpxchg() usage
      KVM: s390: Increase size of union sca_utility to four bytes
      s390/mm/hugetlbfs: Add missing includes
      s390: Support PREEMPT_DYNAMIC
      s390/spinlock: Use symbolic names in inline assemblies
      s390/spinlock: Remove condition code clobber from arch_spin_unlock()
      s390/spinlock: Generate shorter code for arch_spin_unlock()
      s390/spinlock: Use R constraint for arch_load_niai4()
      s390/spinlock: Use flag output constraint for arch_cmpxchg_niai8()

Niklas Schnelle (3):
      s390/debug: Pass in and enforce output buffer size for format handlers
      s390/pci: Fix leak of struct zpci_dev when zpci_add_device() fails
      s390/pci: Fix potential double remove of hotplug slot

Thomas Richter (1):
      s390/cpum_sf: Simplify release of SDBs and SDBTs

Vasily Gorbik (3):
      s390/entry: Mark IRQ entries to fix stack depot warnings
      s390/mm: Allow large pages for KASAN shadow mapping
      Revert "s390/mm: Allow large pages for KASAN shadow mapping"

 arch/s390/Kconfig                   |   2 +
 arch/s390/include/asm/debug.h       |   8 ++-
 arch/s390/include/asm/gmap.h        |   4 +-
 arch/s390/include/asm/hugetlb.h     |   4 +-
 arch/s390/include/asm/kvm_host.h    |  15 +++--
 arch/s390/include/asm/pgtable.h     | 117 +++++++++++++++++++++++++++++-------
 arch/s390/include/asm/preempt.h     |  22 +++++--
 arch/s390/include/asm/spinlock.h    |   7 ++-
 arch/s390/include/asm/thread_info.h |  21 ++++---
 arch/s390/include/asm/tlbflush.h    |   5 --
 arch/s390/kernel/debug.c            |  83 ++++++++++++++-----------
 arch/s390/kernel/entry.S            |   4 ++
 arch/s390/kernel/kprobes.c          |   6 ++
 arch/s390/kernel/perf_cpum_sf.c     |  38 ++++--------
 arch/s390/kernel/stacktrace.c       |   2 +-
 arch/s390/kvm/gaccess.c             |  16 ++---
 arch/s390/kvm/interrupt.c           |  25 +++-----
 arch/s390/kvm/kvm-s390.c            |   4 +-
 arch/s390/kvm/pci.c                 |   5 +-
 arch/s390/lib/spinlock.c            |  34 ++++++++---
 arch/s390/mm/fault.c                |   3 +-
 arch/s390/mm/gmap.c                 |  12 ++--
 arch/s390/mm/hugetlbpage.c          |  31 +++++++---
 arch/s390/pci/pci.c                 |  55 ++++++++---------
 arch/s390/pci/pci_event.c           |  10 ++-
 drivers/s390/crypto/ap_bus.c        |   2 +-
 drivers/s390/crypto/vfio_ap_ops.c   |  32 +++++++---
 27 files changed, 359 insertions(+), 208 deletions(-)
