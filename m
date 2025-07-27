Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A5EED8;
	Sun, 27 Jul 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753612188; cv=none; b=s6Zuyl2pxtIhOZnOBK97PRCSDcK90JdpOebGl0m2kalIfXiIXtwcB3EGsmGJ7hqzTaUCo9IGCRJSZeC4MAicuSKfrwzLG4bXkvWCVsCD1dj7C6qmVxI3Yfomdj8owmtZ9NjD0JII9+DKjEJpI9qMYJs7g1M/OGPK7ir3XapB6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753612188; c=relaxed/simple;
	bh=LQiJMuqXasih86zIGuNx9tznTuZXOBRf9jbLSgHd+VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ItnzSUkBgHRgjKv2hG5ASgIbJ2/nlyOELJQva6A917B/Yt3WFwEtDC1ZIvxnEK46jhjA0cNx4KCPT3u1oIDYC0ghOxo1k5ufBe2CnfkvrAw8zSqydd8RYQ4P8ViG+a5YD8iAd79wMRvEYgKNnljnI0DC6tFNv50lz8DBHSF198A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEso9Aoz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEso9Aoz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R2F4Vw002591;
	Sun, 27 Jul 2025 10:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=Kas+1XJnHpdeKLYR8o1LlOou0NFE1QnwGMeE1b8bTi0=; b=mEso9Aoz
	9ozdlST2zpy2ax2SsRKE5tSmJ3ThesH3pLei616xpm5VtwMva8VQfA3iinSxM8Cp
	wKSqIvl3yC2iYbJ9pVVuJhZBupWsTVyWXtmLBDAk0MebrJ7FDgp8bCBHeZuE5L8I
	3dJ397VQZJuuCXppGqPrp+zjP6OfCylN9MxZnM9l5YuvX8dehfTliT1tuoitLKUp
	6a94aN29LScqSf5C3Asw9HGndskxrs4o5tILasDJfe+IpywqvoQdZjy1KE83EXY+
	GFSl9jfybGXMfKy2xq3rY7tgjYWmv21g37BW0OwLO87/3eZojak3g3/A7U2bgALc
	bdAu4GJOjBk1lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqcag4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Jul 2025 10:29:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56R6WZb7017467;
	Sun, 27 Jul 2025 10:29:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859qysfqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Jul 2025 10:29:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56RATc5b21365192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Jul 2025 10:29:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C81720043;
	Sun, 27 Jul 2025 10:29:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB2BC20040;
	Sun, 27 Jul 2025 10:29:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 27 Jul 2025 10:29:37 +0000 (GMT)
Date: Sun, 27 Jul 2025 12:29:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.17 merge window
Message-ID: <20250727102936.3091421A0e-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA5MSBTYWx0ZWRfX56FZq815S7JM
 WvYBnYR+yZyKiDTzU5QuK1okdYfw+xIS6dXpUv0da5VGmLcbtECFP9qv5/DRm7Az/rnqoAWFOxi
 ekWQjwHxrOPGGofDZffXHdr/aRwLZivKe7EuyXtclTlbdOK34ihGJLbsDcjywIrzOHbiWQovaaT
 cAihPH4lys8K9pJB9oUcnERxdUgIONkf/KzA8JrNCxK0kAn4D+iaN7zvy22fokz9eDy16BiMg6T
 HBx2B5ehkB75SZ3aOrvERhDUK1HlAV775lxTWjCPuQamJmBQ2RXtXhe4Wp5pvTgYKukmVQaIsNo
 Ve0hKeNsUvoU5Vi93a3eheuPu/vNKtyBzPGeq9sCI4vuczWWNBdZ5LtRAQlBe9aL59JN78/FNEb
 3Fy4hNWDT8/jbNho7l6wlMXgMa44BVuvcCuqs73aY8tVSHkP12Qjrnq3die2IqV0KCHx3m8a
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=6885ff97 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
 a=YBpldR6urXzaD3lCsQMA:9 a=CjuIK1q_8ugA:10 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: vDiZtciyHyFvNaqKgtRsXVGN5JYM6WXF
