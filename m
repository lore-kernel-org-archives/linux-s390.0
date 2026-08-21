Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570B429038;
	Fri, 21 Aug 2026 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342031; cv=none; b=U2ypWtGot56LptJV/iCpVmhc9WGmPNna3tpl0j7sbqie0q7KKhb2OSt2I1GL8/CZG2nUM0hAvK0VIwPWlVwcm7wt3gCkNIxc/EuGYrkgZ+lZH/oRMKc9EVJvGWVQ8+IkOxZcnppxJLfGfv6MmyWNCnmRv6KvYdzMGk7ILQEUCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342031; c=relaxed/simple;
	bh=HLDzDYDqKtzySeRr7x12fUNM/gLxpIsgd9EkRV+VCrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQ13qzjwXDKr82Px/OrE3lMW10MwCo9SZo4U6/9k2w8LpsWdz1xxlBIW8YKU10rcvF7hiRz9KJiRpOQBX6MzZ0KzzvPv0fT+nqOFZCo+RadEyMZxO5qXZFD1lZ8y0yln0RdGDY+ey+Bq6RRozPK5Kp7A+CE8Vx7NchMT7vdg5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lv+EyNBi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lv+EyNBi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVf3b2387540;
	Fri, 21 Aug 2026 19:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=V5kF+kcpypEU5ZrdqZyDKp/7dO3hpsFPcjVvIUaFI
	tE=; b=lv+EyNBiJOwGMQ8WiEBzieQkBykZejY+IQQb0H0wm6awO9qXP+woHQrBV
	XtWFsYblg0VxIBWVzzsDNo0CDQuFGapkOCQ1f9QQoW+HNnjPMmEUdtEY1J3a29JC
	YBpcYPRyyVnZoIF6OCvFzyfmqsBkS7Dl+7emTnAbPLXW0M4I4nvQ9RBUsnK/DzOg
	1h70DNiTF7J06a1zwkosnNX0pUdFcRWvPmYnasmtQwH7sRISZJIYZOmsByM4INoa
	VOLIhjEDpvgWoZYU7Sl7XiGXQXFcXlGhYiiVjR09jVo1QALqcO1zyIxZOacIiBIp
	PNXuZpAR5/MMXRd9O3B1XzU19+VKQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4knrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfMOQ021134;
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpnxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr5b841746864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191332004D;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF80320043;
	Fri, 21 Aug 2026 19:53:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:04 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 00/24] unwind_user: Implement .eh_frame handling
Date: Fri, 21 Aug 2026 21:52:35 +0200
Message-ID: <20260821195259.2688377-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88aca6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=07d9gI8wAAAA:8 a=D19gQVrFAAAA:8 a=xopgQSy3GjlcGo99Of0A:9
 a=e2CUPOnPG4QKp8I52DXD:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: gVQM2b4PkalZwH05ToUY3XhzBKuB4F06
X-Proofpoint-GUID: k79t0r2N_xOu_lzI3pkROZh7cWmv7NfH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX2xHnWxkA4uRH
 wh5IzN/8Q3Rhfu+H1JoL8/iBgU2z/CW0pYAIwfn7mGSf+4QJVrEc+t7Nra7fx3LQX681aDA9e6L
 vTBNVUJ5NELul2lyfeSM9p6oDGRNy+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXz0UUsyK9CuBy
 JhVwANss2tArWhDtqxNioquLw1O7fwPfTnTmDbtHdVX9j8llQggMZCoNqu/0LsNZRrwV1aC1gJq
 s8n+fFOdwCl573pmCjv20lEb/1TnHOBQfxO6QYWB+nzADbmngsfbmhHdI4TN2cUr6uOs7q562PN
 hH0pyhNOcq0v4UX4p5WKwWsuTv9FGlYzBTp0QAz2i4FCtlEVvwYn6Op7ugtCet0bRl/g1QYq1fK
 zk8mE58RIcXQ92ai0tBw9FmY9BqdYlKuczinjj3FLu49WBb7YomHyqnC/MTzoIvBaTe++QUoij+
 9CpsTPR1iQiwMZksPNUJ9hmenU7qjA90Q0nV+YD65JWGlsZ8qrzCc5NfnoadzuhCkHkW7RVY7HA
 t16A5T0adqVwv4cbqAhwA+mBLabx4w5PtT4YOukrNXlV5MP1QMlyUlcXFD0a0LGE5TrfKHKJUR0
 cIqzIhyyNcZzU3QI7Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

