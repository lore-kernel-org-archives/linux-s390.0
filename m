Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC209610C;
	Thu,  6 Feb 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851909; cv=none; b=rTcFI+oUM3BPGYA1Cl4wUWGCJO2Uq+KNuefr5rF4Y/TF4zgTg/ND9KXCLqpLOjtKjskOeFI00LtMN45stsn8wabBeyMY1nA7iXQPkqnkb1vuc2+2zdTNz2MtQ/HjLq0Kt5ZNXtz9hYbGFIWYRo3px1qsoWsvl5m2/76KUUo1+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851909; c=relaxed/simple;
	bh=cwTUjdQ0YvWtd8wQNBT4zvsceQsB9677KeuTtNGs3tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUUb7N0q4RG9vDcmGAXEVrc73GjJlXJkOhILRDBSoS5QqHPVAoG2nbFJ8Jgh7QnScXaR66zrMUXZQBHXlpvVLQE6bITIDKm22eis09iHgeCdfIg2MrfvwnZ+3ikKHPBLnyQWhKj7mJpubSICWiPJgdjCQF9/Py6b3bZA/YDm5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrzGLFfx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrzGLFfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738851908; x=1770387908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cwTUjdQ0YvWtd8wQNBT4zvsceQsB9677KeuTtNGs3tQ=;
  b=mrzGLFfxR70zdcqmJ/0w9ydqtW3b6gMZjl3WRxBHOqDa1yYKzIhNxfQj
   zpCFvCpWQgA0t7vp9Qi4h4xMJLdC0ADlQn7NYudSTQMI83ZDLD561Xiph
   0gAKZCZ8lgLLmYW49y+qrs7kg5XB28wgNxg3MYPehnNDPDyARDYkU9z/I
   Op8cA29Cw1DKOI9NaWO/pTC+fYkkYSNsI+aNKpmBSOc7GDzM51Cma9wet
   Avh3Jb2XVw3YgDL1sTx1REKNJ0XDaFWk3Pbf5K/ktsH7q1Bg9lbFKEUFn
   jaiw3ZvfKvtXg4uEoieYWrc/L5dvuJZgWrwSQQM8VruwXQVps4viLoiA3
   A==;
X-CSE-ConnectionGUID: JvmIuEIERh2Ei5gjFpv6ZA==
X-CSE-MsgGUID: 9bnHHzTxTByLKLs2iOuOYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39729231"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39729231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:25:07 -0800
X-CSE-ConnectionGUID: lxOVpppLRVWQxsfFHcoe+Q==
X-CSE-MsgGUID: 1o8WxGLgTr6c2qdSiHlyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111055033"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:25:07 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2439720B5713;
	Thu,  6 Feb 2025 06:25:05 -0800 (PST)
Message-ID: <69f7d048-e7dd-4863-a21f-2d8fafafd280@linux.intel.com>
Date: Thu, 6 Feb 2025 09:25:03 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, linux-s390@vger.kernel.org, james.clark@linaro.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
 <Z6GMmxKvXd0-fd_-@google.com>
 <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
 <688e9a7f-0b98-4f8a-b575-90d7de244589@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <688e9a7f-0b98-4f8a-b575-90d7de244589@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-06 12:42 a.m., Mi, Dapeng wrote:
> 
> On 2/4/2025 11:55 PM, Liang, Kan wrote:
>>
>> On 2025-02-03 10:42 p.m., Namhyung Kim wrote:
>>> Add Kan and Dapeng to CC.
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>
>>> On Fri, Jan 31, 2025 at 11:27:56AM +0100, Thomas Richter wrote:
>>>> On s390 the event instructions can not be used for recording.
>>>> This event is only supported by perf stat.
>>>>
>>>> Change the event from instructions to cycles in
>>>> subtest test_leader_sampling.
>>>>
>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>> Suggested-by: James Clark <james.clark@linaro.org>
>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>  tools/perf/tests/shell/record.sh | 10 +++++-----
>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>>> index fe2d05bcbb1f..ba8d873d3ca7 100755
>>>> --- a/tools/perf/tests/shell/record.sh
>>>> +++ b/tools/perf/tests/shell/record.sh
>>>> @@ -231,7 +231,7 @@ test_cgroup() {
>>>>  
>>>>  test_leader_sampling() {
>>>>    echo "Basic leader sampling test"
>>>> -  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
>>>> +  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
>>>>      perf test -w brstack 2> /dev/null
>>
>> As a non-precise test, using cycles instead should be fine. But we
>> should never use it for precise test, e.g., with p. Because cycles is a
>> non-precise event. It would not surprise me if there is a skid when
>> reading two cycles events at the point when the event overflow occurs.
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Kan, I suppose you mean only the case without counter snapshot, right? With
> counter snapshot's help, there would be same period even for non-precise
> events, right?

No, the counter-snapshot doesn't help. That's why I suggested to not
utilize it via enabling the modifier p. It should work for most of the
cases. But it's not 100% guaranteed for some non-precise events that the
same period is got at overflow. Since it's a test that could be run
everywhere, the occasional false alarm would just bring troubles.

Without p, it falls back to the traditional way of handling the sampling
read. In the PMI handler, the global control is disabled first, then all
the counters are read. The value may not be very accurate, since it's
stopped at the PMI handler, not the counter overflow. But because of the
global control, all the counters stop at the same time. The skid would
be the same. The test should work.

Thanks,
Kan
> 
> 
>>
>> Thanks,
>> Kan
>>
>>>>    then
>>>>      echo "Leader sampling [Failed record]"
>>>> @@ -243,15 +243,15 @@ test_leader_sampling() {
>>>>    while IFS= read -r line
>>>>    do
>>>>      # Check if the two instruction counts are equal in each record
>>>> -    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
>>>> -    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
>>>> +    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>>>> +    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>>>      then
>>>> -      echo "Leader sampling [Failed inconsistent instructions count]"
>>>> +      echo "Leader sampling [Failed inconsistent cycles count]"
>>>>        err=1
>>>>        return
>>>>      fi
>>>>      index=$(($index+1))
>>>> -    prev_instructions=$instructions
>>>> +    prev_cycles=$cycles
>>>>    done < $script_output
>>>>    echo "Basic leader sampling test [Success]"
>>>>  }
>>>> -- 
>>>> 2.48.1
> 
> The code changes look good for me.
> 
> 
>>

