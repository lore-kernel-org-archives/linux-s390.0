Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34F233D9E;
	Wed,  6 Aug 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499946; cv=none; b=Jd0sd1rzy1ZxhZR5CMLd7QNZ3+MWVlSnOixL4GYmcT9OX+EafA9+5tknZsZZ4ez6jdZopi/nrZ/F3SpVju26cwSlRntd9LbgmjOwzRLdIhp1ClorqEd3wMgZOEF0cchyFAhLtKPYfNWbxPlj2bWq52BpqeilViMrLtA8sS6zJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499946; c=relaxed/simple;
	bh=Jmz/+VKR4XnSAOIDVbh88tmRY+PRQkJpX8qCRvZ0awI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/K0OK1VZhQ4ad2ZInp4WBJ0v/v5TOY1Zi3XDss3jTKMt7faIVC4pOCKmsH6nB31ABrc0BI6B1XXwGfv68mJcLl+AscDcCwqO+FuluLx0k8ZsR1MerxgWxGmBFAdpW8PaOgjLBOgIOXDZ2bx3dCUy9Z7QCKdEkGlVOv73PfECOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWLZPzqS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWLZPzqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754499945; x=1786035945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jmz/+VKR4XnSAOIDVbh88tmRY+PRQkJpX8qCRvZ0awI=;
  b=QWLZPzqSyd3voQca1A0srV+39hNWMFyfWvl2YCaPMqpjh5Fgac1X0EfV
   Z1FgL8czSOpiPYQu+VYaXaZjAnn+hyUaS/yzXn6VhfXrHSm5uYIsCzMv6
   HvqYhrjLhD9MnNPBAWC38sj1xXJCPy9F7fGTKeCD72ZyWyDidAUo6muYL
   rHw+xqcco/UFqfWJCnRPt97D1tbFwNQUOvvYfyEJS2eT7HrL6BNyYaQrk
   jmivbwqcH7q+m2EnQefW3G120D71UOJDuYt99J+7ck1n9eV91v/7fNDG7
   lIvzJA3L83VeeaOveX5CYH0Vz0zLV5uYZ5QvmikajOaHuBGBOSSMymWWT
   Q==;
X-CSE-ConnectionGUID: 1mZYFAJUQcuzdpenKPAIIQ==
X-CSE-MsgGUID: unmiCWrRRfq7FOMluJXa5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59440261"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="59440261"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:05:44 -0700
X-CSE-ConnectionGUID: ikyCOtYwRJCAgC/YsxW0jw==
X-CSE-MsgGUID: lDZqGxs9SOiMFrHaa8YIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165236433"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:05:43 -0700
Received: from [10.124.113.62] (kliang2-mobl1.ccr.corp.intel.com [10.124.113.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9672D20B571C;
	Wed,  6 Aug 2025 10:05:41 -0700 (PDT)
Message-ID: <575d9c34-5546-47a2-83e4-5f5d12a17cb5@linux.intel.com>
Date: Wed, 6 Aug 2025 10:05:40 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 07/16] s390/perf: Remove driver-specific throttle
 support
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com, linux-s390@vger.kernel.org
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-8-kan.liang@linux.intel.com>
 <aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <aJMUZTJ7FmB9FW9r@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aJMUZTJ7FmB9FW9r@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sumanth,

Sorry for the late response. I just came back from Sabbatical yesterday.

On 2025-08-06 1:37 a.m., Sumanth Korikkar wrote:
> On Wed, Jul 23, 2025 at 10:06:26AM +0200, Sumanth Korikkar wrote:
>> On Tue, May 20, 2025 at 11:16:35AM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The throttle support has been added in the generic code. Remove
>>> the driver-specific throttle support.
>>>
>>> Besides the throttle, perf_event_overflow may return true because of
>>> event_limit. It already does an inatomic event disable. The pmu->stop
>>> is not required either.
>>>
>>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>>> Cc: linux-s390@vger.kernel.org
>>> ---
>>>  arch/s390/kernel/perf_cpum_cf.c | 2 --
>>>  arch/s390/kernel/perf_cpum_sf.c | 5 +----
>>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
>>> index e657fad7e376..6a262e198e35 100644
>>> --- a/arch/s390/kernel/perf_cpum_cf.c
>>> +++ b/arch/s390/kernel/perf_cpum_cf.c
>>> @@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
>>>  	}
>>>  
>>>  	overflow = perf_event_overflow(event, &data, &regs);
>>> -	if (overflow)
>>> -		event->pmu->stop(event, 0);
>>>  
>>>  	perf_event_update_userpage(event);
>>>  	return overflow;
>>> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
>>> index ad22799d8a7d..91469401f2c9 100644
>>> --- a/arch/s390/kernel/perf_cpum_sf.c
>>> +++ b/arch/s390/kernel/perf_cpum_sf.c
>>> @@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
>>>  	overflow = 0;
>>>  	if (perf_event_exclude(event, &regs, sde_regs))
>>>  		goto out;
>>> -	if (perf_event_overflow(event, &data, &regs)) {
>>> -		overflow = 1;
>>> -		event->pmu->stop(event, 0);
>>> -	}
>>> +	overflow = perf_event_overflow(event, &data, &regs);
>>>  	perf_event_update_userpage(event);
>>>  out:
>>>  	return overflow;
>>> -- 
>>> 2.38.1
>>
>> Hi all,
>>
>> This seems to break POLL_HUP delivery to userspace - when event_limit reaches 0
>>
>> From perf_event_open man page:
>> PERF_EVENT_IOC_REFRESH
>>               Non-inherited overflow counters can use this to enable a
>>               counter for a number of overflows specified by the
>>               argument, after which it is disabled.  Subsequent calls of
>>               this ioctl add the argument value to the current count.  An
>>               overflow notification with POLL_IN set will happen on each
>>               overflow until the count reaches 0; when that happens a
>>               notification with POLL_HUP set is sent and the event is
>>               disabled.
>>
>> When the event_limit reaches 0, the POLL_HUP signal is expected to be
>> sent. Prior to this patch, an explicit call to event->stop() was made,
>> which may have contributed to ensuring that the POLL_HUP signal was
>> ultimately delivered. However, after  this change, I often did not
>> observe the POLL_HUP signal being delivered as expected in the end

