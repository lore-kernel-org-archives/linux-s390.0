Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676635C18D;
	Tue, 27 Jan 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527200; cv=none; b=hQjb5L6nr/BVPE9W6iEDjPlAxbcwtLm+Q6/N/bmE7dL+povaR8hCgvInLg8o89QoinvDOvTMFxjlHtvsWgPv7joyK8gbI2NjOHTp249jMXhQsRFVq31jpout0AF7LRn/NdvhU9u3MDSq8hfeJcWDybxtYFSWelty5ULWM2RK9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527200; c=relaxed/simple;
	bh=BHEKZDQxtcLcu8bUET63iG6q8QRsMhEumZx0xuCs+OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WcYqxzF55BIzmO8YloqhGWX0Q7qQe7y/Odh2fkuy0jZLf0T02x6nVLvkT7pyj3/xFMChGLXEFBVLQroPfFUrJ5gjjS3vZizQUGxP8ZsmDVQxTvQw2LqXfkSVON3Rwf1r44ZZjC5tgyEkJK7Yx1pZ/A8WaG4FOmTtYNfuCPA+ZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=miPhskHb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="miPhskHb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7KbEu030003;
	Tue, 27 Jan 2026 15:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HU28TJxOZUTuTrzCbvdp1PjK5mZZ
	o7h2HeqeaLDoNG8=; b=miPhskHbJCmPnYjp9JT3KcBubgY9PBPW6KjnaK5mSeGw
	eZky4kw39KgUl4rhLdX3O+MbhPy2VLTEcbMj2OsqULWEMyn2npUQa9F/NlYW88bQ
	gDMaJDyUPQXa65HGYX6JTShPieQSW3pYB+D8yTZXOxvklK1OGfN9n4h0e4Btlox7
	DcsRwMrpWUVEvTUWzoeFe8WpX8R4HHocDEMSUpBCGHd76wPYA5nm9UpdDeg/EVk5
	4csKHpf7G3VjubWzy6zzesTuZZ85i8te9JxI302uv65GafYukjS0Kyt2QOFuVJA0
	MPkVxmoHBAVMc3sJHa4GDMKw+dkxHnzQcz3Q+OiMZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr648wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFF5oJ020529;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr648wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDWopW019844;
	Tue, 27 Jan 2026 15:19:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn153x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJVKv48103758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ECA120043;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA7920040;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 00/12] s390: SFrame user space unwinding
Date: Tue, 27 Jan 2026 16:19:13 +0100
Message-ID: <20260127151926.2805123-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX/blPfXEok/94
 g2rpp3lCRHGNmL+Na2QIAIF88+axmMpwOeYt1HQRpzCiuqT0OUxTe9KxtnZS8QQoUQAQ7JMaQbe
 jy6UWfRzd1gWgNF7xum7f986e+Jk2lGLW0NHbkaiSCKSD7A4X1uMMfCWNE8talSS0CjcwlQ2kF+
 hVNuF6arh27Irv/UBwC7mdlrS4cjvDds465YXOq95sCyNFk9IOgzkylV9DKSITwIe3t6Os7cG5m
 qAtZoSmmAACsmmoj53lQj4iQvXxUL87r8wXMHdHcinuWRjQFTU69RLnX1eUWpBxW9mYFf8alOQk
 epVqY2zDYzKY0O5tmGNnzrsiIvepDqT+k2FRQhKX2tFh+XZ8zvcOUKanQrC9VRCblV8GeYBK/EC
 Bcwz2k/1kTcA5T8NP45fKf2b/N4ASx8KTHtioD3Scu7yld6GeTy4fUa6SYaZtmtd7E2ZVXJK5b8
 msTrvA15ROoT9NeL1GQ==
X-Proofpoint-GUID: 245I_JxzFyitRqhZncf6CXB-w6LGeMzh
X-Proofpoint-ORIG-GUID: SZen1Lwiy8UVy_11q9XW2X_Ecy13ls7A
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978d789 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jQNMc0NMXmn7CdNKdNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

