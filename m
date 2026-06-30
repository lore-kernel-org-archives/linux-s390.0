Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC23FF1B1
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816892; cv=none; b=kGL5U1tGuYYKa9EG5S1D+vvVCRwIqSHtcduoPi2Tgjc0f+W/JSwRHd4CXJ3tikJonnYnx+o/vx9HfSgPVgPwJTi9Mt06j2hBWeBwOo2IXoxegYJnjqJzpXjqC3ykehWhVbf0b/4+N1ORZzSjGch1y5bf+HWCeN5nPVZ5MHGfRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816892; c=relaxed/simple;
	bh=E8EahJDvPAF4YNz8qwUiqjlfr2BkB4p68tS2KHq5a6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=semZeg2OCfOH1xSti/aO3JH+Rnp9FKmecjKcyO50J7PqvEemHdbafFOsW/kEpXPoBU44enB+VQIA5YH9OHC6ttTB2giOaeMM6trTptoM8bPomItqQO2vuRQ3aQ3Q1UuzcRpd3MYFuh/oi/qZ8ORspXdbEbaNsQEFg7H/Vp5AAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBTiaqcc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBTiaqcc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4sx1647794;
	Tue, 30 Jun 2026 10:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Im+B37
	/SL9oA94Sy66pOLWN1+mjEkNkV4Bpkm4TMsck=; b=SBTiaqccJhtw4uRiZKWPP1
	4kpl67e8q4PK1hlPn2+G7Y1MkXiplASeBVA07ghGZAmJ2mK4KTN8KmOv+/5IBqX9
	H1+z7e6FUMUHJYPyn4DkupQN7VxDaHJ6QzErCVO5w1wF4CJLLM5nbIvJyfjHEKqs
	A21oaENB4MlKr2ntdmdOH1WZ5TZ6XsDLPlUbZF6EWKmFLjfu3AO6pqlD2vKIpfWh
	/2xAm4tX6EOFh7UpDnhfJongaLQerLjwZKPJHEja2R0S3zSrYlJ6hOgRTYNZgcAm
	3eZ4MXoTzRUdpIKainu9WnCDhWiFAlr/ff4ySiq+hSqz6xZVr84sgEFVR/Forzpw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5p8hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:54:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAnfLB014922;
	Tue, 30 Jun 2026 10:54:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk1s6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:54:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAsbaL48234814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:54:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899EA2004B;
	Tue, 30 Jun 2026 10:54:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA5EB20040;
	Tue, 30 Jun 2026 10:54:36 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.74.190])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:54:36 +0000 (GMT)
Message-ID: <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
Date: Tue, 30 Jun 2026 12:54:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
 <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
 <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
 <a6e637d07024e0ff8a457500110e225f@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <a6e637d07024e0ff8a457500110e225f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5OCBTYWx0ZWRfX4ZgeIXc8DGH7
 K35j8LgT+FW1eINpA3LjECbRV8qZZHSWcAbNovqo0KkMw4kBH9N6v2dtEgXKM1Znu/AVywUe63+
 PcIrIraxhW15dmxgCNHOWDeqmwW5Vub3SswMb0nc/Oc6/UHJ1EQ4To6Gya38dIxTT88R784zZFD
 rLXMAUdZEwECl7hogddka74OEGZ+4FaRpJq9czwwE0mYrjkx+3DW9SmkF/Uf2bYDNq4qnJ4S1Kb
 DxScbCUl8Tzf2GQWZgwOoUnuD3CcrD6YS7M9Zam9JIjAmZoDEs5o1UhRfJRuveKl5BC9oDqFpdO
 3aUaU7hCJhss6opsz0F1J1f01DonvU1MGMQG6na/weKGb8wEx+9dS/57yadoyyVOx26HuVCKhFn
 a1IIi910z8pb81RLQ5jWQs7bAWHlDtGhPLRh4Wv/U7T4mwHrGWGIAaZGHIoDl8a3K4y+sv9dWgA
 6Bqxq5Y+zUWC+F7mFXg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43a073 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0qfM-hUmz0_4sP66ULwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9KN980UPFeBcI_xoQe3G--psREiQeajr
X-Proofpoint-GUID: 9KN980UPFeBcI_xoQe3G--psREiQeajr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5OCBTYWx0ZWRfXyRl/DIQJq8la
 OtMKbXbfVKA4x0iy19EW8v5U298SlWb85c/pTjtue11fkJjrunclvVHTva/YUNpG8Lpyq93pfP3
 ow5a5AIIHaGbK7isSmEdR/fVH3/5nlw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300098