The event_limit case also returns 1. I missed it when fixing the
throttle issue. :(

I didn't use the IOC_REFRESH before. According to the kernel code, it
reschedules all the events of the event->pmu, when the ioctl is invoked.
So we just need to move the event->pmu->stop() to the generic code as
below. It should keep the behavior unchanged.

Could you please try the below fix?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 14ae43694833..f492cbcd3bb6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10341,6 +10341,7 @@ static int __perf_event_overflow(struct
perf_event *event,
 		ret = 1;
 		event->pending_kill = POLL_HUP;
 		perf_event_disable_inatomic(event);
+		event->pmu->stop(event, 0);
 	}

 	if (event->attr.sigtrap) {

Thanks,
Kan

>>
>> Example program:
>> output:
>> Computation result: 49951804672
>> count.hup: 0 count.pollin: 22
>>
>> Expected output should be:
>> count.hup: 1 in the end
>>
>> #define _GNU_SOURCE
>> #include <time.h>
>> #include <stdbool.h>
>> #include <signal.h>
>> #include <poll.h>
>> #include <fcntl.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <unistd.h>
>> #include <time.h>
>>
>> #include <sys/ioctl.h>
>> #include <sys/syscall.h>
>> #include <linux/perf_event.h>
>>
>> static struct signal_counts {
>>         int in;
>> 	int out;
>> 	int hup;
>> 	int unknown;
>> } count;
>>
>>
>> static unsigned long sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>> 		PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR | PERF_SAMPLE_READ |
>> 		PERF_SAMPLE_ID | PERF_SAMPLE_CPU |
>> 		PERF_SAMPLE_PERIOD | PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW;
>>
>> static void sighandler(int signum, siginfo_t *info, void *uc)
>> {
>> 	switch(info->si_code) {
>>                 case POLL_IN:  count.in++;  break;
>>                 case POLL_OUT: count.out++; break;
>>                 case POLL_HUP: count.hup++; break;
>>                 default: count.unknown++; break;
>>         }
>> }
>>
>> void generate_load(unsigned long long iterations) {
>>     unsigned long long sum = 0;
>>     srand(time(0));
>>
>>     for (unsigned long long i = 0; i < iterations; ++i) {
>>         int rnd = rand();
>>         sum += (rnd ^ (rnd >> 3)) % 1000;
>>     }
>>     printf("Computation result: %llu\n", sum);
>> }
>>
>> void perf_attr(struct perf_event_attr *pe,
>> 		       unsigned long config, unsigned long period, bool freq,
>> 		       unsigned long bits)
>> {
>> 	memset(pe, 0, sizeof(struct perf_event_attr));
>> 	pe->size = sizeof(struct perf_event_attr);
>> 	pe->type = PERF_TYPE_HARDWARE;
>> 	pe->config = PERF_COUNT_HW_CPU_CYCLES;
>> 	pe->exclude_kernel = 0;
>> 	pe->sample_period = 50000;
>> 	pe->freq = 1;
>> 	pe->disabled = 1;
>> 	pe->config = config;
>> 	pe->freq = freq;
>> 	pe->sample_type = bits;
>> }
>>
>> int main(int argc, char **argv)
>> {
>> 	int fd, signo = SIGIO, rc = -1;
>> 	struct sigaction sa, sa_old;
>> 	struct perf_event_attr pe;
>>
>> 	perf_attr(&pe, PERF_COUNT_HW_CPU_CYCLES, 50000, 1, sample_type);
>> 	/* Set up overflow handler */
>> 	memset(&sa, 0, sizeof(struct sigaction));
>> 	memset(&sa_old, 0, sizeof(struct sigaction));
>> 	sa.sa_sigaction = sighandler;
>> 	sa.sa_flags = SA_SIGINFO;
>> 	if (sigaction(signo, &sa, &sa_old) < 0)
>> 		goto out;
>>
>> 	fd = syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
>> 	if (fd < 0)
>> 		return rc;
>>
>> 	rc = fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
>> 	rc |= fcntl(fd, F_SETSIG, signo);
>> 	rc |= fcntl(fd, F_SETOWN, getpid());
>> 	if (rc)
>> 		goto out;
>>
>> 	rc = ioctl(fd, PERF_EVENT_IOC_REFRESH, 2500);
>> 	if (rc)
>> 		goto out;
>>
>> 	generate_load(100000000ULL);
>> 	sigaction(signo, &sa_old, NULL);
>> 	printf("count.hup: %d count.pollin: %d\n", count.hup, count.in);
>> 	close(fd);
>> 	return 0;
>> out:
>> 	return rc;
>> }
> 
> Hi Kan,
> 
> It would be great if you could share your feedback on this issue.
> 
> Thank you.

