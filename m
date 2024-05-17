Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90D15AE0;
	Fri, 17 May 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930732; cv=none; b=uiWGxQrgvOLADfNsPQgeeXgO2bUEDSNzyjnIoB7bVtm2UmU7N8BusaCEdAaSRYuEoAUy8VxlePzhFvwod0grHoKHA6MaWVEbUn/RP1N0DwhxuFo+KuH1aPi8nWqU7xF6yukG2G1cwivD3AIX8XtJMpNuWVJWae6XAp6osGWK4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930732; c=relaxed/simple;
	bh=V9pZqZSgm0WFadTWQjQ7+lXhSwdmCrkdWtj1xIfgeCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqW4dYrhKchlMvOTs+LkvC3BNK83YHQ/7Qrm75fvMOdQE+JrT4qKHTIBJ3jp7nv3kEDaOGJytokiIQxKlv08NYhZPNA1jfT9Fil600T2TCp+8jZIuuXxgGJKq5dba0/2EOWa2+LgQYStE0w+7uCRugAiPgUUjlQmESJ3fvLO2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZLYJ6lmG; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZLYJ6lmG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715930721; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ymc8U18af+lJxyPx76zWHby9MgnIgq3GTnFdlP/uLo4=;
	b=ZLYJ6lmGOki3PRZ5ryvNCSMQ5WQiwtp4xyG6HeZhPczvHnZxkbmLfRGhPFUmG4G3pynx1kGOikwp+O7XR+w6vSxTHt7TPqSB448lLxaT5438HNYoX6qhWozR+31RKA+hBxXOmpkZkoCnOhUf5TFU2GpkHuSabvM2AZgGbGTy6c8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6drV.v_1715930399;
Received: from 30.221.130.119(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W6drV.v_1715930399)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 15:20:01 +0800
Message-ID: <cc0480b1-d02a-406c-8b58-aae4ac4aa0ce@linux.alibaba.com>
Date: Fri, 17 May 2024 15:19:59 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Wenjia Zhang <wenjia@linux.ibm.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
 kgraul@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
 <ba4c7916-d6c4-44b6-a649-1e17c65e87f9@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ba4c7916-d6c4-44b6-a649-1e17c65e87f9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/10 17:40, Wenjia Zhang wrote:
> 
> 
> On 07.05.24 07:54, Guangguan Wang wrote:
>> Hi, Wenjia and Jan,
>>
>> When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
>> fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.
>>
>> The first is in the function smc_ib_determine_gid_rcu, where restricts the subnet matching between smcrv2->saddr and the RDMA related netdev.
>> codes here:
>> static int smc_ib_determine_gid_rcu(...)
>> {
>>      ...
>>          in_dev_for_each_ifa_rcu(ifa, in_dev) {
>>              if (!inet_ifa_match(smcrv2->saddr, ifa))
>>                  continue;
>>              subnet_match = true;
>>              break;
>>          }
>>          if (!subnet_match)
>>              goto out;
>>      ...
>> out:
>>      return -ENODEV;
>> }
>> In my testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth0 in netnamespace2. For the sake of clarity
>> in the following text, we will refer to eth0 in netnamespace1 as eth1, and eth0 in netnamespace2 as eth2. The eth1's ip is 192.168.0.3/32 and the
>> eth2's ip is 192.168.0.4/24. The netmask of eth1 must be 32 due to some reasons. The eth1 is a RDMA related netdev, which means the adaptor of eth1
>> has RDMA function. The eth2 has been associated to the eth1's RDMA device using smc_pnet. When testing connection in netnamespace2(using eth2 for
>> SMC-R connection), we got fallback connection, rsn is 0x03010000, due to the above subnet matching restriction. But in this scenario, I think
>> SMC-R should work.
>> In my another testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth1 in netnamespace1. The eth0's ip is
>> 192.168.0.3/24 and the eth1's ip is 192.168.1.4/24. The eth0 is a RDMA related netdev, which means the adaptor of eth0 has RDMA function. The eth1 has
>> been associated to the eth0's RDMA device using smc_pnet. When testing SMC-R connection through eth1, we got fallback connection, rsn is 0x03010000,
>> due to the above subnet matching restriction. In my environment, eth0 and eth1 have the same network connectivity even though they have different
>> subnet. I think SMC-R should work in this scenario.
>>
>> The other is in the function smc_connect_rdma_v2_prepare, where restricts the symmetric configuration of routing between client and server. codes here:
>> static int smc_connect_rdma_v2_prepare(...)
>> {
>>      ...
>>      if (fce->v2_direct) {
>>          memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
>>          ini->smcrv2.uses_gateway = false;
>>      } else {
>>          if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
>>                smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
>>                ini->smcrv2.nexthop_mac,
>>                &ini->smcrv2.uses_gateway))
>>              return SMC_CLC_DECL_NOROUTE;
>>          if (!ini->smcrv2.uses_gateway) {
>>              /* mismatch: peer claims indirect, but its direct */
>>              return SMC_CLC_DECL_NOINDIRECT;
>>          }
>>      }
>>      ...
>> }
>> In my testing environment, server's ip is 192.168.0.3/24, client's ip 192.168.0.4/24, regarding how many netdev in server or client. Server has special
>> route setting due to some other reasons, which results in indirect route from 192.168.0.3/24 to 192.168.0.4/24. Thus, when CLC handshake, client will
>> get fce->v2_direct==false, but client has no special routing setting and will find direct route from 192.168.0.4/24 to 192.168.0.3/24. Due to the above
>> symmetric configuration of routing restriction, we got fallback connection, rsn is 0x030f0000. But I think SMC-R should work in this scenario.
>> And more, why check the symmetric configuration of routing only when server is indirect route?
>>
>> Waiting for your reply.
>>
>> Thanks,
>> Guangguan Wang
>>
> Hi Guangguan,
> 
> Thank you for the questions. We also asked ourselves the same questions a while ago, and also did some research on it. Unfortunately, it was not yet done and I had to delay it because of my vacation last month. Now it's time to pick it up again ;) I'll come back to you as soon as I can give a very 
> certain answer.
> 
> Thanks,
> Wenjia

Hi Wenjia, is there any new information on the original intent of these designs? :) Thanks!
