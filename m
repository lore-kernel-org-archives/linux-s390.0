Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE43F0761
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815016; cv=none; b=Gc1vBi5s/7i3mQb/psSOIU2kXTVDhF8arN9XVM5NskMEzZGSsRZYliRATnngxCUy/ZwYl5+880zciTYlLTHOMZPr7UoRRz9GhHwxG2f75A9vUVqTir1JeBK3B7T0pZ42jy8XchjxzIqWDog3rcXile/Y2mA4LPpHRjsOcQsz0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815016; c=relaxed/simple;
	bh=aFldC3fjiNGQaIA6leeMNybeESvw4oByfVHlHe2X5f4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QVyx7e5rgaqLCJi9l1ceGJRqn5O0E5feFLPzZzstUPA1hKOu0KiAPyNnaIQh0eviALAtMQ47d9GCx38rrllOg4VyHl53SrEHvTWnjkMOAcmOSJqep+lHUVdAnf+UZ5W9IQA+pN+E+0mpBfMbbcR8I+S4FAxQ4U5Ff1EoKsHwmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fH4wOecz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fH4wOecz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n0vA1578045;
	Tue, 30 Jun 2026 10:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=5IZ6lZT9HCEu51HvZb+b5+zSgs0ThBA9dh8/dHRjhcY=; b=fH4wOeczOEnj
	9W9NBvD4wpdzW23BlZQaTafvDHauWxJ8OnZwPJgPeDdtd5qiJmQYrcq5oDf94KK5
	kOOpXVN7bP9PeFE0PLpKlT5Dpsq2YxhdwxWO0rM8I8E/5nchw/x91nuIk2T0Ub0N
	H8AP70PQByVktvQPlfxNun9A9bdM7C8hIblapOUgZTGKPEVsc7GU59zBzpAoB7QB
	x7ftTIookgqWJMFUpLnZeAhP9x712BTPQ033KNhxpP3DkE8eG+p01Fg8e5j1wMqj
	3qrcd4WxNkKnVD4jMBkGIUyxRXQwf4l77zkNVfMBArN1LxM6Waw+47SQ0MemIsSI
	14aiKBU6ww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rewsq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:23:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAJewJ022491;
	Tue, 30 Jun 2026 10:23:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1rfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:23:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UANPbG29491796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:23:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515675805C;
	Tue, 30 Jun 2026 10:23:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 573475805A;
	Tue, 30 Jun 2026 10:23:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:23:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jun 2026 12:23:23 +0200
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
In-Reply-To: <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
 <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
 <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
Message-ID: <a6e637d07024e0ff8a457500110e225f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a43991f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=y3FDp6X5KcjlW3Ig3ksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jx1J-90prwl4Ykyn-DABtV_5LIDbj6uX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX5N7Ry8TTcVyF
 /DL0ngovBnUc/RoCXxpUaGAYWbJLxIvMchGooe315a1BBEtlORNNv9NlyVgMLOTzG7vLd6f2Mgg
 HlBjeba0vPVkP6c2CT9DaXNsBKrTQ68po0yGH7PHse7wQiSKf29RjoKd0oWYdN2hgiYfZqQel3w
 T3MeX5ohu+w7nSFHGpTZ8EdOumzMMj6PWhfdsvxhJ6snjm3Enz1exMpRtyEsnyrSDzpFxx3l3g2
 a90AzFdhhtSn1XB9xR8UGi1nK9QjKw7QTA+MUWkP2X1B3gfaaoWK7EU3IWRy2KuZ6w4BZ52TtfW
 jbrWSyAQWKlVrx4NeSes0b0vNcn22XWz588/2/gR7xZGqrGCQcGEFL+F01SE+XAXO9c0O8FhzAj
 nl6k8iXwj5rD4Li/1t2PkklXhGS1nxY4KJdgcOiqgivgkxpajC3ZYCTohC40DsWx/oFijFaCrR2
 Hoptme0d6YhJgHYW8zg==
X-Proofpoint-GUID: Jx1J-90prwl4Ykyn-DABtV_5LIDbj6uX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX5Pfo0u7m7YDH
 ehOmpJI2W5tgUPDNsNExugLdmWxYkyOFX5o0WpmkuuFyTleZTc6gLGAKfCWftKExrtb8vrEQLCU
 uNYOhUsfAEjGbPQt3DRzOfkPTnvGxxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

On 2026-06-30 11:33, Ilya Leoshkevich wrote:
> On 6/29/26 14:57, Harald Freudenberger wrote:
>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>> With the introduction of the address wrapping function
>>>> wrap_address() the result can't be used to walk the
>>>> source address any more. So introduce a new local variable
>>>> to hold the wrapped address to avoid mixing source and
>>>> wrapped address value.
>>>> 
>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>> argument")
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>> 
>>> If I take as an example AMODE 24 and look at the third loop 
>>> iteration,
>>> with the current code in master I would get:
>>> 
>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>> 
>>> and with your patch it would be:
>>> 
>>>     (addr + 8 + 8) & 0xffffff
>>> 
>>> which is undeniably more elegant, but otherwise looks equivalent to 
>>> me.
>>> 
>>> What is the functional issue here?
>>> 
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
>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>       }
>>>>   }
>>> 
>>> [...]
>> 
>> It is a fix, not an improvement. The original code
>> used the addr variable to hold the wrapped address.
>> But as addr is also used as the loop variable there
>> is a mixing between unwrapped and wrapped address here
>> and the unfixed code only works when wrap_address does
>> return the very same address as output as it became as
>> input. My fix corrects this.
> 
> What does the patch change w.r.t. wrapping?
> Suppose we have amode 24 and addr = 0xfffff0:
> 
> Before:
> 
>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>          a[0] = ldq(0xfffff0);
>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>          a[1] = ldq(0xfffff8);
>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>          a[2] = ldq(0);
>   i = 3; addr = wrap(0 + 8) = 8;
>          a[3] = ldq(8);
> 
> After:
> 
>   i = 0; addr = 0xfffff0;
>          _addr = wrap(0xfffff0) = 0xfffff0;
>          a[0] = ldq(0xfffff0)
>   i = 1; addr = 0xfffff0 + 8;
>          _addr = wrap(0xfffff8) = 0xfffff8;
>          a[1] = ldq(0xfffff8);
>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>          _addr = wrap(0x1000000) = 0;
>          a[2] = ldq(0);
>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>          _addr = wrap(0x1000008) = 8;
>          a[3] = ldq(8);
> 
> The behavior look identical to me.
> What am I missing?

Lets assume addr is some 0x1000 and wrap does just add some offset, e.g. 
0x8000

for (int i = 0; i < 8; i++, addr += 8) {
     addr = wrap_address(env, addr);
     fetch or write something at the wrapped address addr;
}

Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
1. loop with i=0 and addr 0x1000
2. loop with i=1 and addr 0x1000 + 8
3. loop with i=2 and addr 0x1000 + 8 + 8
4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8

BUT the given code does something different. As the addr is used in the 
loop
to hold the wrapped address this loop in fact does:
1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
wrap_address() at the
    end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next loop 
starts with
2. loop with i=1 and addr 0x9000 + 8
    and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and next 
loop starts
3. loop with i=2 and addr 0x11008 + 8
    ...

So introducing an intermediate variable which holds the wrapped address
makes sure the surrounding addr walk in the loop does as intended.



