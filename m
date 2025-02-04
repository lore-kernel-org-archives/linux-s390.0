Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062672054F0;
	Tue,  4 Feb 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698067; cv=none; b=MYm3+jxhpFFxVQTyyTbsPuqMDY3D+JobPXz2qhrxOv0jMrtGm4vPubZkI0a8ygRzIeGXJJajDCIUWcHFYMZIA4fntzFSJcM/xhzIZ/XfdbxHHBKUkbjMHlyghUS+UlQw3yBwRcPZJ3lI56Y6ETVlzfMU60GhuqvbxnvgpxbYAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698067; c=relaxed/simple;
	bh=ZPd5d3LP4lSPJ0S+PvFfBrMSrUEFNR/QGVnE/v8NhkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EL/BvQqAMDyjKlZ92IoQ3dIg27SKHjwzqFa0CHeZdXtuc18YGKD1ZB1SkFp8jdRLuReMerJblDd5STiTHwhVAW/4joBTZoWOaDS346Z0i1CXXW3hG/AwJ+MGBjxnMVXbUH546nrcc3NbmU7zwVC3Zu1VFQh+igtxUez7xrHPSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+aWIPh/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+aWIPh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738698062; x=1770234062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPd5d3LP4lSPJ0S+PvFfBrMSrUEFNR/QGVnE/v8NhkM=;
  b=O+aWIPh/KkmKPVNCN72vDB7tVaGLMk/Z5JgTL8b/7JLUO19ccj0kSwq+
   kYWWbkQbB3ol96/fuA5Sn0YQHgMAV9eaPxxcWAv6SScy9RhyQbTlmHrCh
   xqE/oYLrmnnED27DY+IPE0i8AD9fITXBp8fxVux3uElnhr1NIWSfgVEk1
   jXjmdwouoAQdKDYFgb0Rhqsr2ou/xLuXWGjykCC0ICX0BrLKmdcO2S4g4
   giGnoj+8kJke2EOVEWTsmnos1zGHkGmmNCdN+oEnoOxfSazw+g46ygfcF
   I4biy0BPyOu13k0w/t72WogOGdUzv4kvf4Y9D9+vzOMGgn34BUFe59YAU
   g==;
X-CSE-ConnectionGUID: ichWZ9klScOQ7X2VYtNIyg==
X-CSE-MsgGUID: Wg+8xyWcQkythiIneRKOvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38452874"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="38452874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 11:41:01 -0800
X-CSE-ConnectionGUID: /XafOi5JTy+zcaEwQmVqsw==
X-CSE-MsgGUID: fIWPPb2CSEGKPV779jLAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="111230834"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 11:41:00 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 00B6020B5713;
	Tue,  4 Feb 2025 11:40:58 -0800 (PST)
Message-ID: <5da59431-e21f-42fa-927d-e5d346ae9713@linux.intel.com>
Date: Tue, 4 Feb 2025 14:40:57 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org,
 linux-s390@vger.kernel.org, james.clark@linaro.org, agordeev@linux.ibm.com,
 gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
 <Z6GMmxKvXd0-fd_-@google.com>
 <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
 <Z6JrkYYOkGcuKQOh@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z6JrkYYOkGcuKQOh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-04 2:33 p.m., Namhyung Kim wrote:
> Hello Kan,
> 
> On Tue, Feb 04, 2025 at 10:55:44AM -0500, Liang, Kan wrote:
>>
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
>>
>> As a non-precise test, using cycles instead should be fine. But we
>> should never use it for precise test, e.g., with p. Because cycles is a
>> non-precise event. It would not surprise me if there is a skid when
>> reading two cycles events at the point when the event overflow occurs.
> 
> Sorry, I don't think I'm following.  Are you saying "{cycles:p,cycles:p}:S"
> cannot guarantee that they will have the same period?

Only sampling can supports p modifier. So it should be
{cycles:p,cycles}:S. The "{cycles:p,cycles:p}:S" will error out.
Yes, it's not guaranteed that they have the same period.

Thanks,
Kan
> 
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks for your review and the comment!
> Namhyung
> 
> 