This series adds support for parsing DWARF Call Frame Information (CFI)
from the .eh_frame_hdr and .eh_frame sections of user space ELF files.

The code is based on the deferred unwind user work originally done for
SFrame by Josh, Steven, and myself:

  v4 : https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
  v10: https://lore.kernel.org/all/20250827201548.448472904@kernel.org/
  v16: https://lore.kernel.org/all/20260521142546.3908498-1-jremus@linux.ibm.com/

The goal is to make user space stack traces available in-kernel without
requiring frame pointers and without copying large parts of the user
stack for later processing.

Today, reliable user stack traces from the kernel generally requires
frame pointers.  Otherwise, profilers such as perf have to copy large
amounts of user space stack into the kernel ring buffer and process it
later.  Frame pointers are simple and robust, but enabling them for
all executables and libraries has a performance cost.

Another issue is that the frame layout can vary between compilers and
architectures, and on architectures such as s390 there is no defined
frame layout which allows reliable frame-pointer based stack tracing.
The only way to perform user space profiling on there architectures is
to copy the user space into the kernel buffer.


The .eh_frame section is already emitted by most toolchains on most
architectures unless explicitly disabled.  It contains DWARF CFI
describing how to recover the caller state at any point in a function.
The .eh_frame_hdr section provides a binary search table for looking
up the Frame Description Entry (FDE) for a given instruction pointer
(IP).

Because the .eh_frame_hdr and .eh_frame sections live in the ELF file,
they need to be faulted in when used.  This means that walking the user
space stack requires being in a faultable context.  As profilers like
perf request a stack trace in interrupt or NMI context, the walking
cannot be done when requested.  This series reuses the deferred unwind
user framework, that performed the actual user stack trace is later in
a faultable context, before the task returns to user space.

This series implements .eh_frame[_hdr] support for the deferred unwind
user code and enables it for x86-64 and s390.

It intentionally not implement a complete DWARF unwinder.  It evaluates
only the subset of DWARF CFI needed for stack tracing:

  - Call Frame Address (CFA):  Using rule from DWARF CFI.

  - Stack pointer (SP):  Using an implicit rule based on the CFA
    definition (SP = CFA for most architectures).

  - Frame pointer (FP):  Using rule from DWARF CFI.

  - Return address (RA):  Using rule from DWARF CFI.

Unsupported CFI instructions, unsupported expressions, invalid data, or
user memory faults stop the stack tracing safely and results in a partial
stack trace.


This series applies on top of v7.2 tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  v7.2

The to be stack-traced user space executables and libraries need to
contain .eh_frame_hdr and .eh_frame sections as well as a GNU_EH_FRAME
PHDR.

Namhyung Kim's related perf tools deferred callchain support can be used
for testing, for example:

  perf record --call-graph fp,defer ...
  perf report
  perf script


Why .eh_frame?

This series is not meant to replace or undermine the SFrame work.
SFrame remains the simpler and more purpose-built format for user stack
tracing.  The motivation for .eh_frame support is pragmatic:  .eh_frame
is already widely deployed today.

- Availability and maturity:  .eh_frame is already present in most ELF
  binaries for C++ exception handling.  It has been used in production
  for decades for exception handling and debugger stack unwinding.

- Toolchain support:  .eh_frame is supported across all major compilers
  and architectures today, whereas .sframe adoption is still emerging.

- Size:  .sframe would be added in addition to existing .eh_frame[_hdr]
  rather than replacing it, increasing the ELF file size. [1]


Addressing historical DWARF concerns:

Using DWARF for kernel unwinding has a bad history.  Previous attempts
were complex, fragile, slow, and hard to maintain.  Hand-written
assembly and the complexity of the DWARF state machine were among the
reasons the simpler ORC kernel unwind format was developed. [2,3,4]

