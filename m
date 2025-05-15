Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90216D9C2;
	Thu, 15 May 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317378; cv=none; b=T/718vZ6GvaQ9CBeiSDx7zg5yZx9wASFtHf3sf1HJPK0F6KQJGVvj85Dpzl3Xpo3mwUZx4bDMdYhFIbH3TSH3DGMwzl8aX1wnvaZHdNhj9qOLk7k7ipLRfRmv8x7eYw2iIYBhCxV6068j9J/EJ4TAtQmQfUiAr3ssTpz9mDeEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317378; c=relaxed/simple;
	bh=pYlNEiJAuIX9acWWaPvE/09s073Bz/QGt0AgSOFRSe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqZl7XaLf5qX0XUNq5fMgN1rFUDk3MepQ4g0P0jueVV/koP+lxzhvB2Z1Gt+sR2ixJP6Ua0hVOq3RlglzQSr9swzmX+CDk+AOE5Z3hW06rJJts67moCDsFFo4jrjYLl1KrCPnfjaJDvPvRk2ZLUM0Vew/4I1Ul85nsX250L6+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp7rJh1M; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp7rJh1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747317377; x=1778853377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYlNEiJAuIX9acWWaPvE/09s073Bz/QGt0AgSOFRSe0=;
  b=Yp7rJh1MXDXYGzrih07CUNkHgTVy/v2Kbi9DPw6I0A90xv+a7vPOt30e
   Z+tkzwnyMNADJJ/lA2c/ml6xOSEv38Ui+7WtN32j37P5KE1DfG0mM/Yfn
   O5v89dV9y2zzzjPXCUz23qJaxDEbzWSk9K8YdKwmoEGKMK3HqWsJ2cXFs
   E4mAZ1WxszTHEEuy0QXgMXEKH24V7oRYgg0pQSDAI+uhLr0dilW2L4Htw
   Id+/MzvCukY56UzLj08IFQaIm/dUz2864TP4v5hQK34CgD7Fl8CBs0QHz
   h9341XOLU8YCRUz9d6vxgzml3QljXWlE9D5Zo7SC9ORQy9wm46tG4Q5DD
   w==;
X-CSE-ConnectionGUID: vJ+3e6M3R/6A0eplQjK01Q==
X-CSE-MsgGUID: edxajipLT4aMH6kPT+NbKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48941380"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="48941380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:56:15 -0700
X-CSE-ConnectionGUID: pBGFYyaYTEOkyzUQ6itKoA==
X-CSE-MsgGUID: mjLOwujnQjySkDTiuNQNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138775793"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:56:14 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1DAAC20B5736;
	Thu, 15 May 2025 06:56:13 -0700 (PDT)
Message-ID: <841b89af-9836-476f-984c-ebe54ccdc0ae@linux.intel.com>
Date: Thu, 15 May 2025 09:56:11 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/15] s390/perf: Remove driver-specific throttle
 support
To: Thomas Richter <tmricht@linux.ibm.com>, peterz@infradead.org,
 mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: eranian@google.com, ctshao@google.com, linux-s390@vger.kernel.org
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-7-kan.liang@linux.intel.com>
 <ec0827aa-0bae-4625-ad60-f1a1765a4811@linux.ibm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ec0827aa-0bae-4625-ad60-f1a1765a4811@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-15 9:15 a.m., Thomas Richter wrote:
> On 5/14/25 17:13, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The throttle support has been added in the generic code. Remove
>> the driver-specific throttle support.
>>
>> Besides the throttle, perf_event_overflow may return true because of
>> event_limit. It already does an inatomic event disable. The pmu->stop
>> is not required either.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>  arch/s390/kernel/perf_cpum_cf.c | 2 --
>>  arch/s390/kernel/perf_cpum_sf.c | 5 +----
>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
>> index e657fad7e376..6a262e198e35 100644
>> --- a/arch/s390/kernel/perf_cpum_cf.c
>> +++ b/arch/s390/kernel/perf_cpum_cf.c
>> @@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
>>  	}
>>  
>>  	overflow = perf_event_overflow(event, &data, &regs);
>> -	if (overflow)
>> -		event->pmu->stop(event, 0);
>>  
>>  	perf_event_update_userpage(event);
>>  	return overflow;
>> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
>> index ad22799d8a7d..91469401f2c9 100644
>> --- a/arch/s390/kernel/perf_cpum_sf.c
>> +++ b/arch/s390/kernel/perf_cpum_sf.c
>> @@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
>>  	overflow = 0;
>>  	if (perf_event_exclude(event, &regs, sde_regs))
>>  		goto out;
>> -	if (perf_event_overflow(event, &data, &regs)) {
>> -		overflow = 1;
>> -		event->pmu->stop(event, 0);
>> -	}
>> +	overflow = perf_event_overflow(event, &data, &regs);
>>  	perf_event_update_userpage(event);
>>  out:
>>  	return overflow;
> 
> I have installed patch 1 and 6 on top of the linux-next kernel today.
> The results look good, much better than before, but I still do not
> get both counter values in sync on each iteration all the time.
>

For Intel platforms, there is a global control register which can
disable/enable all counters simultaneously. It's invoked in the
pmu_enable/disable pair. It guarantees that the group start/stop/read in
sync.
If there is no such synchronize mechanism in the hardware, the events in
a group usually start/stop one by one. There may be a small gap between
each event.

I'm not familiar with the s390. I guess it may be the cause that you
didn't get both counter values in sync.

Without hardware's help, the patch set cannot completely fix the gap
between counters, but should be able to minimize it.

> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Thanks!Kan
