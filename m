Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0852E0415;
	Wed, 19 Nov 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538977; cv=none; b=jMaxhJwuvCUtpo/nX0+Ibd61EEjaMwT5XdT1wEGICC6L4g6ODd9B+/0OwG91LNEzp0cfph1ZZPz0KSrKoWqgNPaHSqwY+5JloTfdSLVdKWuQes6ibX70/aylHCqZ48tfGUeRaQcxB9QhtMKgk4hSA3/PmyZHmEJtEtFM9JZu6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538977; c=relaxed/simple;
	bh=fFOj0gYwi+B9zsla+smhaX51Vh+rEi/ZGYNhLplS608=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3HgYiBhkJQ6m88kkiMhDRFzwMdiC3pOXwUvPgXJg8sYZljcqBYHGrxl5H5MLLjHOyKOAUl2WaaN+Wb84HalAPgeBynFf4iiTEJb0Qr9mpyeMwOQsIyUiSb5pAInt4+D5e85OMNiQg6KthLRzm7Omob/+E/JwFIGFhHUIKvDfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YEHOTibS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YEHOTibS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7sKUH006274;
	Wed, 19 Nov 2025 07:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SYfiNP
	6hUuKh16OALQ2gAyjN8MsRmM1HU+NgA5w7pBA=; b=YEHOTibS5i5lJczfLd9Vjq
	iqmSI69v6CJExXl4Y5IYkt2sxMhE3eHZWP4onIdlMpAHpPP8pRCXJBoMO+r2W3vQ
	HCaRqC0nNBg+5TOckUw4GhtETHMkAGXtndcZryxJwPoTVSgzk8DTPhf7K/1E3Kyu
	j1KAuvnuUR+8zKG2sksOELD+9i5rRyRri9WbTyKqiFB95YsV+N4rnHY2yg7+xzKt
	bJuOhL4AvglJemRwsbKWGoDl/EMh4Z6KLh718CaetYKwyxg2Or7T9oOaiVm5zEur
	bOpnQpSMFkmG0CUv11iKD0PMLRD0NcxZnlhfoqCs0zyxIXfHIP1e+9xjjAKQhhGg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtxf7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 07:56:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ4a9jm017381;
	Wed, 19 Nov 2025 07:56:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1q71x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 07:56:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJ7txPO31654230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 07:55:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F262120043;
	Wed, 19 Nov 2025 07:55:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BBFA2004B;
	Wed, 19 Nov 2025 07:55:58 +0000 (GMT)
Received: from [9.111.88.30] (unknown [9.111.88.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 07:55:58 +0000 (GMT)
Message-ID: <81b3029e-6e9f-409e-93b8-495176992209@linux.ibm.com>
Date: Wed, 19 Nov 2025 08:55:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Jan Polensky <japo@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRy7V8EF6cRj8lCo@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aRy7V8EF6cRj8lCo@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e96yBkVVV0aDq6P6qcFdf39VqjP1ciY4
X-Proofpoint-ORIG-GUID: e96yBkVVV0aDq6P6qcFdf39VqjP1ciY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX/jUQ01kXuNRE
 vS0IFlG+BjkYQS6qH88JTQqeu1LU/9eRPflwPntBB3qL0r1RjnEXqjU+WjHOdGFcqNT7XE4u1hp
 su3NHgNHFDfKWn0i4rT9SL3l6FViwlv9yTggwH4727my2L8DRvEYUv3426E1PCwdjgiI5WeTS35
 3ef6uxfYP07bcngwjfWG/GEUzSbzhOWGlgmWLINs2ZsWbXZDDle89OUXNRTRejOdyAULQ3fnh6o
 2McpnH33YMvekihSDxOVgy6/NTCrI5/9zmq7ydMyk78U25rtpFIR16OymStiQZ2A4myjx/OxXCS
 NAOqx56c4MTVP+kh/GHGbPFEXQmmGrecgr3Lkvz1MzdELhYgkMov+6TkFrY8oVncwINmhAaG8RS
 Qdq/w+9VH9QAZnB8Jddxt8FSr6FA9A==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691d7813 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=lNeJwW5zoNWuYIwxTtkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On 11/18/25 19:30, Jan Polensky wrote:
> On Mon, Nov 17, 2025 at 01:43:59PM +0100, Thomas Richter wrote:
>> The following test case fails on linux-next repo:
>>
> ---8<--- snip ---8<---
>>  #
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
>> index ef2da806be6b..9cd6180062d8 100755
>> --- a/tools/perf/tests/shell/trace_btf_general.sh
>> +++ b/tools/perf/tests/shell/trace_btf_general.sh
>> @@ -39,7 +39,7 @@ trace_test_buffer() {
>>    echo "Testing perf trace's buffer augmentation"
>>    # echo will insert a newline (\10) at the end of the buffer
>>    output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
>> -  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
>> +  if ! echo "$output" | grep -qE "^echo/[0-9]+ write\([0-9]+, ${buffer}\\\\10, [0-9]+(, ..)?\) += +[0-9]+$"
>>    then
>>      printf "Buffer augmentation test failed, output:\n$output\n"
>>      err=1
> ---------------8<---------------
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> 
> Thank you Thomas
> 
> Nit: maybe `(, \"\")?` instead of `(, ..)?` for clarity?
> 

Thanks will do it.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
