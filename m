Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74E67A1A;
	Mon,  6 May 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979804; cv=none; b=WQEbQ84P4tQG2didv4L+p5fUQBjHS+mF8Pa3O0rTCsMOfiMj7LY6fUfF2Y1spMelGkR5tENgQ7+mtAgptm/hk3VxbKBZPyTLTCbpv5DAsBHLTUcK3MnAE53NrEr2TYzfqQ148dCdJm1zuICrAqy6EeDLWCRRW4Ryzoe+7QVbWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979804; c=relaxed/simple;
	bh=Y8JxuvyKZOhfvd78F3vJoYA+MMwp35v1+bR6yUTz5RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJjdzf1XoKF4FygUFtMprZB33Z5+mG0AnTIZMhj1Kp0n2mBjen9coImauhdxzj9JeHquEdSzEQM/yPqMV6cGa2zIvjRWNBQ6VF1Ts03GHnaDgzhECdO6MYhs4kaqlI/w6Cl8dG05+lP4y0QdigKWEafkGB45rwcDJQVPw9d5Eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kPwn72Z4; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kPwn72Z4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714979798; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tO9ElOjebai/reO966Q+Ev5PG36wii1GIcjirNSadD0=;
	b=kPwn72Z4FMwyzs+bc5oPu2IUIiYJD1cqn0T1b/h4iB+2flP+tckPeozupMonXZba54OVnmKpT52OZkRmJGFaUrXCDApFts81lACNlbnpf26q2OVvVh6vIJaL/Dx5vSOL/XD1HUtOmgqNtYhUOsJNhmgjhpkiM3xaTzypLvPv7jA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5ugHvr_1714979795;
Received: from 30.221.130.10(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5ugHvr_1714979795)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 15:16:37 +0800
Message-ID: <d8a084e1-eae5-495f-b4c0-078800e7e611@linux.alibaba.com>
Date: Mon, 6 May 2024 15:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix netdev refcnt leak in
 smc_ib_find_route()
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240506015439.108739-1-guwen@linux.alibaba.com>
 <20240506055119.GA939370@maili.marvell.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240506055119.GA939370@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/6 13:51, Ratheesh Kannoth wrote:
> On 2024-05-06 at 07:24:39, Wen Gu (guwen@linux.alibaba.com) wrote:
>> A netdev refcnt leak issue was found when unregistering netdev after
>> using SMC. It can be reproduced as follows.
>>
>> - run tests based on SMC.
>> - unregister the net device.
>>
>> The following error message can be observed.
>>
>> 'unregister_netdevice: waiting for ethx to become free. Usage count = x'
>>
>> With CONFIG_NET_DEV_REFCNT_TRACKER set, more detailed error message can
>> be provided by refcount tracker:
>>
>>   unregister_netdevice: waiting for eth1 to become free. Usage count = 2
>>   ref_tracker: eth%d@ffff9cabc3bf8548 has 1/1 users at
>>        ___neigh_create+0x8e/0x420
>>        neigh_event_ns+0x52/0xc0
>>        arp_process+0x7c0/0x860
>>        __netif_receive_skb_list_core+0x258/0x2c0
>>        __netif_receive_skb_list+0xea/0x150
>>        netif_receive_skb_list_internal+0xf2/0x1b0
>>        napi_complete_done+0x73/0x1b0
>>        mlx5e_napi_poll+0x161/0x5e0 [mlx5_core]
>>        __napi_poll+0x2c/0x1c0
>>        net_rx_action+0x2a7/0x380
>>        __do_softirq+0xcd/0x2a7
>>
>> It is because in smc_ib_find_route(), neigh_lookup() takes a netdev
>> refcnt but does not release. So fix it.
>>
>> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ib.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>> index 97704a9e84c7..b431bd8a5172 100644
>> --- a/net/smc/smc_ib.c
>> +++ b/net/smc/smc_ib.c
>> @@ -210,10 +210,11 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>>   		goto out;
>>   	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
> need to release it here as well ?
> 

Do you mean call ip_rt_put() to release rt?

Yes, after investigating here, I agree that rt needs to be released as well. Thanks!

>>   		goto out;
>> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
>> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
>>   	if (neigh) {
>>   		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
>>   		*uses_gateway = rt->rt_uses_gateway;
>> +		neigh_release(neigh);
>>   		return 0;
>>   	}
>>   out:
>> --
>> 2.32.0.3.g01195cf9f
>>
