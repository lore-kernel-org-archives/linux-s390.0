Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE6423A65
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829200; cv=none; b=tdxIh9kIXcBKQgpzoFsxMsL/EybR5WXQzFFSHcUK9C1H0LW34Ies6nOECRDj0veB2Ji8BhTwzM24iD8Vbzq49WSrg4HWQYX/9h87bOU6/4BR9Gmt9g/87TPrbxdqPTIf7dPp0LXHS+h3gpz7oanN2nzVPhI37LujS8nAZ6nyzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829200; c=relaxed/simple;
	bh=E2a04pJmYntFu5QsDZoTAc6chS0/RiLFnAagEXxd1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq+0XEdjJebYvW5nyod/bbV9iOLglsBv6xQ69mEWVYLkMC7dzeYnKPyDSRbh9c6gHuCsJPn8v9pzKQDnLhS3CxtuLmcoaeq5Xx1Olz9Vs3vpSTYvUhQtrT4zazrCiaJLg2QATv/m/aPtvITVNi8v6tR4tMzmgFz9amTpavZr5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdjvmUAZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceU9nQcb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdjvmUAZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceU9nQcb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDSTf2129051
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=; b=HdjvmUAZk2HvPFO7
	2fop/8j/kX9mHOAMytXR2AmMebUVnxuC+zr46WfD0jLdD3UXVslqDy+tA1OCbvjO
	hlDFXVwfgWTMXTbaR/h/KcqKkitTlBWJZuf1r3bQwIw3wo9rGTw3y5wzJ7FsQSj6
	ODADvxnxDxnFI9rM0XoeQJUgkWGDruSa5iIHYBf72e0Sl3l+kJsZ3/cjJBKjeH8Y
	Y6Ryob3SdCaSIH7fVge+v8dl92S8apbr/tbDO+ldkJ6NHohEytkmuB2LZKhDx39D
	TVvnb9Y7zmZGsq0qoRgNpOJu4faqpBCj3k/McZTvUY8KkblsZqm50Vza/vrU12Gy
	hGhF0A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw93tfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 14:19:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-737d352d3b0so2896565137.1
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782829196; x=1783433996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=;
        b=ceU9nQcb167kxCM+E/F+MAvshDWgzDeuUklfTyoMR+xxi5xHKJRzCv3w1gYKnLIaWE
         ZQCx9TKuonhh3r4UbocIhDUXzIPny2tHoFlAeVUHnIR8pBMLga4hL8V85yLdMD91017V
         d39vNUuokng6z06UCSgJWhLvcNdZpA7cS4zwuqMC0uK4YTqsGARnM2DJsR2vvtZITQpJ
         KwdBUQShoRqHVOnzZr9heRiu+tolrDaSnZ0jVXshpGxKeN6aehEwZNgCg8zmPRYLGE6h
         qRauOArLAIhqTFzcZEDWNaiO5PPlGO3DHl1AxNdipoJ0SJ7jiUlsftfR0jTgtucvf79Z
         xUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782829196; x=1783433996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=;
        b=AFTbv/xIjsR5ic7+cdHgjLgtmGWyn5Et7GH9FlslP481KK17JZyB/3i2FWGs2O0608
         FiAgBOF2AUHZwTQFFkHnrhpksrxYAFq9VKEaxBnUkvY7pTHewg23xxREWiaW3Ly2yq5H
         R4itLxeUzmkxKOTNjayQjYEJ194szWUv4+7aAaH3W6Kq3x58xZQl7YjHtsOcE+Zq+/mJ
         Gkco+KpWTH2fGTo3Mr7dkATwG9o3vm6X7I8mYcPv6Kl2IAFoxvKqStP99g5+arM5vF5C
         9+x7oyF6n/PElPM5tst+3v4/0iwTLH5JHVZoXOn0CQryelMBoYpTcCAK8K5sqm4ILyis
         gqQg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa3XHRmpXRZ9hmaVdQpuFYliv1RZRX7W1+gwLhIHqvdW1VcG23Q08LJl3tzZ1UDu/VoqbTFNWdr5XR@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkGa/kvqyWgTQja0sy6kBR/TgKtEZQNde/pjIPpQlqo44OHs0
	1Q9llFyhv3TMG2x1U5nFL6hLWPP+8XXwLd7NHEhpTmuRrWI//bHK3renNQt36KY2d5cgMNOKAYu
	omp3pz+BEhZHkq+wFKpqvCGb08SIsVChe/ZOystOWWVUlrR7wmYdPisRGDdG/fszp
