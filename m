Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DA186E2C;
	Wed, 17 Jul 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246990; cv=none; b=KK83gTTgphg+S1DL9emZl67FTNzeWggyyz1K/BGuI9m9ZU7Tq3zO0NXVgRA3Vvt1O68HWsM7Iev4HKsK7OuVGFzU0TyS4i5L7MqGlXhh1CSIRGyoWIiVe8iSbIUZ0DH9EqBhVWs8HhCp3YuuVCfsPw9IS25PKxhbR1DIGXxv4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246990; c=relaxed/simple;
	bh=r1SCuP6BDc/XMk8VavdRDAynRmnTpz01AY1AmzWiYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ur9//e+xy3EDpYD9Nf/l0Zo1wvnErsSnZi+NRZnwVHgsTx9Hon9wVsHFwUSOEGyk3rIEBUmaQocb3VnvCT+77VLB7Zv0pXUfR3OXS1PO/TT21nDAPYoStgUmmxQon5NlW9VkAm5dn+PEDCmF7z8WSd7IEnhLpwes+OznagH4oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JTtUg9Kh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JTtUg9Kh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HIuo20030111;
	Wed, 17 Jul 2024 20:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=QQ41U8jnHPCkwR4DJ4KHNgwfTMebv+HYRLpS8QIG1Xw=; b=JTtUg9KhnsKV
	Pm//RLTexHoL63rIXQ5B/OVNYgO0RsP2UbOG1Fi9UBQOIANuyQWTbR1IGIu+nBDA
	tLg8z416CQS/hnnNtAYvUUWdat7MthDlk9HT+bBpuhyRtgAJ0MEp0rRSu2aIzLgY
	KqfhDq92rPav5iDP0d0DYB9FqOCys6RBa8xHSYqsFTzoZXLDtB+EOebSkAYUkuxB
	gkxrWcUoOM9491N06g48RFjJF4EAqGHkDsJlCe5/y3dU5QjFxzzZ0OGEjwQhwHjC
	earMAYF23PCfrBq3peTZjvPXC4ZX5AsK5UYHFX8t2MXJKJ2YezdAYD0rQeRxyEbj
	0YzjwVtRsg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e6h3j60j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 20:09:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46HHK0dT028853;
	Wed, 17 Jul 2024 20:09:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkmx2a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 20:09:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46HK9bXX28770714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:09:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9EAA20043;
	Wed, 17 Jul 2024 20:09:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45EBF20040;
	Wed, 17 Jul 2024 20:09:37 +0000 (GMT)
