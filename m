Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A222370D;
	Thu,  6 Feb 2025 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821971; cv=none; b=e5frxMPtpn9HDj9nxUNY01tbENjQqvTEoZ7hHiF8mOvQVFdRyfmsW87yisxTvmvv4XxvgFUBLOWeOOTBK68ALNl8tC3EKIi2Dbf4ye0yryY9lq/8c3oEeWTZeG9aFV4VJmJZ7rCu0bdkOGwSQYfkUGavN15H1Yau9/9LTczRfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821971; c=relaxed/simple;
	bh=+sxzlzrNtZjx+em7KXC8/phrKF6st5ThSNbzCs5vdJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZJYvBDGheg/V3vTwtB0hXpoh7YwX1tHFueLeWuFB8T8mBopo6KxOIiwVqv76256ye1TxvcOqTfIWO2SqnWpBmXO+xbEsOXPOvAL97dgOY5QxH74I1jIGmQhNGFx0i7D+PcO4q8EpBLsRXdOw5GlvAQRV50eGwluCjL1jGq6RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZLnlOQg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZLnlOQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738821970; x=1770357970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+sxzlzrNtZjx+em7KXC8/phrKF6st5ThSNbzCs5vdJw=;
  b=nZLnlOQgNSDiIgCCrK9eh6WgdVlxHteI1NRNW9jZGPCkV5V9UpQ3H1A0
   IvSx2P44upHmjWtZWxyufbFQV94Nak5k94lJf2yuAphUAo122RnNepOh5
   jmo6P08ZW1g7jv7AotXIDfln6svwPyx5TkCjOXqJFdUxcuqw0VhBaayj6
   R3jSMZN5/SaEWkFI1AZZaIB0/D1JiINE6zZiKAVio7wnFHCl8yPKTnofo
   f91kA36Yq4D+MxnSdYftwABlpRS7yzKmBI3mUPIkQ5YRhkKS/G0Fuuapf
   6VrY/eeVjv9r8WsC5DVXZTCZ1VMTygbG9pNt+17B54SRt1xcMeqVP3kix
   Q==;
X-CSE-ConnectionGUID: 8atJGDo0QR2SKyTmwT/kyg==
X-CSE-MsgGUID: ImgnSc87RTSIfsMuQjHUIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43071761"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="43071761"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 22:06:09 -0800
X-CSE-ConnectionGUID: JJOacnduSKmwDmmFhlOoXQ==
X-CSE-MsgGUID: Tu0xr7jmRRKiRISW8l/LIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="110896776"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 22:06:06 -0800
Message-ID: <688e9a7f-0b98-4f8a-b575-90d7de244589@linux.intel.com>
Date: Thu, 6 Feb 2025 13:42:58 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, linux-s390@vger.kernel.org, james.clark@linaro.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
 <Z6GMmxKvXd0-fd_-@google.com>
 <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/4/2025 11:55 PM, Liang, Kan wrote:
>
> On 2025-02-03 10:42 p.m., Namhyung Kim wrote:
>> Add Kan and Dapeng to CC.
>>
>> Thanks,
>> Namhyung
>>
>>
>> On Fri, Jan 31, 2025 at 11:27:56AM +0100, Thomas Richter wrote:
>>> On s390 the event instructions can not be used for recording.
>>> This event is only supported by perf stat.
>>>
>>> Change the event from instructions to cycles in
>>> subtest test_leader_sampling.
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Suggested-by: James Clark <james.clark@linaro.org>
>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>> ---
>>>  tools/perf/tests/shell/record.sh | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>> index fe2d05bcbb1f..ba8d873d3ca7 100755
>>> --- a/tools/perf/tests/shell/record.sh
>>> +++ b/tools/perf/tests/shell/record.sh
>>> @@ -231,7 +231,7 @@ test_cgroup() {
>>>  
>>>  test_leader_sampling() {
>>>    echo "Basic leader sampling test"
>>> -  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
>>> +  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
>>>      perf test -w brstack 2> /dev/null
>
> As a non-precise test, using cycles instead should be fine. But we
> should never use it for precise test, e.g., with p. Because cycles is a
> non-precise event. It would not surprise me if there is a skid when
> reading two cycles events at the point when the event overflow occurs.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Kan, I suppose you mean only the case without counter snapshot, right? With
counter snapshot's help, there would be same period even for non-precise
events, right?


>
> Thanks,
> Kan
>
>>>    then
>>>      echo "Leader sampling [Failed record]"
>>> @@ -243,15 +243,15 @@ test_leader_sampling() {
>>>    while IFS= read -r line
>>>    do
>>>      # Check if the two instruction counts are equal in each record
>>> -    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
>>> -    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
>>> +    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>>> +    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>>      then
>>> -      echo "Leader sampling [Failed inconsistent instructions count]"
>>> +      echo "Leader sampling [Failed inconsistent cycles count]"
>>>        err=1
>>>        return
>>>      fi
>>>      index=$(($index+1))
>>> -    prev_instructions=$instructions
>>> +    prev_cycles=$cycles
>>>    done < $script_output
>>>    echo "Basic leader sampling test [Success]"
>>>  }
>>> -- 
>>> 2.48.1

The code changes look good for me.


>
