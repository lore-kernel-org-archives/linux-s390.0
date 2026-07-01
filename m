Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5C182D6
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895968; cv=none; b=oD5s1nPPKCBA5/0eLdoxpDQ6Z5I+rqK5+A4azSQfPCdb8Ex/0W3W5o9yVAXTXXUmGWMfswsS8pHIoNfpu76L7nrA798Qz9MK4Gu5pAwPjqtNzN8bb6nypyXKs7UcEWzXM+FIGO5e41LtU2IzgTYkrFMYG1VfKuCPUtlD2DFAvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895968; c=relaxed/simple;
	bh=1mjo2sDcWExyPLqG9TRNUaTT196xJvCdzypRiGcmPTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAj7teTONPn/ENmZs3Wg+Qbf0CoD14SXagndg9zHCfqJUlvr4hmN0h4z11PrmhydKcFUg2RbPOwTXgx9J0Jy6Hs8xBPPIbxLqLCYbluslcl8TDdt0+sIohloiBOJLIxcNjP3oKEKLNt8agx6kC4r7npNt1E18MVegaAbtsxIPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AUmuJfrg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AUmuJfrg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618ITMC298982;
	Wed, 1 Jul 2026 08:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NjfCTE
	/KOteQCQyMrkozfQ8VV+twVmp3gBhQITTRJM0=; b=AUmuJfrgB7gafn4A7DU3mw
	Wkn/2ZebIHA2iH9jERhtCje9Z3YB+WSZj4AO1Rd1Z8jKXol2SVkCBJjbfpO6p71P
	Qo64HbU8JrlwcRDA+spMSCSQcZ58DndIxExpfywFX9VA7sBdDGgmbWVNmPZEMriL
	FnmT8zMGaThUptuUqRS0/976A+J3p226dcBS4XQ960LP0ZUKcaFxrxM2U51feVyn
	Ehi39bbZ0ixQuwELHZUXbfV213I5ScJMRhAelCuwneNjGqyt+T6FmY02stK15u5/
	ZwUe5zF1//sNgUXXn/kShUSVZbt4leT39lpUofXgCiohWEjECOeP8qX7hmSRV1ZA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5uh6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:52:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618nbXA017129;
	Wed, 1 Jul 2026 08:52:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhedrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:52:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618qWkd15663534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:52:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1415920043;
	Wed,  1 Jul 2026 08:52:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A30520040;
	Wed,  1 Jul 2026 08:52:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.26.144])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:52:31 +0000 (GMT)
Message-ID: <176ef620-b70a-4ddd-90bc-32df206542d5@linux.ibm.com>
Date: Wed, 1 Jul 2026 10:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
To: freude@linux.ibm.com,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
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
 <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
 <b13c7644-83aa-48c8-9045-550a436b57ad@oss.qualcomm.com>
 <d6e0a18ac424ae1fc31fc3a437e983b2@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <d6e0a18ac424ae1fc31fc3a437e983b2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA5MCBTYWx0ZWRfXwfYq5Pu0cj58
 U+2aiEqrB8rWoTs6fxN5EfNXocI5fy39tmbLkBllBGWaVfh7ziOHFoTUimE+7DEGycJgQybVDD7
 ZE/7/tznFHZmg1WBNXVufMFjhvJ+XUpGN5uIWuq5W8oe6PCcHLEWHT/GD4zSK3G9Ci6T3r8vNDF
 VO2eQ0fO2up9XDv7crek8CukkDeNJYYR5nlTdzRrBipnBMCNCaRSL6Lj3JiksLOzKaBiifGWZ8Z
 U56RuF4Cls7zzMikVYSpDSlX7s8WNBlBhDQF4N0BTAj2NY51Zxz3UhdLb+8nIMVhdVuGqenbNGR
 QeXNNUaJoTuMlEigozrA6+x3eqg97pQ51ai9FfI8Fb8GhYVKtIfTNUyrhKBWGyJTXUQw3nc1LVT
 1MQd3pphlyWh03jxfAMlzkEXzwCRCf9A08FiufeqRuvzURnaqIXk1j5aakZIorEjEqJ9k5lR4rd
 hOrO37ebPJpb2y9ghKg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44d555 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=JeL95Ie2d5q0B7KwirEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: p7MJbbC_FYHgAAk5jecUvqirYaZPbUor
X-Proofpoint-GUID: p7MJbbC_FYHgAAk5jecUvqirYaZPbUor
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA5MCBTYWx0ZWRfX3w6ndjzpfI/c
 2pfrsF4/FlHsfqpJ2HKUep3z5Qb9An/pg5E5zjGy1NM/hp0M/8DxMbr3G2h8/I6jkz1vy3ZPMJM
 wvSroNrZPF+H+UqiU3ZtBBCr4rQZG4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010090



