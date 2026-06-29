Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9D401A37
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737036; cv=none; b=kRV5CgehO8vsQEcD1cCKrnFkCNyJHlmHnvCeraE6n0b0YHBz9bRSPMQcLgZGQkItMWGczrRqZiusRC/GtCacFlsqF1PgzHjzJf9sDLSN0sUTIDvx1mWyoEozHhade+npGFmucxtmW4nchZbkSUxQNk5zEef7BJ80dd5JKjZNmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737036; c=relaxed/simple;
	bh=ZR4fqV1eq99GC2nqdk6y2s63eTn6PhMqgPWCMoP9mMg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kjEpom6xB4O9k0pr+zcqG2+yrVF0+sKqnPpZzaNplUxCSAxidLZ6NTK8sBF1eiSXsCLTGmRyG4Mqi9YNy8g6k0Yj6Fj7DQ4m7+2sIqNQqUnX0xIUuIreyIgmidFKW+MuUFf9TgD1P5d2uX60ajxK5jpVfmHOhbQa73zIlfT/wTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNFGoWkd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNFGoWkd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmTpd3181970;
	Mon, 29 Jun 2026 12:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=dPbdjCwNnK8IOCg8soyyMUy6JflddGGILKq4Bj8rJ6c=; b=rNFGoWkdOX+d
	BQkUb5o8fDEVH0HZat+lOGU3Qr+smJCltZJRcVz9guSkJM4LvCgivt2Up7D+9fF6
	+in2H+JXvssS7o7mUyIY96dtgU1sx3l/Urv8hzNNo5u4fvSniNOmvqEsOWX6BLpf
	k9S/6i0MtE/aKVauBPnC0IPQh3trYzpG9vkyYg8ZnrtqZ/pW3izhHSndJ7FWWcdj
	wF2p+oLryuieTA5EtAIm4N3i4efV5SxdQPgMI3fkzvjC0r/6jamVzFBhoZZp96M2
	VsuCmhhmDLv4OoxHj4WxgteriGs4eh5N8QILwPteL2OdG3xlEfspXPTjkek1V+hC
	tZGOqTB34g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfsb0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:43:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCYeCK027559;
	Mon, 29 Jun 2026 12:43:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy5783-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:43:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TChfld35455248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 12:43:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 662D65803F;
	Mon, 29 Jun 2026 12:43:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E949158056;
	Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:43:39 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
 <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
 <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
Message-ID: <ddf3dc604cdc0e2d8294166306cb2187@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a42687f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=sAccT5BgK4xihKQz0gUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX5x81Umsuxjfw
 cmBQc8TMxmVhmCBzS/k6uQ1/9rUt7pRZX/BcAVyrW52kF25JyBVCWuRrruZwN8BCJZ21WnxAJ6P
 nMSK0idP3edgUN2mTkwVcoU5FXwbGb8=
X-Proofpoint-GUID: k3V7HL9t4sRPd2dL3dJWIPohAWN5ni1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX7aFaX2LSfV1a
 BEkS2SET7m56y46Q7bvRjX7vF4/Jfn6M3uRjLUM3/XTuYzbajfnXVtgiSlDN+JT6M2HLpXS0j0l
 i7ghwwsfX4QW1q2dNCWqNrzAmIfS+BLQFkeK68JCfZvG+r6j/O2zlU0z4Ks/HsDzC5PxnjzCK4H
 gsG0+RqgrN4nJEThRNuqSol/CmvkknClYNP/vutfI/vtMl9kJ3CWdfHcdoLLkN6aooFaDzFYZAj
 KycZhQggWaOxnWeLR/33B/gaiyxUdcA7L1agzj1cYAgf2Ef/A4FnVUvYowPohkaYpBhCtZdWYrV
 DuDzfrR944HwM5vQtZBVQ911+a+MYj8i8cl3pTFJV80x/sIV52cdjrWNElmMVMrd1mNVTJIrsjF
 rgp6oXHbiwWiGMKUTUOqsS5PRxanpvEBvb4XnBFWyKS0/FiF9vF1jp0DHCdc7xZ9GBJYdbqjYRo
 G4tHU5ZvynKfDWfyXZg==
X-Proofpoint-ORIG-GUID: k3V7HL9t4sRPd2dL3dJWIPohAWN5ni1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290101

On 2026-06-25 12:37, Philippe Mathieu-Daudé wrote:
> On 25/6/26 09:31, Harald Freudenberger wrote:
>> On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
>>> Hi Harald,
>>> 
>>> On 24/6/26 10:09, Harald Freudenberger wrote:
>>>> With the introduction of the address wrapping function
>>>> wrap_address() the result can't be used to walk the
>>>> source address any more. So introduce a new local variable
>>>> to hold the wrapped address to avoid mixing source and
>>>> wrapped address value.
>>>> 
>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>> argument")
>>> 
>>> This commit merely added an argument. I suppose you meant
>>> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").
>>> 
>> 
>> No. Commit fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
>> introduces the mmu_idx with the wrap_address() function or macro.
> 
> You are saying the same, not really explaining, I'm not following...
> 

I rephrased my wording regarding this fix. Please see v9 coming soon.

>> And the result was something like this:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      addr = wrap_address(env, addr);
>>      a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>    }
>> 
>> This code reuses the addr variable in the loop
>> by setting addr to the wrapped address but after
>> that the loop adds +8 to this wrapped address.
>> This code only works as long as the wrapped address
>> is equal to the address put put in.
>> Thus introduce another intermediate variable which
>> holds the wrapped address:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      uint64_t _addr = wrap_address(env, addr);
>>      a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>    }
>> 
>> Of course it would also work with a direct replacement:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>    }
>> 
>> but this isn't that readable.
>> 
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>> 
>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>> crypto_helper.c
>>>> index ae392bce0e..29ad2aff43 100644
>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>>>> const int mmu_idx,
>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>>> mmu_idx);
>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>> -        addr = wrap_address(env, addr);
>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>> +        uint64_t _addr = wrap_address(env, addr);
>>> 
>>> s/_addr/wa/ or even directly inline?
>>> 
>>>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>> 
>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>       }
>>>>   }
>> 

