Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729D1CAA78
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383826; cv=none; b=RNhjtXc87osTOd/7Fj2Mu63kd6jL2pZ/kjmKfvQqBTc49bjPvGfANVVeFqolBahvFTLyxGUtxmDGzMZkLog+u9gjnM470IOH1DlvNmEUfB+cnsGhzOUGVLUGRDg+WWrBA2HebQABok1aQ0XXWZUjvyE17OoPqBNRuvx4xSbvS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383826; c=relaxed/simple;
	bh=z1a25HOzfC1n+VSSRSUp8krFMaY0uh1KOw95MlqAuhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByZ6ifCLUyNVYIexmFzaC25KIOkjOwFyyn+NMUWADwXakAFY4s8LQtfSz6Dc6QQZ68SQXAVQcuxe5PRfw7Ob092/K2q0k+GTrT5v8Z4wOk0R7g9MMlaAwuxOfvqiolY6SBgbSKt/jpFHWAW1YrL4TiEU5WdFNhYMp6Ax1hUejTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzpQRSXk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GT/nkb8l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzpQRSXk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GT/nkb8l"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9k4CE2048176
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 10:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=; b=BzpQRSXkeLQMZrci
	3zfkpUZ08awnUtU2vKHCBR89XvqSK+DVYlwsjM73GFvNRiksWTzkeIErhub5Pcnf
	Sf5ud5i2kPJxcYQXD33oIrBKW93Q8+AjpA8wvuqr3GLeBhmT/VwAxRLp/RZjSWHD
	MJDqAIaRfJCvJ/FtT/YkOBovn2ZnWmICMgQ9bzyTXnyKW8K3kzxwGvcUs8zYmvB4
	a/O4WdBSTv/zs96ezJTXr5/aStuDtGRmqS3LqooyEFTqW64z4rYVHMhweZWXPgWK
	E8E4pRM/XLtkbl6XrYqXqZEJB/4e+IsvOLS5SgZPUA0/YaLUko6fXyTJGO7BNDuj
	ktUc1Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqhn9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 10:37:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e06f4680bbso39511846d6.2
        for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782383823; x=1782988623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=;
        b=GT/nkb8lWzHNJ8ZXicuqzLQnGX+2ccvrSeENcMo6iaa7lC+NLs36DOkS3LQqFlt9/z
         EnEAnXu58E9je8/+DHvJv5a/6Ljr7rUsZjBapIX/lbOB2VstVu2vL7pCBJ0T0u+PgVq0
         1Hv7kgKYTw5gQ7DJzo8Iu4mBQSnfsf3KoMnxKe+AuXcN3RthheSfX2h6nlK52lJOKmSl
         A32uNZeCBJZGWGifwiUeODG91aVsajYVO0/McfwK/yy0cpuj9zXM17P0xA4F2m/jOUkw
         rfR3+Ug4EI6nhStyd9WANi4+CFDghhQe9jV+tE13Q8AGV2Bd12fbRr0Mzqd7d2rmkf23
         15dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383823; x=1782988623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=;
        b=Lm0moPlIQhqZPQvoxfYw7fZ2gTzShi7asHupnRb5lUXQONJ96Gtwr5pqq5JVJKeWT1
         leGBEW4QTsvWd562lDTZtjkCAgGGEJeyxNeBm4ddNcL4hhXMQuzOvMFyb47W+ReEtHvZ
         +RChzttj090GieUT1G6IIIiWlsLyA7b/LWhjbpQ40P1cVANFTyLPfwqf3Gid519vj513
         FvFkagGqxioFgzZJEWiZchZCTaJPRGdw4OJWSGRM2/49p0zqIgOhPu3LORaQi5h23oxt
         cwpuoGor/rz5xsqtShHGCYepwRxzvKq5SPdWMceENS2RjzyK/pzunbWIvFlaKFnOO0pQ
         xZ/A==
X-Forwarded-Encrypted: i=1; AFNElJ92FJJcASzVl6gXnOz1ABp/zmcYwby9z/DVZysrZytKKuXywY7F75IZOgDr+9B/iTccsBJAC6cxZGEb@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMYlBOGB6c/9+T48DW50Ntb7qjB50aruDpeZ1okdPcsFfO/r4
	1ilBT4BwUloEYxTQNnwIu5+8KQdMYVsL6EmZn4o/FNPa/qMmS6RzIEQ/57ILiMJuCFsZdW4gUUE
	mltzvoEiYyQr8EUO10Md0cr2xjKyNuYh+yyH6eQb9bxrumakvWraO5kVeadKM9Ubk
