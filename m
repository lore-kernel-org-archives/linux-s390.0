Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB315E1FB;
	Thu, 18 Apr 2024 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438088; cv=none; b=aNyrI/JKuPgQ1FoWXmhKHdgpqGy+y42bQQpVIC7wAJ5ldHCNvdl7M4zSoVud/Q+X17A7bjCquAzoC7TtDCSbbKhoQLBinhdanw5xNH20iyN1WyDvRm+D7+cSfUMea6016IBRU+vwrT/nf23mlnriqjfIpPfNSRi0xAJKwUgrx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438088; c=relaxed/simple;
	bh=IWBVXvEKNivmLFW4lhGxT3c3JjTMOajf11zBuAEveQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cGev8K6ceMTYi2sUQgfGjRbcsDw6+SI0+RLd9VUgPzEaTqNnzHb+3PeMC/9n6jPn9P8UsT/7V4N3OaGFDbYBcOcj22CqrP2wabrVPM2glErf603XMLk+ykuhbTghv4X1V3hz88Q12u5wkFAeoAnqV5115/RRxSR0NFF56Cz2pEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKvrm0sHWzwS8W;
	Thu, 18 Apr 2024 18:58:16 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 557751800C3;
	Thu, 18 Apr 2024 19:01:20 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 19:01:19 +0800
Message-ID: <7672ae57-86b9-91c2-b03e-2700b931b677@huawei.com>
Date: Thu, 18 Apr 2024 19:01:19 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
To: Wenjia Zhang <wenjia@linux.ibm.com>, Guangguan Wang
	<guangguan.wang@linux.alibaba.com>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<tangchengchang@huawei.com>
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
 <ed5f3665-43ae-cbab-b397-c97c922d26eb@huawei.com>
 <c6deb857-2236-4ec0-b4c7-25a160f1bcfb@linux.ibm.com>
 <cd006e26-6f6e-2771-d1bc-76098a5970ac@huawei.com>
 <0cbb1082-8f5f-4887-b13c-802c2bbcca36@linux.ibm.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <0cbb1082-8f5f-4887-b13c-802c2bbcca36@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/4/18 15:50, Wenjia Zhang wrote:
> 
> 
> On 18.04.24 03:48, shaozhengchao wrote:
>>
>>
>> On 2024/4/17 23:23, Wenjia Zhang wrote:
>>>
>>>
>>> On 17.04.24 10:29, shaozhengchao wrote:
>>>>
>>>> Hi Guangguan:
>>>>    Thank you for your review. When I used the hns driver, I ran into 
>>>> the
>>>> problem of "scheduling while atomic". But the problem was tested on the
>>>> 5.10 kernel branch, and I'm still trying to reproduce it using the
>>>> mainline.
>>>>
>>>> Zhengchao Shao
>>>>
>>>
>> Hi Wenjia:
>>    I will try to reproduce it. 
> 
> Thanks!
> 
> In addition, the last time I sent you a
>> issue about the smc-tool, do you have any idea?
>>
> 
Hi Wenjia:
   I have send it to you. Could you receive it?

Thank you.
Zhengchao Shao
> mhhh, I just see a patch from you on smc_hash_sk/smc_unhash_sk, and it 
> is already applied during my vacation and it does look good to me. If 
> you mean others, could you send me the link again please, I mightbe have 
> missed out on it.
> 
>> Thank you
>> Zhengchao Shao
>>> Could you please try to reproduce the bug with the latest kernel? And 
>>> show more details (e.g. kernel log) on this bug?
>>>
>>> Thanks,
>>> Wenjia
>>
> 
