Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C81EBA0D;
	Wed, 27 Nov 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705344; cv=none; b=tpql2jTcC4FijB1YzbRLPJmBkv/Jsn9H7IEOmNHT+sJgmmqfRyUNcDampRGCn63rvYucmLD+w3xxZn+GBo3HvniQfbf9ZT8i0zpqnHx2s3CMWPcYwqK672lbVAG2yMlXYCz0X6Q/73ltYm0VkBikVxRfP9La7o/3iGL7SDGBYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705344; c=relaxed/simple;
	bh=SR0ePwHp0GA795M/9GcPHbpC2ijsjfg2DaxIWwZJC8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZMeLFkREoW5p65suVeQf9M6TvKJZSAKlUg7Bj/Lgnhg2Ad8eQu6zD/si5gQNv46nILCaEOJv1aUBPobDojeddMX+FZIwCnb9udE2uYBWiz94USGGyxKwg24gGbtOz0JrYSxAPk5wGj9vj25ThPSYFLTP6+Hd1m2v6WdlFV0we0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FcE8UKPS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FcE8UKPS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732705333; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SoaB6C5PEyN7YaAPt3mcEv/MO65XKYDAh7oA1Qdc11A=;
	b=FcE8UKPSDVIzc0wRFiYTOjdKU1lviOP3doMjFMN3SqBGcb0ktD1FcEOPpvtegohU9/WG8x0mIWOMfCgoFykaFnUv0s3xbRU3zKPVmV8je3pipN6D09TPkRPZtSKgTaZGnz7VGARGtssTwtwpnR/QQbkRVpVpeob+y0+pqdYqwbw=
Received: from 30.221.101.175(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKMQX7n_1732705331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 19:02:12 +0800
Message-ID: <3d005186-1e63-4d57-b73f-230d1ded72f2@linux.alibaba.com>
Date: Wed, 27 Nov 2024 19:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: introduce autosplit for smc
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709160551.40595-1-guangguan.wang@linux.alibaba.com>
 <cf07ec76-9d48-4bff-99f6-0842b5127c81@linux.ibm.com>
 <63862dcc-33fd-4757-8daf-e0a018a1c7a3@linux.alibaba.com>
 <faad0886-9ece-4a1c-a659-461b060ba70b@linux.alibaba.com>
 <0afaeec5-f80a-4d8d-806b-d39c0eb5570e@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <0afaeec5-f80a-4d8d-806b-d39c0eb5570e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/8/10 05:07, Wenjia Zhang wrote:
> 
> 
> On 08.08.24 08:26, Guangguan Wang wrote:
>> On 2024/7/15 10:53, Guangguan Wang wrote:
>>>
>>>
>>> On 2024/7/11 23:57, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 09.07.24 18:05, Guangguan Wang wrote:
>>>>> When sending large size data in TCP, the data will be split into
>>>>> several segments(packets) to transfer due to MTU config. And in
>>>>> the receive side, application can be woken up to recv data every
>>>>> packet arrived, the data transmission and data recv copy are
>>>>> pipelined.
>>>>>
>>>>> But for SMC-R, it will transmit as many data as possible in one
>>>>> RDMA WRITE and a CDC msg follows the RDMA WRITE, in the receive
>>>>> size, the application only be woken up to recv data when all RDMA
>>>>> WRITE data and the followed CDC msg arrived. The data transmission
>>>>> and data recv copy are sequential.
>>>>>
>>>>> This patch introduce autosplit for SMC, which can automatic split
>>>>> data into several segments and every segment transmitted by one RDMA
>>>>> WRITE when sending large size data in SMC. Because of the split, the
>>>>> data transmission and data send copy can be pipelined in the send side,
>>>>> and the data transmission and data recv copy can be pipelined in the
>>>>> receive side. Thus autosplit helps improving latency performance when
>>>>> sending large size data. The autosplit also works for SMC-D.
>>>>>
>>>>> This patch also introduce a sysctl names autosplit_size for configure
>>>>> the max size of the split segment, whose default value is 128KiB
>>>>> (128KiB perform best in my environment).
>>>>>
>>>>> The sockperf benchmark shows 17%-28% latency improvement when msgsize
>>>>>> = 256KB for SMC-R, 15%-32% latency improvement when msgsize >= 256KB
>>>>> for SMC-D with smc-loopback.
>>>>>
>>>>> Test command:
>>>>> sockperf sr --tcp -m 1048575
>>>>> sockperf pp --tcp -i <server ip> -m <msgsize> -t 20
>>>>>
>>>>> Test config:
>>>>> sysctl -w net.smc.wmem=524288
>>>>> sysctl -w net.smc.rmem=524288
>>>>>
>>>>> Test results:
>>>>> SMC-R
>>>>> msgsize   noautosplit    autosplit
>>>>> 128KB       55.546 us     55.763 us
>>>>> 256KB       83.537 us     69.743 us (17% improve)
>>>>> 512KB      138.306 us    100.313 us (28% improve)
>>>>> 1MB        273.702 us    197.222 us (28% improve)
>>>>>
>>>>> SMC-D with smc-loopback
>>>>> msgsize   noautosplit    autosplit
>>>>> 128KB       14.672 us     14.690 us
>>>>> 256KB       28.277 us     23.958 us (15% improve)
>>>>> 512KB       63.047 us     45.339 us (28% improve)
>>>>> 1MB        129.306 us     87.278 us (32% improve)
>>>>>
>>>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>>>> ---
>>>>>    Documentation/networking/smc-sysctl.rst | 11 +++++++++++
>>>>>    include/net/netns/smc.h                 |  1 +
>>>>>    net/smc/smc_sysctl.c                    | 12 ++++++++++++
>>>>>    net/smc/smc_tx.c                        | 19 ++++++++++++++++++-
>>>>>    4 files changed, 42 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> Hi Guangguan,
>>>>
>>>> If I remember correctly, the intention to use one RDMA-write for a possible large data is to reduce possible many partial stores. Since many year has gone, I'm not that sure if it would still be an issue. I need some time to check on it.
>>>>
>>>
>>> Did you mean too many partial stores will result in some issue? What's the issue?
>>>
> Forget it, I did verify that the partial stores should not be problem now.
>>>
>>>> BTW, I don't really like the idea to use sysctl to set the autosplit_size in any value at will. That makes no sense to improve the performance.
>>>
>>> Although 128KB autosplit_size have a good performance in most scenario, I still found some better autosplit_size for some specific network configurations.
>>> For example, 128KB autosplit_size have a good performance whether the MTU is 1500 or 8500, but for 8500 MTU, 64KB autosplit_size performs better.
>>>
>>> Maybe the sysctl is not the best way, but I think it should have a way to set the value of autosplit_size for possible performance tuning.
>>>
> mhhh, that could be a good reason to use sysctl.
>>> Thanks,
>>> Guangguan Wang
>>>
>>
>> Hi Wenjia,
>>
>> Is there any update comment or information about this patch?
> 
> Hi Guangguan,
> 
> sorry for the delayed answer. In the last time it is really difficult for me to find time to look into it and test it. With more thinking, I'm kind of convinced with this idea. But test is still needed. I'll be in vacation next 3 weeks. I hope it is okay for you that I'll test it as soon as possible when I'm back. If everything is ok, I think we can let it go upstream.
> 
> Thanks,
> Wenjia

Hi Wenjia,

Is there any update comment or information about this patch?

> 
> 
>>
>>>>
>>>> Thanks,
>>>> Wenjia
