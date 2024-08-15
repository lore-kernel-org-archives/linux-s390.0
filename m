Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5B13A26F;
	Thu, 15 Aug 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707630; cv=none; b=BynBQs3CJ1PzEAXAZBvjuV3QiWTQcKlOYeLHq5N6jli5kWlBvL8MC0BTDAMvGPwgp0QXXa7Kr0Br1cQw7H9SQChhpZXUNLcQVDGdSEu/UAf6Jdo46CkqzainWeF7IfwmRIO5mlyGTkguyZ5CL1PdrELH2DGCvDGmOhZEFKOdBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707630; c=relaxed/simple;
	bh=ELK1TUq9Bz71fAHvrUMzChwNrvo7+0jN0Q9iyU/EqdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3djkUWdcd6ZwDBm4F9uG7txr9xtzrF1Fr+N9A1Kgf1DoiRVHmehBPeMA2XiVSJhBldhkjyU8hKyGRzPz97Bvy22pJaaZAD2CYdxkG+LWIGjgoI2wdwACW/k34XgM9PboMu74piLMNLahRmYibCzsbu+3hl24oFXL5a2pfO+WPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sV4809zs; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sV4809zs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723707618; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pFrK2j7ehfMhjy01kT1kIShp9CVxKwgMTY3JXGTAbn8=;
	b=sV4809zslRSo6q+0MeClKuumPmDaNwkCyCfv82Od5dkdQBhqxylvQZsggvWCbr7NtzYo0Hxjb50DwlK6RzElBozY2eyosAW/L7wsDHGv0wdCakEPPd+Q8+EZR7dsYmMqQTWOk0Z3Yh6XCQqXlcqdl7y6LNJsalhOpyWlfIYm5dU=
Received: from 30.221.149.192(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCvsuc6_1723707295)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 15:34:56 +0800
Message-ID: <08f4d3cf-4d9a-47e6-a033-ed8c03ee5a0e@linux.alibaba.com>
Date: Thu, 15 Aug 2024 15:34:55 +0800
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
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <c9c35759-33e7-4103-a4f0-af1d5fdefcdf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 3:03 PM, Alexandra Winter wrote:
>
> On 15.08.24 08:43, D. Wythe wrote:
>>
>> On 8/15/24 11:15 AM, Jeongjun Park wrote:
>>> 2024년 8월 15일 (목) 오전 11:51, D. Wythe <alibuda@linux.alibaba.com>님이 작성:
>>>>
>>>> On 8/14/24 11:05 PM, Jeongjun Park wrote:
>>>>> Alexandra Winter wrote:
>>>>>> On 14.08.24 15:11, D. Wythe wrote:
>>>>>>>        struct smc_sock {                /* smc sock container */
>>>>>>> -    struct sock        sk;
>>>>>>> +    union {
>>>>>>> +        struct sock        sk;
>>>>>>> +        struct inet_sock    inet;
>>>>>>> +    };
>>>>>> I don't see a path where this breaks, but it looks risky to me.
>>>>>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>>>>>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
>>>> There is no smc_sock->inet_sock->sk before. And this part here was to
>>>> make smc_sock also
>>>> be an inet_sock.
>>>>
>>>> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
>>>> So, the initialization of certain fields
>>>> in smc_sock(for example, clcsk) will overwrite modifications made to the
>>>> inet_sock part in inet(6)_create.
>>>>
>>>> For AF_SMC,  the only problem is that  some space will be wasted. Since
>>>> AF_SMC don't care the inet_sock part.
>>>> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
>>>> the sake of avoid wasting some space
>>>> is a little bit extreme.
>>>>
>
> Thank you for the explanation D. Wythe. That was my impression also.
> I think it is not very clean and risky to use the same structure (smc_sock)
> as inet_sock for IPPROTO_SMC and as smc_sock type for AF_SMC.
> I am not concerned about wasting space, mroe about maintainability.
>
>

Hi Alexandra,

I understand your concern, the maintainability is of course the most 
important. But if we use different
sock types for IPPROTO_SMC and AF_SMC, it would actually be detrimental 
to maintenance because
we have to use a judgment of which type of sock is to use in all the 
code of smc, it's really dirty.

In fact, because a sock is either given to IPPROTO_SMC as inet_sock or 
to AF_SMC as smc_sock,
it cannot exist the same time.  So it's hard to say what risks there are.

Of course, I have to say that this may not be that clean, but compared 
to adding a type judgment
for every sock usage, it is already a very clean approach.

Best wishes,
D. Wythe

>>> Okay. I think using inet_sock instead of sock is also a good idea, but I
>>> understand for now.
>>>
>>> However, for some reason this patch status has become Changes Requested
>
> Afaiu, changes requested in this case means that there is discussion ongoing.
>
>
>>> , so we will split the patch into two and resend the v5 patch.
>>>
>>> Regards,
>>> Jeongjun Park
>> Why so hurry ? Are you rushing for some tasks ? Please be patient.
>>
>> The discussion is still ongoing, and you need to wait for everyone's opinions,
>> at least you can wait a few days to see if there are any other opinions, even if you think
>> your patch is correct.
>>
> [...]
>> Best wishes,
>> D. Wythe
>
> I understand that we have a real problem and need a fix. But I agree with D. Wythe,
> please give people a chance for discussion before sending new versions.
> Also a version history would be helpful (what changed and why)
>
>
>>>>> hmm... then how about changing it to something like this?
>>>>>
>>>>> @@ -283,7 +283,7 @@ struct smc_connection {
>>>>>     };
>>>>>
>>>>>     struct smc_sock {                           /* smc sock container */
>>>>> -     struct sock             sk;
>>>>> +     struct inet_sock        inet;
>>>>>         struct socket           *clcsock;       /* internal tcp socket */
>>>>>         void                    (*clcsk_state_change)(struct sock *sk);
>>>> Don't.
>>>>
>>>>>                                                 /* original stat_change fct. */
>>>>> @@ -327,7 +327,7 @@ struct smc_sock {                         /* smc sock container */
>>>>>                                                  * */
>>>>>     };
>>>>>
>>>>> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>>>> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>>>>>
>>>>>     static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>>>>>     {
>>>>>
>>>>> It is definitely not normal to make the first member of smc_sock as sock.
>>>>>
>>>>> Therefore, I think it would be appropriate to modify it to use inet_sock
>>>>> as the first member like other protocols (sctp, dccp) and access sk in a
>>>>> way like &smc->inet.sk.
>>>>>
>>>>> Although this fix would require more code changes, we tested the bug and
>>>>> confirmed that it was not triggered and the functionality was working
>>>>> normally.
>>>>>
>>>>> What do you think?
>
> Yes, that looks like what I had in mind.
> I am not familiar enough with the details of the SMC code to judge all implications.
>
>
>>>>> Regards,
>>>>> Jeongjun Park
>>

