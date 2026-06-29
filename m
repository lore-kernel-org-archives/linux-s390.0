Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFC3FE363
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737861; cv=none; b=nwIZv6eljG3KiVaDORUdxg+5IPIsKbwBzmEZ+ZDpo3FZbvbd9gVbgzdI5K1NIg20hbLhwfMWlJ5nimN8FHjz9SULuE+UC8mxNOhhEBut+KIcrTaDfy4+CN8Vm1Nz076QbUDgRxksNMSHp8REEGxvyDmRrWyOZ6NMLdcgIDNPo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737861; c=relaxed/simple;
	bh=2CuOVIxISMdYorUqvkzpGZnWvMBpKDOTKvNfPiq3jak=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BTSWtF/lPajnkpwte6ScSDRm3a5/aqaWarMaBOyQWZkq6AVfn6FG2c7l7banq4hY+zZMOtE7uEk3Q3bWjTk10LWBFd+tRk6ybyj1g2xFaJLblssxM7JJByfc3E0u+l86n9lHNckqEJetcjOQZKbtQHXAnwxYszHqOV9iT/DAjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GpfV269n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpfV269n"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmiEJ2921871;
	Mon, 29 Jun 2026 12:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ztRGkR8tk19o9CH6mEohp1ZLVndi3kFXcPKqtLkyiRg=; b=GpfV269ngloo
	eXrOEb4pnon/7KtA7G1QW7y7pEjFPUjbJD674GDuzrScp6pg0Y5wYN/qeRx+gZ3a
	rRy6EU5qwYDdsGWWAy3dCYkK9CWhAjnZiLaSX3tnt2uQIy+J9ynqVF/e/2q+TTUu
	FY/rBY/9CSOFKu2h0ZY39RzxI6NBmMrR785TXuqK3+saH6GQZ7hxeq/4gzWKXvAw
	FD4QpIRp5EFeW4Poulgi0rcsSzFNBjs2xke1CEIgreYD7iHJV/qp2raPEEFI20Cz
	Be/gmInaNWMAv8ajEVik7fBfP8V9dVnBxiPcT5AnPy9VmCO7DJ3tQ/wQY37uQg6r
	cmqy3B1IUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9s796-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCnlH5012372;
	Mon, 29 Jun 2026 12:57:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy58sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:57:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TCvUx527394690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 12:57:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2EC55805E;
	Mon, 29 Jun 2026 12:57:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C5858043;
	Mon, 29 Jun 2026 12:57:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 12:57:29 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:57:29 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
Message-ID: <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX0tKPxL66K/I8
 M0tB5NyRsf8/pgE0mYodYYF3V/29+dY/Y9SznEBiblKfp2eT/8MwmciobJQV+LPdcngdyep9szB
 LAdZp7jSKjjqOvJqscgbZK+f9B4soMhpxLJ01S34fa3+XpBY/rqM2MF7VS5lK3MDsCIH0iKMqIi
 OQ/9iCrZ8fid8n6A4/zAnCtWOQwyQ8mRN783n3qXirkJmyFWo9TwauqN26nyIUa2NW1bchw8nCR
 4HKDn3zE2yrQ0ED9O4C9zFxT8jRQbhMCVg4v91s96PobmAq90Cifryxmj3oytMdGAaqw/EAHJ91
 USdptUEEEcYjXV2IaJsRNXwG2bAXPywFJ8cndXK969TxnlvxVVPF6BA3myBpp8zV5oa0iAysT/x
 po+WEi85VGLZS4+NXLz8q74L4id8IleK6sJ8E7gX+h2r/h2K67yGwOWMU5DxYCxdBdOrs31+C0p
 4tMckC75YKYBrF3iPew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX5IntqDZjTMYq
 BTfTwZ1RODhljfT0erhsiRh9qAOCTQRz1tyJ9ldgYPpPrlZJ32bCV3lVDR6FQ4a/duzhuNIER3U
 vdB1Y2bX3xN/SdeCWKNsmKnouftNkgc=
X-Proofpoint-GUID: 9bk3po2i1DPTTnSXdMPCkKn108xMGY0H
X-Proofpoint-ORIG-GUID: 9bk3po2i1DPTTnSXdMPCkKn108xMGY0H
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a426bbc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=q-Bucc0gGw48xEf_XpsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290106

On 2026-06-24 14:56, Ilya Leoshkevich wrote:
> On 6/24/26 10:09, Harald Freudenberger wrote:
>> With the introduction of the address wrapping function
>> wrap_address() the result can't be used to walk the
>> source address any more. So introduce a new local variable
>> to hold the wrapped address to avoid mixing source and
>> wrapped address value.
>> 
>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> If I take as an example AMODE 24 and look at the third loop iteration,
> with the current code in master I would get:
> 
>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
> 
> and with your patch it would be:
> 
>     (addr + 8 + 8) & 0xffffff
> 
> which is undeniably more elegant, but otherwise looks equivalent to me.
> 
> What is the functional issue here?
> 
>> diff --git a/target/s390x/tcg/crypto_helper.c 
>> b/target/s390x/tcg/crypto_helper.c
>> index ae392bce0e..29ad2aff43 100644
>> --- a/target/s390x/tcg/crypto_helper.c
>> +++ b/target/s390x/tcg/crypto_helper.c
>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>> const int mmu_idx,
>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>> mmu_idx);
>>         for (int i = 0; i < 8; i++, addr += 8) {
>> -        addr = wrap_address(env, addr);
>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>> +        uint64_t _addr = wrap_address(env, addr);
>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>       }
>>   }
> 
> [...]

It is a fix, not an improvement. The original code
used the addr variable to hold the wrapped address.
But as addr is also used as the loop variable there
is a mixing between unwrapped and wrapped address here
and the unfixed code only works when wrap_address does
return the very same address as output as it became as
input. My fix corrects this.
