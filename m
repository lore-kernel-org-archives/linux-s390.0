Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED905314D26;
	Thu, 18 Jun 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784068; cv=none; b=tKGmCdG1/kI7bqwkc7oZFXRfRzy+xzAo+qsIMNPSo1DzEwzNdxFjnuxP9AhrwG3n2n1HvZyUzLcl7tx7hH5WI+bJvqz3wRMroraB5D/8oY+e3PO4NEhmNTuuY6k+XDGAc4Dhe6U30e8dcKSXacup6tNjkv6tgjtcscxhaNFVPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784068; c=relaxed/simple;
	bh=huTBdupjxY4y8gRnPwVE81r1uh0z48z7tfaPCgadeTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e5EreWFcPFTok95zD2kz4Kn2Kt5sv0Kagp11T+SE81sgzQIzli4S5OWjkrvaP5b8sS1mQfcknaXL8eoeSr2dar6QEPGUiYS4fNFWYQB36MVebA6+IvUfHGwDyWG1KQCONO0jfUh2vNhxYM2Phda2AaAYyX7D4I+QMrC5JutD9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJQECdLQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJQECdLQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBIQLo3263217;
	Thu, 18 Jun 2026 12:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=sTcMnqscS11RT9F+rjXSO66h2mVY
	O4MiAL4ZzAxtr0c=; b=nJQECdLQO8oHeKPrv/2yuuozYaP7S2buoBQMQqjF1cy9
	qtrdKrIuvK9HCk+9KetTNQurIHQLFQALGpa1NGhVrZXZiaKR/hOlpi9l8jVFHBzV
	l8aJuX0hmUH8rWsoo+8p5xCirwTaJqrqMi1EQkxA5mDnIKPuEARCyJ/PUaqxG+DE
	Cb330eejMhE7HumaozNdqnAUrq8n4xJZ6YJWOEBxNLqaYtXBsu33DmXqHmBzZbgN
	DNPYkog1hHQaoFME0q8X36Vc90ppvTnRrTPpnH0+IMeRvpTd4N0DZAlKy5Pwwq/W
	skyy52Mp/JgJSWLLMaoTjsWa4+EgfkqwkGX5ipxrgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvywqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnjAG024636;
	Thu, 18 Jun 2026 12:00:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1723jdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0jTa48234968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3792C20040;
	Thu, 18 Jun 2026 12:00:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6374F20043;
	Thu, 18 Jun 2026 12:00:44 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:44 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v3 0/5] s390/idle: CPU idle driver
Date: Thu, 18 Jun 2026 14:00:14 +0200
Message-Id: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQQ6CMBCF4auQri1ppwLiynsYFkCnMgmlpsUGQ
 7i7hZ3G5b94X97KAnrCwK7ZyjxGCuSmFOqUsX5opwdy0qkZCChFKeqUI2pPET0HWSF0UEloFUu
 Dp0dDy4Hdm9TGO8vnwWP7RYiqAKlyJUV95pJbnFHfRppeS06dzXtnd2ygMDv/Po5F2Mm/HyJwk
 Y70YIqL1FKaH6nZtu0DoqbYUeUAAAA=
X-Change-ID: 20260609-idledriver-217e2b2712a3
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX6Z3gG+fkLLVB
 wdHf43xddbStv6schn5UUSONSuuetPS9wD7mugGxjO7BY9ZwZ2hAEKPClLp6qYw54BBGZP0M3Rd
 TZITE0HJsSm3MpuRiIJZch0sNyAw/xI=
