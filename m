Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD26302CC7;
	Mon,  1 Dec 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584845; cv=none; b=GnDQFRrsMXWYSNjzwmncO14M5K5kp3lhBuEl4P1o5i/135j8GMm6zoITdIV0E0DZ2SKNvfxwsKOq3hUdcm8bqLSfL4r2g0dfYkSePlE4kLCkBV1lX1Oh0gc51NQBpz53DihKfP+sYDPO+4k7yxO/6hOsp7Xz3Tn444O5x6kuKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584845; c=relaxed/simple;
	bh=PV8zoTVIrLbtAsLF3nltdVLMpLajL5NprzZyRcaWbVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FHkYyCVkrv1lfa5t9AVPfAupP9MGrQo5N4BJneNhRCCmlxkYG90N9wZ7uiORN0o6ReAsEOKUDUDmVc5YY5sKTdIR51aCkLtTHnCb4hLRu7r4+yuI3zZSnAVReXaweA2gair0BLSuDSA5KrCU0H2gQT3x++a9mSJeBLBmlHX72N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DNb/JQaL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DNb/JQaL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUJ0Fhd003482;
	Mon, 1 Dec 2025 10:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=1rGtVzsELJIU5aF9ipeI3laLSF/Y
	QHmpu1TlhDltfZs=; b=DNb/JQaL5geJlzvISmGzca9AK9HEsW30DTmUmucZZ3dx
	ofJe2HIIeoSqKgeNKECydUmYLf1fRNNasXR0vzPxevtlM5EZdfOFs3Yn7F3EnMVV
	k22WlmpRBIli5JaZh8iXW9LidIqq1ewtk+Do/FTqEZIIMgrH1XhhRWJceqmWe3FS
	sSUYCmfMZYdJ1jklgRYbQQvnYOcSpgNiQ3zyy7Iahg1M3NgnI6fSXBqAWyKyGEEF
	yd0FL2tPXs7GUFkGLPOWNzfL/n4DgMZhJyZZPO8aexLf6bpmmrACJ63+zEH11E4V
	jsrt1MdHv/nnQFlBT+7m16JekJOPF7zJm2AAeEBxqQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg56d5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 10:27:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B19mseG010336;
	Mon, 1 Dec 2025 10:27:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnjwnek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 10:27:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1ARFcM25100866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 10:27:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B9620063;
	Mon,  1 Dec 2025 10:27:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A2B2005A;
	Mon,  1 Dec 2025 10:27:15 +0000 (GMT)
Received: from osiris (unknown [9.87.157.95])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Dec 2025 10:27:15 +0000 (GMT)
Date: Mon, 1 Dec 2025 11:27:13 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.19 merge window
Message-ID: <20251201102713.22472A5b-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gDv3CU0nmiZZ0SR-IAzVznZ9qTughVnk
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692d6d88 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=f1sgFQxEVLTTBC6CUjMA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXwuEukMIvYP3z
 9Indj4E6VCaB5+KHWRv7y+I4GWzIlLhoIlZ3CW819jvhrGe71XELMV9xN/2gikXFsfevMaX9ayM
 CQWZNnO5WFm2WOUukkiFVww5g3r2qiP6/7wrrOhd40LzkRuqr/pa8mhmqFdeI8a4F7mcprG6utm
 X9CoEeNxjyYsp6ys7UFYaS4UR51Tmp1Fjx6FA4PctuR/56kaXmgVJAIXGDNTFxTQDMSlbfFArJB
 oCxCsuQp99DiZKH84Ja2gtR3T5Ot29mHkJdpiHnsCC9DT+CNatIw/As5U6xsr9ifgu2pUSGsyzY
 T70NWeKoCQ11qSzKQXahW+eqK1jMwB3HLOAiPKpVuUjniyHMndVEeQofADS9YBzJY5Akm3fJiAH
 59eRoqRiWsPCh1/sMgTiVvJ0tDrx5Q==
X-Proofpoint-GUID: gDv3CU0nmiZZ0SR-IAzVznZ9qTughVnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

Hi Linus,

please pull s390 updates for the 6.19 merge window.

Note that there will be two merge conflicts:

