Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF31BF53;
	Wed, 14 Aug 2024 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603381; cv=none; b=uARkJPE1N6zDhlMj6VwBnKsEfHEJZ4ZttYivhQGzfSYsxUtpq14FNmyMmgl66rV0EgAo7i+HzD9hUGWSVvl3Q8Z8V1vgzDGac9S5FWbUVBKcNx7pwjdhsf52zpZIlcGov503+MxX3gsB7MHWef8XaEGn13LDxmseWkY5rDiXwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603381; c=relaxed/simple;
	bh=qMgoQ8ff0AtIQRyKQtgYk4VNhP10IgPLr4SQSL1q88Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YnRHlrJyqBKtVdUDqmRx8BXnNSvUri8BsjFAs4VG81rMZfFwr7uZZSsx8ca/Lxjly6QBXdzwW1iKclx/o/bhX0d3uexDvsPtnxIt+UsOqMHT66DBcghDYdPm6rcmlVGicZ9rXhQ5hBLxcoexwr7anGEAvNBX6O+PbKqjtrf2Yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=muVZ9rzu; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="muVZ9rzu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723603370; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zIQdpG/Wa4/ej2jcdCxMipT4/1f4NIH/1XPqtLIyEqw=;
	b=muVZ9rzuAB/rAzG4C8WmTV+oiOvW/uB+oV65S8a6v5nUrmGr11c96VvkJffHt2ayq9I+2sNqq1BlbXS91VHZTafNlJoBZOsKn2FGKcOK1tnzJcFniPJJDOLm0YkyRTuY9vXcsE1xSjlPBpedRONGD/8rFg5YQEtYGfMNscnqmYs=
Received: from 30.221.148.210(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCqgQ79_1723603368)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 10:42:49 +0800
Message-ID: <56255393-cae8-4cdf-9c91-b8ddf0bd2de2@linux.alibaba.com>
Date: Wed, 14 Aug 2024 10:42:47 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in
 txopt_get
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, gbayer@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 dust.li@linux.alibaba.com, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
References: <20240813100722.181250-1-aha310510@gmail.com>
 <b4b49770-2042-4ee8-a1e8-1501cdd807cf@linux.alibaba.com>
 <CAO9qdTFjG7TZ7BKJZ_dvvOm08tjYooVtjh-8mNSoOZ7Ys5H=Ww@mail.gmail.com>
 <97b85c74-55e9-4607-8f30-3a938638a309@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <97b85c74-55e9-4607-8f30-3a938638a309@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/24 10:25 AM, D. Wythe wrote:
