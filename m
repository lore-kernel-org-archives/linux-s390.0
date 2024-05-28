Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3A71748;
	Tue, 28 May 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879559; cv=none; b=pPwwPZp/glfXSWAecYp74c0l6Te0BdtyXaD7ug7JbXi8+wZblBIsncyOxWGowo/tlAcoRLcfXvZUN/LZtG2fftD+1VRRL4UBQlByj6II/GulSu9Px664ZzJ7nLhK3QBfEQP+FdCneEyLy0aDn/voWMvP5hIqji81Kx1VwIT0SoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879559; c=relaxed/simple;
	bh=/Yf0JW8LDSFnss/0AtKBiH9oDph8w4srLwrP3mK8GV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNfzvt4c17BhjJQGS+bMrevVHsp5ov+tLYk3CQnixRkMBm9lPV0jmJzDSiugi0n1R+VMEd9Wcv/rL8vH23+dfmolpbx+v3ecG1U0pLiecK/HADaaDoO4kFuacT5EIi0SSpcmmTLJ5jD9j9MlqSJBcEJpRZx3BeH9xGkrECT+8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tBV6bLoE; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tBV6bLoE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716879553; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lGfdc1RsIqK8uE57Ip0a1BffAQvQcBg5SDFMlNn4XIM=;
	b=tBV6bLoENcZBaUATwZkvWn23ci1Oxb1aC1yku1QO4bocaEVRgZsgTNnaZRuexEc2ojzZfvMi01cvocA1749t3a2ckhWewHBznVJNts2M7eRga4BJr9aHtsejj3A0JVm5an9TCexi7Kj/RtaTFNzdOiNhPpn7arcVqDpTw38gEkM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7OoVNI_1716879551;
Received: from 30.221.100.241(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7OoVNI_1716879551)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 14:59:13 +0800
Message-ID: <0560e117-6f2c-4dbc-a1a9-4df7164ab129@linux.alibaba.com>
Date: Tue, 28 May 2024 14:59:09 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jaka@linux.ibm.com, kgraul@linux.ibm.com
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
 <c3c13531-f8be-4159-b8df-b316adb2d3fc@linux.ibm.com>
 <38c8a10a-339f-402e-836b-baf38994c7b2@linux.alibaba.com>
 <9be5a19c-1641-4b2e-8dac-d2d715cadd42@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <9be5a19c-1641-4b2e-8dac-d2d715cadd42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/5/27 22:57, Wenjia Zhang wrote:
> 
> 
> On 21.05.24 12:52, Guangguan Wang wrote:
>>
>>
>> On 2024/5/17 15:41, Wenjia Zhang wrote:
>>>
>>>
>>> On 07.05.24 07:54, Guangdong Wang wrote:
>>>> Hi, Wenjia and Jan,
>>>>
>>>> When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
>>>> fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.
>>>>
>>>
>>> Hi Guangguan and Wen,
>>>
>>> please see my answer below.
>>>> The first is in the function smc_ib_determine_gid_rcu, where restricts the subnet matching between smcrv2->saddr and the RDMA related netdev.
>>>> ...
>>>>
>>> The purpose of the restriction is to simplify the IP routing topology allowing IP routing to use the destination host's subnet route. Because each host must also have a valid IP route to the peer’s RoCE IP address to create RC QP. If the IP route used is the same IP Route as the associated TCP/IP connection, the reuse of the IP routing topology could be achieved. I think it is what the following sentence means in the doc https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf
>>>
>>> "
>>> For HA, multiple RoCE adapters should be provisioned along with multiple equal cost IP routes to the peer host (i.e., reusing the TCP/IP routing topology).
>>> "
>>> And the "Figure 19. SMC-Rv2 with RoCEv2 Connectivity" in the doc also mentions the restriction.
>>>
>>> The SMCRv2 on linux is indeed implemented with this purpose. Please see the function smc_ib_modify_qp_rtr(). During the first contact processing, the Mac address of the next hop IP address for the IP route is resolved by performing e.g. ARP and used to create the RoCEv2 RC QP. If the route is not usable for the RoCE IP address to reach the peer's RoCE IP address i.e. without this restriction, the UDP/IP packets would not be transported in a right way.
>>>
>>
>> Hi, Wenjia
>>
>> Thanks for the answer.
>>
>> I am clear about the restriction of subnet matching.
>>
>>> BTW, the fallback would still happen without the restriction. Because at the end of the CLC handshake(TCP/IP traffic), the first link will be created by sending and receiving LLC confirm message (SMCRv2 traffic). If one peer can just send but not receive the LLC confirm message, he will send CLC decline message with the reason "Time Out".
>>>
>>> Now let's have a look at your examples above. Both of your RDMA related device have another IP route as the TCP/IP connection, so that the reuse of the IP routing topology is not possible.
>>>
>>> Any thought still?
>>>
>>>> The other is in the function smc_connect_rdma_v2_prepare, where restricts the symmetric configuration of routing between client and server. codes here:
>>>> ...
>>>> In my testing environment, server's ip is 192.168.0.3/24, client's ip 192.168.0.4/24, regarding how many netdev in server or client. Server has special
>>>> route setting due to some other reasons, which results in indirect route from 192.168.0.3/24 to 192.168.0.4/24. Thus, when CLC handshake, client will
>>>> get fce->v2_direct==false, but client has no special routing setting and will find direct route from 192.168.0.4/24 to 192.168.0.3/24. Due to the above
>>>> symmetric configuration of routing restriction, we got fallback connection, rsn is 0x030f0000. But I think SMC-R should work in this scenario.
>>>> And more, why check the symmetric configuration of routing only when server is indirect route?
>>>>
>>> That is to check if the IP routing topology is the same on both sides. Then I'd like to ask why you use asymmetric routing for your connection? From the perspective of Networking set up, does it make any sense that the peers communicate with each other with different IP routing topology?
>>
>> I have looked into the configuration of my testing environment's routing table and found that the configuration can be optimized.
>> And the sketch in the attachment used to describe the topology and route configuration of my testing environment.
>> After optimizing the route setting, the fallback disappear.
>>
>> But why check the symmetric configuration of routing only when server is indirect route is still not clear.
>>
>>
>> Thanks,
>> Guangguan Wang
> 
> The optimized configuration looks much more reasonable to me. Thus, why do we need to do the symmetric check when the server is direct route? Don't we expect for a direct route on the client's side? If not, I have to repeat my question: does it make any sense that the peers communicate with each other with different IP routing topology structures, like your first version of configuration? If yes, I need convincing argument.

I agree it is more reasonable that peers communicate with each other in same IP routing topology structures.

My question is that when server is direct routing, why do not check the route configuration in client side?
For routing configuration, I think it is equal for both sides, either server or client can be misconfigured.

Thanks,
Guangguan Wang

> 
> Thanks,
> Wenjia
