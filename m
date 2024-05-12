Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C51B299;
	Sun, 12 May 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514204; cv=none; b=BA27kReBWmNEOlUbCRZ+L+YM8nHIE7+08QuE49GnB46FyvkyeEH7D7qZKkfkwR8Ob/Cxq2q0+FfMn7su2sJTM92sLBqLJQYy/3z2YZWsBzHUDs4e5pUpzaf9zsEgT2dBkkkKOZjKPHTDuH1qWBqu3Tkf3do1PcMwePEd4xaBqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514204; c=relaxed/simple;
	bh=qLj4gJFZ/7RuARyGAnZp84xT1mPl/8zeXxVZwa+jfd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ1S9suzAPUGC7roTaw8uDiWx48FMsCaafrGK65LlGMzaezagZ2lv9lpKA7Wm9mK5ef27/4XjWLMb4Yr26nEHloVdI1ZWIIzLH/4jrldmEhO+J+KmRZd0P8fue9YspR0YWNxH4XUIMbcGJKppesa2JFLmGEGhfYlse7lRmSh9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jNnTAm1p; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jNnTAm1p"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715514191; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zP98sGRL72gU8rZzmqd2nC7wYAJhh+7edu3Bc8oq2fM=;
	b=jNnTAm1psYsmKrvWnYgLkmyZHjZ9i3MAlqgxmqFejqnz5lrEPhX8y1KTD1ZBY8OxEOTX0hXiXFFvZ40zE7eKEUdU4/aZZEh65aJpUFND/Yq/frz813xx1PB2/G5VQlKFuBPuljjrv59PHdpYoOanMPnJOhBMKBfFRe2DLFahokI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6FbEpK_1715514189;
Received: from 30.236.12.8(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W6FbEpK_1715514189)
          by smtp.aliyun-inc.com;
          Sun, 12 May 2024 19:43:10 +0800
Message-ID: <8ba154e0-30cb-4bc4-9aa2-d4a02cb27545@linux.alibaba.com>
Date: Sun, 12 May 2024 19:43:09 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 kgraul@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
 <ba4c7916-d6c4-44b6-a649-1e17c65e87f9@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <ba4c7916-d6c4-44b6-a649-1e17c65e87f9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
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
> Thank you for the questions. We also asked ourselves the same questions a while ago, and also did some research on it. Unfortunately, it was not yet done and I had to delay it because of my vacation last month. Now it's time to pick it up again ;) I'll come back to you as soon as I can give a very certain answer.
> 
> Thanks,
> Wenjia

Hi, Wen Jia,

So glad to hear that these questions have also caught your attention, and I'm really looking forward to your answers.

Thanks,
Guangguan Wang