X-Proofpoint-ORIG-GUID: vDiZtciyHyFvNaqKgtRsXVGN5JYM6WXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 mlxlogscore=-999 clxscore=1015 lowpriorityscore=0 spamscore=100
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=100 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270091

Hi Linus,

please pull s390 updates for the 6.17 merge window.
There are few merge conflicts with crc, bpf and libcrypto trees.

The crc tree got a conflict in:

  lib/crc/s390/crc32.h

between commit:

  65c9a9f92502 ("s390: Explicitly include <linux/export.h>")

from the s390 tree and commit:

  2374bf238649 ("lib/crc: s390: Migrate optimized CRC code into lib/crc/")

from the crc tree.

Please, take the crc tree version:
https://lore.kernel.org/linux-next/20250618144750.092d01b8@canb.auug.org.au/


The bpf-next tree got a conflict in:

  arch/s390/net/bpf_jit.h

between commit:

  42398caf16c9 ("s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers")

from the s390 tree and commit:

  e26d523edf2a ("s390/bpf: Describe the frame using a struct instead of constants")

from the bpf tree.

Please, delete the file:
https://lore.kernel.org/linux-next/20250704131135.1da6c34d@canb.auug.org.au/


The libcrypto tree got a conflict in:

  arch/s390/lib/crypto/sha256.c

between commit:

  65c9a9f92502 ("s390: Explicitly include <linux/export.h>")

from the s390 tree and commits:

  e96cb9507f2d ("lib/crypto: sha256: Consolidate into single module")
  b8456f7aaf35 ("lib/crypto: s390: Move arch/s390/lib/crypto/ into lib/crypto/")

from the libcrypto tree.

Please, delete the file:
https://lore.kernel.org/linux-next/20250704141635.57ff7b16@canb.auug.org.au/

Please note, along with arch/s390/lib/crypto/sha256.c above you may get
the below conflicts if the libcrypto tree is merged after the s390 tree.

The libcrypto tree conflict in:

  arch/s390/crypto/sha1_s390.c

between commit:

  68279380266a crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2

from the master tree and commit:

  377982d5618a lib/crypto: s390/sha1: Migrate optimized code into library

from the libcrypto tree.

Please, delete the file:
https://lore.kernel.org/linux-next/20250715132051.4b4ce028@canb.auug.org.au/


The libcrypto tree conflict in:

  arch/s390/crypto/sha512_s390.c

between commit:

  68279380266a crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2

from the master tree and commits:

  b7b366087e0f lib/crypto: s390/sha512: Migrate optimized SHA-512 code to library
  e0fca177556c crypto: sha512 - Rename conflicting symbols

from the libcrypto tree.

Please, delete the file:
https://lore.kernel.org/linux-next/20250701123036.0d25bbfc@canb.auug.org.au/

Thanks,
Alexander

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-1

for you to fetch changes up to 5647f61ad9171e8f025558ed6dc5702c56a33ba3:

  s390/mm: Remove possible false-positive warning in pte_free_defer() (2025-07-23 18:06:32 +0200)

----------------------------------------------------------------
s390 updates for 6.17 merge window

- Standardize on the __ASSEMBLER__ macro that is provided by GCC
  and Clang compilers and replace __ASSEMBLY__ with  __ASSEMBLER__
  in both uapi and non-uapi headers

- Explicitly include <linux/export.h> in architecture and driver
  files which contain an EXPORT_SYMBOL() and remove the include
  from the files which do not contain the EXPORT_SYMBOL()

- Use the full title of "z/Architecture Principles of Operation"
  manual and the name of a section where facility bits are listed

- Use -D__DISABLE_EXPORTS for files in arch/s390/boot to avoid
  unnecessary slowing down of the build and confusing external
  kABI tools that process symtypes data

- Print additional unrecoverable machine check information to make
  the root cause analysis easier

- Move cmpxchg_user_key() handling to uaccess library code, since
  the generated code is large anyway and there is no benefit if it
  is inlined

