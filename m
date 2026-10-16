Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161C48DB52;
	Fri, 16 Oct 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174656; cv=none; b=VohNQi8PM22Z3sjvCdA+Ki3V4KeCMZgS85GqaoKI7+3pvMAfkvcySIIXLLaSjF7OGWkWr1YycnnJ8ky8SZlsQSVpE+v2jdZeG9DNrJ14TdQ81gmsHClw+ETcgqcDOh18vZ+Tpfgv9VbYCBxkr7/Qxs64ah6uNJHw+s9JqPUAT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174656; c=relaxed/simple;
	bh=m1UanBCb+O3oEzIk0fMnwU9jlNe14+hwOG9YHzgXhV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gwm07TtCzSgixqbTdcsBvlefiMzvUd25z1Hb33xHY1fckzD85olsQLthilHV2MeNY0niJ4dbvKyQR4PhBbonWu8a8yEZQmsh5tUXqM8WvjHcIzPQZLjjDOQKaiYVryhtmExeE/sUqhmCjpus84kYW5wijjsWM1FTCK3TWhuZ2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/wvlLtf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/wvlLtf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GEE6hd3996367;
	Fri, 16 Oct 2026 18:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=YZQcjWY2l8fZw+apoIRBcm4o95YPjB+FluiMt1yTrTE=; b=L/wvlLtf
	KCw0MebJmq455or6SUCgjwp18alVdn/etJuRO1sA2w3kjl+6j3aHKHH+LZHT7E3H
	6JE5Q1EC1Ya+Nk3h0dZinohEzsEYwMxv2G3/REw7XVkY2ThTc2MHTGYJyPnkHPDP
	ikU64cOwcw1QCL9Jw8CcypOwihWiMODRD7gSncuySjecrEFVhJQgzf2FQnEHz0v+
	JFbiNZbsaxpFako0amyPzAAGKRyWiUlscOQnUIe7OvafDByFRhMMCMXQ3Xm8kX81
	mkg2uYfYLHwAqgqTrhTGR8KZPsMoacEJ5MJsWASqQe3wCt8c9opSLLobzkH4lKEe
	xq2U1oPwioSUIw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv40ue9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 18:17:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GI5arF3752460;
	Fri, 16 Oct 2026 18:17:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hb34mmqjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 18:17:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GIHQLF39846294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 18:17:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5FFF2004B;
	Fri, 16 Oct 2026 18:17:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5607F20049;
	Fri, 16 Oct 2026 18:17:26 +0000 (GMT)
Received: from osiris (unknown [9.87.148.225])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Oct 2026 18:17:26 +0000 (GMT)
Date: Fri, 16 Oct 2026 20:17:24 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.4 merge window
Message-ID: <20261016181724.34355A7e-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PZzdBXuBoKzaAlROGTPk5CTgO50igDZx
X-Proofpoint-ORIG-GUID: PZzdBXuBoKzaAlROGTPk5CTgO50igDZx
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad26a3c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=YCwyvBULpCNw_tihcYAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX5XqCp7ig2M+/
 M9USgi0CnRff916PCfYyKbEjoBdzIlqh+S8n8/O112AdFL5NGt7OWqJ7K1tjD9LwWT8emNXfnaj
 JEwHoWoZbNK58fQJWX3VjmglxZiTc1k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX/ykHJhHYxy3n
 WrzVm/SR+ljWHMc9kvJDI24U3I+AAF0asEBByCH02W7Hu4M/v7o6Y6lZ7wmXquv1i1M5CGf24Lm
 ntmLEFOXiSXAwbYMgdDirEEI0jfoT+c2+JjIWMKJkuQcd0pK/gFfm6HpYHbGqkLswZ/GYEFK/aL
 Ab9h3gU4C2Q2SQwURVuaCPYGxPGe8KsTzQeMAWw/vwA5INJ7a/pV3GzArbZe/sS8fJNmXIvi/Zy
 7xKbbEEcigSFGDzbcfv7j9PNopMDuguKy0tEPz9KH/B1nTeA/JBpN1XpRVtQBi7eo9pbZaIwKVI
 +MmIzEg4TJn3aqKL3cWLEjD/YKNiLzwndZY9niImH4/Wg7aqcCJoC5rXO2sASoA6C20SFNb7LTG
 oAx4Md5s81B8D9kC9UEGOG6N9M/lR7q0pOXoOZirH8pdRqSue4FhJURssKEyuSnrqiHWKzJLCHk
 cB4nz0lKTZ2mjUt89jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072

