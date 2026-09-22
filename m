Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CC28CF5F
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073020; cv=none; b=oIEx+Tad67NvNxECbi9DJsu9pdQRxKadp8dQ5D1nPoUzPfVW4mch+1J+TW/u3uZWdqsJu6SjSqjJ88Do2vHSZv7msxyXAYdqE5+gp8YZBXIopHubBkiFYoxfsDc6L3DrkbcLd9hFiJhkt0EEL9L7kJ5/q9CTAu/E2N+diX2bpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073020; c=relaxed/simple;
	bh=59PltlXaLPMT4dAfY0oLhaheYL3kAdvQ77GsNasOfFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+lXCcYWr+yeEieLfzl+MGDc6DWE+bxpYzrlNZdHQlaug+etU6ZEAG2+8Lz1lpGJyWm+iZrqTIWMH7+yHOX/WfnbQWqL4uGXpNACRWK54kSca8W4OaHW0Jw1wQH9EXeNsCGq8rHYO6BgCBz4FyYJ65efHjY+MGfqoS6/Rfr56KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KBYxk2+U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KBYxk2+U"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05WRd2940065
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LY4elP
	0QHLr2eBkGvrCEGveXc9EcRPoXA80P63v04M8=; b=KBYxk2+UIaq9j+k94b4ETr
	eG77pjgS1VR2a5jfaOCL8awMrhUhsMp5/8B4mI2HeHJ0umW3FTiJfaGYciGAqlRU
	T9a2U605SyeOwOrn9UlSSir5o0rC8xxf2bbEdVocRrJo9yduEydmSurCNMCEB45/
	Z/BHZGEpDciHm0lwwSoyHmJN9wzqpr/ZhBE9Ewz8l9yvAGT7OJtcZZt6b1kZIWAx
	yOnVedI2uy8nVZ2iD0NtLRS6yaNybiJaN7e4lNBtWs6JXX8E8pmWmC1cKxDUsdoQ
	QabF9w7GlRDRvTvpWzAzDnr8mtbKlgUcHwE4UXPF55t5aApHGjanAFWOF/85efEg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2d7we-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:30:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA3LOi2085693
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:30:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq9ha1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:30:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAUE1q55378192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:30:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C50758062;
	Tue, 22 Sep 2026 10:30:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9461F58057;
	Tue, 22 Sep 2026 10:30:13 +0000 (GMT)
Received: from [9.224.94.162] (unknown [9.224.94.162])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 10:30:13 +0000 (GMT)
Message-ID: <ecd27176-fce9-4a87-8f5a-3da9f3276985@linux.ibm.com>
Date: Tue, 22 Sep 2026 12:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/debug: Fix NULL pointer dereference in
 debug_info_copy()
To: Heiko Carstens <hca@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
 <20260918104446.20386Dd4-hca@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260918104446.20386Dd4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RH1bU627GfFspHMc7cPI3q45c5gGTu_m
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab258b9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mSee3cdWVumBI9ZRaUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfX6GqXpCzuQDYM
 Y9XafmNRJITb01RZBNdKSJPU29kt1bDsH0wdwGB8CMwybMkuoRuKVSG8uVw5Grlpmu9k+lnI6At
 DS0UtVYrj78LIkl4dBHmu47zxTqCbwZqR4BX5/s3HVD+f8vj/TMnf86YaFbc9/fJcES1dDQ9hVZ
 oOyB9EA7GDXcbttOCMbAOumtWRYlqRB2jjX81ZydRvvW9kAj2U/6H4kM7/+b195iYg/RGKDxref
 CFG9+wZ5uOH20y2FV8TV1z3LVKLoL4NAbeYT01Etk6FrBMMElguB6/CLejjq8klr8nSiUzxPwkl
 Z4NAkNDezN5BdZFoSInwGMFaTtPO74v38X+cOEIZvzg8ACFSRnPiXh37p00bIHAx4BQ5+2sdGHi
 yhUNJi07XRW2TwFlNckJb1XT3YItlAo0RPtguhwfbbezBYlhYvBtF68VNy/UTFI4iBM5MyQHNly
 G/l6VFbjm9dbYynV6mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfX9V+QxfBQFW76
 zkbMEZV555rCi7k3xRnw59bh0ntz2hOBGtScT+0XuOoVKNgl2QxSANszocrfWHEKOunWlqNz7U4
 1Rtv1rroquTIDmWzht/csMqjP0WvBD8=
X-Proofpoint-GUID: RH1bU627GfFspHMc7cPI3q45c5gGTu_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220145

On 18.09.2026 12:44, Heiko Carstens wrote:
> On Wed, Sep 16, 2026 at 06:06:26PM +0200, Mikhail Zaslonko wrote:
>> When debug_register_static() fails, it clears areas, active_pages and
>> active_entries but leaves the area bounds unchanged. Copying such an
>> area, either by opening its view file or via debug_dump(), makes
>> debug_info_copy() dereference the NULL pointers.
>>
>> Skip the copy loop when the source has no areas.
>>
>> Closes: https://lore.kernel.org/r/20260903132123.12F271F00A3F@smtp.kernel.org
>> Fixes: d72541f94512 ("s390/debug: add early tracing support")
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> ---
>> v2:
>> - Different approach: check the areas pointer in debug_info_copy()
>>   instead of zeroing nr_areas/pages_per_area in debug_register_static().
>>   Zeroing nr_areas made debug_info_alloc() return ZERO_SIZE_PTR for
>>   active_pages/active_entries, which debug_to_act_entry() dereferences
>>   before debug_prev_entry() checks id->areas.
>>   Checking the pointer also matches what all other readers in this file
>>   already do.
>> - v1: https://lore.kernel.org/all/20260910104525.3788362-1-zaslonko@linux.ibm.com/
>>
>>  arch/s390/kernel/debug.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
>> index b5bf8284dbfc..d611d0eed1f6 100644
>> --- a/arch/s390/kernel/debug.c
>> +++ b/arch/s390/kernel/debug.c
>> @@ -434,7 +434,8 @@ static debug_info_t *debug_info_copy(debug_info_t *in, int mode)
>>  		debug_info_free(rc);
>>  	} while (1);
>>  
>> -	if (mode == NO_AREAS)
>> +	/* debug_register_static() failure leaves areas NULL, bounds intact */
>> +	if (mode == NO_AREAS || !in->areas)
> 
> This is just a more or less random indicator that debug_register_static()
> failed. But this seems to be the easiest way forward. Alternatively an
> explicit flag in debug_info_t would make this more obvious.
> 
> Anyway:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Waiting for Peter's reply.

As Heiko mentioned, this can be done in a number of ways, but this one
is fine from my perspective.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