- The new s390 system call table format conflicts with the introduction of the
  new listns system call from the vfs namespace tree

- Removal of two memory hotplug states conflicts with the conversion of memory
  hotplug states from macros to enums from the mm tree.
  The merge conflict resolution can be found here:
  https://lore.kernel.org/all/20251103100750.4522060e@canb.auug.org.au/

Thanks,
Heiko

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-1

for you to fetch changes up to 283f90b50de077970c429e5b9b2745d5e94a5a45:

  watchdog: diag288_wdt: Remove KMSG_COMPONENT macro (2025-11-26 17:34:52 +0100)

----------------------------------------------------------------
s390 updates for 6.19 merge window

- Provide a new interface for dynamic configuration and deconfiguration of
  hotplug memory, allowing with and without memmap_on_memory support. This
  makes the way memory hotplug is handled on s390 much more similar to
  other architectures

- Remove compat support. There shouldn't be any compat user space around
  anymore, therefore get rid of a lot of code which also doesn't need to be
  tested anymore

- Add stackprotector support. GCC 16 will get new compiler options, which
  allow to generate code required for kernel stackprotector support

- Merge pai_crypto and pai_ext PMU drivers into a new driver. This removes
  a lot of duplicated code. The new driver is also extendable and allows
  to support new PMUs

- Add driver override support for AP queues

- Rework and extend zcrypt and AP trace events to allow for tracing of
  crypto requests

- Support block sizes larger than 65535 bytes for CCW tape devices

- Since the rework of the virtual kernel address space the module area and
  the kernel image are within the same 4GB area. This eliminates the need
  of weak per cpu variables. Get rid of ARCH_MODULE_NEEDS_WEAK_PER_CPU

- Various other small improvements and fixes

----------------------------------------------------------------
Aleksei Nikiforov (1):
      s390/fpu: Fix false-positive kmsan report in fpu_vstl()

Bo Liu (1):
      s390: Fix double word in comments

Gerd Bayer (1):
      s390/pci: Highlight failure to enable PCI function

Harald Freudenberger (8):
      s390/zcrypt: Rework zcrypt request and reply trace event definition
      s390/ap: Extend struct ap_queue_status with some convenience fields
      s390/ap: Introduce new AP nqap and dqap trace events
      s390/ap: Expose ap_bindings_complete_count counter via sysfs
      s390/ap: Use all-bits-one apmask/aqmask for vfio in_use() checks
      s390/ap: Support driver_override for AP queue devices
      s390/ap: Rename mutex ap_perms_mutex to ap_attr_mutex
      s390/ap: Restrict driver_override versus apmask and aqmask use

Heiko Carstens (40):
      s390/early: Use scnprintf() instead of sprintf()
      s390/cio: Use scnprintf() instead of sprintf()
      s390/dcss: Use scnprintf() instead of sprintf()
      s390/tape: Use scnprintf() instead of sprintf()
      s390/con3270: Use scnprintf() instead of sprintf()
      Merge branch 'memory-hotplug'
      Merge branch 'tape-block-sizes'
      Merge branch 'ap-bus-trace-events'
      s390/smp: Fix fallback CPU detection
      s390/ap: Don't leak debug feature files if AP instructions are not available
      s390: Add Dat-Enhancement facility 1 to architecture level set
      s390/mm: Remove cpu_has_idte()
      s390/mm: Replace the CSP instruction with CSPG
      Merge branch 'dat-enhancement-1'
      Merge branch 'pai-pmu-merge'
      s390/mm: Remove unused flush_tlb()
      s390/mm: Change comment and die() message if teid.b61 is zero
      s390/mm: Let dump_fault_info() print additional information
      s390/processor: Add __forward_psw() helper
      s390/uprobes: Use __forward_psw() instead of private implementation
      s390/fault: Print unmodified PSW address on protection exception
      s390/ptrace: Rename psw_t32 to psw32_t
      s390/kvm: Use psw32_t instead of psw_compat_t
      s390/syscalls: Add pt_regs parameter to SYSCALL_DEFINE0() syscall wrapper
      tools: Remove s390 compat support
      s390: Remove compat support
      s390/uapi: Remove 31 bit support from uapi header files
      s390/syscalls: Remove system call table pointer from thread_struct
      s390/syscalls: Switch to generic system call table generation
      Merge branch 'compat-removal'
      Merge branch 'ap-driver-override' into features
      s390/percpu: Get rid of ARCH_MODULE_NEEDS_WEAK_PER_CPU
      s390: Remove KMSG_COMPONENT macro
      s390/modules: Simplify module_finalize() slightly
      s390: Add stackprotector support
      s390: Rename head64.S to head.S
      s390/vdso: Rename vdso64 to vdso
      s390/vdso: Get rid of -m64 flag handling
      s390/entry: Use lay instead of aghik
      watchdog: diag288_wdt: Remove KMSG_COMPONENT macro