Hi Linus,

please pull s390 updates for the 7.4 merge window.

Thanks,
Heiko

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-1

for you to fetch changes up to 3e30b96fab780110f62156d5a8cd5240152b3c59:

  s390/signal: Cleanup coding style (2026-10-14 17:36:42 +0200)

----------------------------------------------------------------
s390 updates for 7.4 merge window

- Add support for sclp-vt220 terminal resize events e.g. for QEMU

- Warn if kernel command line contains non-printable EBCDIC
  characters

- Improve show_code() disassembly output by using reliable markers for
  the instruction address and faulting instruction

- Rework exception handling to require only a single exception table
  entry per faulting instruction: convert all inline assemblies from
  EX_TABLE to the new EX_TABLE_INSN macros. The previous exception
  handling was error prone since it usually required two EX_TABLE
  entries: one pointing at the instruction, and one pointing behind it

- Disallow kprobes on instructions with exception table entries to avoid
  exception handlers decoding a breakpoint instead of the original
  instruction

- Preemptible percpu ops changes:

  - Simplify percpu_entry() and percpu_exit() by encoding the percpu
    base, offset, and pointer registers into the lowcore marker, allowing
    percpu_exit() to update the percpu pointer on CPU migration without
    comparing the interrupted instruction

  - Convert this_cpu_cmpxchg(), this_cpu_xchg(), and
    this_cpu_cmpxchg128() to preemptible percpu ops; provide
    this_cpu_try_cmpxchg()

- Emulate virtual timer in appldata via delayed work and remove the
  s390 specific vtimer infrastructure

- Add lock contention tracepoints to rwlock slowpath

- Fix incorrect return address in signal frame setup

- Fix cpum_cf CPU hotplug handling

- Convert various __get_free_pages() / get_zeroed_page() users to
  kmalloc() / kzalloc()

- PCI:

  - Improve RPCIT instruction tracing

  - Fix double-free, use-after-free, and resource leaks in zPCI MSI
    and IRQ setup / cleanup paths

- Crypto and zcrypt:

  - Improve reply message and length verification checks for CCA,
    EP11, and ICA messages to prevent out-of-bounds reads

  - Add missing array_index_nospec() for domain index uses in zcrypt to
    prevent speculative execution bypass

  - Fix out-of-bounds read in cca_query_crypto_facility()

- Various other small fixes and improvements

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/mm: Cleanup pXXp_flush_lazy() routines

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Euan Bourke (1):
      s390/hiperdispatch: Use system_dfl_wq to reschedule hd_capacity_work

Gerd Bayer (3):
      s390/pci: Adjust alignment in insn trace
      s390/pci: Use 32-bit fh outside of inline asm
      s390/pci: Add function handle to RPCIT insn trace

Harald Freudenberger (3):
      s390/zcrypt: Fix and improve zcrypt reply message verification checks
      s390/zcrypt: Guard domain index uses against speculative bypass
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