X-Gm-Gg: AfdE7clAJgWU+n5a/Td54sJxRg24VJBGW5Lll21xEJQxTaZfjepv9/IpLRZCRO51Uqx
	kGS1Sj1yb83icjSlqbZJJ6P9eegDV+wfUGrA/5Rqxdfk0hUwAEXQ8hKXTUa/E/C6ERMxEzGWYEO
	KF6v35RTKSUde14q9SBcxjpEOvgDFjI9neeC5AUgPO+kKb/ZKzSi4Lhxl+YWJJ4VmY5rMvwLZ9S
	9D4kjfMMNGufkIG2zwH0BtzDdtemWBSHbAbhnU3CCo+/5Phu38QZhjeruGJ00WqEOH43bDf5Kb0
	967BDvAiRG9/zP1TXlJXR+434DuIrHh1rhoRoO5xqmFKr6C/B8VNQ/FM7BnPapAEA196KG6gEmG
	tX9+HLnNVqg/cdKA03bCWECDz3woaqxnOBPC8zK99bKzD5Uv66mnEwZJcUfvXTw==
X-Received: by 2002:a05:6102:f89:b0:650:94b2:b209 with SMTP id ada2fe7eead31-73a365e0f3amr2099740137.4.1782829196211;
        Tue, 30 Jun 2026 07:19:56 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:650:94b2:b209 with SMTP id ada2fe7eead31-73a365e0f3amr2099710137.4.1782829195541;
        Tue, 30 Jun 2026 07:19:55 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be383819sm875845e9.1.2026.06.30.07.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:19:54 -0700 (PDT)
Message-ID: <b13c7644-83aa-48c8-9045-550a436b57ad@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 16:19:52 +0200
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
To: Ilya Leoshkevich <iii@linux.ibm.com>, freude@linux.ibm.com
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX5yfZh7fX3dS3
 yogiNfi3uYtM7woeilUKsAKpzUpNgqvJcwy9SaqraA2WNDTcv8NGsxD3rBXE9PelpWqYD86gs1+
 3VVsICfcV8dZAQi3a8r8qAOABRmLItc=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43d08c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VnNF1IyMAAAA:8 a=lMLw8EYMNNNL7W2twHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: SlTGpNeNNznrpbZoNaEcdxQmi7rYJsST
X-Proofpoint-ORIG-GUID: SlTGpNeNNznrpbZoNaEcdxQmi7rYJsST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX0kZZY6NySNmP
 C01fy12VbT4yASsMEv7AjQAczppPJ2O7viEVOksZfbDxls/Jc3sonECRcHHPjC06Dn+6uZrTUjQ
 Wqn8ZdHZv8HDhx9c+yksi6iguldzvrDBzaQa4gXNbqpbnUUyp5q18khOdOljIv+Cx6SBN1QNIuQ
 eWEpUufekCd9xMCRhhC/Mlp9JPHQzpBRmHoJ5o8F9AMbrdwsbflvA6V5BU+YJVmWsL82TUKopMt
 yvfGxcaVFwHe5KaNLTiimtLeaDKXnKEev0LTrAVcm1VVThYipwVtxJtPfIFUX9Fwchb69dF/Ycg
 dh6BN/OUjoCuzqZSsrCtk/tf/sUokTs0A1kFxrafEKPvc2jYaGhurAgHxjmHut/5dNpDgLbfJDP
 gIUnz8503kNdxNHLOtcXOJ7m9TRlQDq+AqxsW6gVqAUeqCQGmqxgbEfq06yFZ1ST0s/anrWdzAU
 Wfa2oo8BGJfK3I/q8ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300133

