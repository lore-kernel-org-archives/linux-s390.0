Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266C3CD8B4;
	Thu, 19 Mar 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921919; cv=none; b=paVWnPVZjF1J6QnnMYprNwxrRMmurN87MuTLYo/Ncn+mu0tVNNe37GB+eyLK1MMeniQIdXPUz4h6QnnsbsTSjZrACr1RTiJqqwNFMRwT0YPGNoGI6dEcRm1EDzlwZ+7m5kyRBbiicydu+JzPu/hqIqQZyfzVCZlyWEvgUYcTUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921919; c=relaxed/simple;
	bh=Drv7tVpUfqn11jRRBMEJ5HOqZ6LGS+MOc+N2SC7wdow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ts/JKxSnxdw1e3x5GZUMoEm94IhDrcXaDVPL1gPMjSRG3DDVtCiHWvSxodg4yqProuYlzA8RlVl/IPphu7NnOm5ay5wgmLFMb871aoH6Hc3aPrbQyAo/+pKJcueIOsUGBgV3LQCyNmFcjJqKohd+UiNSk69M6EQpHHr1qdQuXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UvB1l0oP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UvB1l0oP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4xi0q2670131;
	Thu, 19 Mar 2026 12:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1TrX91tEWwsG9mTtb+H5eggmcM7PIbQdX9XUIsgvh
	ow=; b=UvB1l0oPuvIV8KhYXy8AiS9xJcpqV9tkq6Dew0AZEXl1XVLXglB8lVrg5
	Y6IzcqdvESG2O2BslQ/OzxYzfkP1pw2qu8pxmn1wf61Ay445mMNm4af3OmKbfT0X
	D48UARpPNKndYgf8hoW/nqgQTPSXELAmfW4D07iDLJwOB8s0X8m/2RGyRf4P3mbA
	WHirfOnNr21yIQzO4SNWXHNCpd2zw569s2MPwCEOYIe99CJ5uy98F9OZkMl6hbfU
	JU+WJt8QdX8j/+X9fekAXlrbzKLIz482fMyScHfQwoh57FXRiRQpR5OCy4PsHyhc
	4v90H3DdH7IdjeYpsMai8l3+uBhwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j652f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J90avY014011;
	Thu, 19 Mar 2026 12:05:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyadkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC53WF51053018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80FA820043;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE0320040;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/9] s390: Improve this_cpu operations
Date: Thu, 19 Mar 2026 13:04:54 +0100
Message-ID: <20260319120503.4046659-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2I4CQKEcHNZKvZPTxTtnZn4uFqQaOMr
X-Proofpoint-ORIG-GUID: e2I4CQKEcHNZKvZPTxTtnZn4uFqQaOMr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXzpBQoKq6DaLY
 0m5NlgwUHdqGuySQC1L4IeXuEo4m7Mli/f7uXckbJLxjgh69m1FVQBGqeLGMtvkth/O40oPx+Lm
 kOdlagqBAJDwEZlVojFTtrbj91uzKElNPw0QqpHsOrdEmMc117AFypgdRejVdm9iYqxLn73UplU
 tllQjt0zzDK6/RRmzciC6tpmxFb4Xn2j7cJx1n7Hi5KQWL04sPEbE+Pk7Co2c1UF+UX9Pkw1LN/
 vAIqdZ1mL94NRh0CTzRmmjIRY6psz/YVsOvfhF4W1sc8w6K23AvH+8cdKFgGGVZF90MkYk2bhdt
 vnbdsqeqmdOObIDKcm/sJz9FTuwq6UTp/nL1spnUHpDs4zdB5d61cisXadSkZZgVah5I7jWCZDE
 fk0EdffXxLNeAXqUWytdWbDQ9GpMFZGJn1JkUjQgT9g6eiNrxAxeUVfx4xozgNmkC2kqont2DqN
 tLnVMFVZxe1+joC8/iw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bbe674 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=gLnKuNnXPhP2SBYGgd0A:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

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

Heiko Carstens (9):
  s390/percpu: Provide arch_raw_cpu_ptr()
  s390/alternatives: Add new ALT_TYPE_PERCPU type
  s390/percpu: Infrastructure for more efficient this_cpu operations
  s390/percpu: Use new percpu code section for arch_this_cpu_add()
  s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
  s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
  s390/percpu: Provide arch_this_cpu_read() implementation
  s390/percpu: Provide arch_this_cpu_write() implementation
  s390/percpu: Remove one and two byte this_cpu operation implementation

 arch/s390/boot/alternative.c         |   7 +
 arch/s390/include/asm/alternative.h  |   5 +
 arch/s390/include/asm/entry-percpu.h |  57 ++++++
 arch/s390/include/asm/lowcore.h      |   3 +-
 arch/s390/include/asm/percpu.h       | 259 ++++++++++++++++++++++-----
 arch/s390/include/asm/ptrace.h       |   2 +
 arch/s390/kernel/alternative.c       |  25 ++-
 arch/s390/kernel/irq.c               |  17 +-
 arch/s390/kernel/nmi.c               |   3 +
 arch/s390/kernel/traps.c             |   3 +
 10 files changed, 330 insertions(+), 51 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

-- 
2.51.0

