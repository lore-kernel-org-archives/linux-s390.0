Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA341990C4;
	Mon,  4 Nov 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705696; cv=none; b=lQ//12ejTjWsasB4IW4VNKvsNAcm2j/FXSxPTtc4KIfEybvnyiFzqQV2Jt9r+tuVSE1y7gRW/PUjt2LCzdB7kwTRUcN+J2C6ZJflpbQEzBgVop1gx5os2hP7Lm7Fqy5bkpCV1WS/QgCHSETVmBqdp5FcGJjBCk5VTzNaH9ikdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705696; c=relaxed/simple;
	bh=MWy8vIN6QSXiONZdHGnlEtYNema0+nY8NcNFttCGPok=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OX/sw2ml9C1HOyPN+7LI3hNs9SfGgR3op2MesTymXH9NThON4iwkWBvDXE1MeIpwzH7oDr+Rt6A4BxcnzQyW9LE68acEmnBglDBbY8JA11ruF/gb1gOXprmsbQzFJuNFzT1blfH4aHaMOZdQFfoqy22+NUh2/CduPD0NnXFHp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xhjq568xlz10PZb;
	Mon,  4 Nov 2024 15:32:33 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FD25140384;
	Mon,  4 Nov 2024 15:34:51 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 15:34:46 +0800
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
To: "D. Wythe" <alibuda@linux.alibaba.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241029065415.1070-1-liqiang64@huawei.com>
 <58333f24-ae0a-4860-a6a8-37fef09165a0@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <866b75ce-1692-5878-5b98-ec2a12e665bc@huawei.com>
Date: Mon, 4 Nov 2024 15:34:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <58333f24-ae0a-4860-a6a8-37fef09165a0@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/11/4 9:41, D. Wythe 写道:
> 
> 
> On 10/29/24 2:54 PM, liqiang wrote:
>> We create a lock-less link list for the currently
>> idle reusable smc_buf_desc.
>>
>> When the 'used' filed mark to 0, it is added to
>> the lock-less linked list.
>>
>> When a new connection is established, a suitable
>> element is obtained directly, which eliminates the
>> need for traversal and search, and does not require
>> locking resource.
>>
>> A lock-free linked list is a linked list that uses
>> atomic operations to optimize the producer-consumer model.
> 
> 
> 
> No objection, but could you provide us with some data before and after the optimization ?
> .

I have resent this patch a few days ago with '[PATCH net-next]' prefix.
It contains more detailed function time-consuming and nginx test data.
You can find some test data in that email. :)

Let me summarize it here:
1. The function 'smc_buf_get_slot' takes less time when a new SMC link is established,
5us->100ns (when there are 200 active links), 30us->100ns (when there are 1000 active links).

2. Using wrk and nginx to test multi-threaded short connection performance
has significantly improved.

Environment: QEMU emulator version 1.5.3 @ Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
Test with SMC loopback-ism.

-- 
Best regards,
Li Qiang