Jan Höppner (8):
      s390/tape: Remove count parameter from read/write_block functions
      s390/tape: Remove 34xx Read Opposite error recovery
      s390/tape: Remove 3590 Read Opposite error recovery
      s390/tape: Remove extra CCW allocation for error recovery
      s390/tape: Fix return value of ccw helper functions
      s390/tape: Move idal allocation to core functions
      s390/tape: Introduce idal buffer array
      s390/tape: Add support for bigger block sizes

Jens Remus (2):
      s390/ptrace: Explicitly include <linux/typecheck.h>
      s390/vdso: Use common STABS_DEBUG and DWARF_DEBUG macros

Josephine Pfeiffer (4):
      s390/cmm: Replace sprintf() with scnprintf() for buffer safety
      s390/extmem: Replace sprintf() with snprintf() for buffer safety
      s390/sysinfo: Replace sprintf() with snprintf() for buffer safety
      s390/ptdump: Use seq_puts() in pt_dump_seq_puts() macro

Mete Durlu (1):
      s390/hiperdispatch: Decrease steal time threshold

Peter Oberparleiter (1):
      s390/debug: Update description of resize operation

Sumanth Korikkar (5):
      s390/mm: Support removal of boot-allocated virtual memory map
      s390/sclp: Add support for dynamic (de)configuration of memory
      s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
      mm/memory_hotplug: Remove MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
      s390/sclp_mem: Consider global memory_hotplug.memmap_on_memory setting

Thomas Richter (25):
      s390/pai_crypto: Adjust paicrypt_copy() return statement
      s390/pai_crypto: Rename variable cfm_dbg
      s390/pai_crypto: Rename member paicrypt_map::page
      s390/pai_crypto: Rename structure paicrypt_mapptr to pai_mapptr
      s390/pai_crypto: Rename structure paicrypt_map to pai_map
      s390/pai_crypto: Rename structure paicrypt_root
      s390/pai_crypto: Rename paicrypt_root_alloc() and paicrypt_root_free()
      s390/pai_crypto: Add PAI crypto characteristics table for parameters
      s390/pai_crypto: Introduce generic event init using pai_pmu[]
      s390/pai_crypto: Rename some function for common usage.
      s390/pai_crypto: Rename paicrypt_getdata() to pai_getdata()
      s390/pai_crypto: Rename paicrypt_getctr() to pai_getctr()
      s390/pai_crypto: Rename paicrypt_have_samples() to pai_have_samples()
      s390/pai_crypto: Unify sample push logic and update context handling
      s390/pai_crypto: Add common pai_read() function
      s390/pai_crypto: Add common pai_start() function
      s390/pai_crypto: Add common pai_add() function
      s390/pai_crypto: Add common pai_stop() function
      s390/pai_crypto: Add common pai_del() function
      s390/pai_crypto: Rename paicrypt_copy() to pai_copy()
      s390/pai_crypto: Make pai_root per-PMU and unify naming
      s390/pai_crypto: Introduce PAI crypto specific event delete function
      s390/pai_crypto: Merge pai_ext PMU into pai_crypto
      s390/pai: Rename perf_pai_crypto.c to perf_pai.c
      s390/pai: Calculate size of reserved PAI extension control block area