This series adds s390 support for unwinding of user space using SFrame V3.
It is based on Josh's, Steven's, and my work (see prerequisites below).
The generic unwind user (sframe) frameworks are extended to enable
support for a few s390-particularities (see patches 5 and 6), including
unwinding of user space using back chain (see patches 10-12).


Changes in v4:
- Rebase on my user unwind sframe series v13, which provides SFrame V3
  support.

Changes in RFC v3:
- Rebase on and include my unwind user cleanup series v4, which includes
  a simplification of unwind_user_word_size() on x86. (Linus)
- Implement unwinding of user space using s390 back chain using unwind
  user fp instead of introducing a new unwind user backchain. (Josh)

Changes in RFC v2:
- Rebased on latest "unwind user" enhancements from Peter Zijlstra and
  my latest "unwind user sframe" series v12.
- Incorporated RFC v1 review feedback.
- No new config options (except for unwind user backchain).


Motivation:

On s390 unwinding using frame pointer (FP) is unsupported, because of
lack of proper s390 64-bit (s390x) ABI specification and compiler
support.  The ABI does only specify a "preferred" FP register.  Both GCC
and Clang, regardless of compiler option -fno-omit-frame-pointer, setup
the preferred FP register as late as possible, which usually is after
static stack allocation, so that the CFA cannot be deduced from the FP
without any further data, such as provided by DWARF CFI or SFrame.

In theory there is a s390-specific alternative of unwinding using
back chain (compiler option -mbackchain), but this has its own
limitations.  Ubuntu is currently the only distribution that that
builds user space with back chain.

As a consequence the Kernel stack tracer cannot unwind user space
(except if it is built with back chain).  Recording call graphs of user
space using perf is limited to stack dump sampling (i.e. perf record
--call-graph dwarf), which generates a fairly large amount of data and
has limitations.

Initial testing of recording call graphs using perf using the s390
support for SFrame provided by RFC v1 of this series shows that
data size notably improves:

perf record data size is greatly reduced (smaller perf.data):

  SFrame (--call-graph fp):
  # perf record -F 9999 --call-graph fp objdump -wdWF objdump
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 2.498 MB perf.data (10891 samples) ]

  Stack sampling (--call-graph dwarf) with a default stack size of 8192:
  # perf record -F 9999 --call-graph dwarf objdump -wdWF objdump
  [ perf record: Woken up 270 times to write data ]
  [ perf record: Captured and wrote 67.467 MB perf.data (8241 samples) ]


Prerequirements:

This series applies on top of the latest unwind user sframe series
"[PATCH v13 00/18] unwind_deferred: Implement sframe handling":
https://lore.kernel.org/all/20260127150554.2760964-1-jremus@linux.ibm.com/

Like above series it depends on the upcoming binutils 2.46 release to
be used to build executables and libraries (e.g. vDSO) with SFrame V3
on s390 (using the assembler option --gsframe-3).

The unwind user sframe series depends on a Glibc patch from Josh, that
adds support for the prctls introduced in the Kernel:
https://lore.kernel.org/all/20250122023517.lmztuocecdjqzfhc@jpoimboe/
Note that Josh's Glibc patch needs to be adjusted for the updated prctl
numbers from "[PATCH v13 18/18] unwind_user/sframe: Add prctl() interface
for registering .sframe sections":
https://lore.kernel.org/all/20260127150554.2760964-19-jremus@linux.ibm.com/


Overview:

Patch 1 aligns asm/dwarf.h to x86 asm/dwarf2.h. [*]

Patch 2 replicates Josh's x86 patch "x86/asm: Avoid emitting DWARF
CFI for non-VDSO" for s390.  [*]

Patch 3 changes the build of the vDSO on s390 to keep the function
symbols for stack tracing purposes. [*]

