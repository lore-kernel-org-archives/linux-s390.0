Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88F15D5B6;
	Fri,  1 Nov 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449651; cv=none; b=lrREjYMLxMb/DFtm04g2p1OAOqhttjlIL+7Av/P6GPiXOHjGBrc/hNEZAoAB8PAie4B+juqM08gtFhUUrEX46gjz36qwphpCoInGhPOYXMAU2PUgRx88Ct6HhLcn4A/UKsXOtWShZ+N4zTncmkzNjLJWE3PWKQpEyg1rS1luKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449651; c=relaxed/simple;
	bh=ddgJmiU4ENkfDV9jjLCh0nDalDVAbrbRr1uNrGoombY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MGCj1hTyKElvt4BVUxdhiPdh8XuhR8QTED/G+FIZKwlN8aRJu5v5w1YmwAR27Al8Gk/v3Y/cfeNKHW+yL6M30/kzrGMBpDkn0gYi/OhCAv+6AUD31VclnfiLJ8KutUBtbjTEbhnCf6CeNkMrd7EBZRojHvXOPRUamBUxAyq0vWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xfv7r1wzmzyT7x;
	Fri,  1 Nov 2024 16:25:44 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B90318005F;
	Fri,  1 Nov 2024 16:27:25 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 16:27:24 +0800
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
To: <dust.li@linux.alibaba.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241029065415.1070-1-liqiang64@huawei.com>
 <20241101065016.GF101007@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <6d5bfce0-b01d-b46b-3a9f-5291455f3022@huawei.com>
Date: Fri, 1 Nov 2024 16:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241101065016.GF101007@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf200001.china.huawei.com (7.202.181.227)



ÔÚ 2024/11/1 14:50, Dust Li Ð´µÀ:
> On 2024-10-29 14:54:15, liqiang wrote:
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
> Do you see any performance issues without this lock-less linked list ?
> Under what test case ? Any performance numbers would be welcome
> 

I optimized it through review. I re-sent this patch based on the
net-next repo. It contains some of my own test data. Please check it. :-)

> Best regards,
> Dust
> 
> .
> 

-- 
Cheers,
Li Qiang