Heiko Carstens (70):
      Merge branch 'cio-page-alloc-to-kmalloc'
      s390/percpu: Fix comment typo
      s390/percpu: Add sanity check to GEN_MVIY macro
      s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
      s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
      s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
      s390/percpu: Rename inline assembly symbolic names
      s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
      s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
      s390/percpu: Use percpu code section for this_cpu_xchg()
      s390/percpu: Use percpu code section for this_cpu_cmpxchg()
      s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
      Merge branch 'percpu'
      s390/dis: Mark non-NUL-terminated character arrays with __nonstring
      Merge branch 'cpum_cf'
      s390/appldata: Emulate virtual timer with delayed work
      s390/vtime: Remove vtimer infrastructure
      Merge branch 'vtimer'
      s390/ptrace: Preserve ILC when updating system call number
      s390/extable: Fix mvcos instruction decoding
      s390/uprobes: Fix off-by-one bug in emulated PER handling
      Merge branch 'pci-fixes'
      s390/kprobes: Prevent kprobes on instructions with exception table entry
      s390/early: Fix early warning handling
      s390: Clear pt_regs flags field
      s390/bug: Indicate modified PSW in disassembly
      s390/tools: Rename gen_facilities to gen_bitmaps
      s390/tools: Generate bitmap of nullified program checks
      s390/traps: Handle nullifying program checks in get_trap_ip()
      s390/dis: Improve show_code() output
      s390/extable: Rework exception handling logic
      s390/diag: Convert amode31 exception tables to EX_TABLE_INSN
      s390/uaccess: Convert inline assembly to EX_TABLE_INSN
      s390/lib/uaccess: Convert inline assembly to EX_TABLE_INSN
      s390/futex: Convert inline assembly to EX_TABLE_INSN
      s390/diag: Convert inline assembly to EX_TABLE_INSN
      s390/mm/pfault: Convert inline assembly to EX_TABLE_INSN
      s390/cpu_mf: Convert inline assembly to EX_TABLE_INSN
      s390/cert_store: Convert inline assembly to EX_TABLE_INSN
      s390/ipl: Convert inline assembly to EX_TABLE_INSN
      s390/hypfs: Convert inline assembly to EX_TABLE_INSN
      s390/ap: Convert inline assembly to EX_TABLE_INSN
      s390/fpu: Convert inline assembly to EX_TABLE_INSN
      s390/traps: Convert inline assembly to EX_TABLE_INSN
      s390/word-at-a-time: Convert inline assembly to EX_TABLE_INSN
      s390/kvm: Convert inline assembly to EX_TABLE_INSN
      s390/pci: Convert inline assembly to EX_TABLE_INSN
      s390/boot: Convert inline assembly to EX_TABLE_INSN
      s390/cio: Convert inline assembly to EX_TABLE_INSN
      s390/dasd: Convert inline assembly to EX_TABLE_INSN
      s390/diag_ftp: Convert inline assembly to EX_TABLE_INSN
      s390/sclp: Convert inline assembly to EX_TABLE_INSN
      s390/bpf: Simplify exception table entry handling
      s390/extable: Remove EX_TABLE macros and fallback extable search
      Merge branch 'exception-handling'
      s390/percpu: Use asm_inline for arch_this_cpu_add()
      s390/percpu: Drop unused output register from arch_this_cpu_add()
      s390/percpu: Drop unused output register from arch_this_cpu_to_op()
      s390/percpu: Implement this_cpu_try_cmpxchg()
      Merge branch 'percpu-improvements'
      s390/entry: Last breaking event vs invalid kernel stack
      s390/entry: Save lowcore on invalid kernel stack
      Merge branch 'stack-register'
      Merge branch 'pci-insn-tracing'
      s390: Select ARCH_MEMORY_ORDER_TSO
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/probes: Add missing fixup for bctgr and bic
      s390/probes: Fix wrong mnemonic comment for clgib
      s390/signal: Fix incorrect return address in signal frame
      s390/signal: Cleanup coding style

Ilya Leoshkevich (2):
      s390/ebcdic: Add character classes for the ASCII subset of EBCDIC
      s390: Warn if kernel command line contains non-printable EBCDIC characters

Jan Polensky (1):
      s390/rwlock: Add contention tracepoints to rwlock slowpath

Kees Cook (1):
      s390/keyboard: Allocate key_maps and func_table with ARRAY_SIZE()

Maximilian Immanuel Brandtner (2):
      s390/sclp: Introduce dedicated sclp-vt220 event buffer type
      s390/sclp: Implement resize for sclp-vt220 console

