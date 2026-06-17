Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163C347503;
	Wed, 17 Jun 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680545; cv=none; b=MGyKe8g/1lAfaS/3XbWHi1nGN5DLHrzCAyuvXXSiAfuNjiNnbyc/KQwKM5Ep7bEA7Jjtez+w66FAS2dw9nhakduLlcD6wgAGVo+q2z7sQMsjWDzq/NTYMOhJ0yqGpD3zYhh3Q8ylMEBe6oO3eGVpB0TLr93/LF9xb1aoN+tbHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680545; c=relaxed/simple;
	bh=uWOLKC73XAcqNC2asyzbDC2LmPMSYlm0M9c2sUQ/3Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG9pFy1FoYkIMLxv1wcw504kp6Xjk3rpoQcrhY+2CXSbYA43iyGw5T/aIwmUSBzunm8138fKQQg4MioBaL6oj+XH0SN0Z9dlBSjM0flnDo0W8wTJEXkPTRbvDl+3YFR2ubyCDESd2m2pIzSATb6v3AkulxwN4dD74cl6H9STLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e1btydOr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e1btydOr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F84483F;
	Wed, 17 Jun 2026 00:15:36 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66F003F915;
	Wed, 17 Jun 2026 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781680541; bh=uWOLKC73XAcqNC2asyzbDC2LmPMSYlm0M9c2sUQ/3Wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1btydOrBoulh5hrB8lrsdCYaAbaVveBaJCE1h3pSY6iEEIsHOzcY0XR3DXv3UjYI
	 sXQXdNgztwk4n1UHgoX2GOxqIkCKVREawbisbBChcWhmOiuz5JOhbFQPfF3NT67qWG
	 R50KTx5b2dsF5rgUZpAVUpkuujA8eNrswkADY5WA=
Message-ID: <445a6ab5-3574-4493-9187-701ee7ea7c28@arm.com>
Date: Wed, 17 Jun 2026 08:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] s390/idle: CPU idle driver
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
 <0e6ff23c-b509-40eb-87f3-7b04fb066edf@arm.com>
 <93743121-2f6f-441b-8675-4eaa92647b4d@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <93743121-2f6f-441b-8675-4eaa92647b4d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/26 21:23, Mete Durlu wrote:
> On 6/9/26 5:47 PM, Christian Loehle wrote:
>> On 6/9/26 14:24, Mete Durlu wrote:
>>> v1 -> v2:
>>>
>>> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
>>> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>>>    (Christian Loehle)
>>>
>>> This patch series introduces a CPU idle driver for s390
>>> architecture that leverages the existing cpu idle infrastructure and
>>> TEO (Timer Events Oriented) governor to optimize idle state selection
>>> based on timer events and interrupt patterns.
>>
>> So if (according to v1) there's no data (yet) that teo is much preferred,
>> I would remove all mentions of it in code and patch descriptions?
>> A cpuidle driver requiring a specific governor sort-of violates the
>> abstraction.
> 
> True, s/TEO governor/idle governor/g + s/TEO/idle governor/g should
> be good enough.
> 
>> In case teo does work much better for you, which I wouldn't doubt for
>> a second from what your system looks like, it would be nice to present
>> some data on it. Additionally I think setting it in the defconfig alone
>> is probably enough?
>>
> 
> I ran a quick menu vs teo run on an LPAR.
> There was no significant change between the results of the benchmarks
> except for slightly higher cpu utilization when using menu governor. I
> can put it down to the cover letter. The only noticeable change is on my
> micro benchmark where I use epoll_wait() to make two threads on
> different cores ping each other.
> 
> micro-benchmark |   teo    |   menu
> -------------------------------------
> avg time        | ~21.6sec | ~24.3sec
> 
> Idle framework tries to find the specified governor in the driver struct
> but if it can't find it or no governor was specified it uses the next
> available one, so setting teo on defconfig and disabling rest of the
> governors can be good enough to pick teo.
> 

Thanks for testing!

> 
>>> - Configuration
>>> -----------------------------------------------------------------------
>>>
>>> Idle state parameters are tuned per hypervisor type after benchmarks:
>>>
>>> **LPAR:**
>>> - Polling: 5us target residency, 0us exit latency
>>> - EW: 5us target residency, 5us exit latency
>>>
>>> **KVM/z/VM:**
>>> - Polling: 1us target residency, 0us exit latency
>>> - EW: 1us target residency, 1us exit latency
>>>
>> I think this would also be useful in cpuidle-s390.c in particular the
>> different residency+latency values for LPAR and KVM/z/VM and what they aim
>> to achieve for you.
> 
> We can put down a comment like below;
> 
> /*
>  * After various benchmark runs the tuneables for idle driver has shown
>  * the best performance with the following values;
>  * for LPAR:
>  * - Polling: 5us target residency, 0us exit latency
>  * - EW: 5us target residency, 5us exit latency
>  *
>  * for KVM/z/VM:
>  * - Polling: 1us target residency, 0us exit latency
>  * - EW: 1us target residency, 1us exit latency
>  */
> 
> Is that what you are looking for or something more extensive to cover
> what sort of behavior it causes and why it benefits the performance?
> I wouldn't really like to put down lengthy comments here to be honest.

Why not?
At least to me the values are hard to follow and without knowing what they
represent.
For example is this actually the worst case exit latency for these systems?
Also from a cpuidle perspective residency == latency isn't outright wrong
but certainly always a little suspicious.

> 
>> Additionally polling is initialised to 0/0 by poll_state.c, so I don't know
>> where you're taking these values from?
> 
> Having a look at the implementation of poll_idle() in poll_state.c.
> The polling time limit (target_residency) is acquired from
> cpuidle_poll_time(), which tries to find an enabled state deeper than
> polling state and returns its target_residency. Since we only have two
> states, it automatically means EW state's target_residency, or
> IDLE_POLL_MAX if it is disabled.

I agree that cpuidle_poll_time() can derive the polling time limit from a
deeper enabled state, but it only does that for states with
target_residency_ns >= CPUIDLE_POLL_MIN (10us). With the proposed s390 EW
values of 1us/5us, that state is skipped and the poll limit falls
back to CPUIDLE_POLL_MAX (TICK_NSEC / 16).


> 
> If I am not mistaken governor also uses the next enabled state
> to calculate the target_residency of the polling state.
> 

With just two state that is practically what happens in the selection
algorithm anyway, yes.