- Fix a problem when cmpxchg_user_key() is executing a code with a
  non-default key: if a system is IPL-ed with "LOAD NORMAL", and
  the previous system used storage keys where the fetch-protection
  bit was set for some pages, and the cmpxchg_user_key() is located
  within such page, a protection exception happens

- Either the external call or emergency signal order is used to send
  an IPI to a remote CPU. Use the external order only, since it is at
  least as good and sometimes even better, than the emergency signal

- In case of an early crash the early program check handler prints
  more or less random value of the last breaking event address, since
  it is not initialized properly. Copy the last breaking event address
  from the lowcore to pt_regs to address this

- During STP synchronization check udelay() can not be used, since the
  first CPU modifies tod_clock_base and get_tod_clock_monotonic() might
  return a non-monotonic time. Instead, busy-loop on other CPUs, while
  the the first CPU actually handles the synchronization operation

- When debugging the early kernel boot using QEMU with the -S flag and
  GDB attached, skip the decompressor and start directly in kernel

- Rename PAI Crypto event 4210 according to z16 and z17 "z/Architecture
  Principles of Operation" manual

- Remove the in-kernel time steering support in favour of the new s390
  PTP driver, which allows the kernel clock steered more precisely

- Remove a possible false-positive warning in pte_free_defer(), which
  could be triggered in a valid case KVM guest process is initializing

----------------------------------------------------------------
Alexander Gordeev (1):
      Merge branch 'uaccess-key' into features

Gerald Schaefer (1):
      s390/mm: Remove possible false-positive warning in pte_free_defer()

Heiko Carstens (14):
      s390: Explicitly include <linux/export.h>
      s390: Remove unnecessary include <linux/export.h>
      s390/drivers: Explicitly include <linux/export.h>
      s390/drivers: Remove unnecessary include <linux/export.h>
      s390/nmi: Print additional information
      s390/page: Cleanup page_set_storage_key() inline assemblies
      s390/page: Add memory clobber to page_set_storage_key()
      s390/uaccess: Make cmpxchg_user_key() library code
      s390/skey: Provide infrastructure for executing with non-default access key
      s390/uaccess: Initialize code pages executed with non-default access key
      s390/uaccess: Prevent kprobes on cmpxchg_user_key() functions
      s390/uaccess: Merge cmpxchg_user_key() inline assemblies
      s390/smp: Remove conditional emergency signal order code usage
      s390/early: Copy last breaking event address to pt_regs

Ilya Leoshkevich (2):
      s390/boot: Introduce jump_to_kernel() function
      scripts/gdb/symbols: make lx-symbols skip the s390 decompressor

Petr Pavlu (1):
      s390/boot: Use -D__DISABLE_EXPORTS

Sven Schnelle (7):
      s390/stp: Remove udelay from stp_sync_clock()
      s390/time: Use monotonic clock in get_cycles()
      s390/smp: Use monotonic clock in smp_emergency_stop()
      s390/sclp: Use monotonic clock in sclp_sync_wait()
      s390/time: Remove in-kernel time steering
      s390/stp: Remove leap second support
      s390/stp: Default to enabled

Thomas Huth (2):
      s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

Thomas Richter (1):
      s390/pai_crypto: Rename PAI Crypto event 4210

