Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E73E0241;
	Thu,  1 Oct 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850781; cv=none; b=tGGTxj4RF1U4R+/lcylK0Hke1+//Zt63yOWh7qtSFFhBJVqaq8P2EntsZxhIlFCN8EFTs2hQyGNtvLvjvZEuMszwVMZisjJPcKX2YekeyxfQBHYcKOxnwYNX0/23nxZRa5yHhWEFTqyxWqH2hVUSztw/pFrGCnuDH4pMqSlo1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850781; c=relaxed/simple;
	bh=TpALWNbMIbHaXkCRDhGQtkGquzO2fvJ8ZlZy/+e51jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWBCnNlBFJGbTtLyjSn+oC9Vlzz6oMp3n66o7NYukiGkX3ciytQ5AML3ApZbP+6sIphQtQhwOyCWohGQoljYrM27uLQmzof1P5bwfW4YcO01DZc9d183vJCgH+4TCMbNnrK1ARreTiURxjxsIcS9cwaxo+Fyngwxc3+9R0C96pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oMLxFVx0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oMLxFVx0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175TUk4040694;
	Thu, 1 Oct 2026 10:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BN3ehrRSLetR6TViBEMlSJ1IW4l7bxLuypmmAWuHu
	dc=; b=oMLxFVx0pwvFIB3+NH3QigKPt3hShb8g1S1QiUBoTjcdc710ZSm7sWm+M
	+R/yhRptHfCjwMNu5XUP9WoxC856DoIWbGiwTrH1ruaM3U59nxFAfVUmCivH0Tcx
	4P2YNGWK6gtq1OcbmM6DzZwr8mkF/ikaMSVkmN1G+wCGITvc7Julsed+jReIe/fq
	/j1Jncil6FbZGuTzd59OMVGeVRnlNFqVEe+ycoAgSTa7I+MzP/fwYbuxm+6BeT0K
	pyj9MJTViCBxc0vUPq0doZVDqnmQwZCnXB3TrafYMjnq+TfRYFl+KrW7wmoIz1tN
	CrU5rghj76Pq1j7uYdjMbA36fUERQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfmm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172VYo520704;
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWmFo47448352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382F22004B;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E232D20043;
	Thu,  1 Oct 2026 10:32:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:47 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 00/32] s390: Improve exception table handling and disassembler
Date: Thu,  1 Oct 2026 12:32:15 +0200
Message-ID: <20261001103247.1989111-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5qd1ryUQL-RcUFIz8jIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXzT7fLIYyAQM9
 jfZw9DlrgJQbqRjYkyqsUmB3SCtuCgTEu0D7iWkJwgIU99hmcaVApzVNl3/s09uRShXB3R+4Bow
 JDjXDbIccZi4kcSOJROB0Nz1ZVyzcxw=
X-Proofpoint-ORIG-GUID: AptFFdvSi6_qmxqj1CHecoWkrUs77yVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX0lZLfDwZ338k
 HAXu393WAiKC3dKoHgKomJwey+2kNp+iTuVRGKcnRZPOcJ9P7SZK15t4EuVzWuawgms2XJb00SI
 xxCFj0b8FA4zhnRxpHo3xUindB1h6ZOY55ea0SfjwuMHXykLFKCtfuR/alANK7AEYUZkFjbKDVJ
 IL1ggDh5Ct5jGWjUlSmXUb+S9C1QD8OzE1ZRrbO4p7TwFf8rucrzI89IbzNscDWCLcsh1YH5Hjl
 RMTj/PSUBigMveXL0r2bngSYNXkumSRAi0WNbpmQDBtxFILPvSFjQ48tRjSrVLzqQG0GAf0scbk
 AXa5wvufGStCeJs7ua0CdjE7qFnliPDPqPbvF+h3c+b3RtF50DPPMFTMqSvKMFMM9Pl/9X8AtRV
 hBOEqShbNqe2rZ2Ta6xKTL0FbT7lGKmzLjru+UvdNF31u/frdSLtIXNhrZl28y74RYX/XbDctJr
 WKx9jl0tK4XNgD39jKw==
X-Proofpoint-GUID: AptFFdvSi6_qmxqj1CHecoWkrUs77yVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Extend the existing get_trap_ip() so that it returns the address of
the instruction which caused an exception, and use that for both the
disassembler as well as exception handling.

This allows improving two things:

- The in kernel disassembler prints PGM+PSW markers which clearly
  identify the instruction causing an exception, and the current PSW
  address. This replaces the previous "best guess" approach with '*' and
  '>' markers

- EX_TABLE entries for inline assemblies are simplified. Only the address
  of the faulting instruction needs to be provided from now on. The second
  entry, which is the address following the faulting instruction, is not
  needed anymore

Disassembler
------------

The output of the kernel disassembler changes. If the disassembly is
printed as a result of a program check, 'PGM' and 'PSW' markers identify
the instruction which caused the exception, and where the PSW points
to. For suppressing exceptions, the output now looks like this:

 Krnl Code:
            000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
       PGM >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
       PSW >000003ff8dc7c004: a7280000     lhi     %r2,0
            000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)

