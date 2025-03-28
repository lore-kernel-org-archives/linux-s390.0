Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053C849C;
	Fri, 28 Mar 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175846; cv=none; b=tGx0kA62AYe8Vc46vhYJhraz4GI98qAdZTKxniS+kkNQt/GdB9yMoeZWWItgsJiNr9AruJB6KvW+95flkl/szXjwg1gaktyg0QbtWvi1MD3ZNGX7nKbFvXs5MpC4o3O+uNqMls9YBCAp8g2FUd1c0EmvGjndWvN1XMSPCxcVlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175846; c=relaxed/simple;
	bh=wrbMpu/gwJN+qgh6AW9KABnOg4F+gl7YOpEfGOfI7Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=szPMvhzRVAjlIAuG8IAJ9ymtgvHgsgN5htTrPpFiAYKdJosYsODJGOrfIbC21PA45TLvoavfUHSXan5/zAA3g6vgdVb4/4aRKk4aERslyG/iGzp7b3MRJpQnhZWMlIB19iKfcjeersockDr0lejFhFQAg58j9QEPpUpz9/f75VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UmD0tm4a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmD0tm4a"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SA0TDe029079;
	Fri, 28 Mar 2025 15:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=+471/zau67ovIYp2lpL2+pqFZ33C6J7YwDZ44dRKQ5Q=; b=UmD0tm4a
	Hf2dQL3/VzYfxqmBbXIVdm+m/Cg1p8yk4J8XamciMx5EtK/4PqwWQvQlMYRQn/Jb
	9Zhdz9IdsrqBgzToWZcjQA5YWoIog1rrylQLwFoacFRSrian3e1HI85uD2RHIIkR
	vrxD77JwDAcnj60TteGOJKzYoiu9P9vuYyYu75K7ISelhBbCuHo2d0FwTnRzNEYO
	5vuyLC/pZAjHhO26n0YoD5QeEtosk+pBS7eEjAnjBVb4+ZPET2UCKcPygYS2c/k8
	wkm8+9P7TstXTL+G0N1fVXoNPSKtXoHXlf1wuxS/0YHAhxHZg81Ebgs2TXUJeJg1
	eExi1dqukGH1Ng==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndupvq9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 15:30:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52SDUNpl012239;
	Fri, 28 Mar 2025 15:30:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mjwau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 15:30:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52SFUb4i26214746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 15:30:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F9692004D;
	Fri, 28 Mar 2025 15:30:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C09520040;
	Fri, 28 Mar 2025 15:30:37 +0000 (GMT)
