Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770A32B128;
	Thu, 18 Jun 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798796; cv=none; b=K2gVGI4H04Mo5/s8+I9lClNAjdXeQKXdRPkphR3/MEwYx71PpxYylLBRhhYbcadkAwhJf5QmzLYHBw2qKcp6dO9hMxQpq8X/dX+V8rOt8Pc21+75nKJmNdPPOhWuzmd+qBQH2zAMv5zdSENfwgvoEBZmYWx2TkrQ9cdY0g1VvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798796; c=relaxed/simple;
	bh=S7/atp7qhCI/LBkPov1K1NfiCLzklLsUfrZnQ8z2FJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijP1R9qBAiP+0tgK8cQHpSaNbz4FS8hytmx0QPT9mxNfKBzyCR5A45AHDA/HWs5dNoGgv3kpx8qAecg0Oiy1RuBTONcWVb0jX1ONZJP6yKscdJ1ulBQ66tjeVANTMwxFWgbU/pY6NRNz6YuCOW2NGdtg0sPkMaNEfUE6ucqdCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aDf8Re86; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aDf8Re86"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF044493F;
	Thu, 18 Jun 2026 09:06:29 -0700 (PDT)
Received: from [10.57.24.180] (unknown [10.57.24.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2143F632;
	Thu, 18 Jun 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781798794; bh=S7/atp7qhCI/LBkPov1K1NfiCLzklLsUfrZnQ8z2FJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDf8Re86s92xSZizM8Uf0vxbf54v4hQwugiO0mbDN1+4dPUU2j8zKDqLuov8bLBiI
	 3CRiqjECQ46Xm1IQjJwM1nYPWKby+1bvSNGID0zZt8vGa95TRAJqkboktiqlRUE14F
	 9I7Fj3hbz0KJZbKK90ikSbzhAbZPpNo9UI/SSd8Q=
Message-ID: <e6723ea1-2400-4edc-aee8-8be7d9cb7945@arm.com>
Date: Thu, 18 Jun 2026 17:06:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
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
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
 <464e277c-40f8-4812-85f6-67b470436692@arm.com>
 <f280ac2a-7690-42eb-aca2-3cef711d71c9@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <f280ac2a-7690-42eb-aca2-3cef711d71c9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/26 15:47, Mete Durlu wrote:
> On 6/18/26 4:41 PM, Christian Loehle wrote:
>> On 6/18/26 13:00, Mete Durlu wrote:
>>> Introduce generic cpuidle driver on s390. Use a two stage approach to
>>> handle idle scenarios and use idle governor for idle stage selection.
>>> Two stages are, from shallow to deep, idle polling and enabled wait.
>>>
>>> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>>> ---
> 
> [..snip..]
> 
> 
>>> +static int s390_cpuidle_cpu_online(unsigned int cpu)
>>> +{
>>> +    struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
>>> +    int rc;
>>> +
>>> +    if (dev->registered) {
>>> +        cpuidle_pause_and_lock();
>>> +        rc = cpuidle_enable_device(dev);
>>> +        cpuidle_resume_and_unlock();
>>> +        if (rc)
>>> +            pr_err("Failed to enable cpuidle device on cpu %u\n", cpu);
>>> +    } else {
>>> +        dev->cpu = cpu;
>>> +        rc = cpuidle_register_device(dev);
>>> +        if (rc)
>>> +            pr_err("Failed to register cpuidle driver on cpu %u\n", cpu);
>>> +    }
>>> +    return rc;
>>
>> Most other drivers allow for hotplug cpu_online to succeed even if cpuidle doesn't, is
>> this intentionally done otherwise here?
> 
> Yes it is by design. Users would not be aware that something went wrong
> if we don't fail here (unless they check dmesg regularly which we don't
> expect). By failing here driver communicates that there is a problem
> and allows users to resolve that instead of letting a cpu run with
> degraded performance.
> 

Okay, thanks!
So FWIW this looks reasonable to me now, can't really comment much
on the s390 specifics, in particular as a guest, but from a purely
cpuidle perspective this looks okay, so good to see that this seems
to be working for you!

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