On 6/30/26 12:23, Harald Freudenberger wrote:
> On 2026-06-30 11:33, Ilya Leoshkevich wrote:
>> On 6/29/26 14:57, Harald Freudenberger wrote:
>>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>>> With the introduction of the address wrapping function
>>>>> wrap_address() the result can't be used to walk the
>>>>> source address any more. So introduce a new local variable
>>>>> to hold the wrapped address to avoid mixing source and
>>>>> wrapped address value.
>>>>>
>>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>>> argument")
>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>> ---
>>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> If I take as an example AMODE 24 and look at the third loop iteration,
>>>> with the current code in master I would get:
>>>>
>>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>>>
>>>> and with your patch it would be:
>>>>
>>>>     (addr + 8 + 8) & 0xffffff
>>>>
>>>> which is undeniably more elegant, but otherwise looks equivalent to me.
>>>>
>>>> What is the functional issue here?
>>>>
>>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>>> crypto_helper.c
>>>>> index ae392bce0e..29ad2aff43 100644
>>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>>>>> const int mmu_idx,
>>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>>>> mmu_idx);
>>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>>> -        addr = wrap_address(env, addr);
>>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>>> +        uint64_t _addr = wrap_address(env, addr);
>>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>>       }
>>>>>   }
>>>>
>>>> [...]
>>>
>>> It is a fix, not an improvement. The original code
>>> used the addr variable to hold the wrapped address.
>>> But as addr is also used as the loop variable there
>>> is a mixing between unwrapped and wrapped address here
>>> and the unfixed code only works when wrap_address does
>>> return the very same address as output as it became as
>>> input. My fix corrects this.
>>
>> What does the patch change w.r.t. wrapping?
>> Suppose we have amode 24 and addr = 0xfffff0:
>>
>> Before:
>>
>>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>>          a[0] = ldq(0xfffff0);
>>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>>          a[1] = ldq(0xfffff8);
>>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>>          a[2] = ldq(0);
>>   i = 3; addr = wrap(0 + 8) = 8;
>>          a[3] = ldq(8);
>>
>> After:
>>
>>   i = 0; addr = 0xfffff0;
>>          _addr = wrap(0xfffff0) = 0xfffff0;
>>          a[0] = ldq(0xfffff0)
>>   i = 1; addr = 0xfffff0 + 8;
>>          _addr = wrap(0xfffff8) = 0xfffff8;
>>          a[1] = ldq(0xfffff8);
>>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>>          _addr = wrap(0x1000000) = 0;
>>          a[2] = ldq(0);
>>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>>          _addr = wrap(0x1000008) = 8;
>>          a[3] = ldq(8);
>>
>> The behavior look identical to me.
>> What am I missing?
> 
> Lets assume addr is some 0x1000 and wrap does just add some offset, e.g. 
> 0x8000
> 
> for (int i = 0; i < 8; i++, addr += 8) {
>      addr = wrap_address(env, addr);
>      fetch or write something at the wrapped address addr;
> }
> 
> Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
> 1. loop with i=0 and addr 0x1000
> 2. loop with i=1 and addr 0x1000 + 8
> 3. loop with i=2 and addr 0x1000 + 8 + 8
> 4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
> 5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
> 6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
> 7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
> 8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8
> 
> BUT the given code does something different. As the addr is used in the 
> loop
> to hold the wrapped address this loop in fact does:
> 1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
> wrap_address() at the
>     end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next loop 
> starts with
> 2. loop with i=1 and addr 0x9000 + 8
>     and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and 
> next loop starts
> 3. loop with i=2 and addr 0x11008 + 8
>     ...
> 
> So introducing an intermediate variable which holds the wrapped address
> makes sure the surrounding addr walk in the loop does as intended.

Ah, now I see where we were talking past each other, thanks for the
clarification. You assume that wrap_address() may do arbitrary
transformations, like addition in your example above. But today it does
only bitwise "and", as defined by the architecture:

static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
{
     if (!(env->psw.mask & PSW_MASK_64)) {
         if (!(env->psw.mask & PSW_MASK_32)) {
             /* 24-Bit mode */
             a &= 0x00ffffff;
         } else {
             /* 31-Bit mode */
             a &= 0x7fffffff;
         }
     }
     return a;
}

and I believe in this specific case the order doesn't matter.