Received: from localhost (unknown [9.171.52.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jul 2024 20:09:37 +0000 (GMT)
Date: Wed, 17 Jul 2024 22:09:35 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.11 merge window
Message-ID: <your-ad-here.call-01721246975-ext-7833@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FDClh2zFGJ2yuRYszmF1al-kSz6DGezZ
X-Proofpoint-ORIG-GUID: FDClh2zFGJ2yuRYszmF1al-kSz6DGezZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170151

Hello Linus,

Please pull s390 changes for 6.11. There is a conflict with the mm tree
(not yet pulled as of now) which contains the KMSAN implementation for
s390. Please apply the following fix-up if possible to avoid build breakage:
https://lore.kernel.org/all/20240627150405.27663-1-iii@linux.ibm.com
---
 arch/s390/include/asm/kmsan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kmsan.h b/arch/s390/include/asm/kmsan.h
index 27db65fbf3f6..f73e181d09ae 100644
--- a/arch/s390/include/asm/kmsan.h
+++ b/arch/s390/include/asm/kmsan.h
@@ -12,8 +12,8 @@
 
 static inline bool is_lowcore_addr(void *addr)
 {
-       return addr >= (void *)&S390_lowcore &&
-              addr < (void *)(&S390_lowcore + 1);
+       return addr >= (void *)get_lowcore() &&
+              addr < (void *)(get_lowcore() + 1);
 }
 
 static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
@@ -25,7 +25,7 @@ static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
                 * order to get a distinct struct page.
                 */
                addr += (void *)lowcore_ptr[raw_smp_processor_id()] -
-                       (void *)&S390_lowcore;
+                       (void *)get_lowcore();
                if (KMSAN_WARN_ON(is_lowcore_addr(addr)))
                        return NULL;
                return kmsan_get_metadata(addr, is_origin);
-- 

Thank you,
Vasily

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-1

for you to fetch changes up to df39038cd89525d465c2c8827eb64116873f141a:

  s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception() (2024-07-17 14:30:30 +0200)

----------------------------------------------------------------
s390 updates for 6.11 merge window

- Remove restrictions on PAI NNPA and crypto counters, enabling
  concurrent per-task and system-wide sampling and counting events

- Switch to GENERIC_CPU_DEVICES by setting up the CPU present mask in
  the architecture code and letting the generic code handle CPU bring-up

- Add support for the diag204 busy indication facility to prevent
  undesirable blocking during hypervisor logical CPU utilization
  queries. Implement results caching

- Improve the handling of Store Data SCLP events by suppressing
  unnecessary warning, preventing buffer release in I/O during failures,
  and adding timeout handling for Store Data requests to address potential
  firmware issues

- Provide optimized __arch_hweight*() implementations

- Remove the unnecessary CPU KOBJ_CHANGE uevents generated during topology
  updates, as they are unused and also not present on other architectures

- Cleanup atomic_ops, optimize __atomic_set() for small values and
  __atomic_cmpxchg_bool() for compilers supporting flag output constraint

- Couple of cleanups for KVM:
  - Move and improve KVM struct definitions for DAT tables from gaccess.c
    to a new header
  - Pass the asce as parameter to sie64a()

- Make the crdte() and cspg() page table handling wrappers return a
  boolean to indicate success, like the other existing "compare and swap"
  wrappers

- Add documentation for HWCAP flags

- Switch to obtaining total RAM pages from memblock instead of
  totalram_pages() during mm init, to ensure correct calculation of zero
  page size, when defer_init is enabled

- Refactor lowcore access and switch to using the get_lowcore() function
  instead of the S390_lowcore macro

- Cleanups for PG_arch_1 and folio handling in UV and hugetlb code

- Add missing MODULE_DESCRIPTION() macros

- Fix VM_FAULT_HWPOISON handling in do_exception()

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/sclp: Define commands for storage (un)assignment

Claudio Imbrenda (3):
      s390/pgtable: Make crdte() and cspg() return a value
      s390/entry: Pass the asce as parameter to sie64a()
      s390/kvm: Move bitfields for dat tables

David Hildenbrand (10):
      s390/uv: Don't call folio_wait_writeback() without a folio reference
      s390/uv: gmap_make_secure() cleanups for further changes
      s390/uv: Split large folios in gmap_make_secure()
      s390/uv: Convert PG_arch_1 users to only work on small folios
      s390/uv: Update PG_arch_1 comment
      s390/uv: Make uv_convert_from_secure() a static function
      s390/uv: Convert uv_destroy_owned_page() to uv_destroy_(folio|pte)()
      s390/uv: Convert uv_convert_owned_from_secure() to uv_convert_from_secure_(folio|pte)()
      s390/uv: Implement HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
      s390/hugetlb: Convert PG_arch_1 code to work on folio->flags

Gerald Schaefer (1):
      s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

Heiko Carstens (5):
      s390: Provide optimized __arch_hweight*() implementations
      s390/hwcaps: Add documentation for HWCAP flags
      s390/atomic_ops: Use symbolic names
      s390/atomic_ops: Improve __atomic_set() for small values
      s390/atomic_ops: Make use of flag output constraint

Jeff Johnson (5):
      s390/crc32: Add missing MODULE_DESCRIPTION() macro
      s390/lib: Add missing MODULE_DESCRIPTION() macros
      s390/mm: Add missing MODULE_DESCRIPTION() macro
      s390/dcssblk: Add missing MODULE_DESCRIPTION() macro
      s390/3270: Add missing MODULE_DESCRIPTION() macros

Mete Durlu (8):
      s390/topology: Remove CPU KOBJ_CHANGE uevents
      s390/sclp: Diag204 busy indication facility detection
      s390/diag: Return errno's from diag204
      s390/diag: Diag204 add busy return errno
      s390/diag: Add busy-indication-facility requirements
      s390/hypfs_diag: Diag204 busy loop
      s390/sthyi: Move diag operations
      s390/sthyi: Use cached data when diag is busy

Peter Oberparleiter (3):
      s390/sclp: Suppress unnecessary Store Data warning
      s390/sclp: Prevent release of buffer in I/O
      s390/sclp: Add timeout to Store Data requests

Sven Schnelle (11):
      s390: Add get_lowcore() function
      s390: Replace S390_lowcore by get_lowcore()
      s390/drivers: Replace S390_lowcore by get_lowcore()
      s390/boot: Replace S390_lowcore by get_lowcore()
      s390/nmi: Remove duplicate get_lowcore() calls
      s390/smp: Remove duplicate get_lowcore() calls
      s390/vtime: Remove duplicate get_lowcore() calls
      s390/idle: Remove duplicate get_lowcore() calls
      s390/mm: Remove duplicate get_lowcore() calls
      s390: Remove S390_lowcore
      s390/smp: Switch to GENERIC_CPU_DEVICES

Thomas Richter (6):
      s390/pai_crypto: Enable concurrent system-wide counting/sampling event
      s390/pai_crypto: Enable per-task counting event
      s390/pai_crypto: Enable per-task and system-wide sampling event
      s390/pai_ext: Enable concurrent system-wide counting/sampling
      s390/pai_ext: Enable per-task counting event
      s390/pai_ext: Enable per-task and system-wide sampling event

Wei Yang (1):
      s390/mm: Get total ram pages from memblock

 arch/s390/Kconfig                     |   3 +-
 arch/s390/boot/ipl_parm.c             |   4 +-
 arch/s390/boot/ipl_report.c           |   2 +-
 arch/s390/boot/pgm_check_info.c       |  18 +--
 arch/s390/boot/physmem_info.c         |   8 +-
 arch/s390/boot/startup.c              |  12 +-
 arch/s390/boot/vmem.c                 |  12 +-
 arch/s390/crypto/crc32-vx.c           |   1 +
 arch/s390/hypfs/hypfs_dbfs.c          |   4 +-
 arch/s390/hypfs/hypfs_diag.c          |  17 ++-
 arch/s390/include/asm/arch_hweight.h  |  76 +++++++++++++
 arch/s390/include/asm/atomic_ops.h    |  84 ++++++++++----
 arch/s390/include/asm/bitops.h        |   3 +-
 arch/s390/include/asm/current.h       |   2 +-
 arch/s390/include/asm/dat-bits.h      | 170 ++++++++++++++++++++++++++++
 arch/s390/include/asm/diag.h          |   8 ++
 arch/s390/include/asm/elf.h           |   8 ++
 arch/s390/include/asm/facility.h      |   4 +-
 arch/s390/include/asm/hardirq.h       |   6 +-
 arch/s390/include/asm/kvm_host.h      |   7 +-
 arch/s390/include/asm/lowcore.h       |   5 +-
 arch/s390/include/asm/mmu_context.h   |   8 +-
 arch/s390/include/asm/page.h          |   5 +
 arch/s390/include/asm/pai.h           |  17 ++-
 arch/s390/include/asm/percpu.h        |   2 +-
 arch/s390/include/asm/pgtable.h       |  33 +++++-
 arch/s390/include/asm/preempt.h       |  30 ++---
 arch/s390/include/asm/processor.h     |   8 +-
 arch/s390/include/asm/sclp.h          |   1 +
 arch/s390/include/asm/setup.h         |  34 +++---
 arch/s390/include/asm/smp.h           |   4 +-
 arch/s390/include/asm/softirq_stack.h |   2 +-
 arch/s390/include/asm/spinlock.h      |   2 +-
 arch/s390/include/asm/stacktrace.h    |   1 +
 arch/s390/include/asm/timex.h         |  10 +-
 arch/s390/include/asm/uv.h            |  12 +-
 arch/s390/include/asm/vtime.h         |  16 ++-
 arch/s390/kernel/asm-offsets.c        |   1 +
 arch/s390/kernel/diag.c               |  12 +-
 arch/s390/kernel/dumpstack.c          |   8 +-
 arch/s390/kernel/early.c              |  36 +++---
 arch/s390/kernel/entry.S              |   8 +-
 arch/s390/kernel/idle.c               |  11 +-
 arch/s390/kernel/irq.c                |  18 +--
 arch/s390/kernel/machine_kexec.c      |   4 +-
 arch/s390/kernel/nmi.c                |  31 ++---
 arch/s390/kernel/perf_cpum_sf.c       |   2 +-
 arch/s390/kernel/perf_pai_crypto.c    | 189 +++++++++++++++++++------------
 arch/s390/kernel/perf_pai_ext.c       | 146 ++++++++++++++++--------
 arch/s390/kernel/process.c            |   6 +-
 arch/s390/kernel/setup.c              |  24 ++--
 arch/s390/kernel/smp.c                |  88 +++++++--------
 arch/s390/kernel/sthyi.c              |  95 +++++++++++-----
 arch/s390/kernel/syscall.c            |   4 +-
 arch/s390/kernel/time.c               |  22 ++--
 arch/s390/kernel/topology.c           |   8 +-
 arch/s390/kernel/traps.c              |  28 ++---
 arch/s390/kernel/uv.c                 | 207 +++++++++++++++++++++++-----------
 arch/s390/kernel/vtime.c              |  82 +++++++-------
 arch/s390/kvm/gaccess.c               | 163 +-------------------------
 arch/s390/kvm/kvm-s390.c              |   5 +-
 arch/s390/kvm/vsie.c                  |   2 +-
 arch/s390/lib/spinlock.c              |   4 +-
 arch/s390/lib/test_kprobes.c          |   1 +
 arch/s390/lib/test_modules.c          |   1 +
 arch/s390/lib/test_unwind.c           |   3 +-
 arch/s390/lib/uaccess.c               |   4 +-
 arch/s390/mm/cmm.c                    |   1 +
 arch/s390/mm/dump_pagetables.c        |   2 +-
 arch/s390/mm/fault.c                  |  33 +++---
 arch/s390/mm/gmap.c                   |  16 +--
 arch/s390/mm/hugetlbpage.c            |   8 +-
 arch/s390/mm/init.c                   |   3 +-
 arch/s390/mm/pageattr.c               |   2 +-
 arch/s390/mm/pgalloc.c                |   4 +-
 arch/s390/pci/pci.c                   |   2 +-
 drivers/s390/block/dcssblk.c          |   1 +
 drivers/s390/char/con3270.c           |   1 +
 drivers/s390/char/fs3270.c            |   1 +
 drivers/s390/char/raw3270.c           |   1 +
 drivers/s390/char/sclp_cmd.c          |   7 +-
 drivers/s390/char/sclp_config.c       |   2 +-
 drivers/s390/char/sclp_early.c        |   5 +-
 drivers/s390/char/sclp_early_core.c   |  12 +-
 drivers/s390/char/sclp_sd.c           |  26 ++++-
 drivers/s390/cio/qdio_main.c          |   2 +-
 drivers/s390/cio/qdio_thinint.c       |   2 +-
 drivers/s390/cio/trace.h              |   2 +-
 88 files changed, 1207 insertions(+), 778 deletions(-)
 create mode 100644 arch/s390/include/asm/arch_hweight.h
 create mode 100644 arch/s390/include/asm/dat-bits.h