Mike Rapoport (Microsoft) (13):
      s390/chsc: Use kzalloc() for CUBs
      s390/chsc: Use kzalloc() for the SEI work area
      s390/chsc_sch: Use kzalloc() for CHSC requests
      s390/chsc_sch: Use __free(kfree) for synchronous CHSC requests
      s390/cio: Use kzalloc() for CHSC work areas
      s390/cmf: Use kmalloc() for the CMB area
      s390/idals: Use kmalloc() for IDAL data buffers
      s390/qdio_main: Use kzalloc() for the IRQ structure
      s390/qdio_main: Use kzalloc() for the QDR
      s390/qdio_setup: Use kzalloc() for QDIO buffers
      s390/qdio_setup: Use kmalloc() for the storage list
      s390/qdio_setup: Use kmalloc() for the SSQD request
      s390/scm: Use kmalloc() for SCM information

Niklas Schnelle (1):
      s390/configs: Enable NVMe-oF RDMA and TCP in defconfig

Sang-Heon Jeon (1):
      s390/sclp: Remove redundant memset after memblock_alloc_low()

Shirong Zhao (1):
      s390/fs3270: Return -ENOTTY for unknown ioctls in fs3270_ioctl()

Sumanth Korikkar (2):
      s390/cpum_cf: Check session mask before cpu offline
      s390/cpum_cf: Honor hwctr session cpu mask during hotplug