Xose Vazquez Perez (1):
      s390/boot: Use the full title of the manual for facility bits

 arch/s390/appldata/appldata_base.c        |   1 +
 arch/s390/boot/Makefile                   |   6 +-
 arch/s390/boot/als.c                      |   2 +-
 arch/s390/boot/boot.h                     |   5 +-
 arch/s390/boot/ipl_data.c                 |   9 +-
 arch/s390/boot/startup.c                  |   2 +-
 arch/s390/boot/trampoline.S               |   9 ++
 arch/s390/crypto/arch_random.c            |   1 +
 arch/s390/crypto/sha_common.c             |   1 +
 arch/s390/include/asm/alternative.h       |   6 +-
 arch/s390/include/asm/asm-const.h         |   2 +-
 arch/s390/include/asm/cpu.h               |   4 +-
 arch/s390/include/asm/cpu_mf-insn.h       |   4 +-
 arch/s390/include/asm/ctlreg.h            |   4 +-
 arch/s390/include/asm/dwarf.h             |   4 +-
 arch/s390/include/asm/extmem.h            |   2 +-
 arch/s390/include/asm/fpu-insn-asm.h      |   4 +-
 arch/s390/include/asm/fpu-insn.h          |   4 +-
 arch/s390/include/asm/ftrace.h            |   4 +-
 arch/s390/include/asm/irq.h               |   4 +-
 arch/s390/include/asm/jump_label.h        |   4 +-
 arch/s390/include/asm/lowcore.h           |   6 +-
 arch/s390/include/asm/machine.h           |   4 +-
 arch/s390/include/asm/mem_encrypt.h       |   4 +-
 arch/s390/include/asm/nmi.h               |   4 +-
 arch/s390/include/asm/nospec-branch.h     |   4 +-
 arch/s390/include/asm/nospec-insn.h       |   5 +-
 arch/s390/include/asm/page.h              |  22 ++--
 arch/s390/include/asm/processor.h         |   4 +-
 arch/s390/include/asm/ptrace.h            |   4 +-
 arch/s390/include/asm/purgatory.h         |   4 +-
 arch/s390/include/asm/sclp.h              |   4 +-
 arch/s390/include/asm/setup.h             |   6 +-
 arch/s390/include/asm/sigp.h              |   4 +-
 arch/s390/include/asm/skey.h              |  32 +++++
 arch/s390/include/asm/thread_info.h       |   2 +-
 arch/s390/include/asm/timex.h             |  13 +-
 arch/s390/include/asm/tpi.h               |   4 +-
 arch/s390/include/asm/types.h             |   4 +-
 arch/s390/include/asm/uaccess.h           | 202 ++++--------------------------
 arch/s390/include/asm/vdso.h              |   4 +-
 arch/s390/include/asm/vdso/getrandom.h    |   4 +-
 arch/s390/include/asm/vdso/gettimeofday.h |   8 +-
 arch/s390/include/asm/vdso/time_data.h    |   3 +-
 arch/s390/include/asm/vdso/vsyscall.h     |   4 +-
 arch/s390/include/uapi/asm/ptrace.h       |   5 +-
 arch/s390/include/uapi/asm/schid.h        |   4 +-
 arch/s390/include/uapi/asm/types.h        |   4 +-
 arch/s390/kernel/Makefile                 |   2 +-
 arch/s390/kernel/cpufeature.c             |   1 +
 arch/s390/kernel/crash_dump.c             |   1 +
 arch/s390/kernel/ctlreg.c                 |   1 +
 arch/s390/kernel/dis.c                    |   1 -
 arch/s390/kernel/early.c                  |   4 +
 arch/s390/kernel/facility.c               |   1 +
 arch/s390/kernel/fpu.c                    |   2 +
 arch/s390/kernel/nmi.c                    |  76 ++++++++++-
 arch/s390/kernel/perf_cpum_cf.c           |   1 -
 arch/s390/kernel/perf_cpum_sf.c           |   1 -
 arch/s390/kernel/perf_event.c             |   1 -
 arch/s390/kernel/perf_pai_crypto.c        |   3 +-
 arch/s390/kernel/perf_pai_ext.c           |   1 -
 arch/s390/kernel/process.c                |   1 -
 arch/s390/kernel/skey.c                   |  48 +++++++
 arch/s390/kernel/smp.c                    |  11 +-
 arch/s390/kernel/sthyi.c                  |   2 +
 arch/s390/kernel/time.c                   | 121 +-----------------
 arch/s390/kernel/unwind_bc.c              |   2 +
 arch/s390/kernel/uv.c                     |   1 +
 arch/s390/kernel/vmlinux.lds.S            |   7 ++
 arch/s390/kvm/interrupt.c                 |   1 +
 arch/s390/kvm/kvm-s390.c                  |   1 +
 arch/s390/kvm/pv.c                        |   2 +
 arch/s390/lib/crc32.c                     |   1 +
 arch/s390/lib/crypto/chacha-glue.c        |   1 +
 arch/s390/lib/crypto/sha256.c             |   1 +
 arch/s390/lib/delay.c                     |   1 +
 arch/s390/lib/uaccess.c                   | 188 +++++++++++++++++++++++++++
 arch/s390/mm/gmap.c                       |   1 +
 arch/s390/mm/gmap_helpers.c               |   2 +
 arch/s390/mm/pgalloc.c                    |   5 -
 arch/s390/mm/pgtable.c                    |   1 +
 arch/s390/net/bpf_jit.h                   |   4 +-
 arch/s390/net/pnet.c                      |   1 +
 arch/s390/pci/pci_bus.c                   |   1 -
 arch/s390/pci/pci_kvm_hook.c              |   2 +
 drivers/s390/block/dasd.c                 |   1 +
 drivers/s390/block/dasd_devmap.c          |   1 +
 drivers/s390/block/dasd_eer.c             |   1 +
 drivers/s390/block/dasd_erp.c             |   1 +
 drivers/s390/block/dasd_ioctl.c           |   1 +
 drivers/s390/char/keyboard.c              |   1 +
 drivers/s390/char/raw3270.c               |   1 +
 drivers/s390/char/sclp.c                  |   5 +-
 drivers/s390/char/sclp_cmd.c              |   1 -
 drivers/s390/char/sclp_early.c            |   1 +
 drivers/s390/char/sclp_ocf.c              |   1 +
 drivers/s390/char/sclp_sd.c               |   1 -
 drivers/s390/char/tape_34xx.c             |   1 +
 drivers/s390/char/tape_3590.c             |   1 +
 drivers/s390/char/tape_class.c            |   1 +
 drivers/s390/char/tape_core.c             |   1 +
 drivers/s390/char/tape_std.c              |   1 +
 drivers/s390/char/vmcp.c                  |   1 -
 drivers/s390/cio/airq.c                   |   1 +
 drivers/s390/cio/ccwgroup.c               |   2 +
 drivers/s390/cio/chsc.c                   |   1 +
 drivers/s390/cio/cio.c                    |   1 +
 drivers/s390/cio/device_fsm.c             |   1 +
 drivers/s390/cio/eadm_sch.c               |   1 +
 drivers/s390/cio/fcx.c                    |   1 +
 drivers/s390/cio/isc.c                    |   1 +
 drivers/s390/cio/itcw.c                   |   1 +
 drivers/s390/cio/qdio_debug.c             |   1 -
 drivers/s390/cio/qdio_main.c              |   2 +
 drivers/s390/cio/scm.c                    |   1 +
 drivers/s390/crypto/ap_bus.c              |   1 +
 drivers/s390/crypto/ap_queue.c            |   1 +
 drivers/s390/crypto/pkey_api.c            |   1 +
 drivers/s390/crypto/pkey_base.c           |   1 +
 drivers/s390/crypto/zcrypt_api.c          |   1 +
 drivers/s390/crypto/zcrypt_card.c         |   1 +
 drivers/s390/crypto/zcrypt_ccamisc.c      |   1 +
 drivers/s390/crypto/zcrypt_ep11misc.c     |   1 +
 drivers/s390/crypto/zcrypt_queue.c        |   1 +
 drivers/s390/net/ctcm_mpc.c               |   1 +
 drivers/s390/net/fsm.c                    |   1 +
 drivers/s390/net/ism_drv.c                |   1 +
 drivers/s390/net/qeth_core_main.c         |   1 +
 drivers/s390/net/qeth_l2_main.c           |   1 +
 drivers/s390/net/qeth_l3_main.c           |   1 +
 drivers/s390/net/smsgiucv.c               |   1 +
 lib/raid6/recov_s390xc.c                  |   1 -
 net/iucv/iucv.c                           |   1 +
 scripts/gdb/linux/symbols.py              |  26 ++++
 135 files changed, 603 insertions(+), 429 deletions(-)
 create mode 100644 arch/s390/boot/trampoline.S
 create mode 100644 arch/s390/include/asm/skey.h
 create mode 100644 arch/s390/kernel/skey.c