However, this implementation for user space stack tracing differs from
those problematic kernel unwinding attempts:

- It stack traces user space, not kernel.

- It runs in a deferred, faultable context, not in NMI, interrupt, or
  oops context.

- It may return partial stack traces.  Bad CFI, unsupported operations,
  invalid user memory, or faults are allowed to terminate the unwind.

- It implements only the CFI subset needed for stack tracing, not a
  general DWARF unwinder.

- It does not include a general-purpose DWARF expression VM.  Expression
  size is bounded.  Only a small number of pattern-matched expressions
  is supported (e.g. DRAP and PLT expressions on x86).  Unsupported
  expressions cause stack tracing to fail safely.

- All user memory access uses [unsafe_]get_user() with proper bounds
  checking and fault handling.

- Corruption detection with automatic section removal on invalid
  .eh_frame prevents further stack tracing attempts.


Limitations and future work:

- CIE version 1 support only and no DWARF64 support, as I have not run
  into either during my testing.

- Signal frames are not handled yet.  An architecture hook could support
  unwinding through FDEs whose CIE augmentation contains 'S' (signal
  frame), similar to Glibc's SFrame backtrace() support.  See also my
  "[RFC PATCH v1 0/5] s390: Signal frame user space unwinding". [5]

- x86-32, x86-x32, and 32-bit compat mode support not implemented yet.

- CIE caching would be useful.  Reading an FDE requires reading its
  referenced CIE first to obtain the FDE encoding.  Most .eh_frame
  sections have only a very small number of CIEs, often one default
  CIE shared by most FDEs and possibly one signal frame CIE.  Caching
  the last CIE per section, together with the initial CFA, FP, and RA
  rules, would avoid repeated CIE parsing and initial CFI instruction
  processing.


[1]: https://lore.kernel.org/all/CAN30aBFVDxeoXApn_g_Hw0Ayhi4V=m7CcX8UDO6ZDTi6xA-3Pg@mail.gmail.com/
[2]: https://lwn.net/Articles/727553/
[3]: https://lkml.org/lkml/2012/2/10/356
[4]: https://lkml.org/lkml/2017/5/20/165
[5]: https://lore.kernel.org/all/20260127153331.2902504-1-jremus@linux.ibm.com/


Patches 1-6 add base functionality to unwind user to support .eh_frame-
based (or .sframe-based) unwinding.  Patches originate from my latest
.sframe patch series.

Patches 7-10 add the basic infrastructure for reading .eh_frame_hdr and
.eh_frame sections and storing them in a per-mm maple tree.

Patches 11-14 wire up the eh_frame infrastructure to the unwind user
framework and add error handling and debugging support.

Patch 15 duplicates registered .eh_frame_hdr section data on clone/fork.

Patch 16 improves .eh_frame DWARF CFI instruction processing.

Patch 17 enables architectures to implement selected DWARF expressions
in CFI instructions.

Patches 18-21 enable .eh_frame unwinding on x86-64 with minimal DWARF
expression support for DRAP and PLT expressions.

Patches 22-23 enable .eh_frame unwinding on s390.

Patch 24 adds a prctl() interface for (un)registering .eh_frame_hdr
sections for shared libraries.  I will send a related test-patch for
Glibc separately.


Changes in RFC v2:
- Addressed most of Sashikos AI review feedback.
- Dropped patch that added support for linear .eh_frame search, as
  there is no good mean to limit it from reading outside of the
  .eh_frame section.
- Tweaked limits based on limited testing (still fairly arbitrary;
  needs more thought):
  - Reduced state stack depth limit to 1.
  - Added FDE length limit of 32.768 bytes.
  - Added CFI instruction limit (CIE+FDE) of 16.384 instructions.