>
>
> On 8/13/24 7:48 PM, Jeongjun Park wrote:
>> D. Wythe wrote:
>>>
>>>
>>> On 8/13/24 6:07 PM, Jeongjun Park wrote:
>>>> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, 
>>>> inet6_create()
>>>> copies an incorrect address value, sk + 0 (offset), to 
>>>> inet_sk(sk)->pinet6.
>>>>
>>>> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock 
>>>> practically
>>>> point to the same address, when smc_create_clcsk() stores the newly
>>>> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is 
>>>> corrupted
>>>> into clcsock. This causes NULL pointer dereference and various other
>>>> memory corruptions.
>>>>
>>>> To solve this, we need to add a smc6_sock structure for 
>>>> ipv6_pinfo_offset
>>>> initialization and modify the smc_sock structure.
>>>>
>>>> Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
>>>> Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
>>>> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
>>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>>> ---
>>>>    net/smc/smc.h      | 19 ++++++++++---------
>>>>    net/smc/smc_inet.c | 24 +++++++++++++++---------
>>>>    2 files changed, 25 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>>>> index 34b781e463c4..f4d9338b5ed5 100644
>>>> --- a/net/smc/smc.h
>>>> +++ b/net/smc/smc.h
>>>> @@ -284,15 +284,6 @@ struct smc_connection {
>>>>
>>>>    struct smc_sock {                           /* smc sock 
>>>> container */
>>>>        struct sock             sk;
>>>> -     struct socket           *clcsock;       /* internal tcp 
>>>> socket */
>>>> -     void                    (*clcsk_state_change)(struct sock *sk);
>>>> -                                             /* original 
>>>> stat_change fct. */
>>>> -     void                    (*clcsk_data_ready)(struct sock *sk);
>>>> -                                             /* original 
>>>> data_ready fct. */
>>>> -     void                    (*clcsk_write_space)(struct sock *sk);
>>>> -                                             /* original 
>>>> write_space fct. */
>>>> -     void                    (*clcsk_error_report)(struct sock *sk);
>>>> -                                             /* original 
>>>> error_report fct. */
>>>>        struct smc_connection   conn;           /* smc connection */
>>>>        struct smc_sock         *listen_smc;    /* listen parent */
>>>>        struct work_struct      connect_work;   /* handle 
>>>> non-blocking connect*/
>>>> @@ -325,6 +316,16 @@ struct smc_sock 
>>>> {                                /* smc sock container */
>>>>                                                /* protects clcsock 
>>>> of a listen
>>>>                                                 * socket
>>>>                                                 * */
>>>> +     struct socket           *clcsock;       /* internal tcp 
>>>> socket */
>>>> +     void                    (*clcsk_state_change)(struct sock *sk);
>>>> +                                             /* original 
>>>> stat_change fct. */
>>>> +     void                    (*clcsk_data_ready)(struct sock *sk);
>>>> +                                             /* original 
>>>> data_ready fct. */
>>>> +     void                    (*clcsk_write_space)(struct sock *sk);
>>>> +                                             /* original 
>>>> write_space fct. */
>>>> +     void                    (*clcsk_error_report)(struct sock *sk);
>>>> +                                             /* original 
>>>> error_report fct. */
>>>> +
>>>>    };
>>>>
>>>>    #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>>> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
>>>> index bece346dd8e9..25f34fd65e8d 100644
>>>> --- a/net/smc/smc_inet.c
>>>> +++ b/net/smc/smc_inet.c
>>>> @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
>>>>    };
>>>>
>>>>    #if IS_ENABLED(CONFIG_IPV6)
>>>> +struct smc6_sock {
>>>> +     struct smc_sock smc;
>>>> +     struct ipv6_pinfo np;
>>>> +};
>>> I prefer to:
>>>
>>> struct ipv6_pinfo inet6;
>> Okay, I'll write a v4 patch and send it to you tomorrow.
>>
>> Regards,
>> Jeongjun Park
>
> Before you issue the v4, I still don't know why you move clcsk_xxx 
> from smc_connection
> to smc_sock, can you explain it ?


I misread it, it seems you're moving them from head to tail, but still, 
the same question,
why move it ?

Thanks
D. Wythe


>
> Also, regarding alignment, it's okay for me whether it's aligned or 
> not，But I checked the styles of other types of
> structures and did not strictly require alignment, so I now feel that 
> there is no need to
> modify so much to do alignment.
>
> D. Wythe



>
>>
>>>> +
>>>>    static struct proto smc_inet6_prot = {
>>>> -     .name           = "INET6_SMC",
>>>> -     .owner          = THIS_MODULE,
>>>> -     .init           = smc_inet_init_sock,
>>>> -     .hash           = smc_hash_sk,
>>>> -     .unhash         = smc_unhash_sk,
>>>> -     .release_cb     = smc_release_cb,
>>>> -     .obj_size       = sizeof(struct smc_sock),
>>>> -     .h.smc_hash     = &smc_v6_hashinfo,
>>>> -     .slab_flags     = SLAB_TYPESAFE_BY_RCU,
>>>> +     .name                           = "INET6_SMC",
>>>> +     .owner                          = THIS_MODULE,
>>>> +     .init                           = smc_inet_init_sock,
>>>> +     .hash                           = smc_hash_sk,
>>>> +     .unhash                         = smc_unhash_sk,
>>>> +     .release_cb                     = smc_release_cb,
>>>> +     .obj_size                       = sizeof(struct smc6_sock),
>>>> +     .h.smc_hash                     = &smc_v6_hashinfo,
>>>> +     .slab_flags                     = SLAB_TYPESAFE_BY_RCU,
>>>> +     .ipv6_pinfo_offset              = offsetof(struct smc6_sock, 
>>>> np),
>>>>    };
>>>>
>>>>    static const struct proto_ops smc_inet6_stream_ops = {
>>>> -- 
>

