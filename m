Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E775809;
	Fri,  1 Nov 2024 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430706; cv=none; b=A6ff4lEHei75QFNbC0+53AhGYoqagHP1XctcZZjQKn9NpiVMJDDg8GaqOyYsxBpTwprzXgL74v/AfkCe7zsg2+U+0Wddd5Bo/b1EPHhS0hNFCHpViTjT7fOUngLqs9bjVB5OOzrUDjp9thOAH0Kl2zdNCyPHltapIyzhepmGRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430706; c=relaxed/simple;
	bh=mCECXu2SHwQQBPhjjFyjbqzS5ldtUDM/L0B/c6MQ7+U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FPB3Sl69ya5o13lZrP2HZ7uEst3jn7KdZT6680axCLH3dxUC565zZA2dQr6BXH+Sz0fGhkFWQss5VrvA0ZmeT5KL0ZORD5Z9YZA1iuocaYqp8LKt5PeAvt3tZoq3gQVvAysb9KA9dikt7zbvLXHH1k8qxHMfbDexnyLZAqg2yEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xfm4D4PSnz1HLx0;
	Fri,  1 Nov 2024 11:07:08 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id EEC2E180042;
	Fri,  1 Nov 2024 11:11:38 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 11:11:37 +0800
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
To: Jakub Kicinski <kuba@kernel.org>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241029065415.1070-1-liqiang64@huawei.com>
 <20241031190652.5f775796@kernel.org>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <8a0e0ee5-3db1-34c3-d8e7-1d1639c4b425@huawei.com>
Date: Fri, 1 Nov 2024 11:11:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241031190652.5f775796@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200001.china.huawei.com (7.202.181.227)



ÔÚ 2024/11/1 10:06, Jakub Kicinski Ð´µÀ:
> On Tue, 29 Oct 2024 14:54:15 +0800 liqiang wrote:
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
> Not sure what the story here is but the patch does not apply to net-next
> 

Thanks for the reminder.
I will resend the patch to adapt to net-next later.

-- 
Cheers,
Li Qiang