Note that I will be away from keyboard for two weeks.  I'll reply
to your (and Sashiko AI's) feedback afterwards.


Thanks and regards,
Jens


Jens Remus (23):
  unwind_user: Add generic and arch-specific headers to MAINTAINERS
  unwind_user: Stop when reaching an outermost frame
  unwind_user: Enable archs that pass RA in a register
  unwind_user: Flexible FP/RA recovery rules
  unwind_user: Flexible CFA recovery rules
  unwind_user: Enable archs that define CFA = SP_callsite + offset
  unwind_user/eh_frame: Add support for reading .eh_frame_hdr section
  unwind_user/eh_frame: Store .eh_frame_hdr section data in per-mm maple
    tree
  unwind_user/eh_frame: Add support for reading .eh_frame section
  unwind_user/eh_frame: Detect .eh_frame_hdr sections in executables
  unwind_user/eh_frame: Wire up unwind_user to eh_frame
  unwind_user/eh_frame: Remove .eh_frame[_hdr] section on detected
    corruption
  unwind_user/eh_frame: Show file name in debug output
  unwind_user/eh_frame: Add .eh_frame[_hdr] validation option
  unwind_user/eh_frame: Duplicate registered .eh_frame[_hdr] section
    data on clone/fork
  unwind_user/eh_frame: Ignore DW_CFA_GNU_args_size
  unwind_user/eh_frame: Add support for DWARF expressions
  unwind_user/eh_frame/x86: Enable eh_frame unwinding on x86
  unwind_user/eh_frame/x86: Handle PLT expressions
  unwind_user/eh_frame/x86: Handle DRAP expressions
  s390/ptrace: Provide frame_pointer()
  unwind_user/eh_frame/s390: Enable eh_frame unwinding on s390
  unwind_user/eh_frame: Add prctl() interface for (un)registering
    .eh_frame_hdr sections

Josh Poimboeuf (1):
  x86/uaccess: Add unsafe_copy_from_user() implementation

 MAINTAINERS                                  |    5 +
 arch/Kconfig                                 |   26 +
 arch/s390/Kconfig                            |    1 +
 arch/s390/include/asm/ptrace.h               |    6 +
 arch/s390/include/asm/unwind_user.h          |   71 +
 arch/s390/include/asm/unwind_user_eh_frame.h |   24 +
 arch/x86/Kconfig                             |    1 +
 arch/x86/include/asm/mmu.h                   |    2 +-
 arch/x86/include/asm/uaccess.h               |   39 +-
 arch/x86/include/asm/unwind_user.h           |   77 +-
 arch/x86/include/asm/unwind_user_eh_frame.h  |  153 ++
 fs/binfmt_elf.c                              |   49 +-
 include/asm-generic/Kbuild                   |    1 +
 include/asm-generic/unwind_user_eh_frame.h   |   92 +
 include/linux/eh_frame.h                     |  105 ++
 include/linux/mm_types.h                     |    3 +
 include/linux/unwind_user.h                  |   20 +
 include/linux/unwind_user_eh_frame_types.h   |   41 +
 include/linux/unwind_user_types.h            |   51 +-
 include/uapi/linux/eh_frame.h                |   14 +
 include/uapi/linux/prctl.h                   |    4 +
 kernel/fork.c                                |   10 +
 kernel/sys.c                                 |   11 +
 kernel/unwind/Makefile                       |    3 +-
 kernel/unwind/eh_frame.c                     | 1657 ++++++++++++++++++
 kernel/unwind/eh_frame.h                     |   83 +
 kernel/unwind/eh_frame_debug.h               |   67 +
 kernel/unwind/user.c                         |  142 +-
 mm/init-mm.c                                 |    2 +
 mm/mmap.c                                    |    5 +
 30 files changed, 2724 insertions(+), 41 deletions(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_eh_frame.h
 create mode 100644 arch/x86/include/asm/unwind_user_eh_frame.h
 create mode 100644 include/asm-generic/unwind_user_eh_frame.h
 create mode 100644 include/linux/eh_frame.h
 create mode 100644 include/linux/unwind_user_eh_frame_types.h
 create mode 100644 include/uapi/linux/eh_frame.h
 create mode 100644 kernel/unwind/eh_frame.c
 create mode 100644 kernel/unwind/eh_frame.h
 create mode 100644 kernel/unwind/eh_frame_debug.h


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.53.0

