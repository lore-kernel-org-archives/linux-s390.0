Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698753E3D85
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811999; cv=none; b=Y6oHVDMKHOMXz989Cryx9nVdOqw13Z+45Y3NqNHJjQw4tyjJk1LAou6YqlKhaskJtANkq8RlpPxI0VXiUWM4fGTBH/QvHdAGb16ljBCTueTGdXAZShfosM6k12s1divNLPy0S5vhHLoU1QTlDQM1HcZ9D1VtEuPrCpT1YsovyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811999; c=relaxed/simple;
	bh=ic8SgWsq4uYR3/8A5unicmmbRvDxN4HWU3hq6mdrU+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRvHN7/07jx91P0dOZVdJ6wtRmV/aar3l8cNepbN7XZKjQnug3CIWib4O//8rYPbipBv501MHePbA5GHs3a4LTi3yF+3O9lCiJBcv2uf0qfv+EDpZwul90XDsAzjYKL35CEL1XQX7ITc8aF8asUfE2AKL/+8DUg1IBjE72qMWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QsdskB4n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QsdskB4n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5ndoi1071904;
	Tue, 30 Jun 2026 09:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qrEJqj
	0TLCZMbzewbrRYZCimi7vEuo8/7qvBQj3GoPc=; b=QsdskB4n/1tXPCbjpbOFdO
	NoeLsJpAPgfegXXFdGFlKth64YsVNYPxUon9mBceF6c9zKXSODYL9Np2MOLJHmt1
	4qpFiWgZwwkbrl+JJnRS5YJrij7vu4Rzncjb114K+P2LUWE5yc1yP8C3ZqSZjDWD
	XSZIo4ZQD5FKQUyE5meKpZpx2LUJOEw0jDnCOeVwukaMyTeQ5HmN7uQIt3go2Yx6
	Rp2A5rl0WH+eR6cnCw7/iAtUzwYOCpPKC2NUGEocDxzfZTfywgrk4zugSZGI4Yrd
	WWKtjoDN71WACkfoY72huynjJhbZjMQDlrf+YHNMFMxMDxyjMzINa4fyPCarA3gQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rewkr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:33:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9JioM021467;
	Tue, 30 Jun 2026 09:33:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy97ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:33:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9X3Ga31326534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:33:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F722004E;
	Tue, 30 Jun 2026 09:33:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAD6720043;
	Tue, 30 Jun 2026 09:33:02 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.74.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:33:02 +0000 (GMT)
Message-ID: <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
Date: Tue, 30 Jun 2026 11:33:02 +0200
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
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a438d54 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ds73FjZ_ZaksN5JMifAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9U76Rn7OBdubWxNVaiOUEU3B83wxl4LV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfX+LDBa16FSNQh
 Bv2VOX+/h5wd4TvBnc0513ivbmhpTLUlVHWFyUD6DEjmgBoTLORHi/JkUQv3Kyqen1isWC5Nx54
 0rNJBL+hrnzSxYSSNwyT9POCPzFFqhJgR2W2sH4BqqhD/SiWnbOvCoj6GfSgZLTFRTGsbywaJYg
 5mX2qTlPevXm99Q/XVHuVyBshWGzte2xAIWCVeWRDM7/lMrYq9XJPXmKPlrEj3TNAEcER1cw4GL
 zqYxD0tXFmT/rokNWKG7QJMWtUozORiPPTamvM1DH9/++TOuIwdYnIjP6lD915KtDVVX+nLbykf
 N6j98VY7JNxh+8c5IqV4jMVuMC9Vr7C4B0Bh/skuntiip7yQKJkBBwK64CMlefRcxtORmVBRlWM
 zHb9SurYc3/IZbxtON6qY+p/Nmt/LKvOEBnw6cniRpkMRNkJ6A7OxS5fljdXPEqhydWLNtUamva
 WQOBlLUvnSYhEACIaVA==
X-Proofpoint-GUID: 9U76Rn7OBdubWxNVaiOUEU3B83wxl4LV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXwOTfKkqPuqFc
 44wnujJ2dUtxFoMvabogRjYqVU8xcG9XOl1lIAEN02JGrNbO6IzSlEqpIc1l6IcYO42uSnfy9kh
 uvIw/8x0Nde8ZR/GDYSxrmsZF6+lI/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300083



On 6/29/26 14:57, Harald Freudenberger wrote:
> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>> With the introduction of the address wrapping function
>>> wrap_address() the result can't be used to walk the
>>> source address any more. So introduce a new local variable
>>> to hold the wrapped address to avoid mixing source and
>>> wrapped address value.
>>>
>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>> argument")
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> If I take as an example AMODE 24 and look at the third loop iteration,
>> with the current code in master I would get:
>>
>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>
>> and with your patch it would be:
>>
>>     (addr + 8 + 8) & 0xffffff
>>
>> which is undeniably more elegant, but otherwise looks equivalent to me.
>>
>> What is the functional issue here?
>>
>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>> crypto_helper.c
>>> index ae392bce0e..29ad2aff43 100644
>>> --- a/target/s390x/tcg/crypto_helper.c
>>> +++ b/target/s390x/tcg/crypto_helper.c
>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>>> const int mmu_idx,
>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>> mmu_idx);
>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>> -        addr = wrap_address(env, addr);
>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>> +        uint64_t _addr = wrap_address(env, addr);
>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>       }
>>>   }
>>
>> [...]
> 
> It is a fix, not an improvement. The original code
> used the addr variable to hold the wrapped address.
> But as addr is also used as the loop variable there
> is a mixing between unwrapped and wrapped address here
> and the unfixed code only works when wrap_address does
> return the very same address as output as it became as
> input. My fix corrects this.

What does the patch change w.r.t. wrapping?
Suppose we have amode 24 and addr = 0xfffff0:

Before:

   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
          a[0] = ldq(0xfffff0);
   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
          a[1] = ldq(0xfffff8);
   i = 2; addr = wrap(0xfffff8 + 8) = 0;
          a[2] = ldq(0);
   i = 3; addr = wrap(0 + 8) = 8;
          a[3] = ldq(8);

After:

   i = 0; addr = 0xfffff0;
          _addr = wrap(0xfffff0) = 0xfffff0;
          a[0] = ldq(0xfffff0)
   i = 1; addr = 0xfffff0 + 8;
          _addr = wrap(0xfffff8) = 0xfffff8;
          a[1] = ldq(0xfffff8);
   i = 2; addr = 0xfffff8 + 8 = 0x1000000
          _addr = wrap(0x1000000) = 0;
          a[2] = ldq(0);
   i = 3; addr = 0x1000000 + 8 = 0x1000008;
          _addr = wrap(0x1000008) = 8;
          a[3] = ldq(8);

The behavior look identical to me.
What am I missing?
