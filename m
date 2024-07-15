Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CFEAD5;
	Mon, 15 Jul 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012037; cv=none; b=OZQ/v+iL2kfkG8UqvkGQ6GWibERfhRUnKKQpOsGTWocbLX103ZYnX2kNL6s3fP47uvOr0B/wvVaFgFTiG5ork8shXGLinkw2dHXJ1MNUXFvuNizmPq/KieUTjmU/JjwdIpw+YtAJ8rdtdIPH7hnAAbkJb51PYPqUbji2ViAsJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012037; c=relaxed/simple;
	bh=aQiqzrVZ3PHS2MYW5gjFRHJupDz2inDkWvjjBjUDgog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecKk63+d0IVSB+q7wtLnlla+3WorNLXqKYl0nkK2fPQtCC7RBD2gdggmnXkc1FdKEoimY17t1TI74qjUccto0vx/nmaCIG3T16IvcbumHbokB3bMocyyAMtgFb12hk9gnYnMmA/90ePHwkxofPIzv6++EgcN+rjfKgeRVRlQKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HiQl0XKB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HiQl0XKB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721012026; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HVInFwlXXhbbzZQjxVtud9mzYHkhIRQyqI9B0uOtKBg=;
	b=HiQl0XKBeqWk/yz3cbs+xXXMqKDBA9eNUrYa/DQmwTorDxRibhuLm5KnnYnJz1NhClNamakLV4YMSI4QdOVoyQKrxT44Stzo2XTmDaQsgGI/QaTkp4lVwV7YizidN/OJdGpYlabpQWWaRxwUYzzdkAJ0LRHgxxOISM/izb80ONM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WAUsDnm_1721012024;
Received: from 30.221.101.244(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WAUsDnm_1721012024)
          by smtp.aliyun-inc.com;
          Mon, 15 Jul 2024 10:53:45 +0800
Message-ID: <63862dcc-33fd-4757-8daf-e0a018a1c7a3@linux.alibaba.com>
Date: Mon, 15 Jul 2024 10:53:44 +0800
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
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <cf07ec76-9d48-4bff-99f6-0842b5127c81@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/7/11 23:57, Wenjia Zhang wrote:
> 
> 
> On 09.07.24 18:05, Guangguan Wang wrote:
>> When sending large size data in TCP, the data will be split into
>> several segments(packets) to transfer due to MTU config. And in
>> the receive side, application can be woken up to recv data every
>> packet arrived, the data transmission and data recv copy are
>> pipelined.
>>
>> But for SMC-R, it will transmit as many data as possible in one
>> RDMA WRITE and a CDC msg follows the RDMA WRITE, in the receive
>> size, the application only be woken up to recv data when all RDMA
>> WRITE data and the followed CDC msg arrived. The data transmission
>> and data recv copy are sequential.
>>
>> This patch introduce autosplit for SMC, which can automatic split
>> data into several segments and every segment transmitted by one RDMA
>> WRITE when sending large size data in SMC. Because of the split, the
>> data transmission and data send copy can be pipelined in the send side,
>> and the data transmission and data recv copy can be pipelined in the
>> receive side. Thus autosplit helps improving latency performance when
>> sending large size data. The autosplit also works for SMC-D.
>>
>> This patch also introduce a sysctl names autosplit_size for configure
>> the max size of the split segment, whose default value is 128KiB
>> (128KiB perform best in my environment).
>>
>> The sockperf benchmark shows 17%-28% latency improvement when msgsize
>>> = 256KB for SMC-R, 15%-32% latency improvement when msgsize >= 256KB
>> for SMC-D with smc-loopback.
>>
>> Test command:
>> sockperf sr --tcp -m 1048575
>> sockperf pp --tcp -i <server ip> -m <msgsize> -t 20
>>
>> Test config:
>> sysctl -w net.smc.wmem=524288
>> sysctl -w net.smc.rmem=524288
>>
>> Test results:
>> SMC-R
>> msgsize   noautosplit    autosplit
>> 128KB       55.546 us     55.763 us
>> 256KB       83.537 us     69.743 us (17% improve)
>> 512KB      138.306 us    100.313 us (28% improve)
>> 1MB        273.702 us    197.222 us (28% improve)
>>
>> SMC-D with smc-loopback
>> msgsize   noautosplit    autosplit
>> 128KB       14.672 us     14.690 us
>> 256KB       28.277 us     23.958 us (15% improve)
>> 512KB       63.047 us     45.339 us (28% improve)
>> 1MB        129.306 us     87.278 us (32% improve)
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> ---
>>   Documentation/networking/smc-sysctl.rst | 11 +++++++++++
>>   include/net/netns/smc.h                 |  1 +
>>   net/smc/smc_sysctl.c                    | 12 ++++++++++++
>>   net/smc/smc_tx.c                        | 19 ++++++++++++++++++-
>>   4 files changed, 42 insertions(+), 1 deletion(-)
>>
> 
> Hi Guangguan,
> 
> If I remember correctly, the intention to use one RDMA-write for a possible large data is to reduce possible many partial stores. Since many year has gone, I'm not that sure if it would still be an issue. I need some time to check on it.
> 

Did you mean too many partial stores will result in some issue? What's the issue?


> BTW, I don't really like the idea to use sysctl to set the autosplit_size in any value at will. That makes no sense to improve the performance.

Although 128KB autosplit_size have a good performance in most scenario, I still found some better autosplit_size for some specific network configurations.
For example, 128KB autosplit_size have a good performance whether the MTU is 1500 or 8500, but for 8500 MTU, 64KB autosplit_size performs better.

Maybe the sysctl is not the best way, but I think it should have a way to set the value of autosplit_size for possible performance tuning.

Thanks,
Guangguan Wang

> 
> Thanks,
> Wenjia
