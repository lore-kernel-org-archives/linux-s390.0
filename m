Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FB311940;
	Fri, 19 Jun 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861377; cv=none; b=LcPk8dMaCwo1EXznYCkh4lRTxKLvlEjmR0MO0P3JRq0OwYDX6kunjoQnc95Afo4gTH2u58zoF/Y5GgI7nPqXDyYPgIcL56qdAWaOCI+anapC0D9iYTEkICtevWSX6dvnG3rGm9emQdvr25uJO/AbROJAonHIqVpbHvH5ZYEKnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861377; c=relaxed/simple;
	bh=RPcm9jqK83pkNoe7lKbfWzVE+N3PB25ddsIZ5Zmzphk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC2k2a88OJ3bdOavJonSZOjcwEng+OG/TrHtZ6MDdq+x0NROoZRp/fZeBey0McHTOg6898m92qViLs5Q3uNGEhQGSXGMJ1KwZQM2Dcy/NPUntafasgFxpUQFTDbFQ5rNBxS91/L+Q4lxpM+HF/KY8n/z6Ay2nGBZ4gGyTZH2pBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ELuL3aMR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ELuL3aMR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mUtm1674778;
	Fri, 19 Jun 2026 09:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w+HCNlB3BxvJ4i5wrGEEEVQy2Vf6bz
	9yHyNstGEYNog=; b=ELuL3aMRBE9q8AbTuRavLFrX4uKx9aL7VH2Wxw6pvXYte/
	1MOXVhqrO8jWtoJ9qXW5VasT/Qf0RZkrqNNhtCNZyvAnlAJC2bg7cjnqQKnIXU7G
	26BnNTyD3+1I0UwqI23mkYMJsANgM8K64nF/v0pJcFzhaRqhWtI03LK1v1glBIjg
	OPBP86Rh2BZo3PYb6rGql89VWeW4VwJu3+gDZDQaoH0h8oyhWSRRMU8DTu7dRHwO
	j5F0pcbrSxv0fhRLhFaQGhU32+5jmG0ObmoeXOrSA3IPhFl9uXs1rKp74H85BLNB
	0t44IsMWzPEU7o37ewYzn7ErJKfxYlS9aupGM5rg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw4tt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 09:29:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J9JbBN011019;
	Fri, 19 Jun 2026 09:29:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17285ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 09:29:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J9TNI156230360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 09:29:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DBBF20040;
	Fri, 19 Jun 2026 09:29:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37BA02004B;
	Fri, 19 Jun 2026 09:29:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.83.221])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 09:29:22 +0000 (GMT)
Date: Fri, 19 Jun 2026 11:29:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] s390/idle: CPU idle driver
Message-ID: <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX4ezXzYeVpJLz
 b/MZQ7TjblzDPAvAyZ1N8ybxBJQAv0P3nZMQNtqNx0j6OpgjJMp/YlQaQBGwHX2DXew7EK53fKF
 tExlV4vhN79hRNqmDhywPh8/EnqRrxs=
X-Proofpoint-GUID: abg4Ryfq43opm4tU6yzG9rDjiSF8_WmZ
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a350bf8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qNUs5Gt8cy9_CmkmY6UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: abg4Ryfq43opm4tU6yzG9rDjiSF8_WmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX8w1vThKFGw0x
 KyA4fQtK/g03/5CYm8EI7zpFQ/9S1bOthfGT0O0vQa9HYUBGyW3IXWTGn7DFmin1Nnd5Jyp1yTL
 xTPY0spDLPo3NGTv221uWii0zPJSdzpetE19kOe+TFUladFNDjMhGQd5hnxHeVBbWWoJB3L7Ub4
 9UfUR1Y8gIzmXlnwY1iNkSTeHw80bI8w0RV2LGemnGWiy1XuRkwRpCVC3LGu0a0Bd76tJlQxgfP
 1NYDlyoFfbbiu8YIQYzTEcD0qNKkXftWGVeHkI0Is6qab8BCE6zwf4W8IrLG2I8OI/0+vGRRWSV
 FSmwmWB2T3g+z5zT+8XqxuTaq9/RtUsF4qapSnxqWg8uqmVNEfFC1VnyQtk9TB+RwxXvSKeR1YC
 f7mSHKkbrKr/3HbIZ2GWQIDZi+SivCcB6n+nHBm/U567BUlsCd/W25FqCXea2Fov7HvqZJI9YQx
 73T05Zpl0yDyLWJfp4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190086

