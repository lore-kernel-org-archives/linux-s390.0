Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996232F757;
	Tue, 17 Mar 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777293; cv=none; b=m2HrUrIuWObwL4ZFnuDJy4JpRlhgNoSsxr4xjZ+x2E10bv7muAC6scTBf7SLLKOZN7TkG0DVtrqN6JMXWc55dcoF21W7k+KXCx7eLYDw9a4WyHsSCNH8fMlqTww8pb/lYwQWEiSewm5of4jpyXhq8cmi1MluPLPFo6KqfOh2jDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777293; c=relaxed/simple;
	bh=YyXQolrZjw7jMHtKyXF53bFXH+j3i8z3DSyQWZS+mWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YADp5PPckSR+OQx5HS9BoXGzBn1J/zu27xvvk+2WLLa1qkyYF/R/sVEZnJkww/AXXEh7o8Ub8G/M7rAX/fg0impbdzXja+Rj1+32jU8PU7h9FDj6r+i3qmwxUDkNlxZOFM3wugoNkh77RQB60GWl7O5Nw965Wx9BnrqWZSI7ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TkVaFpNa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TkVaFpNa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HChpq93558410;
	Tue, 17 Mar 2026 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=b7umUp/0xpUdo80syYL8zkv+4InsVdit0yva8ElbM
	Tk=; b=TkVaFpNavWstt191b+9lFRx5viR9yhDPNTsls7qNEOADHxpGIqFLuBtrk
	05eoudwf7MpdX+kLFt90QJp1io4QvYk6mHXrtr3AN4HsvCTpqk5q7z+fJRE2gkKt
	yzp0T6N3R2+ted/DvqReF3N6lc07s976lyC9GMEdGi8pcSs4QHVcTx/UznFhPbYS
	9AjA4RehVeuEBlJ04gvZ9fYIgBKJg2Mbktdtt3pv4fuVhTdS1r1osVf8tFoJ8PUN
	9kKLTeVN5RkW4g877WgvsywKdAgQCT8XAQ1Is2/ks7H47PL39vBJnHQIm987Bwks
	5ajPp3pa13OsKpHhIIXBM1OX1RKtA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hx8v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJ3Ga3014113;
	Tue, 17 Mar 2026 19:54:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy2vdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJsbd649217928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E642004D;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1696F2004B;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/9] s390: Improve this_cpu operations
Date: Tue, 17 Mar 2026 20:54:27 +0100
Message-ID: <20260317195436.2276810-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YdMv3bucgFrL0-2g9esJusjf4cBW7V9m
X-Proofpoint-ORIG-GUID: YdMv3bucgFrL0-2g9esJusjf4cBW7V9m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX9ZBldpMbNrcB
 NI4yl3v+1atWuGu6m+1v8OHupSQdJJx/6RWwnXfpUZZzOh+pJNgyDLLl9Do9ZvaYN1ndaU5KHGL
 NeSIuDMQi8KNB/GpGhZ41NQ7+j0ZEkfCDpvczQkbfAoUmmdKuQktXES0mmhUdCiU22hL1JONV5C
 4QhWJ02A/HTeL+/eNR1ZXN4WBOL5Xv7NMoY9NXdMizoEVgnqfrjGN2QQcWj4/cAvVaSlDRPP+cv
 gsjAyJkGY32njk2aMxjJc0v8I+AJlWYtyXep7lxSl2LUuNw6LYrwiwZ03P62AVd+vxc2cIVX3IT
 YJR0KIVkIVR4qiL7/MFI1Hjc3dUpkzcBkXHv+UvArHkPETEll+gmw4pH9QgQy8umOwhOZBdcbPR
 KPZjY65yrrpottHO++PMo0FIcoG1laaV8OlLBKfmdEV6sAtJX8tm7bszv6NU4L+9RpExwAL5yDD
 /wZmhVBmhuZ/XdvIHxA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b9b182 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=WsHKUha7AAAA:8 a=HcqIOo54q-CbW65RmJ8A:9
 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170174

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
 arch/s390/include/asm/entry-percpu.h |  54 ++++++
 arch/s390/include/asm/lowcore.h      |   3 +-
 arch/s390/include/asm/percpu.h       | 259 ++++++++++++++++++++++-----
 arch/s390/include/asm/ptrace.h       |   2 +
 arch/s390/kernel/alternative.c       |  25 ++-
 arch/s390/kernel/irq.c               |   5 +
 arch/s390/kernel/nmi.c               |   3 +
 arch/s390/kernel/traps.c             |   3 +
 10 files changed, 319 insertions(+), 47 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.51.0
