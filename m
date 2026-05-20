Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D043C3429;
	Wed, 20 May 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268993; cv=none; b=sPOK/cKHOYydOJGO/Hz+YmaS5yaBAgBU7S/GpRqtgUMR/hwfpfhpL7Jv3Z1GVTVXNJg3+S1Szh1PAYAgbMZ6n7Lln7YYw0AbDIvketAotzHkl4JZ/gGa6qkyXtO3ZrLC5+L6RIdqbsojbNUR10Nrh1a9YPPWFxcWcaIaqK73M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268993; c=relaxed/simple;
	bh=ZGyqobwv+cwuI+gNDvY0sei931DgLjUv2S41lj2F6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnyDed0XLRQdQJDsHOociGT5PLpIts7xiTPy50ZnsYATPz1nmh70kMyTTWRJ8WxITEoLp5DG1LA2Nc4xxasKvNcs/XnvIq/aLeblaraSyZ7byYW88bEOhONP2ibt/5TJJH435TEejHPd60XZLx+IXt/hHWyD+i1K2oG3RxxJ9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hb1FyFm8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hb1FyFm8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JLEI99789447;
	Wed, 20 May 2026 09:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/ksn5/y4/PDUUKedDO/3QzeqKu94C8bi7/Tbo8erS
	i4=; b=Hb1FyFm8gvP3ZAY6CPdikssnK0rKPXKbOOa561maRq7vBn7q/XuD2/b8u
	IMUb6fkcmaYhnqfUJX90q/b7H7xfUrie7LQSEwX07umD3ISYhYLtxjsaHvULXFG7
	sxCbzMN60tM8eAORfCIVOpXyqotylioaMd79D9e/4VseXVqb9esyBc8kFHM7LRbV
	N2+lPsgzRVvVT0etU9DrrWFUZ9FPcfNz+PavilGLy5Q3F/4sO2Fji7NK4va6h+aW
	SiN2FPyfAt5VEEpWZHXo/9YkFwd0ejwtSk5YJQVbwRnvNWnpWFbxPW3Q5G0GzChr
	o34EKIq9iJU5py6WFFwW5dsqzULcA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8gb2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K996rl002411;
	Wed, 20 May 2026 09:22:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky6dbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9MiBw49480050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C5F820043;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D95A20040;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 0/9] s390: Improve this_cpu operations
Date: Wed, 20 May 2026 11:22:34 +0200
Message-ID: <20260520092243.264847-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX3vRWSafiCFh1
 qI6/UUvWoH6WqWHhen01zsnxy9FG2Nq2HQGbK0VJSacsrSjCv7tig688iaezCkzdWlxUNpNrNUI
 5PMkKklpzUVqX2Gu0Ba5uz2u8NtnTznk9lt4GT8N+WcHloVsHLBVg8R0NIb4V8nsB5kbl+i01Me
 KoXLlU8nd0M/FVaRjGJeqKNOq6b0Oaaug3Fkm4GoofQp8/lM9tRu44qDqu3mmLjgv4GjiabWjRd
 HDygKYI/fMnMn4riWhSdYbUL39BTdzznyXClgqcHxpfXprT6sW1Omg89ftOWSLQCODxTpevv9U0
 lrR0bjDJJfpGk9de5pbGnyXqM5opjGplmf7ejZlYvqGcattUFiDUeGr+qIcm5S7NjLcRK3UsxXJ
 LGvVTGZnwj6m2OyqQtT8dSjnIepmmvhyft3gFcM2k5VyZ97HSPP1XqLzxB3ZXN0OL0TzYkNQYCx
 qEdeQo/M1TWCRJfJaFA==
X-Proofpoint-GUID: 6MHw4aXD035NrnBUxP-LkZHA9dGdzXuQ
X-Proofpoint-ORIG-GUID: 6MHw4aXD035NrnBUxP-LkZHA9dGdzXuQ
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0d7d68 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=vzhER2c_AAAA:8 a=WsHKUha7AAAA:8 a=gmZ_rDaMcn-pUePHzQAA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

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

Heiko Carstens (9):
  s390/alternatives: Add new ALT_TYPE_PERCPU type
  s390/percpu: Infrastructure for more efficient this_cpu operations
  s390/percpu: Add missing do { } while (0) constructs
  s390/percpu: Use new percpu code section for arch_this_cpu_add()
  s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
  s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
  s390/percpu: Provide arch_this_cpu_read() implementation
  s390/percpu: Provide arch_this_cpu_write() implementation
  s390/percpu: Remove one and two byte this_cpu operation implementation

 arch/s390/boot/alternative.c         |   7 +
 arch/s390/include/asm/alternative.h  |   5 +
 arch/s390/include/asm/entry-percpu.h |  76 ++++++++
 arch/s390/include/asm/lowcore.h      |   3 +-
 arch/s390/include/asm/percpu.h       | 249 +++++++++++++++++++++------
 arch/s390/include/asm/ptrace.h       |   2 +
 arch/s390/kernel/alternative.c       |  25 ++-
 arch/s390/kernel/irq.c               |  26 ++-
 arch/s390/kernel/nmi.c               |   6 +
 arch/s390/kernel/traps.c             |   6 +
 10 files changed, 344 insertions(+), 61 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.51.0

