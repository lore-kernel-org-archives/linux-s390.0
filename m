Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFD746E;
	Wed, 14 Aug 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615241; cv=none; b=NCFMgAOZF4TDb49n/f8Sj2mdyLZ1KGgHHpUpkJyc1faHPD6mbDPzno/rxFBnejs/BemsPKBytJMyLo9VkMnP/Ux68rFitdw7LkOCV955aeHYGh1SmIWWkzp7M5xGyyDAesNrdmgrG+xtbGzXcYZR15atBQmT6udndpyEruYuUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615241; c=relaxed/simple;
	bh=FOPl2havV4Ul4eVn3v9RX0fnwuQx/e7cxI411HDaxDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+vA6NQnox3UwXsAoeQCaxf37IF0k4D9Gca0CjLiQb2GPmf+k/RS0BVCr1LJ38gdit8i7Ib+kf1cljvCOCUmIAR4ZjD8N7fF+pU4n6VyTug5p1NuckAXpGy+6Z/iNvn/mZlXIdnX5NQOio9RBTCIcvb4OViXxl33J4uXijuJeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OfrGxKJ9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OfrGxKJ9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723615235; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kuNwCNNAn1z+ogm4NogyBe1/xX19uPpstxB17dEWlzk=;
	b=OfrGxKJ9bkKD5J4cpTDhO8JiTscAPTFHmxb4906vM4meL1n65q92stvIqrOBXn8HodlFHtYPgtlYvAN7DSk7u5qPA1BMJld+YC7MpcQodeBxCTRlqd2GNSHl/z+7oS+eutIk1yh2K2UtUKfW2bDYvNLi0A+P/s8C/NZr0GLj9Oc=
Received: from 30.221.148.210(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCr9oFT_1723615233)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 14:00:34 +0800
Message-ID: <4eeb32b7-d750-4c39-87df-43fd8365f163@linux.alibaba.com>
Date: Wed, 14 Aug 2024 14:00:32 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com
References: <56255393-cae8-4cdf-9c91-b8ddf0bd2de2@linux.alibaba.com>
 <20240814035812.220388-1-aha310510@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240814035812.220388-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/24 11:58 AM, Jeongjun Park wrote:
> Because clcsk_*, like clcsock, is initialized during the smc init process,
> the code was moved to prevent clcsk_* from having an address like
> inet_sk(sk)->pinet6, thereby preventing the previously initialized values
> ​​from being tampered with.

I don't agree with your approach, but I finally got the problem you 
described. In fact, the issue here is that smc_sock should also be an 
inet_sock, whereas currently it's just a sock. Therefore, the best 
solution would be to embed an inet_sock within smc_sock rather than 
performing this movement as you suggested.

struct smc_sock {               /* smc sock container */
     union {
         struct sock         sk;
         struct inet_sock    inet;
     };

     ...

Thanks.
D. Wythe


>
> Additionally, if you don't need alignment in smc_inet6_prot , I'll modify
> the patch to only add the necessary code without alignment.
>
> Regards,
> Jeongjun Park


>>
>>> Also, regarding alignment, it's okay for me whether it's aligned or
>>> not，But I checked the styles of other types of
>>> structures and did not strictly require alignment, so I now feel that
>>> there is no need to
>>> modify so much to do alignment.
>>>
>>> D. Wythe
>>
>>
>>>>>> +
>>>>>>     static struct proto smc_inet6_prot = {
>>>>>> -     .name           = "INET6_SMC",
>>>>>> -     .owner          = THIS_MODULE,
>>>>>> -     .init           = smc_inet_init_sock,
>>>>>> -     .hash           = smc_hash_sk,
>>>>>> -     .unhash         = smc_unhash_sk,
>>>>>> -     .release_cb     = smc_release_cb,
>>>>>> -     .obj_size       = sizeof(struct smc_sock),
>>>>>> -     .h.smc_hash     = &smc_v6_hashinfo,
>>>>>> -     .slab_flags     = SLAB_TYPESAFE_BY_RCU,
>>>>>> +     .name                           = "INET6_SMC",
>>>>>> +     .owner                          = THIS_MODULE,
>>>>>> +     .init                           = smc_inet_init_sock,
>>>>>> +     .hash                           = smc_hash_sk,
>>>>>> +     .unhash                         = smc_unhash_sk,
>>>>>> +     .release_cb                     = smc_release_cb,
>>>>>> +     .obj_size                       = sizeof(struct smc6_sock),
>>>>>> +     .h.smc_hash                     = &smc_v6_hashinfo,
>>>>>> +     .slab_flags                     = SLAB_TYPESAFE_BY_RCU,
>>>>>> +     .ipv6_pinfo_offset              = offsetof(struct smc6_sock,
>>>>>> np),
>>>>>>     };
>>>>>>
>>>>>>     static const struct proto_ops smc_inet6_stream_ops = {
>>>>>> --