Patch 4 replicates Josh's patch "x86/vdso: Enable sframe generation
in VDSO" for s390.  It enables generation of SFrame V3 stack trace
information (.sframe section) for the vDSO if the assembler supports it.

Patches 5 and 6 enable the generic unwind user (sframe) frameworks to
support the following s390 particularities:

- Patch 5 adds support for architectures that define their CFA as SP at
  callsite + offset.

- Patch 6 adds support for architectures that store the CFA offset
  from CFA base register (e.g. SP or FP) in SFrame encoded.  For
  instance on s390 the CFA offset is stored adjusted by -160 and
  then scaled down by 8 to enable and improve the use of signed 8-bit
  SFrame offsets (i.e. CFA, RA, and FP offset).

Patch 7 converts several s390 ptrace function macros to inline
functions. [*]

Patch 8 introduces frame_pointer() in ptrace on s390, which is a
prerequisite for enabling unwind user.

Patch 9 adds support for unwinding of user space using SFrame on
s390.  It leverages the extensions of the generic unwind user (sframe)
frameworks from patches 5 and 6, as well as the unwind user sframe
series support for SFrame V3 flexible FDEs.

Patches 10 and 11 enable unwind user (fp) to support the following s390
back chain particularities:

- Patch 10 introduces FP/RA restore rule ZERO, which enables s390
  back chain unwinding, which cannot unwind FP.

- Patch 11 enables sophisticated architecture-specific initialization
  of the FP frame, which enables s390 back chain unwinding to provide
  dynamic information.

Patch 12 adds support for unwinding of user space using back chain on
s390.  Main reasons to support back chain on s390 are:
- With Ubuntu there is a major distribution that builds user space with
  back chain.
- Java JREs, such as OpenJDK, do maintain the back chain in jitted code.


Limitations:

Unwinding of user space using back chain cannot - by design - restore
the FP.  Therefore unwinding of subsequent frames using e.g. SFrame may
fail, if the FP is the CFA base register.

Thanks and regards,
Jens

Jens Remus (12):
  s390: asm/dwarf.h should only be included in assembly files
  s390/vdso: Avoid emitting DWARF CFI for non-vDSO
  s390/vdso: Keep function symbols in vDSO
  s390/vdso: Enable SFrame V3 generation in vDSO
  unwind_user: Enable archs that define CFA = SP_callsite + offset
  unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
  s390/ptrace: Convert function macros to inline functions
  s390/ptrace: Provide frame_pointer()
  s390/unwind_user/sframe: Enable sframe unwinding on s390
  unwind_user: Introduce FP/RA recovery rule unknown
  unwind_user/fp: Use arch-specific helper to initialize FP frame
  s390/unwind_user/fp: Enable back chain unwinding of user space

 arch/Kconfig                               |   7 ++
 arch/s390/Kconfig                          |   2 +
 arch/s390/include/asm/dwarf.h              |  53 ++++++---
 arch/s390/include/asm/ptrace.h             |  43 +++++--
 arch/s390/include/asm/unwind_user.h        | 132 +++++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h |  21 ++++
 arch/s390/kernel/vdso/Makefile             |   9 +-
 arch/s390/kernel/vdso/vdso.lds.S           |   9 ++
 arch/x86/include/asm/unwind_user.h         |  21 +++-
 arch/x86/include/asm/unwind_user_sframe.h  |   2 +
 include/asm-generic/Kbuild                 |   1 +
 include/asm-generic/unwind_user_sframe.h   |  20 ++++
 include/linux/unwind_user.h                |  19 +--
 include/linux/unwind_user_types.h          |   2 +
 kernel/unwind/sframe.c                     |   5 +-
 kernel/unwind/sframe.h                     |  11 ++
 kernel/unwind/user.c                       |  31 +++--
 17 files changed, 323 insertions(+), 65 deletions(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h
 create mode 100644 include/asm-generic/unwind_user_sframe.h

-- 
2.51.0

