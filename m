Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93933421F16;
	Fri, 22 May 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459197; cv=none; b=e+VomP4DkO85q6953UXQcGAdXuKFwDSdMXZfLKqPDegoDUqXI76lm4q8mj9XEmbg87XYY4pcr6HLVJTifh0owXjsU8/oifPrLLnjb0ziVQyWxiSVybBi11JzUCcJ/vaC+yE2kn6eyJZGaOwWUXj888QtY8698zYw6h4O8Qn65iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459197; c=relaxed/simple;
	bh=sjnN9TAEbj30QU09KFFpK0NLaa9yXMtl2NjlDuUwRyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftrYDKpN27yXkLsCebKrf945i93vH/ZDVrny14I9J9g8tDmN5piBPp39EUxRW2O5zlprVYy5593m4N/h7iJOgS850CRhs7xOi+IX/nTsuvxxQAXHiEbUfL8kND6UiSBXZurodbupdFxbkPz5V6d4owgOFiE7XlJQwV0d94J6oUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ATMRaawc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ATMRaawc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBQ5js331129;
	Fri, 22 May 2026 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZakITQ8p+cCkIofmvBTC8S00zrt1htaiVNXt761Sc
	xg=; b=ATMRaawcXz1Yktrpx6RiZsOElnzqNn1/F902b1FHlYtd4PeYf6BWjRR+9
	oKZauNizC82qJzp2WR+2OcAiV2dVAACNczR3Md/7wmIpSnZCVOtu7UXAp9wnq/Qi
	+FTNr4SOjPN9iwTzkak+NY/SRuxtqmjcDSOGjeRBJf5zqC54L5qHtN5+E8StBBbm
	0sGjfuc2py3WTk6gDsusZMCi4VXhkZ6mNL0+4gVLjEBtw816rjqxbyyXcIqUPYVZ
	HV+nxW/dCVBwjaB1l8ybfIp2vgKbvLg1SyodICcattDiLBTe3To+MIZsgkvHMIYl
	m80iqAV/uSAddfok1rzBpIPrgZA7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawjwba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME95VY030291;
	Fri, 22 May 2026 14:13:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj149r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECwNj36897142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1241B20043;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D374620040;
	Fri, 22 May 2026 14:12:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:57 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 0/8] s390: Improve this_cpu operations
Date: Fri, 22 May 2026 16:12:49 +0200
Message-ID: <20260522141257.303617-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfX6tzvhMMaDdSq
 dnfby28tfA5kQILzgygexVqGlhdlABD7AU2RuRzp83pswpNwTOECfxEzBri8k5c2viyezzgGCkQ
 TCg9hizd+LMUR3WLvHJDkISr0Ha2zEyuLO1C7R9kwFlc1X5xsnwRJq2gvSC588aOAaS0lXlaOkt
 y/QZD4zSjXkkvPTw6ZL8Q1MM9lMidhtVMmEHWLQ3tY8akxudI0ilnmAl7vg5OVtwwnkd5AqvY0T
 DIx2aImVBOP4c1dFp0nxmkjU96HjgPjJvinubZFtEKQ+bF5NQEC9eChHFANVyY/i7wOp9F16Dp0
 a9aZedjDja12zrY930KmzXhhxkhkSPSI1laeJjUDoKtZQa8rfw38B9Y6LiVTDG2p6IIfgGWe7dt
 9zb+/AcYs9sGbC8YI5s+gEiqPCVPmW8yso2uLF5lDbnrn2Me84hjQ3ko6XdUUd0+wV8RLD+wq9t
 8goJfeAov4tQbtQDrDQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a10646f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=vzhER2c_AAAA:8 a=WsHKUha7AAAA:8 a=NTOWs0FUGPymbM_41vIA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-ORIG-GUID: WpYqK2V3vUa2fF6K-7Ub9F2TMQAvYBjV
X-Proofpoint-GUID: D_dwu4tWBEe2Tx1AsbtRKISMssC7diSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

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

Heiko Carstens (8):
  s390/percpu: Infrastructure for more efficient this_cpu operations
  s390/percpu: Add missing do { } while (0) constructs
  s390/percpu: Use new percpu code section for arch_this_cpu_add()
  s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
  s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
  s390/percpu: Provide arch_this_cpu_read() implementation
  s390/percpu: Provide arch_this_cpu_write() implementation
  s390/percpu: Remove one and two byte this_cpu operation implementation

 arch/s390/include/asm/entry-percpu.h |  78 ++++++++
 arch/s390/include/asm/lowcore.h      |   3 +-
 arch/s390/include/asm/percpu.h       | 257 +++++++++++++++++++++------
 arch/s390/include/asm/ptrace.h       |   2 +
 arch/s390/kernel/irq.c               |  24 ++-
 arch/s390/kernel/nmi.c               |   5 +
 arch/s390/kernel/traps.c             |   5 +
 7 files changed, 315 insertions(+), 59 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

-- 
2.51.0

