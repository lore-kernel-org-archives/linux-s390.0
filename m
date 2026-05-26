Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18D3BED5A;
	Tue, 26 May 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775030; cv=none; b=hCx8NPNp0vOAqB1RtTnkVhNWXS7C5z/2G3hnA6CtUbndPcc26LEpkxtbJzM69MSLEEkkqi2uSxqoXjaBOh2kcCsA9W233D/DZoMarl4jTQaZqAD29N5wRBQg1XoH+CiEBCqdpDrQGHgsJ+DXZV1y73oHiPupiteyj1ii0sDs4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775030; c=relaxed/simple;
	bh=JknMsY05G2+QP7spNPENqUOQkZmfZQHrpmK1GlOoFQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZqFTnBLsgX1z7avyPrVMCnJdic7fBY6dfCWnb9SPALb5wcTecZiqSTYH9OmsX+MEnmXXNLac3r9OBWalyNROF3QTTcPGzLIJp88SPMr7yzLGDqeUS8XpJ8R7SPtFxjr+ro7L7e+Mcpm34HM90MA7yZA1WZnBbiGd/e6C+CrcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nNXCPHG3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nNXCPHG3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q520Gb752061;
	Tue, 26 May 2026 05:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2KLtIn2nzY0hwl6skKsWolQQ7fUfdNyvgcG/AMyl6
	CU=; b=nNXCPHG3AAxI/Qq7HLOruFzZIdnG2I6t80DM1RLwU7b1X6cCpwIx93miS
	gUsoeagb7op+2LTJVRvg/7l1mc6jK4QfkuyF/Mnv74mXq75bceoN2TwxYQU9qBWE
	dTnjZfqpX1dTfQ7F7NFztgNUNrHcQT2RztzhEE9iPAacwyjSLtyZFEmqMwi1C8tx
	RcWmulYTWnb26vnxqLtDhGhVl0Sl6aN4sLILTk8+OIetWy/qg6G4puFWtoAO/X2g
	k8mM1cMVtM0iIwf6QDPsLF3JMt1d3bWapOV4jHXOI6W2gf9peLRejcs/tDa7HuqH
	CUQjvQQfBht7xOdWKvAxpP0OGc+kg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pd9pq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5sAcJ022530;
	Tue, 26 May 2026 05:57:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg7sa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v3qo52167014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C6E20040;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1415C20043;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 0/7] s390: Improve this_cpu operations
Date: Tue, 26 May 2026 07:56:55 +0200
Message-ID: <20260526055702.1429061-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a153633 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=vzhER2c_AAAA:8 a=WsHKUha7AAAA:8 a=IJ8qDfw2XgzfjrnLdLcA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: 3IL87sFX3D_wcjzHcRJtp4z3LCAJ5KAE
X-Proofpoint-ORIG-GUID: 3IL87sFX3D_wcjzHcRJtp4z3LCAJ5KAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfXzGhGihIS54PM
 c6QNmFzxLrvjCgpvRqiBaaFpHHcE8jlFlp6uMfLzJuxxD2ZIZ61RJKGmpX82/UX/BIe8WV7BHe1
 dBZg8UPBGusvPb4d9X+o2dLECx7eXcjaPc3o6WqQ4gzG+DE8KFD7okgd/i/tL+AOY5U3a+SsuiK
 dXY//55DW+8VvenjKtcI7KSa4Bn3KdGyop0vySWy7mGBamC8kKMWS9Vvx7qITjcQSWZ1wbOZI1E
 RJ8N4AYiTvOAi2KssEVPSol+CTUudzvgzV2NLT+3L8jiCKXT5rmb+TIzjjuwbze/dEX5sPYvf5k
 ofeFgZxAzTUMdjMMVkAtnu4dx/eE9iX06L6OSq4bxzw7TKwctKaxXAq0GPrMMn7d2xc8nOTzsi0
 BOc+XFsl74OJlg9iNUTQSOIa0QeXlZH0qkQJCJqLSbg8BFhZXAQY/qW/Om/pZvXOBLCMnpsrBfM
 YPch5G62T4Cb45SXOmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260046

v5:

- Add missing user_mode() check to percpu_exit() [Sashiko [6]]

- Use zero extending instructions for arch_this_cpu_read() [Sashiko [6]]

- Keep 1- and 2-byte implementations since
  ARCH_HAS_NMI_SAFE_THIS_CPU_OPS relies on them  [Sashiko [6]]