On 7/1/26 09:42, Harald Freudenberger wrote:
> On 2026-06-30 16:19, Philippe Mathieu-Daudé wrote:
>> On 30/6/26 12:54, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 6/30/26 12:23, Harald Freudenberger wrote:
>>>> On 2026-06-30 11:33, Ilya Leoshkevich wrote:
>>>>> On 6/29/26 14:57, Harald Freudenberger wrote:
>>>>>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>>>>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>>>>>> With the introduction of the address wrapping function
>>>>>>>> wrap_address() the result can't be used to walk the
>>>>>>>> source address any more. So introduce a new local variable
>>>>>>>> to hold the wrapped address to avoid mixing source and
>>>>>>>> wrapped address value.
>>>>>>>>
>>>>>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>>>>>> argument")
>>>>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> If I take as an example AMODE 24 and look at the third loop 
>>>>>>> iteration,
>>>>>>> with the current code in master I would get:
>>>>>>>
>>>>>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>>>>>>
>>>>>>> and with your patch it would be:
>>>>>>>
>>>>>>>     (addr + 8 + 8) & 0xffffff
>>>>>>>
>>>>>>> which is undeniably more elegant, but otherwise looks equivalent 
>>>>>>> to me.
>>>>>>>
>>>>>>> What is the functional issue here?
>>>>>>>
>>>>>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/ 
>>>>>>>> tcg/ crypto_helper.c
>>>>>>>> index ae392bce0e..29ad2aff43 100644
>>>>>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>>>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>>>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState 
>>>>>>>> *env, const int mmu_idx,
>>>>>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | 
>>>>>>>> MO_UNALN, mmu_idx);
>>>>>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>>>>>> -        addr = wrap_address(env, addr);
>>>>>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>>>>>> +        uint64_t _addr = wrap_address(env, addr);
>>>>>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>>>>>       }
>>>>>>>>   }
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> It is a fix, not an improvement. The original code
>>>>>> used the addr variable to hold the wrapped address.
>>>>>> But as addr is also used as the loop variable there
>>>>>> is a mixing between unwrapped and wrapped address here
>>>>>> and the unfixed code only works when wrap_address does
>>>>>> return the very same address as output as it became as
>>>>>> input. My fix corrects this.
>>>>>
>>>>> What does the patch change w.r.t. wrapping?
>>>>> Suppose we have amode 24 and addr = 0xfffff0:
>>>>>
>>>>> Before:
>>>>>
>>>>>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>>>>>          a[0] = ldq(0xfffff0);
>>>>>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>>>>>          a[1] = ldq(0xfffff8);
>>>>>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>>>>>          a[2] = ldq(0);
>>>>>   i = 3; addr = wrap(0 + 8) = 8;
>>>>>          a[3] = ldq(8);
>>>>>
>>>>> After:
>>>>>
>>>>>   i = 0; addr = 0xfffff0;
>>>>>          _addr = wrap(0xfffff0) = 0xfffff0;
>>>>>          a[0] = ldq(0xfffff0)
>>>>>   i = 1; addr = 0xfffff0 + 8;
>>>>>          _addr = wrap(0xfffff8) = 0xfffff8;
>>>>>          a[1] = ldq(0xfffff8);
>>>>>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>>>>>          _addr = wrap(0x1000000) = 0;
>>>>>          a[2] = ldq(0);
>>>>>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>>>>>          _addr = wrap(0x1000008) = 8;
>>>>>          a[3] = ldq(8);
>>>>>
>>>>> The behavior look identical to me.
>>>>> What am I missing?
>>>>
>>>> Lets assume addr is some 0x1000 and wrap does just add some offset, 
>>>> e.g. 0x8000
>>>>
>>>> for (int i = 0; i < 8; i++, addr += 8) {
>>>>      addr = wrap_address(env, addr);
>>>>      fetch or write something at the wrapped address addr;
>>>> }
>>>>
>>>> Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
>>>> 1. loop with i=0 and addr 0x1000
>>>> 2. loop with i=1 and addr 0x1000 + 8
>>>> 3. loop with i=2 and addr 0x1000 + 8 + 8
>>>> 4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
>>>> 5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
>>>> 6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
>>>> 7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
>>>> 8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8
>>>>
>>>> BUT the given code does something different. As the addr is used in 
>>>> the loop
>>>> to hold the wrapped address this loop in fact does:
>>>> 1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
>>>> wrap_address() at the
>>>>     end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next 
>>>> loop starts with
>>>> 2. loop with i=1 and addr 0x9000 + 8
>>>>     and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and 
>>>> next loop starts
>>>> 3. loop with i=2 and addr 0x11008 + 8
>>>>     ...
>>>>
>>>> So introducing an intermediate variable which holds the wrapped address
>>>> makes sure the surrounding addr walk in the loop does as intended.
>>>
>>> Ah, now I see where we were talking past each other, thanks for the
>>> clarification. You assume that wrap_address() may do arbitrary
>>> transformations, like addition in your example above. But today it does
>>> only bitwise "and", as defined by the architecture:
>>>
>>> static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
>>> {
>>>      if (!(env->psw.mask & PSW_MASK_64)) {
>>>          if (!(env->psw.mask & PSW_MASK_32)) {
>>>              /* 24-Bit mode */
>>>              a &= 0x00ffffff;
>>>          } else {
>>>              /* 31-Bit mode */
>>>              a &= 0x7fffffff;
>>>          }
>>
>>            bool wrap32 = env->psw.mask & PSW_MASK_32;
>>            a = extract64(a, 0, wrap32 ? 31 : 24);
>>>      }
>>>      return a;
>>> }
>>>
>>> and I believe in this specific case the order doesn't matter.
>>>
> 
> Hm, however a wrap_address() function may return whatever
> wrapping address calculation may be. A caller should not
> rely on the returned address being 'the same' as the address
> given in. So using separate variables for the address to
> wrap and the wrapped address is wise in my opinion.

Sure, I too think it's cleaner and more future-proof.
My only point was that there are no practical issues today.
