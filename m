Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1B2147F4;
	Tue,  4 Feb 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684550; cv=none; b=U6C/Y3gBkkFJhmLLkbqB1dGlt9HObxK+5fgYGY1xVXk9XOHKLdWzu1dAipdUwt5jtc6DHBBdAplb0m39rpOk3dXKkRy1cltSQkdOxZs6/aMkQzhpmTXlorir5ZtubnSmEAdsE7NZoDmW9dGpuBOlKvo+qMZtWjOj1YNRKxCaq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684550; c=relaxed/simple;
	bh=MfU4zkvJuWsXPwef+2sVlFAfUNs2Bjk8e7EVIiknJ3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nn/M4QGGztNd4QS3MDPvDKuNU8GMOIBOe4Q70wa0nm5GgN3YgboR9yjMFgs1LGxbqwu2kdGLWF1GKcKxlS0s9R90Jt1o/OE5XtkuGGEKgvaq3qVtqdC9UHwzb6WMNY1kGkydrWWm94kxNKYQvow6f5hm89Zepdn5JCZEsWWcmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/CRGjlU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/CRGjlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738684549; x=1770220549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MfU4zkvJuWsXPwef+2sVlFAfUNs2Bjk8e7EVIiknJ3c=;
  b=O/CRGjlUdToDJfKvNz6maDie15RY9ZQZ958szwzxwF0CiGtX9zh0tPxB
   GHnxk+v3kY3MtEfnutNduT4iiZtE0gVfaXVImBVet8lZuuNiKi7MwRZ2A
   WyLbuY7BK9rOIVCKDb6ecWwmdwDFjuWhaW8xOQALilg63JstbraUjOqiq
   +m+hPHDMRAVKqS38T2sNdPETiNz1iNrq4+sDmU6B5Tri5pydMCtNEJv0I
   au1SDIf1c7U9WeU1kEvKKIMXH5AVhJDAS63NUUS6Y32RLG5F2ggHywmNc
   oOAppk0hV5ftFB39fTJ2edPErTp6dBELQBeZ9bLmFgn6SNVnTwu+rfgSY
   A==;
X-CSE-ConnectionGUID: pzswkPd+RXSmDixC3DcgUg==
X-CSE-MsgGUID: SDoHoyaIQ7GPRckxErn6TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38427055"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="38427055"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:55:48 -0800
X-CSE-ConnectionGUID: XoteHasDRlmHFrYrmOIhWA==
X-CSE-MsgGUID: Fvos8oJ/TGO8g//af5lAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133877889"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:55:47 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A5C6620B5713;
	Tue,  4 Feb 2025 07:55:45 -0800 (PST)
Message-ID: <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
Date: Tue, 4 Feb 2025 10:55:44 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
To: Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, linux-s390@vger.kernel.org, james.clark@linaro.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
 <Z6GMmxKvXd0-fd_-@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z6GMmxKvXd0-fd_-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-03 10:42 p.m., Namhyung Kim wrote:
> Add Kan and Dapeng to CC.
> 
> Thanks,
> Namhyung
> 
> 
> On Fri, Jan 31, 2025 at 11:27:56AM +0100, Thomas Richter wrote:
>> On s390 the event instructions can not be used for recording.
>> This event is only supported by perf stat.
>>
>> Change the event from instructions to cycles in
>> subtest test_leader_sampling.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Suggested-by: James Clark <james.clark@linaro.org>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>> ---
>>  tools/perf/tests/shell/record.sh | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index fe2d05bcbb1f..ba8d873d3ca7 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -231,7 +231,7 @@ test_cgroup() {
>>  
>>  test_leader_sampling() {
>>    echo "Basic leader sampling test"
>> -  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
>> +  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
>>      perf test -w brstack 2> /dev/null


As a non-precise test, using cycles instead should be fine. But we
should never use it for precise test, e.g., with p. Because cycles is a
non-precise event. It would not surprise me if there is a skid when
reading two cycles events at the point when the event overflow occurs.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>>    then
>>      echo "Leader sampling [Failed record]"
>> @@ -243,15 +243,15 @@ test_leader_sampling() {
>>    while IFS= read -r line
>>    do
>>      # Check if the two instruction counts are equal in each record
>> -    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
>> -    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
>> +    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>> +    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>      then
>> -      echo "Leader sampling [Failed inconsistent instructions count]"
>> +      echo "Leader sampling [Failed inconsistent cycles count]"
>>        err=1
>>        return
>>      fi
>>      index=$(($index+1))
>> -    prev_instructions=$instructions
>> +    prev_cycles=$cycles
>>    done < $script_output
>>    echo "Basic leader sampling test [Success]"
>>  }
>> -- 
>> 2.48.1
>>

