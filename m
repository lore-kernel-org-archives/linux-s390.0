Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB413BC3D;
	Tue, 13 Aug 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539150; cv=none; b=eWM/5ZqLpqP3UHtpomeDShcoSwNN1twUuJOPEXo/cBCZdhSHLVdIL7bb4NvJ+B7jyEMU1g71R4/tAUnVoGtXCoQsJBcTMtqY586279KU14Zhu3nvyE+JJj40bCXiKpqV1m/LCvnX/YTfFpSkUSMqt7Q8sijOiaKZ7lvCuTwn4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539150; c=relaxed/simple;
	bh=l+6d0G/fZCLDwkVVx5rEdwnsS2PoFnLxiZfzO6qlwIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJAeHtnaxQMbPS5iqxuabHqnVLmF8wfjRr2BEMkC+Jpt/gL4l9fIWbvliKrZCYOpWb4IhILZ+LiYy4GK/FxJddGghSAtrlaHN8vYAAniExxKv7YDusMs8kNHqIfmYcLxI86Qq9aW7TnwQp0Y+SBg+6HaM76GaXQPBheTtpdZylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UETRTk3k; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UETRTk3k"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723539139; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UKqdmkqrdrnUSQuPYTma+IyIpTeLxOlpeCWhOzQvg5s=;
	b=UETRTk3kLRLGLte41k36hD3XH8ouLGZ+NxvePJ4+NPyW3JHN+sxhE0Pkdd+a3bWxtb1SUIH0sEB5XYrlIwxlFpVMmd61hyF7SwKnGihvm0pUR7FeSJXgqXB7x4HzjLj/KtoxtUn1QZ+fX7XnGsa1sT15fXMS0ZJBk6gg4+07lZk=
Received: from 30.221.149.156(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCoOwhs_1723539137)
          by smtp.aliyun-inc.com;
          Tue, 13 Aug 2024 16:52:19 +0800
Message-ID: <4ccf34a0-3db2-4cbf-a9b2-cf585af8c63a@linux.alibaba.com>
Date: Tue, 13 Aug 2024 16:52:16 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Gerd Bayer <gbayer@linux.ibm.com>, Jeongjun Park <aha310510@gmail.com>,
 wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240810172259.621270-1-aha310510@gmail.com>
 <9102add11cb13e94d3d798290e7d08145e8a6af9.camel@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <9102add11cb13e94d3d798290e7d08145e8a6af9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/24 4:05 PM, Gerd Bayer wrote:
> On Sun, 2024-08-11 at 02:22 +0900, Jeongjun Park wrote:
>> Since smc_inet6_prot does not initialize ipv6_pinfo_offset,
>> inet6_create() copies an incorrect address value, sk + 0 (offset), to
>> inet_sk(sk)->pinet6.
>>
>> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock
>> practically point to the same address, when smc_create_clcsk() stores
>> the newly created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6
>> is corrupted into clcsock. This causes NULL pointer dereference and
>> various other memory corruptions.
>>
>> To solve this, we need to add a smc6_sock structure for
>> ipv6_pinfo_offset initialization and modify the smc_sock structure.
> I can not argue substantially with that... There's very little IPv6
> testing that I'm aware of. But do you really need to move that much
> code around and change whitespace for you fix?
>
> [--- snip ---]
>
>
>> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>>   net/smc/smc.h      | 19 ++++++++++---------
>>   net/smc/smc_inet.c | 24 +++++++++++++++---------
>>   2 files changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 34b781e463c4..f4d9338b5ed5 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -284,15 +284,6 @@ struct smc_connection {
>>   
>>   struct smc_sock {				/* smc sock
>> container */
>>   	struct sock		sk;
>> -	struct socket		*clcsock;	/* internal tcp
>> socket */
>> -	void			(*clcsk_state_change)(struct sock
>> *sk);
>> -						/* original
>> stat_change fct. */
>> -	void			(*clcsk_data_ready)(struct sock
>> *sk);
>> -						/* original
>> data_ready fct. */
>> -	void			(*clcsk_write_space)(struct sock
>> *sk);
>> -						/* original
>> write_space fct. */
>> -	void			(*clcsk_error_report)(struct sock
>> *sk);
>> -						/* original
>> error_report fct. */
>>   	struct smc_connection	conn;		/* smc connection */
>>   	struct smc_sock		*listen_smc;	/* listen
>> parent */
>>   	struct work_struct	connect_work;	/* handle non-
>> blocking connect*/
>> @@ -325,6 +316,16 @@ struct smc_sock {				/*
>> smc sock container */
>>   						/* protects clcsock
>> of a listen
>>   						 * socket
>>   						 * */
>> +	struct socket		*clcsock;	/* internal tcp
>> socket */
>> +	void			(*clcsk_state_change)(struct sock
>> *sk);
>> +						/* original
>> stat_change fct. */
>> +	void			(*clcsk_data_ready)(struct sock
>> *sk);
>> +						/* original
>> data_ready fct. */
>> +	void			(*clcsk_write_space)(struct sock
>> *sk);
>> +						/* original
>> write_space fct. */
>> +	void			(*clcsk_error_report)(struct sock
>> *sk);
>> +						/* original
>> error_report fct. */
>> +
>>   };

Hi Jeongjun,

I have no problem with this fix, thank you for your assistance.
But, what this here was for ?


>>   
>>   #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
>> index bece346dd8e9..3c54faef6042 100644
>> --- a/net/smc/smc_inet.c
>> +++ b/net/smc/smc_inet.c
>> @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_IPV6)
>> +struct smc6_sock {
>> +	struct smc_sock smc;
>> +	struct ipv6_pinfo np;
>> +};
>> +
>>   static struct proto smc_inet6_prot = {
>> -	.name		= "INET6_SMC",
>> -	.owner		= THIS_MODULE,
>> -	.init		= smc_inet_init_sock,
>> -	.hash		= smc_hash_sk,
>> -	.unhash		= smc_unhash_sk,
>> -	.release_cb	= smc_release_cb,
>> -	.obj_size	= sizeof(struct smc_sock),
>> -	.h.smc_hash	= &smc_v6_hashinfo,
>> -	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>> +	.name		       = "INET6_SMC",
>> +	.owner		       = THIS_MODULE,
>> +	.init		       = smc_inet_init_sock,
>> +	.hash		       = smc_hash_sk,
>> +	.unhash		       = smc_unhash_sk,
>> +	.release_cb	       = smc_release_cb,
>> +	.obj_size	       = sizeof(struct smc6_sock),
>> +	.h.smc_hash	       = &smc_v6_hashinfo,
>> +	.slab_flags	       = SLAB_TYPESAFE_BY_RCU,
>> +	.ipv6_pinfo_offset = offsetof(struct smc6_sock, np),

Since you have done alignment, why not align the  '='.

> The line above together with the definition of struct smc6_sock seem to
> be the only changes relevant to fixing the issue, IMHO.
>
>>   };
>>   
>>   static const struct proto_ops smc_inet6_stream_ops = {
>> --
>>
> Thanks, Gerd