Tobias Schumacher (8):
      s390/pci: Fix double-free and NULL deref in zpci MSI domain cleanup
      s390/pci: Fix resource leak in zpci MSI setup
      s390/pci: Fix MSI directed-mode teardown IRQ bit count
      s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
      s390/pci: Add error cleanup in zpci_directed_irq_init()
      s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
      s390/pci: Drop the unused index argument of zpci_msi_clear_airq()
      s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()

 arch/s390/Kconfig                                  |   1 +
 arch/s390/appldata/appldata_base.c                 | 171 +++++----
 arch/s390/boot/ipl_parm.c                          |  19 +-
 arch/s390/boot/pgm_check.c                         |  14 +-
 arch/s390/boot/physmem_info.c                      |  18 +-
 arch/s390/boot/startup.c                           |  12 +-
 arch/s390/configs/debug_defconfig                  |  14 +
 arch/s390/configs/defconfig                        |  14 +
 arch/s390/hypfs/hypfs_vm.c                         |   6 +-
 arch/s390/include/asm/Kbuild                       |   1 +
 arch/s390/include/asm/ap.h                         |  12 +-
 arch/s390/include/asm/asm-extable.h                |  28 +-
 arch/s390/include/asm/cpu_mf.h                     |  18 +-
 arch/s390/include/asm/diag.h                       |   5 +-
 arch/s390/include/asm/diag288.h                    |   6 +-
 arch/s390/include/asm/ebcdic.h                     |   6 +
 arch/s390/include/asm/entry-percpu.h               |  71 +---
 arch/s390/include/asm/extable.h                    |  25 +-
 arch/s390/include/asm/fpu-insn.h                   |   6 +-
 arch/s390/include/asm/futex.h                      |  17 +-
 arch/s390/include/asm/idals.h                      |   9 +-
 arch/s390/include/asm/lowcore.h                    |   5 +-
 arch/s390/include/asm/pci_insn.h                   |   2 +-
 arch/s390/include/asm/percpu.h                     | 401 ++++++++++++++-------
 arch/s390/include/asm/ptrace.h                     |   6 +
 arch/s390/include/asm/uaccess.h                    |  45 +--
 arch/s390/include/asm/vtime.h                      |   2 +
 arch/s390/include/asm/vtimer.h                     |  30 --
 arch/s390/include/asm/word-at-a-time.h             |   5 +-
 arch/s390/kernel/cert_store.c                      |   6 +-
 arch/s390/kernel/diag/diag.c                       |  12 +-
 arch/s390/kernel/dis.c                             |  39 +-
 arch/s390/kernel/dumpstack.c                       |   7 +-
 arch/s390/kernel/early.c                           |  26 +-
 arch/s390/kernel/ebcdic.c                          |  40 +-
 arch/s390/kernel/entry.S                           |  17 +-
 arch/s390/kernel/entry.h                           |   4 +
 arch/s390/kernel/hiperdispatch.c                   |   2 +-
 arch/s390/kernel/ipl.c                             |   6 +-
 arch/s390/kernel/irq.c                             |  10 +-
 arch/s390/kernel/kprobes.c                         |   3 +
 arch/s390/kernel/nmi.c                             |   4 +-
 arch/s390/kernel/perf_cpum_cf.c                    |  19 +-
 arch/s390/kernel/process.c                         |  13 +-
 arch/s390/kernel/ptrace.c                          |   9 +-
 arch/s390/kernel/signal.c                          | 230 +++++-------
 arch/s390/kernel/smp.c                             |   2 +-
 arch/s390/kernel/text_amode31.S                    |  34 +-
 arch/s390/kernel/time.c                            |   2 +-
 arch/s390/kernel/traps.c                           |  42 ++-
 arch/s390/kernel/uprobes.c                         |   2 +-
 arch/s390/kernel/vtime.c                           | 212 +----------
 arch/s390/kvm/s390/gaccess.c                       |  11 +-
 arch/s390/lib/probes.c                             |  20 +-
 arch/s390/lib/spinlock.c                           |   4 +
 arch/s390/lib/uaccess.c                            |  29 +-
 arch/s390/mm/extable.c                             |   6 +-
 arch/s390/mm/pfault.c                              |  12 +-
 arch/s390/mm/pgtable.c                             |   4 +-
 arch/s390/net/bpf_jit_comp.c                       |  78 ++--
 arch/s390/pci/pci_clp.c                            |  12 +-
 arch/s390/pci/pci_insn.c                           |  78 ++--
 arch/s390/pci/pci_irq.c                            | 109 +++---
 arch/s390/pci/pci_mmio.c                           |  28 +-
 arch/s390/tools/.gitignore                         |   1 +
 arch/s390/tools/Makefile                           |  16 +-
 .../s390/tools/{gen_facilities.c => gen_bitmaps.c} | 103 +++++-
 arch/s390/tools/gen_opcode_table.c                 |  23 +-
 drivers/iommu/s390-iommu.c                         |   8 +-
 drivers/s390/block/dasd_diag.c                     |   6 +-
 drivers/s390/char/diag_ftp.c                       |   6 +-
 drivers/s390/char/fs3270.c                         |   3 +
 drivers/s390/char/keyboard.c                       |   6 +-
 drivers/s390/char/sclp.h                           |   7 +-
 drivers/s390/char/sclp_early.c                     |   1 -
 drivers/s390/char/sclp_vt220.c                     |  87 ++++-
 drivers/s390/char/vmcp.c                           |   4 +-
 drivers/s390/cio/chsc.c                            |  20 +-
 drivers/s390/cio/chsc_sch.c                        | 300 ++++++---------
 drivers/s390/cio/cmf.c                             |  11 +-
 drivers/s390/cio/ioasm.c                           |  24 +-
 drivers/s390/cio/qdio.h                            |   2 +-
 drivers/s390/cio/qdio_main.c                       |  23 +-
 drivers/s390/cio/qdio_setup.c                      |  14 +-
 drivers/s390/cio/qdio_thinint.c                    |   2 +-
 drivers/s390/cio/scm.c                             |   7 +-
 drivers/s390/crypto/zcrypt_api.c                   |  35 +-
 drivers/s390/crypto/zcrypt_ccamisc.c               |  22 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |  95 +++--
 drivers/s390/crypto/zcrypt_msgtype6.c              | 208 ++++++++---
 90 files changed, 1682 insertions(+), 1453 deletions(-)
 delete mode 100644 arch/s390/include/asm/vtimer.h
 rename arch/s390/tools/{gen_facilities.c => gen_bitmaps.c} (65%)