On Thu, Jun 18, 2026 at 02:00:14PM +0200, Mete Durlu wrote:
...
> This patch series introduces a CPU idle driver for s390 architecture
> that leverages the existing cpu idle infrastructure and idle governor
> to optimize idle state selection based on timer events and interrupt
> patterns.
> 
> - Implementation Overview
> -----------------------------------------------------------------------
> 
> The driver implements two idle states;
> 
> **Polling Idle (shallow state)**
> - Busy-loop implementation that prevents SIE-exit during short idle periods
> - Zero exit latency, optimized for latency-sensitive workloads
> - Maintains CPU with the guest, improving response times
> 
> **Enabled Wait (deep state)**
> - Traditional EW state that signals hypervisor availability
> - Higher exit latency but more efficient for longer idle periods
> 
> The idle governor dynamically selects between these states by monitoring
> next timer interrupts and system interrupt frequency, choosing the most
> appropriate idle state for each situation.
> 
> - Performance Benefits
> -----------------------------------------------------------------------
> 
> Benchmark results across LPAR, KVM, and z/VM guests demonstrate significant
> improvements for latency-sensitive and scheduler-intensive workloads:
> 
> ```
> Benchmark    | LPAR  | z/VM  | KVM   |
> -----------------------------------------
> cyclictest   | +45%  | +50%  | +30%  |
> hackbench    | +5%   | +12%  | -     |
> pgbench      | +2%   | +15%  | +2%   |
> uperf        | +50%* | +-5%  | +-5%  |
> ```
> 
> *Single-threaded uperf scenarios show 50-70% improvements on LPAR.
> Multi-threaded results show slight improvements overall.
> 
> Additionally, fio and ioping tests show latency distribution shifts toward
> lower values with reduced minimum and average latencies.
> 
> - Configuration
> -----------------------------------------------------------------------
> 
> Target residency and exit latency values are benchmark estimates. Due to
> s390's virtualized architecture, these values are non-deterministic.
> Idle state parameters are tuned per hypervisor type after benchmarks:
> 
> **LPAR:**
> - EW: 5us target residency, 5us exit latency
> 
> **KVM/z/VM:**
> - EW: 1us target residency, 1us exit latency
> 
> ---
> Mete Durlu (5):
>       s390/tick: Remove CIF_NOHZ_DELAY flag
>       tick: Remove arch_needs_cpu
>       s390: Enable TIF_POLLING_NRFLAG
>       s390/idle: Introduce cpuidle for s390
>       s390/configs: Enable cpuidle driver on s390
> 
>  MAINTAINERS                         |   8 +++
>  arch/s390/Kconfig                   |   5 ++
>  arch/s390/configs/debug_defconfig   |   2 +
>  arch/s390/configs/defconfig         |   2 +
>  arch/s390/include/asm/processor.h   |   4 --
>  arch/s390/include/asm/thread_info.h |   1 +
>  arch/s390/kernel/idle.c             |   1 -
>  arch/s390/kernel/irq.c              |   4 --
>  arch/s390/kernel/smp.c              |   1 -
>  drivers/cpuidle/Kconfig             |   5 ++
>  drivers/cpuidle/Kconfig.s390        |  11 ++++
>  drivers/cpuidle/Makefile            |   4 ++
>  drivers/cpuidle/cpuidle-s390.c      | 115 ++++++++++++++++++++++++++++++++++++
>  include/linux/tick.h                |   3 -
>  kernel/time/tick-sched.c            |   7 +--
>  15 files changed, 156 insertions(+), 17 deletions(-)
> ---
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
> change-id: 20260609-idledriver-217e2b2712a3
> 
> Best regards,
> -- 
> Mete Durlu <meted@linux.ibm.com>

Applied, thanks!