X-Proofpoint-GUID: SooQhMfVIkXr0d4gRZUOmDzdksPWLeCe
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a33ddf1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n8XGycmV1CrEpJvqQmUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SooQhMfVIkXr0d4gRZUOmDzdksPWLeCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX6StbYFdezFGV
 pB8Nv5+VH9Sbp2mQnGyCc8zwfwsbIcJd9tcWJrs78Sve3dC/RqRp/J6jprAay/kWSs5JMPQ0LQZ
 net/srrngU0xA1PdIfLYEnCH2JkSjS3j4UHB5LkAOh9mWMy1QVGBOy669TZJrBbBzpFBI5bWsnE
 eT+MNOMU0DFh3oR6tC8x5dfNmo+nro0TEtRCwNqZ1zASSRW17eLKj1rNtXsHIbOdYhgv9PlCVdr
 Xwd7HGcqfxTGVz6gvIEiSWmCqciIuUMXuTkSqRGm3vPodg4iyrQHqJtCqj6hAZSr0PLo1KSvsS+
 B6zGFjPXsn+bcidVV95bfKBqy0yVg8YUCvJnfPYeCtXklmVUuBs+8caXHvO48Ig+Z40iWcK4gc7
 TIDZepXqFKloPfX5oBjaiGt3n9NeeyiYOYAs6QUtPbAmX7CN8KwRGuMuu9U3WCoukZC+TlOhr+u
 CHZI6kb7LDJVX33TH3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

v2 -> v3:
* Link to v2: https://lore.kernel.org/r/20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com
* Remove any mentions of idle governor since the driver is not tied to
  any specific governor. TEO is just the default pick for s390
  (Christian Loehle)
* Add a comment to reflect how the values for idle driver tuneables are
  picked (Christian Loehle)

v1 -> v2:

* Add idle driver enteries to MAINTAINERS file (Christian Loehle)
* Remove extra line break left in drivers/cpuidle/Kconfig.s390
  (Christian Loehle)

This patch series introduces a CPU idle driver for s390 architecture
that leverages the existing cpu idle infrastructure and idle governor
to optimize idle state selection based on timer events and interrupt
patterns.

- Implementation Overview
-----------------------------------------------------------------------

The driver implements two idle states;

**Polling Idle (shallow state)**
- Busy-loop implementation that prevents SIE-exit during short idle periods
- Zero exit latency, optimized for latency-sensitive workloads
- Maintains CPU with the guest, improving response times

**Enabled Wait (deep state)**
- Traditional EW state that signals hypervisor availability
- Higher exit latency but more efficient for longer idle periods

The idle governor dynamically selects between these states by monitoring
next timer interrupts and system interrupt frequency, choosing the most
appropriate idle state for each situation.

- Performance Benefits
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

- Configuration
-----------------------------------------------------------------------

Target residency and exit latency values are benchmark estimates. Due to
s390's virtualized architecture, these values are non-deterministic.
Idle state parameters are tuned per hypervisor type after benchmarks:

**LPAR:**
- EW: 5us target residency, 5us exit latency

**KVM/z/VM:**
- EW: 1us target residency, 1us exit latency

---
Mete Durlu (5):
      s390/tick: Remove CIF_NOHZ_DELAY flag
      tick: Remove arch_needs_cpu
      s390: Enable TIF_POLLING_NRFLAG
      s390/idle: Introduce cpuidle for s390
      s390/configs: Enable cpuidle driver on s390

 MAINTAINERS                         |   8 +++
 arch/s390/Kconfig                   |   5 ++
 arch/s390/configs/debug_defconfig   |   2 +
 arch/s390/configs/defconfig         |   2 +
 arch/s390/include/asm/processor.h   |   4 --
 arch/s390/include/asm/thread_info.h |   1 +
 arch/s390/kernel/idle.c             |   1 -
 arch/s390/kernel/irq.c              |   4 --
 arch/s390/kernel/smp.c              |   1 -
 drivers/cpuidle/Kconfig             |   5 ++
 drivers/cpuidle/Kconfig.s390        |  11 ++++
 drivers/cpuidle/Makefile            |   4 ++
 drivers/cpuidle/cpuidle-s390.c      | 115 ++++++++++++++++++++++++++++++++++++
 include/linux/tick.h                |   3 -
 kernel/time/tick-sched.c            |   7 +--
 15 files changed, 156 insertions(+), 17 deletions(-)
---
base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
change-id: 20260609-idledriver-217e2b2712a3

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

