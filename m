Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE9374E41;
	Fri, 19 Jun 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865497; cv=none; b=qd/YWHPygIR3Q1mcxZUhCz8Ip8iKIy1BW8Gdm7d3MM0cetwuGrxxzWHP695A9zgbYonv7vvMAfiqAQ2p5b/cbvk4tbYru0B7HwQtv7EdaWHx86pUeB1HGkWIHL+NQzXfWFds/uMSm6YwoH5LcItFEcVuL922Kbuu8ENZeP1z1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865497; c=relaxed/simple;
	bh=TNVSQBOPCyTq1v4LT0F8z5O6jAz0H6Pp7Z0DRg0GUWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCLfCLcA+4ZcUx3hRMsKf5PEDtHfrqlWONcvi+tLA7jUxjiRzJohlRgFikZjOQ1VixmUgh1UM8Qq/2KP4Wm+UhA/HmuFoGHO0UPoCH4c6qEsrDVIIJ0zj69bIBg0wPno1M5EZhogsrYst5pGNcKH7xIymDXq/5yfIcahkxrzZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oYz1as5+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oYz1as5+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C142F152B;
	Fri, 19 Jun 2026 03:38:08 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ED303F62B;
	Fri, 19 Jun 2026 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781865493; bh=TNVSQBOPCyTq1v4LT0F8z5O6jAz0H6Pp7Z0DRg0GUWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oYz1as5+YOELFfU9x/VVN/utpFDjYMK9WyjRVLUAN9chVQIJaS/zeSZLtgOLMXPwg
	 BUbRG2FIQtHg/rGssnzljHJYCSQFz+QLCwzR7moEuZN+RSC3LCx8IubjmB0pPtzw0m
	 dhW48r2E+3wbfwURok52F8v98iV+xc8Rr2+xDUi0=
Message-ID: <749b0206-f2d5-44dc-b95b-5ade0bf3801a@arm.com>
Date: Fri, 19 Jun 2026 11:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] s390/idle: CPU idle driver
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 10:29, Alexander Gordeev wrote:
> On Thu, Jun 18, 2026 at 02:00:14PM +0200, Mete Durlu wrote:
> ...
>> This patch series introduces a CPU idle driver for s390 architecture
>> that leverages the existing cpu idle infrastructure and idle governor
>> to optimize idle state selection based on timer events and interrupt
>> patterns.
>>
>> - Implementation Overview
>> -----------------------------------------------------------------------
>>
>> The driver implements two idle states;
>>
>> **Polling Idle (shallow state)**
>> - Busy-loop implementation that prevents SIE-exit during short idle periods
>> - Zero exit latency, optimized for latency-sensitive workloads
>> - Maintains CPU with the guest, improving response times
>>
>> **Enabled Wait (deep state)**
>> - Traditional EW state that signals hypervisor availability
>> - Higher exit latency but more efficient for longer idle periods
>>
>> The idle governor dynamically selects between these states by monitoring
>> next timer interrupts and system interrupt frequency, choosing the most
>> appropriate idle state for each situation.
>>
>> - Performance Benefits
>> -----------------------------------------------------------------------
>>
>> Benchmark results across LPAR, KVM, and z/VM guests demonstrate significant
>> improvements for latency-sensitive and scheduler-intensive workloads:
>>
>> ```
>> Benchmark    | LPAR  | z/VM  | KVM   |
>> -----------------------------------------
>> cyclictest   | +45%  | +50%  | +30%  |
>> hackbench    | +5%   | +12%  | -     |
>> pgbench      | +2%   | +15%  | +2%   |
>> uperf        | +50%* | +-5%  | +-5%  |
>> ```
>>
>> *Single-threaded uperf scenarios show 50-70% improvements on LPAR.
>> Multi-threaded results show slight improvements overall.
>>
>> Additionally, fio and ioping tests show latency distribution shifts toward
>> lower values with reduced minimum and average latencies.
>>
>> - Configuration
>> -----------------------------------------------------------------------
>>
>> Target residency and exit latency values are benchmark estimates. Due to
>> s390's virtualized architecture, these values are non-deterministic.
>> Idle state parameters are tuned per hypervisor type after benchmarks:
>>
>> **LPAR:**
>> - EW: 5us target residency, 5us exit latency
>>
>> **KVM/z/VM:**
>> - EW: 1us target residency, 1us exit latency
>>
>> ---
>> Mete Durlu (5):
>>       s390/tick: Remove CIF_NOHZ_DELAY flag
>>       tick: Remove arch_needs_cpu
>>       s390: Enable TIF_POLLING_NRFLAG
>>       s390/idle: Introduce cpuidle for s390
>>       s390/configs: Enable cpuidle driver on s390
>>
>>  MAINTAINERS                         |   8 +++
>>  arch/s390/Kconfig                   |   5 ++
>>  arch/s390/configs/debug_defconfig   |   2 +
>>  arch/s390/configs/defconfig         |   2 +
>>  arch/s390/include/asm/processor.h   |   4 --
>>  arch/s390/include/asm/thread_info.h |   1 +
>>  arch/s390/kernel/idle.c             |   1 -
>>  arch/s390/kernel/irq.c              |   4 --
>>  arch/s390/kernel/smp.c              |   1 -
>>  drivers/cpuidle/Kconfig             |   5 ++
>>  drivers/cpuidle/Kconfig.s390        |  11 ++++
>>  drivers/cpuidle/Makefile            |   4 ++
>>  drivers/cpuidle/cpuidle-s390.c      | 115 ++++++++++++++++++++++++++++++++++++
>>  include/linux/tick.h                |   3 -
>>  kernel/time/tick-sched.c            |   7 +--
>>  15 files changed, 156 insertions(+), 17 deletions(-)
>> ---
>> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
>> change-id: 20260609-idledriver-217e2b2712a3
>>
>> Best regards,
>> -- 
>> Mete Durlu <meted@linux.ibm.com>
> 
> Applied, thanks!

All of it? Rafael should probably at least ack drivers/cpuidle/* things...