For nullifying exceptions where both addresses are the same,
'PGM+PSW >' is printed instead:

 Krnl Code:
            000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
   PGM+PSW >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
            000003ff8dc7c004: a7280000     lhi     %r2,0
            000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)

EX_TABLE entries
----------------

With get_trap_ip() now returning the exact faulting instruction address,
EX_TABLE entries for inline assemblies are simplified. Only the address
of the faulting instruction needs to be provided. The second entry - the
address following the faulting instruction - is no longer needed.

For example, an inline assembly using a single instruction can now be
written as:

        asm_inline volatile(
                "0:     lg      %[data],%[addr]\n"
                "1:\n"
                EX_TABLE_INSN(0b, 1b));

Previously this required:

        asm_inline volatile(
                "       nopr    %%r7\n"
                "0:     lg      %[data],%[addr]\n"
                "1:     nopr    %%r7\n"
                EX_TABLE(0b, 1b)
                EX_TABLE(1b, 1b));

The old approach had several non-obvious restrictions:

- If an instruction immediately preceding the inline assembly caused a
  non-nullifying exception, the PSW would point to the start of the
  inline assembly. If the faulting instruction was placed there, the
  exception handler would incorrectly resolve the fault using the inline
  assembly's fixup handler.  Hence, a leading NOP was required before the
  faulting instruction

- Similarly, an exception table entry placed behind a faulting
  instruction must also point to an instruction that cannot fault. A
  nullifying exception on the following instruction would otherwise be
  incorrectly resolved by that entry

- Furthermore, instructions that can cause both nullifying and
  non-nullifying exceptions required two separate exception table entries

These restrictions are error-prone and have caused several bugs in the
past.

All EX_TABLE* macros have been renamed to EX_TABLE_INSN*. This allows the
old and new semantics to be distinguished, and ensures that backports of
code using the new semantics will intentionally fail to compile if the
new infrastructure is not present.

Note
----

There are some existing oddities and corner cases with kprobes. Only
some of them will be addressed with this series. The other ones will
be addressed with follow-on changes, since this series is already
large enough.

Thanks,
Heiko

Heiko Carstens (32):
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

 arch/s390/boot/ipl_parm.c                     |   6 +-
 arch/s390/boot/pgm_check.c                    |  14 ++-
 arch/s390/boot/physmem_info.c                 |  18 +--
 arch/s390/boot/startup.c                      |  12 +-
 arch/s390/hypfs/hypfs_vm.c                    |   6 +-
 arch/s390/include/asm/Kbuild                  |   1 +
 arch/s390/include/asm/ap.h                    |  12 +-
 arch/s390/include/asm/asm-extable.h           |  28 +++--
 arch/s390/include/asm/cpu_mf.h                |  18 +--
 arch/s390/include/asm/diag.h                  |   5 +-
 arch/s390/include/asm/diag288.h               |   6 +-
 arch/s390/include/asm/extable.h               |  25 ++---
 arch/s390/include/asm/fpu-insn.h              |   6 +-
 arch/s390/include/asm/futex.h                 |  17 ++-
 arch/s390/include/asm/ptrace.h                |   6 +
 arch/s390/include/asm/uaccess.h               |  45 +++-----
 arch/s390/include/asm/word-at-a-time.h        |   5 +-
 arch/s390/kernel/cert_store.c                 |   6 +-
 arch/s390/kernel/diag/diag.c                  |  12 +-
 arch/s390/kernel/dis.c                        |  35 +++---
 arch/s390/kernel/dumpstack.c                  |   7 +-
 arch/s390/kernel/early.c                      |  26 ++++-
 arch/s390/kernel/entry.S                      |   1 +
 arch/s390/kernel/ipl.c                        |   6 +-
 arch/s390/kernel/kprobes.c                    |   3 +
 arch/s390/kernel/text_amode31.S               |  34 +++---
 arch/s390/kernel/traps.c                      |  30 +++--
 arch/s390/kvm/s390/gaccess.c                  |  11 +-
 arch/s390/lib/uaccess.c                       |  29 ++---
 arch/s390/mm/extable.c                        |   2 +-
 arch/s390/mm/pfault.c                         |  12 +-
 arch/s390/net/bpf_jit_comp.c                  |  78 ++++---------
 arch/s390/pci/pci_clp.c                       |  12 +-
 arch/s390/pci/pci_insn.c                      |  36 +++---
 arch/s390/pci/pci_mmio.c                      |  28 ++---
 arch/s390/tools/.gitignore                    |   1 +
 arch/s390/tools/Makefile                      |  16 ++-
 .../tools/{gen_facilities.c => gen_bitmaps.c} | 103 ++++++++++++++----
 drivers/s390/block/dasd_diag.c                |   6 +-
 drivers/s390/char/diag_ftp.c                  |   6 +-
 drivers/s390/char/sclp.h                      |   7 +-
 drivers/s390/cio/ioasm.c                      |  24 ++--
 42 files changed, 409 insertions(+), 352 deletions(-)
 rename arch/s390/tools/{gen_facilities.c => gen_bitmaps.c} (65%)

-- 
2.53.0