[6] https://sashiko.dev/#/patchset/20260522141257.303617-1-hca%40linux.ibm.com

v4:

- Drop alternatives approach and extract percpu base register number for
  mviy at compile time [David Laight]

- Fix logic for percpu code section detection, as well as
  interruption/exception/nmi path [Sashiko [5]]

[5] https://sashiko.dev/#/patchset/20260520092243.264847-1-hca%40linux.ibm.com

v3:

- Fix various typos [Juergen Christ]

- Add missing kprobe detection / handling [Sashiko [3]]
  [FWIW, this made me also aware of that the current general s390 kprobes
   code seems to be racy against concurrent removal of a kprobe while a
   probe hit on a different CPU. But that is a different story.]

- Fix various minor findings [Sashiko [3]]

- All of this might be dropped / exchanged in future in favor of the percpu
  page table approach proposed by Yang Shi [4].

[3] https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca@linux.ibm.com
[4] https://lore.kernel.org/all/20260429170758.3018959-1-yang@os.amperecomputing.com/

v2:

- Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
  warnings

- Add missing __packed attribute to insn structure [Sashiko [2]]

- Fix inverted if condition [Sashiko [2]]

- Add missing user_mode() check [Sashiko [2]]

- Move percpu_entry() call in front of irqentry_enter() call in all
  entry paths to avoid that potential this_cpu() operations overwrite
  the not-yet saved percpu code section indicator  [Sashiko [2]]

[2] https://sashiko.dev/#/patchset/20260317195436.2276810-1-hca%40linux.ibm.com

v1:
This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].

With the intended removal of PREEMPT_NONE this_cpu operations based on
atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
become more expensive: the preempt_disable() / preempt_enable() pairs are
not optimized away anymore during compile time.

In particular the conditional call to preempt_schedule_notrace() after
preempt_enable() adds additional code and register pressure.

To avoid this Peter suggested an in-kernel rseq approach. While this would
certainly work, this series tries to come up with a solution which uses
less instructions and doesn't require to repeat instruction sequences.

The idea is that this_cpu operations based on atomic instructions are
guarded with mvyi instructions:

- The first mvyi instruction writes the register number, which contains
  the percpu address variable to lowcore. This also indicates that a
  percpu code section is executed.

- The first instruction following the mvyi instruction must be the ag
  instruction which adds the percpu offset to the percpu address register.

- Afterwards the atomic percpu operation follows.

- Then a second mvyi instruction writes a zero to lowcore, which indicates
  the end of the percpu code section.

- In case of an interrupt/exception/nmi the register number which was
  written to lowcore is copied to the exception frame (pt_regs), and a zero
  is written to lowcore.

- On return to the previous context it is checked if a percpu code section
  was executed (saved register number not zero), and if the process was
  migrated to a different cpu. If the percpu offset was already added to
  the percpu address register (instruction address does _not_ point to the
  ag instruction) the content of the percpu address register is adjusted so
  it points to percpu variable of the new cpu.

All of this seems to work, but of course it could still be broken since I
missed some detail.

In total this series results in a kernel text size reduction of ~106kb. The
number of preempt_schedule_notrace() call sites is reduced from 7089 to
1577.

Note: this comes without any huge performance analysis, however all
microbenchmarks confirmed that the new code is at least as fast as the
old code, like expected.

[1] 20260223163843.GR1282955@noisy.programming.kicks-ass.net

Heiko Carstens (7):
  s390/percpu: Infrastructure for more efficient this_cpu operations
  s390/percpu: Add missing do { } while (0) constructs
  s390/percpu: Use new percpu code section for arch_this_cpu_add()
  s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
  s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
  s390/percpu: Provide arch_this_cpu_read() implementation
  s390/percpu: Provide arch_this_cpu_write() implementation

 arch/s390/include/asm/entry-percpu.h |  80 +++++++++
 arch/s390/include/asm/lowcore.h      |   3 +-
 arch/s390/include/asm/percpu.h       | 246 ++++++++++++++++++++++-----
 arch/s390/include/asm/ptrace.h       |   2 +
 arch/s390/kernel/irq.c               |  24 ++-
 arch/s390/kernel/nmi.c               |   5 +
 arch/s390/kernel/traps.c             |   5 +
 7 files changed, 318 insertions(+), 47 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

-- 
2.51.0

