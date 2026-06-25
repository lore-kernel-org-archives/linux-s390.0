Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE235A397
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372707; cv=none; b=qpDiXWuzCtt/b9Iqhe+1DFvDsDQYVNFYx4zzcnco4vP5DEEpONQ0Uf9kM1kIbn6ixuuetzDUq+JbJD9MzXcmI/hIOn+sDTA3ue5RFixvzUocF9spaKA1D6j3ezL9nSGbX/aC2GJAMhDNHCmthEPAgbuhzOtmEOjW2GLKJ0I2bSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372707; c=relaxed/simple;
	bh=ZgUCmgd8zYdiaMmGwk8qBqQ6nugjvol+OhrSajQO/7g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rnJXA/7013d06bBPqzN7u/83Db44Fp4KWZlH96Xe9h9+SexcCZPceLN/rR+YfxT20N+9Q+AoGSK03rf4xiqkWxkNMFzitF91jsV70I0ZMVKsifW7lush976SiRcEW80Pjw8afQ/nazQidJ1jK1a7oiekUj2BfpZBhHNa2pI6j0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fOO4PahR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOO4PahR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mOTe2889206;
	Thu, 25 Jun 2026 07:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=H/RsST/Jacq02q07rgIzDzvCC9G0GkRadik2Hae8IUI=; b=fOO4PahR3vFx
	FT8uolEF0pIFPt5Yhb3J14L6ecqU+suE0/Q9VolkUZpmlVtColSYnG8QRxoGklpP
	/tEE5yXtLxQs2q9/z+VvZi9Lqq2lpml/dhOCHS16Wviz2Xe3SDis9nmYm2nZBJ2j
	cJSZVJ/qvOqY36e88/sx3dbIlNrashSO1UqAv3UfoJRvrpOqunJ0waEyyNAtxPay
	hc+cuzjKlbLHmXFT4idunW29DpQqM+ayBXYjjw//jfvnnvtrPQGnQpggmuZ2Bvw9
	wIZLsg22TENtNLDC2nqrFvipPuu88CZFZGFkauXpOiBUL+dApahsQCAbSkoAMN4h
	Y9Ktvy2wiA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt05nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:31:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7Ji7Q007912;
	Thu, 25 Jun 2026 07:31:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qn7fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:31:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P7VYUr13501128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 07:31:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D474258058;
	Thu, 25 Jun 2026 07:31:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59DAC58059;
	Thu, 25 Jun 2026 07:31:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 07:31:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 09:31:32 +0200
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
In-Reply-To: <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
Message-ID: <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2MiBTYWx0ZWRfXx1l9K+UcsKq9
 oKAusuX5T/qgv0Ewtp05635wHz7ucwfSLvMezc/Pl74ONPuImPbXEasmTlzbui/VxhCAD15Rkaj
 7RWYCq5uufVuPteiFcBS5gS6Z6uxPeDWrUb5L3VmYDxHAubF1q6gBq1GQB+m4pDHbDprdcL6jzv
 ULNyWneBpd7aoar7x48DkTXABEST/6CESFU+qkxV05veRnUrcynJcoIPxFGGiz3qA8+uDkKGETD
 n3Fpc5Oky0TyUb5Yxm9zjJ4IV1X01C3IU9/ioWitdDjeGwjehZ2ffW7Gq9oG2n8r2TWvQkBr/s9
 GMnZwG13Zz7zdnuwySf3XU1O1l6BM/5sWWyzWEaFz7cZnsctDCKYnDVSQgiRsH043/ELWs1h0Dn
 wu8hI250A/71BjVJ3AJhf8l/+5kSWn5qaxlv309mkC6oiEdusA5eZew8AnApnzoeo21gFTJ9DTv
 VHtWpFM4A386s6QPArg==
X-Proofpoint-GUID: ePXDAYOtja2vKlrm-tyzwbvkDLTRjWTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2MiBTYWx0ZWRfXx8v6lR80ITbC
 L3ssMCsEpdx48wcG+daAqPo9T+dhRd+bdnEvmANl226bqPY9U5um5jmI1+oleBULvtu2wWCaCOs
 qZicpdrCKK/bUcX2ejjMt9mFkfEaSpw=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3cd95a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KRZ25yUibapRHaRLCNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ePXDAYOtja2vKlrm-tyzwbvkDLTRjWTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250062

On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
> Hi Harald,
> 
> On 24/6/26 10:09, Harald Freudenberger wrote:
>> With the introduction of the address wrapping function
>> wrap_address() the result can't be used to walk the
>> source address any more. So introduce a new local variable
>> to hold the wrapped address to avoid mixing source and
>> wrapped address value.
>> 
>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
> 
> This commit merely added an argument. I suppose you meant
> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").
> 

No. Commit fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
argument")
introduces the mmu_idx with the wrap_address() function or macro.
And the result was something like this:

   for (int i = 0; i < 8; i++, addr += 8) {
     addr = wrap_address(env, addr);
     a[i] = cpu_ldq_mmu(env, addr, oi, ra);
   }

This code reuses the addr variable in the loop
by setting addr to the wrapped address but after
that the loop adds +8 to this wrapped address.
This code only works as long as the wrapped address
is equal to the address put put in.
Thus introduce another intermediate variable which
holds the wrapped address:

   for (int i = 0; i < 8; i++, addr += 8) {
     uint64_t _addr = wrap_address(env, addr);
     a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
   }

Of course it would also work with a direct replacement:

   for (int i = 0; i < 8; i++, addr += 8) {
     a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
   }

but this isn't that readable.

>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>> 
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
> 
> s/_addr/wa/ or even directly inline?
> 
>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
> 
>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>       }
>>   }
