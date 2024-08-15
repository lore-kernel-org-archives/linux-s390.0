Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B5BA53;
	Thu, 15 Aug 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704564; cv=none; b=LIXQEYfO6Le4lmJng4YuiRR0BhX0NfIwT3KfQ5GaW8je37iqyUqX/s/TNGjPZrJ/p7/HPY7/pOQl5//hXcjzepZOSUnXIujLGruNR8lGbbMd2TOJGSqD0778BawyVdxwrJvHNuxr7pfcfuBTKDlgWjNQ5LvnYeWlD4CbkLPb4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704564; c=relaxed/simple;
	bh=GBFDD5hO31UtxQ3fdpkMHOjwMKil/jfzWGsr7KvcUoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG53HEJN7qmp+c0Q6suFDwYmlslhHa7SK5CTnLN6adh/5pDA/A3q6SqUN0/tfDiZZCo3tgkQ8zw4NbVOwmkhC3VE4PujdF/unqA6wQRpyNR4Mp6E7EkLPHk1VgEt0htwiJiWuRk7mcCE62P9gbhDPjMVGipVb7fjchqNFgJ5cus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qNJcKvas; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qNJcKvas"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723704558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FV7TrzVL+vp/dCsRizHWQY2sNChvjRjUcrbuhCkBO6k=;
	b=qNJcKvasXu/gKzyp3rROP8iVHJ1i1O6nZ4T4WpYuU5ld+PVRIcduwSqB1NP9BKzDAv4MmckVhELqVpYwSWvgMdOjbKD2olocOgql/T2SgOedq9hYqAexc5pgqP+4g8qz+KWd7QZ5rm0/IestnuV8FPpv18u1STZG41KBOfQYGPA=
Received: from 30.221.149.192(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCvpwnH_1723704235)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 14:43:56 +0800
Message-ID: <6bcd6097-13dd-44fd-aa67-39a3bcc69af2@linux.alibaba.com>
Date: Thu, 15 Aug 2024 14:43:55 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Jeongjun Park <aha310510@gmail.com>
Cc: wintera@linux.ibm.com, gbayer@linux.ibm.com, guwen@linux.alibaba.com,
 jaka@linux.ibm.com, tonylu@linux.alibaba.com, wenjia@linux.ibm.com,
 davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
 <20240814150558.46178-1-aha310510@gmail.com>
 <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
 <CAO9qdTGFGxgD_8RYQKTx9NJbwa0fiFziFyx2FJpnYk3ZvFbUmw@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAO9qdTGFGxgD_8RYQKTx9NJbwa0fiFziFyx2FJpnYk3ZvFbUmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 11:15 AM, Jeongjun Park wrote:
> 2024년 8월 15일 (목) 오전 11:51, D. Wythe <alibuda@linux.alibaba.com>님이 작성:
>>
>>
>> On 8/14/24 11:05 PM, Jeongjun Park wrote:
>>> Alexandra Winter wrote:
>>>> On 14.08.24 15:11, D. Wythe wrote:
>>>>>       struct smc_sock {                /* smc sock container */
>>>>> -    struct sock        sk;
>>>>> +    union {
>>>>> +        struct sock        sk;
>>>>> +        struct inet_sock    inet;
>>>>> +    };
>>>> I don't see a path where this breaks, but it looks risky to me.
>>>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>>>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
>>
>> There is no smc_sock->inet_sock->sk before. And this part here was to
>> make smc_sock also
>> be an inet_sock.
>>
>> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
>> So, the initialization of certain fields
>> in smc_sock(for example, clcsk) will overwrite modifications made to the
>> inet_sock part in inet(6)_create.
>>
>> For AF_SMC,  the only problem is that  some space will be wasted. Since
>> AF_SMC don't care the inet_sock part.
>> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
>> the sake of avoid wasting some space
>> is a little bit extreme.
>>
> Okay. I think using inet_sock instead of sock is also a good idea, but I
> understand for now.
>
> However, for some reason this patch status has become Changes Requested
> , so we will split the patch into two and resend the v5 patch.
>
> Regards,
> Jeongjun Park

Why so hurry ? Are you rushing for some tasks ? Please be patient.

The discussion is still ongoing, and you need to wait for everyone's 
opinions,
at least you can wait a few days to see if there are any other opinions, 
even if you think
your patch is correct.

There is no need to send a new patch. If this patch is approved, the net 
maintainer will handle it,
regardless of whether it is a change request or not.

And your new patch, I don't want to go too far, as you are a newcomer, I 
appreciate your report and
willingness to fix this issue. But it's wrong.

If you want to split them, embedding inet_sock should be the first 
patch, which is a basic logical issue.

Then, don't send patches so frequently, I'm very worried that you will 
immediately send out v6 after
seeing it.

Best wishes,
D. Wythe

>>> hmm... then how about changing it to something like this?
>>>
>>> @@ -283,7 +283,7 @@ struct smc_connection {
>>>    };
>>>
>>>    struct smc_sock {                           /* smc sock container */
>>> -     struct sock             sk;
>>> +     struct inet_sock        inet;
>>>        struct socket           *clcsock;       /* internal tcp socket */
>>>        void                    (*clcsk_state_change)(struct sock *sk);
>>
>> Don't.
>>
>>>                                                /* original stat_change fct. */
>>> @@ -327,7 +327,7 @@ struct smc_sock {                         /* smc sock container */
>>>                                                 * */
>>>    };
>>>
>>> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>>>
>>>    static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>>>    {
>>>
>>> It is definitely not normal to make the first member of smc_sock as sock.
>>>
>>> Therefore, I think it would be appropriate to modify it to use inet_sock
>>> as the first member like other protocols (sctp, dccp) and access sk in a
>>> way like &smc->inet.sk.
>>>
>>> Although this fix would require more code changes, we tested the bug and
>>> confirmed that it was not triggered and the functionality was working
>>> normally.
>>>
>>> What do you think?
>>>
>>> Regards,
>>> Jeongjun Park