X-Gm-Gg: AfdE7cksXx8TR/5K3lhlmpJvXHpvOS9gQ3TNopO46jwMIcqEbnaVB1G3WepceEFTbVR
	gbKPQgrGR/LNx8DpHIPFuwXl+Kzymf9f2Sl7zmiBdItXVNqp1olZGPNkEZGI9Hq9CBpPS5yM1eQ
	Lg4ocoi1GIxfJsJouXrUstCcCo5jbHFT7BLb9/N6FzvKcaSVK28pkveyHCg1reSxwGtALzXq0Fr
	V0RZuCg0YJWDX/TBoFokDq59YYamK1ByyZRABvhWRPM31m0epeTPJ7jIBUCrYAJoVx96MtFgqGj
	LYPr9rsWnKXFf2JWe6T0uzuFgy07ADDC6gz9Wnjh9f6p5yFPpU/RhLgDMkI6jk71c2Frr6FGsBS
	oiReJs58D0dIofMnE1Rc1fZg66GNG7cmQFfs7fn+5AdeJ4CHq0knVYtjVQZADnQ==
X-Received: by 2002:a05:620a:46a0:b0:914:7e9a:2716 with SMTP id af79cd13be357-9293c506503mr270635185a.38.1782383823309;
        Thu, 25 Jun 2026 03:37:03 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:914:7e9a:2716 with SMTP id af79cd13be357-9293c506503mr270631085a.38.1782383822848;
        Thu, 25 Jun 2026 03:37:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b7d7sm14073249f8f.31.2026.06.25.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:37:02 -0700 (PDT)
Message-ID: <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Content-Language: en-US
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
 <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZzMZMlCQ9BDy3p32djHRqKMr8_hFheP9
X-Proofpoint-ORIG-GUID: ZzMZMlCQ9BDy3p32djHRqKMr8_hFheP9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfXy6GquWweL98y
 XdBhCNhZ5awtZl6UAuLzk0tK7u5bgsyM+2S/L+a6RgD8FqWQz7WxC+Gz0a55rbkmqwL7htgcwCx
 yfrz0mtKt5XpEMXm+3fVGTxD9qkqSdA=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d04cf cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=yFRDIQdNgmOVVyJK8FYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX6ZUFksai+cyS
 OqdbKwUgtWnefYKWcJ7jyUzJKpIk9qxTv6Ir5m6uGz4j1xsKBQ/smmWf//buyrWW/C5HAZWNy5J
 SwaBRRW+tPchRWHJH4Ft4K9fPdR/0NNdolPgbTU58ZsRO9r9fR/297JBo42jE6cSp2SJxTfa3rd
 HETwfSMkYbki5TntOz1RBmH05xg29tT+VwOMHSE+QUJUg5VmcxBrIrJOupbnd1klLDn7/vrk6Nw
 7csGy81dZYdizvRXeA/PLFBFEWhYEfqrN0bk/XwSi9AMCtPA8AVX+bUd8G3dJr0/QMYNiDBWAiX
 Zwx/4DhbKjfWbKCha7KJBh3XAozEvNZ1/H8I2jAp+BVpKPQfpobQLdUD/mFTaaVx3W4PiYEIdIR
 2lkUbXAnunqeqtlz3xQyFgczGBZVbx0uNMTCvlwsWyQOdT6+fgD6OZ8gTcC9iUxI6NTn2iXF/yK
 KlWPYKUfyr3Ut5eYOPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250090

On 25/6/26 09:31, Harald Freudenberger wrote:
> On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
>> Hi Harald,
>>
>> On 24/6/26 10:09, Harald Freudenberger wrote:
>>> With the introduction of the address wrapping function
>>> wrap_address() the result can't be used to walk the
>>> source address any more. So introduce a new local variable
>>> to hold the wrapped address to avoid mixing source and
>>> wrapped address value.
>>>
>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>> argument")
>>
>> This commit merely added an argument. I suppose you meant
>> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").
>>
> 
> No. Commit fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
> argument")
> introduces the mmu_idx with the wrap_address() function or macro.

You are saying the same, not really explaining, I'm not following...

> And the result was something like this:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      addr = wrap_address(env, addr);
>      a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>    }
> 
> This code reuses the addr variable in the loop
> by setting addr to the wrapped address but after
> that the loop adds +8 to this wrapped address.
> This code only works as long as the wrapped address
> is equal to the address put put in.
> Thus introduce another intermediate variable which
> holds the wrapped address:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      uint64_t _addr = wrap_address(env, addr);
>      a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>    }
> 
> Of course it would also work with a direct replacement:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>    }
> 
> but this isn't that readable.
> 
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
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
>>
>> s/_addr/wa/ or even directly inline?
>>
>>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>
>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>       }
>>>   }
> 