Received: from localhost (unknown [9.171.72.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 15:30:37 +0000 (GMT)
Date: Fri, 28 Mar 2025 16:30:35 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.15 merge window
Message-ID: <your-ad-here.call-01743175835-ext-6464@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jDex3tPHNeX906VFVeCH6INaOQ8THr6d
X-Proofpoint-ORIG-GUID: jDex3tPHNeX906VFVeCH6INaOQ8THr6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_07,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280104

Hello Linus,

Please pull s390 changes for 6.15. There are couple of small merge
conflicts:

With the tip tree (pulled already), reported from linux-next:
https://lore.kernel.org/all/20250319155410.3cdf01cb@canb.auug.org.au/
---
diff --cc kernel/sysctl.c
index 88b83fb504c8,6c70fb3b2376..64acbfdb5e8a
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@@ -1828,15 -1888,15 +1828,6 @@@ static const struct ctl_table kern_tabl
                .proc_handler   = proc_dointvec,
        },
  #endif
- #if defined(CONFIG_S390) && defined(CONFIG_SMP)
 -#if   defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
--      {
-               .procname       = "spin_retry",
-               .data           = &spin_retry,
-               .maxlen         = sizeof (int),
 -              .procname       = "acpi_video_flags",
 -              .data           = &acpi_realmode_flags,
 -              .maxlen         = sizeof (unsigned long),
--              .mode           = 0644,
-               .proc_handler   = proc_dointvec,
 -              .proc_handler   = proc_doulongvec_minmax,
--      },
--#endif
  #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
        {
                .procname       = "ignore-unaligned-usertrap",
--

And with the s390 fixes (pulled for 6.14-rc6):
---
diff --cc arch/s390/kernel/traps.c
index b746213d3110,9705929d256f..19687dab32f7
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@@ -283,12 -257,12 +257,12 @@@ static void __init test_monitor_call(vo

        if (!IS_ENABLED(CONFIG_BUG))
                return;
-       asm volatile(
+       asm_inline volatile(
                "       mc      0,0\n"
 -              "0:     xgr     %0,%0\n"
 +              "0:     lhi     %[val],0\n"
                "1:\n"
 -              EX_TABLE(0b,1b)
 -              : "+d" (val));
 +              EX_TABLE(0b, 1b)
 +              : [val] "+d" (val));
        if (!val)
                panic("Monitor call doesn't work!\n");
  }
--

Thank you,
Vasily

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-1

for you to fetch changes up to 0dafe9968ac7c78c67ee6bb2d970d413fb493b95:

  s390: Use inline qualifier for all EX_TABLE and ALTERNATIVE inline assemblies (2025-03-18 17:13:51 +0100)

----------------------------------------------------------------
s390 updates for 6.15 merge window

- Add sorting of mcount locations at build time

- Rework uaccess functions with C exception handling to shorten inline
  assembly size and enable full inlining. This yields near-optimal code
  for small constant copies with a ~40kb kernel size increase

- Add support for a configurable STRICT_MM_TYPECHECKS which allows to
  generate better code, but also allows to have type checking for
  debug builds

- Optimize get_lowcore() for common callers with alternatives that
  nearly revert to the pre-relocated lowcore code, while also slightly
  reducing syscall entry and exit time

- Convert MACHINE_HAS_* checks for single facility tests into cpu_has_*
  style macros that call test_facility(), and for features with additional
  conditions, add a new ALT_TYPE_FEATURE alternative to provide a static
  branch via alternative patching. Also, move machine feature detection
  to the decompressor for early patching and add debugging functionality
  to easily show which alternatives are patched

- Add exception table support to early boot / startup code to get rid
  of the open coded exception handling

- Use asm_inline for all inline assemblies with EX_TABLE or ALTERNATIVE
  to ensure correct inlining and unrolling decisions

- Remove 2k page table leftovers now that s390 has been switched to
  always allocate 4k page tables

- Split kfence pool into 4k mappings in arch_kfence_init_pool() and
  remove the architecture-specific kfence_split_mapping()

- Use READ_ONCE_NOCHECK() in regs_get_kernel_stack_nth() to silence
  spurious KASAN warnings from opportunistic ftrace argument tracing

- Force __atomic_add_const() variants on s390 to always return void,
  ensuring compile errors for improper usage

- Remove s390's ioremap_wt() and pgprot_writethrough() due to mismatched
  semantics and lack of known users, relying on asm-generic fallbacks

- Signal eventfd in vfio-ap to notify userspace when the guest AP
  configuration changes, including during mdev removal

- Convert mdev_types from an array to a pointer in vfio-ccw and vfio-ap
  drivers to avoid fake flex array confusion

- Cleanup trap code

- Remove references to the outdated linux390@de.ibm.com address

- Other various small fixes and improvements all over the code

----------------------------------------------------------------
Halil Pasic (2):
      s390/vfio-ap: Make mdev_types not look like a fake flex array
      s390/vfio-ccw: Make mdev_types not look like a fake flex array

Haoxiang Li (2):
      s390/sclp: Add check for get_zeroed_page()
      s390/tty: Fix a potential memory leak bug

Heiko Carstens (63):
      s390/cio: Remove outdated email address
      s390: Sort mcount locations at build time
      s390/mm: Remove have_store_indication static key
      s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies
      s390/uaccess: Separate key uaccess functions
      s390/uaccess: Define INLINE_COPY_FROM_USER and INLINE_COPY_TO_USER
      s390/uaccess: Optimize raw_copy_from_user() / raw_copy_to_user() for constant sizes
      s390/uaccess: Inline __clear_user()
      s390/zfcp: Remove outdated email address
      s390/cpufeature: Convert MACHINE_HAS_SEQ_INSN to cpu_has_seq_insn()
      s390/cpufeature: Convert MACHINE_HAS_RDP to cpu_has_rdp()
      s390/cpufeature: Convert MACHINE_HAS_GS to cpu_has_gs()
      s390/cpufeature: Convert MACHINE_HAS_NX to cpu_has_nx()
      s390/cpufeature: Convert MACHINE_HAS_TLB_LC to cpu_has_tlb_lc()
      s390/cpufeature: Convert MACHINE_HAS_TOPOLOGY to cpu_has_topology()
      s390/cpufeature: Convert MACHINE_HAS_EDAT1 to cpu_has_edat1()
      s390/cpufeature: Convert MACHINE_HAS_EDAT2 to cpu_has_edat2()
      s390/cpufeature: Convert MACHINE_HAS_IDTE to cpu_has_idte()
      s390: Static branches for machine features infrastructure
      s390/lowcore: Convert relocated lowcore alternative to machine feature
      s390/pci: Get rid of MACHINE_HAS_PCI_MIO
      s390/time: Convert MACHINE_HAS_SCC to machine_has_scc()
      s390/tlb: Convert MACHINE_HAS_TLB_GUEST to machine_has_tlb_guest()
      s390/tx: Convert MACHINE_HAS_TE to machine_has_tx()
      s390/kvm: Convert MACHINE_HAS_ESOP to machine_has_esop()
      s390/diag: Convert MACHINE_HAS_DIAG9C to machine_has_diag9c()
      s390/sysinfo: Remove exception handling from __stsi()
      s390/sysinfo: Cleanup stsi() inline assembly
      s390/sysinfo: Move stsi() to header file
      s390: Convert MACHINE_IS_[LPAR|VM|KVM], etc, machine_is_[lpar|vm|kvm]()
      s390/vx: Convert cpu_has_vx() to cpu feature function
      s390/bear: Convert cpu_has_bear() to cpu feature function
      s390/setup: Add decompressor_handled_param() wrapper
      s390/alternatives: Add debug functionality
      s390: Use system header file variant of include directive
      s390/asm-offsets: Rename __LC_PGM_INT_CODE
      s390/boot: Pass pt_regs to program check handler
      s390/boot: Add exception table support
      s390/boot: Convert cmma_test_essa() to extable
      s390/boot: Convert __diag260() to extable
      s390/boot: Convert tprot() to extable
      s390/boot: Convert diag500_storage_limit() to extable
      s390/boot: Convert detect_diag9c() to extable
      s390/boot: Convert __diag308() to extable
      s390/traps: Cleanup get_user() handling in illegal_op()
      s390/traps: Use pr_emerg() instead of printk()
      s390/traps: Get rid of superfluous cpu_has_vx() check
      s390/traps: Cleanup coding style
      s390/atomic_ops: Let __atomic_add_const() variants always return void
      s390/mm: Use pgprot_val() instead of open coding
      s390/mm: Convert pgprot_val() into function
      s390/mm: Convert pgste_val() into function
      s390/mm: Add configurable STRICT_MM_TYPECHECKS
      s390/lowcore: Use inline qualifier for get_lowcore() inline assembly
      s390/current: Implement current with inline assembly
      s390/smp: Implement raw_smp_processor_id() with inline assembly
      s390/spinlock: Implement SPINLOCK_LOCKVAL with inline assembly
      s390/syscall: Merge __do_syscall() and do_syscall()
      s390/lowcore: Use lghi instead llilh to clear register
      s390/tlb: Use mm_has_pgste() instead of mm_alloc_pgste()
      s390: Remove 2k vs 4k page table leftovers
      s390/sysctl: Remove "vm/allocate_pgste" sysctl
      s390: Use inline qualifier for all EX_TABLE and ALTERNATIVE inline assemblies

Niklas Schnelle (1):
      s390: Remove ioremap_wt() and pgprot_writethrough()

Qasim Ijaz (1):
      s390/mm: Simplify gap clamping in mmap_base() using clamp()

Rorie Reyes (2):
      s390/vfio-ap: Signal eventfd when guest AP configuration is changed
      s390/vfio-ap: Notify userspace that guest's AP config changed when mdev removed

Sven Schnelle (2):
      s390/traps: Change stack overflow message
      s390/syscall: Simplify syscall_get_arguments()

Thorsten Blum (1):
      s390/vfio-ap: Fix indentation in vfio_ap_mdev_ioctl()

Vasily Gorbik (3):
      Merge branch 'strict-mm-typechecks-support' into features
      s390/ptrace: Avoid KASAN false positives in regs_get_kernel_stack_nth()
      s390/kfence: Split kfence pool into 4k mappings in arch_kfence_init_pool()

WangYuli (1):
      s390/boot: Ignore vmlinux.map

joel granados (1):
      s390: Move s390 sysctls into their own file under arch/s390

 arch/s390/Kconfig                                |   2 +-
 arch/s390/Kconfig.debug                          |  10 ++
 arch/s390/boot/.gitignore                        |   1 +
 arch/s390/boot/Makefile                          |   2 +-
 arch/s390/boot/alternative.c                     | 135 +++++++++++++++
 arch/s390/boot/boot.h                            |   8 +-
 arch/s390/boot/head.S                            |  25 +--
 arch/s390/boot/ipl_parm.c                        |  33 ++--
 arch/s390/boot/{pgm_check_info.c => pgm_check.c} |  48 +++--
 arch/s390/boot/physmem_info.c                    |  84 +++------
 arch/s390/boot/printk.c                          |   4 +-
 arch/s390/boot/startup.c                         | 114 ++++++++----
 arch/s390/boot/vmem.c                            |   8 +-
 arch/s390/boot/vmlinux.lds.S                     |   2 +-
 arch/s390/configs/debug_defconfig                |   2 +
 arch/s390/configs/mmtypes.config                 |   2 +
 arch/s390/hypfs/hypfs_diag0c.c                   |   5 +-
 arch/s390/hypfs/hypfs_diag_fs.c                  |   3 +-
 arch/s390/hypfs/hypfs_vm.c                       |   5 +-
 arch/s390/hypfs/inode.c                          |   5 +-
 arch/s390/include/asm/abs_lowcore.h              |   7 -
 arch/s390/include/asm/alternative.h              |  11 +-
 arch/s390/include/asm/appldata.h                 |   3 +-
 arch/s390/include/asm/asm-extable.h              |   8 +
 arch/s390/include/asm/atomic_ops.h               |   8 +-
 arch/s390/include/asm/cpu_mf.h                   |   6 +-
 arch/s390/include/asm/cpufeature.h               |  14 ++
 arch/s390/include/asm/current.h                  |  18 +-
 arch/s390/include/asm/diag.h                     |   2 +-
 arch/s390/include/asm/elf.h                      |  32 ----
 arch/s390/include/asm/fpu.h                      |   7 +-
 arch/s390/include/asm/hugetlb.h                  |   3 +-
 arch/s390/include/asm/io.h                       |   2 -
 arch/s390/include/asm/kfence.h                   |  17 +-
 arch/s390/include/asm/lowcore.h                  |  18 +-
 arch/s390/include/asm/machine.h                  | 103 +++++++++++
 arch/s390/include/asm/mmu.h                      |   3 -
 arch/s390/include/asm/mmu_context.h              |   3 -
 arch/s390/include/asm/page.h                     |  71 ++++----
 arch/s390/include/asm/pgalloc.h                  |   1 -
 arch/s390/include/asm/pgtable.h                  |  23 ++-
 arch/s390/include/asm/processor.h                |   6 +-
 arch/s390/include/asm/ptrace.h                   |   2 -
 arch/s390/include/asm/sclp.h                     |   1 +
 arch/s390/include/asm/setup.h                    |  42 -----
 arch/s390/include/asm/smp.h                      |  24 ++-
 arch/s390/include/asm/spinlock.h                 |  20 ++-
 arch/s390/include/asm/syscall.h                  |   6 +-
 arch/s390/include/asm/sysinfo.h                  |  28 ++-
 arch/s390/include/asm/thread_info.h              |   2 -
 arch/s390/include/asm/timex.h                    |   5 +-
 arch/s390/include/asm/tlb.h                      |   2 +-
 arch/s390/include/asm/tlbflush.h                 |   8 +-
 arch/s390/include/asm/uaccess.h                  | 212 ++++++++++-------------
 arch/s390/include/asm/word-at-a-time.h           |   2 +-
 arch/s390/kernel/abs_lowcore.c                   |   1 -
 arch/s390/kernel/alternative.c                   |  65 ++++++-
 arch/s390/kernel/asm-offsets.c                   |   5 +-
 arch/s390/kernel/cert_store.c                    |   2 +-
 arch/s390/kernel/diag/diag.c                     |   4 +-
 arch/s390/kernel/early.c                         | 116 ++-----------
 arch/s390/kernel/entry.S                         |  19 +-
 arch/s390/kernel/entry.h                         |   2 +-
 arch/s390/kernel/ftrace.c                        |  11 +-
 arch/s390/kernel/guarded_storage.c               |   3 +-
 arch/s390/kernel/head64.S                        |   4 +-
 arch/s390/kernel/hiperdispatch.c                 |   3 +-
 arch/s390/kernel/ipl.c                           |  23 +--
 arch/s390/kernel/irq.c                           |   8 +-
 arch/s390/kernel/kprobes.c                       |   5 +-
 arch/s390/kernel/machine_kexec.c                 |   6 +-
 arch/s390/kernel/nmi.c                           |   9 +-
 arch/s390/kernel/processor.c                     |  10 +-
 arch/s390/kernel/ptrace.c                        |  25 +--
 arch/s390/kernel/setup.c                         |  23 +--
 arch/s390/kernel/smp.c                           |   8 +-
 arch/s390/kernel/syscall.c                       |  51 ++----
 arch/s390/kernel/sysinfo.c                       |  48 +----
 arch/s390/kernel/time.c                          |   4 +-
 arch/s390/kernel/topology.c                      |  19 +-
 arch/s390/kernel/traps.c                         | 111 +++++-------
 arch/s390/kvm/interrupt.c                        |   6 +-
 arch/s390/kvm/kvm-s390.c                         |  18 +-
 arch/s390/lib/spinlock.c                         |  31 +++-
 arch/s390/lib/uaccess.c                          | 122 +++++++++----
 arch/s390/mm/dump_pagetables.c                   |   8 +-
 arch/s390/mm/extable.c                           |  47 +++++
 arch/s390/mm/extmem.c                            |   9 +-
 arch/s390/mm/fault.c                             |  33 ++--
 arch/s390/mm/gmap.c                              |  19 +-
 arch/s390/mm/hugetlbpage.c                       |   7 +-
 arch/s390/mm/init.c                              |   6 +-
 arch/s390/mm/mmap.c                              |   9 +-
 arch/s390/mm/pageattr.c                          |   9 +-
 arch/s390/mm/pfault.c                            |   4 +-
 arch/s390/mm/pgalloc.c                           |  25 ---
 arch/s390/mm/pgtable.c                           |  88 +++++-----
 arch/s390/mm/vmem.c                              |   9 +-
 arch/s390/pci/pci.c                              |   5 +-
 arch/s390/pci/pci_clp.c                          |   4 +-
 arch/s390/pci/pci_insn.c                         |  12 +-
 arch/s390/pci/pci_mmio.c                         |   6 +-
 drivers/s390/block/dasd.c                        |   3 +-
 drivers/s390/block/dasd_devmap.c                 |   3 +-
 drivers/s390/block/dasd_diag.c                   |   5 +-
 drivers/s390/block/dasd_eckd.c                   |   3 +-
 drivers/s390/char/con3215.c                      |   3 +-
 drivers/s390/char/con3270.c                      |   3 +-
 drivers/s390/char/diag_ftp.c                     |   2 +-
 drivers/s390/char/hmcdrv_ftp.c                   |   6 +-
 drivers/s390/char/monreader.c                    |   3 +-
 drivers/s390/char/monwriter.c                    |   3 +-
 drivers/s390/char/raw3270.c                      |   3 +-
 drivers/s390/char/sclp.h                         |   9 +-
 drivers/s390/char/sclp_cmd.c                     |   3 +-
 drivers/s390/char/sclp_con.c                     |  17 ++
 drivers/s390/char/sclp_early.c                   |   6 +-
 drivers/s390/char/sclp_early_core.c              |  13 ++
 drivers/s390/char/sclp_tty.c                     |  16 +-
 drivers/s390/char/vmcp.c                         |   5 +-
 drivers/s390/char/vmlogrdr.c                     |   3 +-
 drivers/s390/char/vmur.c                         |   3 +-
 drivers/s390/cio/crw.c                           |   5 +-
 drivers/s390/cio/device_id.c                     |   3 +-
 drivers/s390/cio/ioasm.c                         |   8 +-
 drivers/s390/cio/vfio_ccw_drv.c                  |   6 +-
 drivers/s390/cio/vfio_ccw_private.h              |   2 +-
 drivers/s390/crypto/ap_bus.c                     |   3 +-
 drivers/s390/crypto/vfio_ap_ops.c                |  68 +++++++-
 drivers/s390/crypto/vfio_ap_private.h            |   4 +-
 drivers/s390/net/qeth_l2_main.c                  |   3 +-
 drivers/s390/net/smsgiucv.c                      |   3 +-
 drivers/s390/net/smsgiucv_app.c                  |   3 +-
 drivers/s390/scsi/zfcp_aux.c                     |   2 +-
 drivers/tty/hvc/hvc_iucv.c                       |   7 +-
 drivers/watchdog/diag288_wdt.c                   |   7 +-
 include/uapi/linux/vfio.h                        |   1 +
 kernel/sysctl.c                                  |  18 --
 lib/raid6/s390vx.uc                              |   1 +
 net/iucv/af_iucv.c                               |   3 +-
 net/iucv/iucv.c                                  |   3 +-
 141 files changed, 1446 insertions(+), 1096 deletions(-)
 rename arch/s390/boot/{pgm_check_info.c => pgm_check.c} (66%)
 create mode 100644 arch/s390/configs/mmtypes.config
 create mode 100644 arch/s390/include/asm/machine.h
