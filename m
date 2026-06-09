Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7E3E7BB3;
	Tue,  9 Jun 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991577; cv=none; b=rGiNxkrPO2mPB2S0tUtrcbmQRWh8aekCbxYxIDopBcdP8YbobKSf8CDhiNnJTwwD/W/e1hOzTKh8CbEnJkmirq1LQQBpspVn7/bYYCPXTAWX3JNscsfGVZU1WSil7flkp4pl+++/vGu9bFS/MfNjNo5Oe2MW0sG5Q/75qJyVj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991577; c=relaxed/simple;
	bh=/qYUSOgRp+OLjYCpuDqmhpU09ReShs2ibpzFCxZIWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmBHHVKQDLYT6R7eaM/oTkonrbaqq2DXTeDC7zEQGEtTxSVVRwUZX5TWE+JN7tW9VBDUaD+1Hi74BzD8aXp2s4frilHafiq/RUaU5Y2Yr3EKk84WDG40poLrxDPX0yh4oUtVm+YgEGU+Tdx5gcpQH9lwmGpyFDQDHZi+NHUDEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnuWjLYB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnuWjLYB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65909b5A2111229;
	Tue, 9 Jun 2026 07:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=H677v5YhjEMM2OgQ1zokX2df2UfYacF4/y1aCx4ZM
	xY=; b=MnuWjLYBy6149tCLl8ptvZYYrGLrO9btgkTjMu8RcuXmRugoMrsyaR31w
	8JnWAiXD4GEgNv0N20L2bBdrD23nj8zOyHLcBzjjLwZrfDfMrMIkl3FLdZ4B6W6r
	iitAo2wF9Wz+3OPDsvKNA+XCfDQqywB9ZrYyfS/c6RbS3wx1knBy51dSw+8gFvwJ
	U9Jk0vXLAiISDtkvbvIBDcKbwihLZpzOjki0dsrphyWvHR5s5pz/VIY7DxssSZ8h
	kb7iCJg8FRMVmQjrVjAk57p8Txv9eag12pV3bBrrQtXvzzyckD9RX6ssF1QTpT+z
	N+rCDXtLf9Pigd1OzLysIgCNsdKKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qk144-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597nk8F006425;
	Tue, 9 Jun 2026 07:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy8r2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qV1l52625728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F161320040;
	Tue,  9 Jun 2026 07:52:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8A920043;
	Tue,  9 Jun 2026 07:52:30 +0000 (GMT)
Received: from lenovo-pc.ehn-de.ibm.com (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 07:52:30 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] s390/idle: CPU idle driver
Date: Tue,  9 Jun 2026 09:52:08 +0200
Message-ID: <20260609075213.31094-1-meted@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27c643 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=obfDj28oHUvmwgAfbDoA:9
X-Proofpoint-GUID: ckdd-0WwYRdTW9Ozd-0FxNJwstA1SY1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX7+YiXL3Z9eZB
 3HpEMikRuCTaSuzJlyNtf/CES4EmUqJYFd5vRbxLhXeR+FfRZ5FejYpMp6K9e4SpR153+SZ1TDn
 9lG52YIIAve6ecAK7LaW6mKSPK1KknaI4LkgCYWKTtJ6qfce6GX+9M0gWqMoHcJkHhwfPisxhs0
 s6MwU8XtYfkhtDaBjqMlt0IzPmg0VxH5OzMSqDjQTFSRsGjHbSwKZgMY1A9dKAJXCbNPV2hJhpU
 8wYSdrS2LrRD0kX5Ipqo+YIa53xt6B7kqbJ1bR0IX+Tz9oo+uZb13q1pSyEoER1W1l92T1IX+OP
 TPll42jdmHf2etxRwDpNcFaOc23JxLp2R4Q9rUJ0duHpZ5bp3jG32mqTkjdRrrx+F/QWWOdWxQj
 /ApEKQlALRd2RIXNtDySFVOF5wlJYfUHpFO9uXwsgnt6UjLZo/Q/6ZPAS8L7d+2OgbRcOfWdJSd
 pga8xwXL/ZJpQZJNcKQ==
X-Proofpoint-ORIG-GUID: ckdd-0WwYRdTW9Ozd-0FxNJwstA1SY1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071

This patch series introduces a CPU idle driver for s390
architecture that leverages the existing cpu idle infrastructure and
TEO (Timer Events Oriented) governor to optimize idle state selection
based on timer events and interrupt patterns.

# Implementation Overview
-----------------------------------------------------------------------

The driver implements two idle states;

**Polling Idle (shallow state)**
- Busy-loop implementation that prevents SIE-exit during short idle periods
- Zero exit latency, optimized for latency-sensitive workloads
- Maintains CPU with the guest, improving response times

**Enabled Wait (deep state)**
- Traditional EW state that signals hypervisor availability
- Higher exit latency but more efficient for longer idle periods

The TEO governor dynamically selects between these states by monitoring
next timer interrupts and system interrupt frequency, choosing the most
appropriate idle state for each situation.

# Performance Benefits
-----------------------------------------------------------------------

Benchmark results across LPAR, KVM, and z/VM guests demonstrate significant
improvements for latency-sensitive and scheduler-intensive workloads:

```
Benchmark    | LPAR  | z/VM  | KVM   |
-----------------------------------------
cyclictest   | +45%  | +50%  | +30%  |
hackbench    | +5%   | +12%  | -     |
pgbench      | +2%   | +15%  | +2%   |
uperf        | +50%* | +-5%  | +-5%  |
```

*Single-threaded uperf scenarios show 50-70% improvements on LPAR.
Multi-threaded results show slight improvements overall.

Additionally, fio and ioping tests show latency distribution shifts toward
lower values with reduced minimum and average latencies.

# Configuration
-----------------------------------------------------------------------

Idle state parameters are tuned per hypervisor type after benchmarks:

**LPAR:**
- Polling: 5us target residency, 0us exit latency
- EW: 5us target residency, 5us exit latency

**KVM/z/VM:**
- Polling: 1us target residency, 0us exit latency  
- EW: 1us target residency, 1us exit latency


Mete Durlu (5):
  s390/tick: Remove CIF_NOHZ_DELAY flag
  tick: Remove arch_needs_cpu
  s390: Enable TIF_POLLING_NRFLAG
  s390/idle: Introduce cpuidle for s390
  s390/configs: Enable cpuidle driver on s390

 arch/s390/Kconfig                   |   5 ++
 arch/s390/configs/debug_defconfig   |   2 +
 arch/s390/configs/defconfig         |   2 +
 arch/s390/include/asm/processor.h   |   4 --
 arch/s390/include/asm/thread_info.h |   1 +
 arch/s390/kernel/idle.c             |   1 -
 arch/s390/kernel/irq.c              |   4 --
 arch/s390/kernel/smp.c              |   1 -
 drivers/cpuidle/Kconfig             |   5 ++
 drivers/cpuidle/Kconfig.s390        |  12 ++++
 drivers/cpuidle/Makefile            |   4 ++
 drivers/cpuidle/cpuidle-s390.c      | 104 ++++++++++++++++++++++++++++
 include/linux/tick.h                |   3 -
 kernel/time/tick-sched.c            |   7 +-
 14 files changed, 138 insertions(+), 17 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.s390
 create mode 100644 drivers/cpuidle/cpuidle-s390.c

-- 
2.54.0