On 30/6/26 12:54, Ilya Leoshkevich wrote:
> 
> 
> On 6/30/26 12:23, Harald Freudenberger wrote:
>> On 2026-06-30 11:33, Ilya Leoshkevich wrote:
>>> On 6/29/26 14:57, Harald Freudenberger wrote:
>>>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>>>> With the introduction of the address wrapping function
>>>>>> wrap_address() the result can't be used to walk the
>>>>>> source address any more. So introduce a new local variable
>>>>>> to hold the wrapped address to avoid mixing source and
>>>>>> wrapped address value.
>>>>>>
>>>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>>>> argument")
>>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>>> ---
>>>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>
>>>>> If I take as an example AMODE 24 and look at the third loop iteration,
>>>>> with the current code in master I would get:
>>>>>
>>>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>>>>
>>>>> and with your patch it would be:
>>>>>
>>>>>     (addr + 8 + 8) & 0xffffff
>>>>>
>>>>> which is undeniably more elegant, but otherwise looks equivalent to 
>>>>> me.
>>>>>
>>>>> What is the functional issue here?
>>>>>
>>>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>>>> crypto_helper.c
>>>>>> index ae392bce0e..29ad2aff43 100644
>>>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState 
>>>>>> *env, const int mmu_idx,
>>>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>>>>> mmu_idx);
>>>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>>>> -        addr = wrap_address(env, addr);
>>>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>>>> +        uint64_t _addr = wrap_address(env, addr);
>>>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>>>       }
>>>>>>   }
>>>>>
>>>>> [...]
>>>>
>>>> It is a fix, not an improvement. The original code
>>>> used the addr variable to hold the wrapped address.
>>>> But as addr is also used as the loop variable there
>>>> is a mixing between unwrapped and wrapped address here
>>>> and the unfixed code only works when wrap_address does
>>>> return the very same address as output as it became as
>>>> input. My fix corrects this.
>>>
>>> What does the patch change w.r.t. wrapping?
>>> Suppose we have amode 24 and addr = 0xfffff0:
>>>
>>> Before:
>>>
>>>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>>>          a[0] = ldq(0xfffff0);
>>>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>>>          a[1] = ldq(0xfffff8);
>>>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>>>          a[2] = ldq(0);
>>>   i = 3; addr = wrap(0 + 8) = 8;
>>>          a[3] = ldq(8);
>>>
>>> After:
>>>
>>>   i = 0; addr = 0xfffff0;
>>>          _addr = wrap(0xfffff0) = 0xfffff0;
>>>          a[0] = ldq(0xfffff0)
>>>   i = 1; addr = 0xfffff0 + 8;
>>>          _addr = wrap(0xfffff8) = 0xfffff8;
>>>          a[1] = ldq(0xfffff8);
>>>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>>>          _addr = wrap(0x1000000) = 0;
>>>          a[2] = ldq(0);
>>>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>>>          _addr = wrap(0x1000008) = 8;
>>>          a[3] = ldq(8);
>>>
>>> The behavior look identical to me.
>>> What am I missing?
>>
>> Lets assume addr is some 0x1000 and wrap does just add some offset, 
>> e.g. 0x8000
>>
>> for (int i = 0; i < 8; i++, addr += 8) {
>>      addr = wrap_address(env, addr);
>>      fetch or write something at the wrapped address addr;
>> }
>>
>> Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
>> 1. loop with i=0 and addr 0x1000
>> 2. loop with i=1 and addr 0x1000 + 8
>> 3. loop with i=2 and addr 0x1000 + 8 + 8
>> 4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
>> 5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
>> 6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
>> 7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
>> 8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8
>>
>> BUT the given code does something different. As the addr is used in 
>> the loop
>> to hold the wrapped address this loop in fact does:
>> 1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
>> wrap_address() at the
>>     end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next loop 
>> starts with
>> 2. loop with i=1 and addr 0x9000 + 8
>>     and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and 
>> next loop starts
>> 3. loop with i=2 and addr 0x11008 + 8
>>     ...
>>
>> So introducing an intermediate variable which holds the wrapped address
>> makes sure the surrounding addr walk in the loop does as intended.
> 
> Ah, now I see where we were talking past each other, thanks for the
> clarification. You assume that wrap_address() may do arbitrary
> transformations, like addition in your example above. But today it does
> only bitwise "and", as defined by the architecture:
> 
> static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> {
>      if (!(env->psw.mask & PSW_MASK_64)) {
>          if (!(env->psw.mask & PSW_MASK_32)) {
>              /* 24-Bit mode */
>              a &= 0x00ffffff;
>          } else {
>              /* 31-Bit mode */
>              a &= 0x7fffffff;
>          }

            bool wrap32 = env->psw.mask & PSW_MASK_32;
            a = extract64(a, 0, wrap32 ? 31 : 24);
>      }
>      return a;
> }
> 
> and I believe in this specific case the order doesn't matter.
> 

