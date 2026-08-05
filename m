Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA142377D
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928659; cv=none; b=jlBa2A1zwvTYUB/wAjeEW9QAQ1/yPCGqKISQdIfhlGfqaVBvoDaQenh6SDZFCHks+xmZPkEf8GWYvkO0PTvA/QIKPYG1L8XpVPAh5kOxTSN1T0A/kaXBGD3SnjkevpkjMa9mfFpgNVlllU1wjF8CU171WGI9u76pj10Mv21Y8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928659; c=relaxed/simple;
	bh=29sDxsBhIsQ8QFlQ47y7o5lbuWUB4Ql+O+ClKo8c+C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8LTB+WblLdONS3wI2YzGyKY++vfWJLIF9BEHbq3pf/tN0i0BEmVrN3MC4l1qFeRgZm6mSJkCcTx3n8F3viH4PX7N7mbTZhUBgc4x07udrT7uYJO74jb5rYJp7ScsuzEwsQUtoYxT32kGelyu6RgdmyyvG4iGWitpNQbXm1m7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y8WmQZNa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y8WmQZNa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lZEQ3354411;
	Wed, 5 Aug 2026 11:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MrZNsc
	tzKCoJqJXE+IPcmDSIXzseewWtqOFC5N9O6no=; b=Y8WmQZNafrD1vQMna28Ut4
	zF3GFuWj+Bz/L3XPgmm0dVBHvsI5kDnPUsPkTEu4+ASfvv0/V+bCo86pWKO+YF1Y
	HP5XVh6BeT/q8PDu7k9lp6qzOLUSgEWT+Aul1olA03aRPPeC6toexVuyHCLqRh3J
	tWYhZQ0IiZFawLSrypC0cXDo/R/j3lafL2CztvvKCrwfMrtOL6tJsGIAN/8rPSGU
	Iv2J261juBD6Zvu1sgz5NP9T6cPLhtLENNzG3uhPn3Da0bxmQlE2q70tUp7nT/NX
	hCKi88nUDx7ee4m9aq+kS3eArvdmaz0WvG71gBCbM3PND/vZ8RYE57XCHel9SOgA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42pv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:17:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBGhJ029166;
	Wed, 5 Aug 2026 11:17:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe68x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:17:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BHOxt40304900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:17:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438DA2004E;
	Wed,  5 Aug 2026 11:17:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC38B20040;
	Wed,  5 Aug 2026 11:17:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:17:23 +0000 (GMT)
Message-ID: <9ae87449-18d5-447b-8a06-59aa10793a0b@linux.ibm.com>
Date: Wed, 5 Aug 2026 13:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/18] target/s390x: Support protected key AES ECB for
 cpacf km instruction
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-13-freude@linux.ibm.com>
 <69f53a7c-83dd-46bf-81a1-7941f4b6c5f5@linux.ibm.com>
 <fd5d369e27953708bdbd43620aa73957@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <fd5d369e27953708bdbd43620aa73957@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731bc9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pZgpfxxYkm12d7G2mg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NXnAJJ6gU5lSQorIWbdfcquO63-a78D3
X-Proofpoint-GUID: NXnAJJ6gU5lSQorIWbdfcquO63-a78D3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX5S6Vef9Vtfa3
 ZjgfJybM2Ee0OJixn/FmhBYVW/RndXabV64b89B3kXuKTkQCLvqIYwaZmdFUxIHv6Su7JtIewmb
 73Leu0T9LUHFfiSDcdnkoDzEeW3Qd2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX+mKOD0xxWKQA
 yjjN2p4wnEyCV8233GR3h4pBxRFIFwOHnfupeoW52s5bGCESsRYrqoWgWQYpVH9KBYOxS2ZCUFl
 Fkm6iFWmO1lEFMHp2NF8Ub/KhgPiS8i667DDXqaXsOm7HoPU7rkpKDnh/Oca0YvTZCqF6jGMeaA
 FGQmcaB4fG8e9Nf7vleNAM5LzGFTo9RG5DdLK3qVdGs/uub1lClVHrH89DIN3Zj1p9Vo+8W6a8W
 x4x2/tKP++CeU1XLbOCQKltwI/H9JBAGa4Q4x2xR60VomEricLzoVk0nVLCir7AopQagpUnOMiO
 swyf3BIP6D6OfLRrx3gRa185aPJzAwEy4j08C4I00BHhH6dVfi85FCWInmFPePYfVcpnFi+Ii4F
 y/8/6dAM+kaTuuDAtW5xDOS6ai/UEatB8AOh06OhhBcLClIB2DOenTp2ePgbVq0bE/EqNgSnUzk
 wxY1OgkcbC5JDxGaO7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086



On 8/5/26 10:28, Harald Freudenberger wrote:
> On 2026-08-05 00:48, Ilya Leoshkevich wrote:
>> On 8/3/26 18:12, Harald Freudenberger wrote:
>>> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
>>> and CPACF_KM_PAES_256 for the cpacf km instruction.
>>>
>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/gen-features.c      |  3 ++
>>>   target/s390x/tcg/cpacf.h         |  4 ++
>>>   target/s390x/tcg/cpacf_aes.c     | 91 ++++++++++++++++++++++++++++++++
>>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>>   4 files changed, 105 insertions(+)
>>
>> [...]
>>
>>> +
>>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
>>> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
>>> +        if (mod) {
>>> +            AES_decrypt(in, out, &exkey);
>>> +        } else {
>>> +            AES_encrypt(in, out, &exkey);
>>> +        }
>>> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
>>> +        len -= AES_BLOCK_SIZE;
>>> +        done += AES_BLOCK_SIZE;
>>> +    }
>>> +
>>> +    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
>>> +                             *src_ptr_reg + done);
>>> +    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
>>> +                             *dst_ptr_reg + done);
>>> +    *src_len_reg -= done;
>>
>> Should we update registers after each iteration?
>> Otherwise there may be interesting effects due to swapped out pages when
>> running in system emulation.
> 
> I don't get this. Swapping and interruption of this code should not affect
> the encrypted/decrypted result in memory and also not the register content.
> But I assume that a CPACF instruction itself is some atomic operation. So
> there needs to be a consistent state before and after the instruction. But
> "while" the instruction is executed does not need to be consistent all the
> time. Otherwise for example here the memory write and the update of the
> registers should be atomic.

I agree that the "while" state is in general not important, except for
the special case when we get a memory-related exception in the middle of
processing. Then we end up committing the "while" state and it can be
observed by at least the exception handler. In this specific case I
guess the whole instruction will be restarted and the application code
will not have a chance to observe the inconsistency (memory updated, but
registers are not), but it a) doesn't look very clean and b) has
quadratic complexity: if 10 pages are swapped out, we will perform
1+2+...+10 decryptions.

DFLTCC, which is similar, handles it like this: it processes as many
pages as it can, and if the next page is not accessible, it returns CC3,
updating memory and registers accordingly. Only if the very first page
is not accessible it raises an exception. This makes sure we don't end
up with a quadratic number of bytes decompressed.
>> Blocks crossing the page boundary is a similar issue, not sure if it's
>> that easy to solve.
> 
> Well yes. This is a clear issue hanging around in all the memory read/write
> crypto code here. I have no idea on how this could be solved. However, 
> sounds
> like there will participate a new guy in the Qemu cpacf area soon. So maybe
> he has some ideas to work this out.

Looking at tcg/mem_helper.c, they use a static access_prepare()
instruction to pre-check the address ranges; this function takes page
crossings into account.

Perhaps it can be made non-static and reused here as is?

>> [...]

