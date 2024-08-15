Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBD224EF;
	Thu, 15 Aug 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709407; cv=none; b=CREMFp8FSHbxukhW+E3+/f3FuUHEw92dVRR60HqhXv6tZ7y61YZXcVTIS74BhNH6TS8TAk3BY7LAfAECJCVviAOHjeRPjTm7ipsS/S9VLcvMi3Qszdxmz73tuvnfXVfDvV0eGH8azEDAy+MYy5/fOThjzytb6vXebbzONnjsriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709407; c=relaxed/simple;
	bh=Vq9fdpiHYCcA3YutqCJf5nOgy5ZsiZMwomSl6P5m1+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPMadaO94IegUsM3PIsJcxfCfwhXr8GYYf2q5ocTMDwpILtiZpzMflwNd1ODkV3AXhptzpAYRnruMIMFBA4GIRXhaP7rVyS3iZijOA5V78o0Ui5TSSXhOn2MbqYXa+19V+X1zSnQEIm0NvjILiDHDyehKKixrCMRFYc1gQfFzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ij/YyljS; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ij/YyljS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723709396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dhlnD4w2ERVomdZm2wZoEaPSUN72pF3OY/AUE2o6W1E=;
	b=Ij/YyljSxBzt4x0JMM0Wt9lEGIHPeQqWvoLvVORm3/1o+FOzsPn463lzmX4PKsgcBBpABDoeibAtg0KrmOe1filN5iTnOtUTN1QSRZ4CQfpJNdV0oaLUjRUOQROjucRnBUPR2K4Dd1FBJFt/dyao5NUpkF1vpx6dLnZZWQ+nVm0=
Received: from 30.221.149.192(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCw3Kx0_1723709394)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 16:09:55 +0800
Message-ID: <5f283fe3-92e9-4622-bda6-ad40b718aadc@linux.alibaba.com>
Date: Thu, 15 Aug 2024 16:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Alexandra Winter <wintera@linux.ibm.com>,
 Jeongjun Park <aha310510@gmail.com>
Cc: gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com, davem@davemloft.net,
 dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
 <20240814150558.46178-1-aha310510@gmail.com>
 <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
 <CAO9qdTGFGxgD_8RYQKTx9NJbwa0fiFziFyx2FJpnYk3ZvFbUmw@mail.gmail.com>
 <6bcd6097-13dd-44fd-aa67-39a3bcc69af2@linux.alibaba.com>
 <c9c35759-33e7-4103-a4f0-af1d5fdefcdf@linux.ibm.com>
 <08f4d3cf-4d9a-47e6-a033-ed8c03ee5a0e@linux.alibaba.com>
 <5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 3:56 PM, Alexandra Winter wrote:
>
> On 15.08.24 09:34, D. Wythe wrote:
>>
>> On 8/15/24 3:03 PM, Alexandra Winter wrote:
>>> On 15.08.24 08:43, D. Wythe wrote:
>>>> On 8/15/24 11:15 AM, Jeongjun Park wrote:
>>>>> 2024년 8월 15일 (목) 오전 11:51, D. Wythe <alibuda@linux.alibaba.com>님이 작성:
>>>>>> On 8/14/24 11:05 PM, Jeongjun Park wrote:
>>>>>>> Alexandra Winter wrote:
>>>>>>>> On 14.08.24 15:11, D. Wythe wrote:
>>>>>>>>>         struct smc_sock {                /* smc sock container */
>>>>>>>>> -    struct sock        sk;
>>>>>>>>> +    union {
>>>>>>>>> +        struct sock        sk;
>>>>>>>>> +        struct inet_sock    inet;
>>>>>>>>> +    };
>>>>>>>> I don't see a path where this breaks, but it looks risky to me.
>>>>>>>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>>>>>>>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
>>>>>> There is no smc_sock->inet_sock->sk before. And this part here was to
>>>>>> make smc_sock also
>>>>>> be an inet_sock.
>>>>>>
>>>>>> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
>>>>>> So, the initialization of certain fields
>>>>>> in smc_sock(for example, clcsk) will overwrite modifications made to the
>>>>>> inet_sock part in inet(6)_create.
>>>>>>
>>>>>> For AF_SMC,  the only problem is that  some space will be wasted. Since
>>>>>> AF_SMC don't care the inet_sock part.
>>>>>> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
>>>>>> the sake of avoid wasting some space
>>>>>> is a little bit extreme.
>>>>>>
>>> Thank you for the explanation D. Wythe. That was my impression also.
>>> I think it is not very clean and risky to use the same structure (smc_sock)
>>> as inet_sock for IPPROTO_SMC and as smc_sock type for AF_SMC.
>>> I am not concerned about wasting space, mroe about maintainability.
>>>
>>>
>> Hi Alexandra,
>>
>> I understand your concern, the maintainability is of course the most important. But if we use different
>> sock types for IPPROTO_SMC and AF_SMC, it would actually be detrimental to maintenance because
>> we have to use a judgment of which type of sock is to use in all the code of smc, it's really dirty.
>>
>> In fact, because a sock is either given to IPPROTO_SMC as inet_sock or to AF_SMC as smc_sock,
>> it cannot exist the same time.  So it's hard to say what risks there are.
>>
>> Of course, I have to say that this may not be that clean, but compared to adding a type judgment
>> for every sock usage, it is already a very clean approach.
>>
>
> At least the union makes it visible now, so it is cleaner than before.
> Maybe add a comment to the union, which one is used in which case?
>
>> Best wishes,
>> D. Wythe
>>
> [...]
>
>>>>>>> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>>>>>> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>>>>>>>
>
> Just an idea: Maybe it would be sufficient to do the type judgement in smc_sk() ?

I'm afraid not. We need do at least like this

void  smc_sendmsg(struct sock *sk, ...)
{
     struct smc_inet_sock *inet_smc;
     struct smc_sock * smc ;

     if (sk->protocol == IPPROTO_SMC) {
         inet_smc = smc_inet_sk(sk);
         do_same_sendmsg_but_with_inet_sock(inet_smc);
     } else {
         smc = smc_sk(sk);
         do_same_sendmsg_but_with_smc_sock(smc);
     }
}

I am more prefer to what you said about adding more comments. Of course 
it's just my idea,
We can also see if Jan and Wenjia have any other ideas too.

Best wishes,
D. Wythe


>