Thorsten Blum (2):
      s390/nmi: Annotate s390_handle_damage() with __noreturn
      s390/smp: Mark pcpu_delegate() and smp_call_ipl_cpu() as __noreturn

 Documentation/arch/s390/s390dbf.rst                |    5 +-
 arch/s390/Kconfig                                  |   21 +-
 arch/s390/Makefile                                 |   14 +-
 arch/s390/appldata/appldata_base.c                 |    3 +-
 arch/s390/appldata/appldata_os.c                   |    3 +-
 arch/s390/boot/Makefile                            |    1 +
 arch/s390/boot/boot.h                              |    4 +
 arch/s390/boot/ipl_data.c                          |    3 +-
 arch/s390/boot/ipl_parm.c                          |    6 +
 arch/s390/boot/stackprotector.c                    |    6 +
 arch/s390/boot/startup.c                           |    8 +
 arch/s390/configs/compat.config                    |    3 -
 arch/s390/crypto/aes_s390.c                        |    3 +-
 arch/s390/crypto/hmac_s390.c                       |    3 +-
 arch/s390/crypto/paes_s390.c                       |    3 +-
 arch/s390/crypto/phmac_s390.c                      |    3 +-
 arch/s390/crypto/prng.c                            |    3 +-
 arch/s390/hypfs/hypfs_diag.c                       |    3 +-
 arch/s390/hypfs/hypfs_diag_fs.c                    |    3 +-
 arch/s390/hypfs/hypfs_sprp.c                       |    6 +-
 arch/s390/hypfs/inode.c                            |    3 +-
 arch/s390/include/asm/ap.h                         |   30 +-
 arch/s390/include/asm/arch-stackprotector.h        |   25 +
 arch/s390/include/asm/cio.h                        |    2 +
 arch/s390/include/asm/compat.h                     |  140 ---
 arch/s390/include/asm/cpufeature.h                 |    1 -
 arch/s390/include/asm/elf.h                        |   47 +-
 arch/s390/include/asm/fpu-insn.h                   |    3 +
 arch/s390/include/asm/ftrace.h                     |   19 +-
 arch/s390/include/asm/idals.h                      |   76 ++
 arch/s390/include/asm/lowcore.h                    |    3 +-
 arch/s390/include/asm/pai.h                        |    1 +
 arch/s390/include/asm/percpu.h                     |    8 -
 arch/s390/include/asm/pgtable.h                    |   19 +-
 arch/s390/include/asm/processor.h                  |   22 +-
 arch/s390/include/asm/ptrace.h                     |    5 +-
 arch/s390/include/asm/seccomp.h                    |    5 -
 arch/s390/include/asm/smp.h                        |    2 +-
 arch/s390/include/asm/stackprotector.h             |   16 +
 arch/s390/include/asm/syscall.h                    |   19 +-
 arch/s390/include/asm/syscall_wrapper.h            |   95 +-
 arch/s390/include/asm/thread_info.h                |    2 -
 arch/s390/include/asm/tlbflush.h                   |   13 +-
 arch/s390/include/asm/trace/ap.h                   |   87 ++
 arch/s390/include/asm/trace/zcrypt.h               |   44 +-
 arch/s390/include/asm/unistd.h                     |    8 +-
 arch/s390/include/asm/vdso-symbols.h               |   12 +-
 arch/s390/include/uapi/asm/bitsperlong.h           |    4 -
 arch/s390/include/uapi/asm/ipcbuf.h                |    3 -
 arch/s390/include/uapi/asm/posix_types.h           |   13 -
 arch/s390/include/uapi/asm/ptrace.h                |  124 --
 arch/s390/include/uapi/asm/sigcontext.h            |   15 -
 arch/s390/include/uapi/asm/stat.h                  |   70 --
 arch/s390/include/uapi/asm/unistd.h                |    4 -
 arch/s390/kernel/Makefile                          |   12 +-
 arch/s390/kernel/asm-offsets.c                     |    4 +
 arch/s390/kernel/audit.c                           |   16 -
 arch/s390/kernel/audit.h                           |   16 -
 arch/s390/kernel/compat_audit.c                    |   48 -
 arch/s390/kernel/compat_linux.c                    |  289 -----
 arch/s390/kernel/compat_linux.h                    |  101 --
 arch/s390/kernel/compat_ptrace.h                   |   64 -
 arch/s390/kernel/compat_signal.c                   |  420 -------
 arch/s390/kernel/cpacf.c                           |    3 +-
 arch/s390/kernel/cpcmd.c                           |    3 +-
 arch/s390/kernel/debug.c                           |    3 +-
 arch/s390/kernel/dis.c                             |   17 +-
 arch/s390/kernel/dumpstack.c                       |    8 +-
 arch/s390/kernel/early.c                           |   21 +-
 arch/s390/kernel/entry.S                           |   25 +-
 arch/s390/kernel/{head64.S => head.S}              |    0
 arch/s390/kernel/hiperdispatch.c                   |    5 +-
 arch/s390/kernel/module.c                          |   21 +-
 arch/s390/kernel/nmi.c                             |    3 +-
 arch/s390/kernel/os_info.c                         |    3 +-
 arch/s390/kernel/perf_cpum_cf.c                    |    6 +-
 arch/s390/kernel/perf_cpum_sf.c                    |    7 +-
 arch/s390/kernel/perf_event.c                      |    4 +-
 arch/s390/kernel/perf_pai.c                        | 1230 ++++++++++++++++++++
 arch/s390/kernel/perf_pai_crypto.c                 |  843 --------------
 arch/s390/kernel/perf_pai_ext.c                    |  756 ------------
 arch/s390/kernel/perf_regs.c                       |    3 -
 arch/s390/kernel/process.c                         |    9 +-
 arch/s390/kernel/processor.c                       |    3 +-
 arch/s390/kernel/ptrace.c                          |  524 ---------
 arch/s390/kernel/setup.c                           |    6 +-
 arch/s390/kernel/signal.c                          |   27 +-
 arch/s390/kernel/smp.c                             |   15 +-
 arch/s390/kernel/stackprotector.c                  |  156 +++
 arch/s390/kernel/stacktrace.c                      |    3 -
 arch/s390/kernel/sthyi.c                           |    2 +-
 arch/s390/kernel/syscall.c                         |   12 +-
 arch/s390/kernel/syscalls/Makefile                 |   58 +-
 arch/s390/kernel/syscalls/syscall.tbl              |  856 +++++++-------
 arch/s390/kernel/syscalls/syscalltbl               |  232 ----
 arch/s390/kernel/sysinfo.c                         |    2 +-
 arch/s390/kernel/time.c                            |    3 +-
 arch/s390/kernel/topology.c                        |    3 +-
 arch/s390/kernel/uprobes.c                         |   13 +-
 arch/s390/kernel/uv.c                              |    3 +-
 arch/s390/kernel/vdso.c                            |   36 +-
 arch/s390/kernel/{vdso32 => vdso}/.gitignore       |    2 +-
 arch/s390/kernel/vdso/Makefile                     |   76 ++
 .../kernel/{vdso64 => vdso}/gen_vdso_offsets.sh    |    2 +-
 arch/s390/kernel/{vdso64 => vdso}/getcpu.c         |    0
 arch/s390/kernel/{vdso32 => vdso}/note.S           |    0
 arch/s390/kernel/{vdso64 => vdso}/vdso.h           |    6 +-
 .../{vdso64/vdso64.lds.S => vdso/vdso.lds.S}       |   43 +-
 .../vdso64_generic.c => vdso/vdso_generic.c}       |    0
 .../kernel/{vdso64 => vdso}/vdso_user_wrapper.S    |    0
 .../vdso32_wrapper.S => vdso/vdso_wrapper.S}       |    8 +-
 .../kernel/{vdso64 => vdso}/vgetrandom-chacha.S    |    0
 arch/s390/kernel/{vdso64 => vdso}/vgetrandom.c     |    0
 arch/s390/kernel/vdso32/Makefile                   |   64 -
 arch/s390/kernel/vdso32/gen_vdso_offsets.sh        |   15 -
 arch/s390/kernel/vdso32/vdso32.lds.S               |  140 ---
 arch/s390/kernel/vdso32/vdso_user_wrapper.S        |   22 -
 arch/s390/kernel/vdso64/.gitignore                 |    2 -
 arch/s390/kernel/vdso64/Makefile                   |   79 --
 arch/s390/kernel/vdso64/note.S                     |   13 -
 arch/s390/kernel/vdso64/vdso64_wrapper.S           |   15 -
 arch/s390/kernel/vmlinux.lds.S                     |   13 +
 arch/s390/kvm/interrupt.c                          |    3 +-
 arch/s390/kvm/kvm-s390.c                           |    3 +-
 arch/s390/kvm/priv.c                               |    2 +-
 arch/s390/mm/cmm.c                                 |    4 +-
 arch/s390/mm/dump_pagetables.c                     |    2 +-
 arch/s390/mm/extmem.c                              |   17 +-
 arch/s390/mm/fault.c                               |   29 +-
 arch/s390/mm/gmap.c                                |   28 +-
 arch/s390/mm/hugetlbpage.c                         |    3 +-
 arch/s390/mm/mmap.c                                |    1 -
 arch/s390/mm/pageattr.c                            |    4 +-
 arch/s390/mm/pgalloc.c                             |    2 +
 arch/s390/mm/pgtable.c                             |   14 +-
 arch/s390/mm/vmem.c                                |   21 +-
 arch/s390/net/bpf_jit_comp.c                       |    3 +-
 arch/s390/pci/pci.c                                |    3 +-
 arch/s390/pci/pci_bus.c                            |    7 +-
 arch/s390/pci/pci_clp.c                            |    7 +-
 arch/s390/pci/pci_debug.c                          |    3 +-
 arch/s390/pci/pci_event.c                          |    3 +-
 arch/s390/pci/pci_iov.c                            |    3 +-
 arch/s390/pci/pci_irq.c                            |    3 +-
 arch/s390/pci/pci_report.c                         |    3 +-
 arch/s390/pci/pci_sysfs.c                          |    3 +-
 arch/s390/tools/gen_facilities.c                   |    1 +
 drivers/base/memory.c                              |   23 +-
 drivers/char/hw_random/s390-trng.c                 |    3 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |    3 +-
 drivers/s390/block/dasd.c                          |    1 -
 drivers/s390/block/dasd_eckd.c                     |   11 -
 drivers/s390/block/dasd_fba.c                      |    1 -
 drivers/s390/block/dasd_ioctl.c                    |    6 +-
 drivers/s390/block/dcssblk.c                       |    7 +-
 drivers/s390/block/scm_blk.c                       |    3 +-
 drivers/s390/block/scm_drv.c                       |    3 +-
 drivers/s390/char/con3270.c                        |   21 +-
 drivers/s390/char/diag_ftp.c                       |    3 +-
 drivers/s390/char/fs3270.c                         |    7 +-
 drivers/s390/char/hmcdrv_cache.c                   |    3 +-
 drivers/s390/char/hmcdrv_dev.c                     |    3 +-
 drivers/s390/char/hmcdrv_ftp.c                     |    3 +-
 drivers/s390/char/hmcdrv_mod.c                     |    3 +-
 drivers/s390/char/monreader.c                      |    3 +-
 drivers/s390/char/monwriter.c                      |    3 +-
 drivers/s390/char/sclp_ap.c                        |    3 +-
 drivers/s390/char/sclp_cmd.c                       |    3 +-
 drivers/s390/char/sclp_config.c                    |    3 +-
 drivers/s390/char/sclp_cpi_sys.c                   |    3 +-
 drivers/s390/char/sclp_ctl.c                       |   12 +-
 drivers/s390/char/sclp_early.c                     |    3 +-
 drivers/s390/char/sclp_ftp.c                       |    3 +-
 drivers/s390/char/sclp_mem.c                       |  292 +++--
 drivers/s390/char/sclp_ocf.c                       |    3 +-
 drivers/s390/char/sclp_pci.c                       |    3 +-
 drivers/s390/char/sclp_sd.c                        |    3 +-
 drivers/s390/char/sclp_sdias.c                     |    3 +-
 drivers/s390/char/tape.h                           |   21 +-
 drivers/s390/char/tape_34xx.c                      |   31 +-
 drivers/s390/char/tape_3590.c                      |   92 +-
 drivers/s390/char/tape_char.c                      |  142 +--
 drivers/s390/char/tape_class.c                     |    3 +-
 drivers/s390/char/tape_core.c                      |   38 +-
 drivers/s390/char/tape_proc.c                      |    3 +-
 drivers/s390/char/tape_std.c                       |   83 +-
 drivers/s390/char/tape_std.h                       |    9 +-
 drivers/s390/char/vmcp.c                           |    7 +-
 drivers/s390/char/vmlogrdr.c                       |    3 +-
 drivers/s390/char/vmur.c                           |    3 +-
 drivers/s390/char/zcore.c                          |    3 +-
 drivers/s390/cio/blacklist.c                       |    3 +-
 drivers/s390/cio/ccwgroup.c                        |    6 +-
 drivers/s390/cio/ccwreq.c                          |    3 +-
 drivers/s390/cio/chp.c                             |    5 +-
 drivers/s390/cio/chsc.c                            |   13 +-
 drivers/s390/cio/chsc_sch.c                        |    7 +-
 drivers/s390/cio/cio.c                             |    5 +-
 drivers/s390/cio/cio_inject.c                      |    3 +-
 drivers/s390/cio/cmf.c                             |    3 +-
 drivers/s390/cio/css.c                             |    3 +-
 drivers/s390/cio/device.c                          |    3 +-
 drivers/s390/cio/device_status.c                   |    2 +-
 drivers/s390/crypto/ap_bus.c                       |  196 +++-
 drivers/s390/crypto/ap_bus.h                       |    5 +-
 drivers/s390/crypto/ap_card.c                      |    3 +-
 drivers/s390/crypto/ap_queue.c                     |   75 +-
 drivers/s390/crypto/pkey_api.c                     |    3 +-
 drivers/s390/crypto/pkey_base.c                    |    3 +-
 drivers/s390/crypto/pkey_cca.c                     |    3 +-
 drivers/s390/crypto/pkey_ep11.c                    |    3 +-
 drivers/s390/crypto/pkey_pckmo.c                   |    3 +-
 drivers/s390/crypto/pkey_sysfs.c                   |    3 +-
 drivers/s390/crypto/pkey_uv.c                      |    3 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |   14 +-
 drivers/s390/crypto/zcrypt_api.c                   |  257 +---
 drivers/s390/crypto/zcrypt_card.c                  |    1 -
 drivers/s390/crypto/zcrypt_ccamisc.c               |    3 +-
 drivers/s390/crypto/zcrypt_ep11misc.c              |    3 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |    3 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |    3 +-
 drivers/s390/crypto/zcrypt_queue.c                 |    1 -
 drivers/s390/net/ctcm_fsms.c                       |    3 +-
 drivers/s390/net/ctcm_main.c                       |    3 +-
 drivers/s390/net/ctcm_mpc.c                        |    3 +-
 drivers/s390/net/ctcm_sysfs.c                      |    3 +-
 drivers/s390/net/ism_drv.c                         |    3 +-
 drivers/s390/net/qeth_core_main.c                  |    7 +-
 drivers/s390/net/qeth_core_sys.c                   |    3 +-
 drivers/s390/net/qeth_ethtool.c                    |    3 +-
 drivers/s390/net/qeth_l2_main.c                    |    3 +-
 drivers/s390/net/qeth_l3_main.c                    |    3 +-
 drivers/s390/net/smsgiucv_app.c                    |    5 +-
 drivers/s390/scsi/zfcp_aux.c                       |    3 +-
 drivers/s390/scsi/zfcp_ccw.c                       |    3 +-
 drivers/s390/scsi/zfcp_dbf.c                       |    3 +-
 drivers/s390/scsi/zfcp_erp.c                       |    3 +-
 drivers/s390/scsi/zfcp_fc.c                        |    3 +-
 drivers/s390/scsi/zfcp_fsf.c                       |    3 +-
 drivers/s390/scsi/zfcp_qdio.c                      |    3 +-
 drivers/s390/scsi/zfcp_scsi.c                      |    3 +-
 drivers/s390/scsi/zfcp_sysfs.c                     |    3 +-
 drivers/watchdog/diag288_wdt.c                     |    3 +-
 include/linux/memory.h                             |    9 -
 include/linux/memory_hotplug.h                     |   18 +-
 include/linux/memremap.h                           |    1 -
 include/linux/percpu-defs.h                        |    2 +-
 mm/memory_hotplug.c                                |   17 +-
 mm/sparse.c                                        |    3 +-
 tools/arch/s390/include/uapi/asm/bitsperlong.h     |    4 -
 tools/include/nolibc/arch-s390.h                   |    5 -
 tools/include/nolibc/arch.h                        |    2 +-
 tools/lib/bpf/libbpf.c                             |    4 -
 tools/lib/bpf/usdt.c                               |    2 -
 tools/testing/selftests/nolibc/Makefile.nolibc     |    5 -
 tools/testing/selftests/nolibc/run-tests.sh        |    6 +-
 tools/testing/selftests/rseq/rseq-s390.h           |   39 -
 tools/testing/selftests/vDSO/vdso_config.h         |    4 -
 258 files changed, 3135 insertions(+), 6188 deletions(-)
 create mode 100644 arch/s390/boot/stackprotector.c
 delete mode 100644 arch/s390/configs/compat.config
 create mode 100644 arch/s390/include/asm/arch-stackprotector.h
 delete mode 100644 arch/s390/include/asm/compat.h
 create mode 100644 arch/s390/include/asm/stackprotector.h
 create mode 100644 arch/s390/include/asm/trace/ap.h
 delete mode 100644 arch/s390/kernel/audit.h
 delete mode 100644 arch/s390/kernel/compat_audit.c
 delete mode 100644 arch/s390/kernel/compat_linux.c
 delete mode 100644 arch/s390/kernel/compat_linux.h
 delete mode 100644 arch/s390/kernel/compat_ptrace.h
 delete mode 100644 arch/s390/kernel/compat_signal.c
 rename arch/s390/kernel/{head64.S => head.S} (100%)
 create mode 100644 arch/s390/kernel/perf_pai.c
 delete mode 100644 arch/s390/kernel/perf_pai_crypto.c
 delete mode 100644 arch/s390/kernel/perf_pai_ext.c
 create mode 100644 arch/s390/kernel/stackprotector.c
 delete mode 100755 arch/s390/kernel/syscalls/syscalltbl
 rename arch/s390/kernel/{vdso32 => vdso}/.gitignore (78%)
 create mode 100644 arch/s390/kernel/vdso/Makefile
 rename arch/s390/kernel/{vdso64 => vdso}/gen_vdso_offsets.sh (82%)
 rename arch/s390/kernel/{vdso64 => vdso}/getcpu.c (100%)
 rename arch/s390/kernel/{vdso32 => vdso}/note.S (100%)
 rename arch/s390/kernel/{vdso64 => vdso}/vdso.h (80%)
 rename arch/s390/kernel/{vdso64/vdso64.lds.S => vdso/vdso.lds.S} (64%)
 rename arch/s390/kernel/{vdso64/vdso64_generic.c => vdso/vdso_generic.c} (100%)
 rename arch/s390/kernel/{vdso64 => vdso}/vdso_user_wrapper.S (100%)
 rename arch/s390/kernel/{vdso32/vdso32_wrapper.S => vdso/vdso_wrapper.S} (64%)
 rename arch/s390/kernel/{vdso64 => vdso}/vgetrandom-chacha.S (100%)
 rename arch/s390/kernel/{vdso64 => vdso}/vgetrandom.c (100%)
 delete mode 100644 arch/s390/kernel/vdso32/Makefile
 delete mode 100755 arch/s390/kernel/vdso32/gen_vdso_offsets.sh
 delete mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso_user_wrapper.S
 delete mode 100644 arch/s390/kernel/vdso64/.gitignore
 delete mode 100644 arch/s390/kernel/vdso64/Makefile
 delete mode 100644 arch/s390/kernel/vdso64/note.S
 delete mode 100644 arch/s390/kernel/vdso64/vdso64_wrapper.S
