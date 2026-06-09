Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723E280CFB;
	Tue,  9 Jun 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011487; cv=none; b=sYrNu7OfsRtwKFSfyky0YoUj+YXjECIhnHuMhorPebwniiEM+zAcgF+mEkViRiHv2yFHhXlhepETfy9xxqtzfdJ2Af0UjR9QOK05m6jbl2LGvxjyRVGtBRTjbzCDRAfrIvKgu/Lp5ieOu5J883XgkfAMQffwnMg+QaobHX1abZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011487; c=relaxed/simple;
	bh=JpMtrZYK6R11pwb88uifHS+sMOos7kLMDBoHOaJCCWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XwNLB0ZhMSMlHwRnNVD3Z3MGyY4uBPQBX1t0gDjuv8fnF/jeUlHv5gYY09isQNsmCZDYAWuZ0s3bYrlvCvjp7C2Bx55hzBVlVPcDqvwSSHR/kkajJRJZyNzuz2AkUWKIqXkhS32xBJNtiLdXz8ywAFrSa3Zg11DfiptcQ0Fadcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EkoBS/o/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EkoBS/o/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659C0kkq3404977;
	Tue, 9 Jun 2026 13:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=gbTfzD0xVTSVn9AehLwcJPYxd3hk
	8tVbsWqb/LO6sWo=; b=EkoBS/o/DhZw6Zdhw39svVqh0yd01VX2/uyLfNJCHnuO
	X8+nSvD7vmRgCw2aTpHgM6mkxx5c0jQEZMWtL4sTTUZmVpNZk3id+HvibHNHr4hz
	JidK+5NLVRCKA5AMGHv4LbBK9LDhDEcrZ4fw6j/YMmti8TrsZU/rJmQTXG7dDVLd
	VfUrC0xMr2eZ//u8uOa9vLXAi6z6Ly1ADRmtJFoAZBckFlo/bFdIPa+TvAg3ZTvT
	Vd8evEwyUL3frLSwnEqlr53TNzbtw7pXc6iqG/623Oc9Y2clV/XWs/vZFQGKcGFw
	YWdjkb4kxAd09MHCYwkhUTtSNMxk59VVvb6buaBtfw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye45fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DJeDC015483;
	Tue, 9 Jun 2026 13:24:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w2882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DOSo349086888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:24:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24AEE20040;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22D82005A;
	Tue,  9 Jun 2026 13:24:27 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:24:27 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v2 0/5] s390/idle: CPU idle driver
Date: Tue, 09 Jun 2026 15:24:20 +0200
Message-Id: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQUKGoC/1XMQQ6CMBBA0auQWdumHZQGV97DuAA6yCS0JVMkJ
 IS727hz+Rb/H5BJmDLcqwOENs6cYgFeKhimLr5JsS8GNNiYxrSFM3nhjUShdYQ9OotdDSVYhEb
 ef7Pnq3iUFNQ6CXV/C+NuaGtdW9NelVWBVvKPmeNn19wHPaQA5/kF6bJMKZkAAAA=
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX+xHBDl0pFZYz
 ZVDvZXzhDYCKCkPjxcCjyDLD0SMekoBxDbUZ8tN/F+woMNTcvGAbv4ANx9QAmv3IoFrUsnCV2iL
 6446/8MFTRCwM0RsD9Gbe+X5CYgYklxi4X4Fd4noPMjo2M8P8m6rNlENEWM9F6snf9udmMtmQv1
 h9TgSRn6v+5eqRCCLTFzHjS/GKYa7Yhky/kx1+SVAyZLjgtGgOCXEeTN29RUYmiAs5o03tlh+MI
 rms5qRM7cUfUoePivU09dD8091iIp1+RQrXddn1GwyruSolNarTkXg2mvmvijb+mbhv5D9E4z+J
 wh+7UI3w7c2qV/2JkFHKeIogNeDJQSw5Od7SNN5Zh7kyWl6tsiMJgHQp2jES2OTZI1BgK5mNHnl
 ZKau0NyyqGmwiFXbmprm88V6A24062G4TXFnIxChps1I9tSvz/3IN98GW1zv3vb0kn666HA6mRa
 pDy3aExXjSi0/ZCvfsw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a281410 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=obfDj28oHUvmwgAfbDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tynu0NYdabWxQDQEZCXAj9pcr7kBJGyu
X-Proofpoint-ORIG-GUID: tynu0NYdabWxQDQEZCXAj9pcr7kBJGyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090124

v1 -> v2:

* Add idle driver enteries to MAINTAINERS file (Christian Loehle)
* Remove extra line break left in drivers/cpuidle/Kconfig.s390
  (Christian Loehle)

This patch series introduces a CPU idle driver for s390
architecture that leverages the existing cpu idle infrastructure and
TEO (Timer Events Oriented) governor to optimize idle state selection
based on timer events and interrupt patterns.

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

The TEO governor dynamically selects between these states by monitoring
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

Idle state parameters are tuned per hypervisor type after benchmarks:

**LPAR:**
- Polling: 5us target residency, 0us exit latency
- EW: 5us target residency, 5us exit latency

**KVM/z/VM:**
- Polling: 1us target residency, 0us exit latency
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
 drivers/cpuidle/cpuidle-s390.c      | 104 ++++++++++++++++++++++++++++++++++++
 include/linux/tick.h                |   3 --
 kernel/time/tick-sched.c            |   7 ++-
 15 files changed, 145 insertions(+), 17 deletions(-)
---
base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
change-id: 20260609-idledriver-217e2b2712a3

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

