Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3921105;
	Thu, 15 Aug 2024 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690307; cv=none; b=uHi+WRTTcwhp6UaDCesZFLgp1kh9b2sK9IyGgHJUgBGcrJJDR559bepLzeeDfl3QjgOedSbTqWNv+qmEEUbNaIYqPhXLtbOD8Day3tcGW9dc0rWO3MRMMp0t/mT6gF4kmO6VlRQ8vLd245ApIUTabqe48mszWgVsxwUomRO9HLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690307; c=relaxed/simple;
	bh=XB/OFRNrquH4mpAQclpCYONQ3pgQikjiRXZkuOQFGbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFIIxuR/nJzpZ+g4hiWgWEjy/SBKFWsLl0tFJx1qhGTi9zz8oNlHJ2I16vmjOvv/jSkmILrJoSqOFMzl8eyC3zYegPLuFOSHBr/uMKwA7tzTVISVc/lQj4/Q8A74+MSXIvmn1k+6d07xvOi43dIhZkRgwXKPg1CgnChnHiCHWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gzMr9WFg; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gzMr9WFg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723690296; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UT+txWt3od0RrNF4QQo+/QHyhZ0lGG/Ah9rRkU+1xw0=;
	b=gzMr9WFgES9x9PlGozMcMstCl9PeCHhCgJy4hrQU9LSow0qKN7EgiphrR53+/DqYm2Fy9kWfHxlvjXtty7LtsOwbIw7H0yy8gHpsR+jFypg7vArV7/04E5VKGU1h5lVEPq/KTZRWCQGu8PXfoHBTZ1FzPCUjrwSrgNwrTvDK/rA=
Received: from 30.32.126.52(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCv-Oun_1723690294)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 10:51:35 +0800
Message-ID: <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
Date: Thu, 15 Aug 2024 10:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Jeongjun Park <aha310510@gmail.com>, wintera@linux.ibm.com,
 gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
 <20240814150558.46178-1-aha310510@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240814150558.46178-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/24 11:05 PM, Jeongjun Park wrote:
> Alexandra Winter wrote:
>> On 14.08.24 15:11, D. Wythe wrote:
>>>      struct smc_sock {                /* smc sock container */
>>> -    struct sock        sk;
>>> +    union {
>>> +        struct sock        sk;
>>> +        struct inet_sock    inet;
>>> +    };
>>
>> I don't see a path where this breaks, but it looks risky to me.
>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?


There is no smc_sock->inet_sock->sk before. And this part here was to 
make smc_sock also
be an inet_sock.

For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before. 
So, the initialization of certain fields
in smc_sock(for example, clcsk) will overwrite modifications made to the 
inet_sock part in inet(6)_create.

For AF_SMC,  the only problem is that  some space will be wasted. Since 
AF_SMC don't care the inet_sock part.
However, make the use of sock by AF_SMC and IPPROTO_SMC separately for 
the sake of avoid wasting some space
is a little bit extreme.


> hmm... then how about changing it to something like this?
>
> @@ -283,7 +283,7 @@ struct smc_connection {
>   };
>   
>   struct smc_sock {				/* smc sock container */
> -	struct sock		sk;
> +	struct inet_sock	inet;
>   	struct socket		*clcsock;	/* internal tcp socket */
>   	void			(*clcsk_state_change)(struct sock *sk);


Don't.

>   						/* original stat_change fct. */
> @@ -327,7 +327,7 @@ struct smc_sock {				/* smc sock container */
>   						 * */
>   };
>   
> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>   
>   static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>   {
>
> It is definitely not normal to make the first member of smc_sock as sock.
>
> Therefore, I think it would be appropriate to modify it to use inet_sock
> as the first member like other protocols (sctp, dccp) and access sk in a
> way like &smc->inet.sk.
>
> Although this fix would require more code changes, we tested the bug and
> confirmed that it was not triggered and the functionality was working
> normally.
>
> What do you think?
>
> Regards,
> Jeongjun Park

