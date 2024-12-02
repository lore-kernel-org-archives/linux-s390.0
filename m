Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289B17C68;
	Mon,  2 Dec 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106054; cv=none; b=K/xbqW0wPEJV6QILV51QUVKtrFegCQZ4TAMZN51dGQf9/MD/4Osb8wAwmLHpQqMOn15ZuHstkB8CjgdM8zVHkjaIl0RUdyW0sk3YufUoXKY9RPbW+GzplQam+/zYF1RaurW9Nxepxw3pYFijSZXS1kCZUIi83tTewqy5adpRbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106054; c=relaxed/simple;
	bh=Rl6VecOJp5P1Hz3Awfi+89uXY3PYZEYq4plD9zQaXWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DEOvZArPWx/1lj7SE/dxDz5NM2IcRtMFnZ3LYJT/lqvLVZD3SYHCcuqs2YowO2kmik10cXolE44dXTLjMTUEclLKXvBuwX95/KLEadHFRaDkADJL2w+Eh+QXVOrWYoUR1uPXT5QCyoUmt1ADN93AZANmtNsbmA6vMiA3qC3MgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y1nW21SBCzxWnG;
	Mon,  2 Dec 2024 10:17:50 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E43651800F2;
	Mon,  2 Dec 2024 10:20:43 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Dec
 2024 10:20:42 +0800
Message-ID: <ed04079e-2bd8-453b-9076-aabb6095d3e4@huawei.com>
Date: Mon, 2 Dec 2024 10:20:41 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Optimize the timing of unlocking in
 smc_listen_work
To: Jakub Kicinski <kuba@kernel.org>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<luanjianhai@huawei.com>, <zhangxuzhou4@huawei.com>,
	<dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241130082630.2007-1-liqiang64@huawei.com>
 <20241130110425.4610e6b6@kernel.org>
From: Li Qiang <liqiang64@huawei.com>
In-Reply-To: <20241130110425.4610e6b6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/12/1 3:04, Jakub Kicinski 写道:
> On Sat, 30 Nov 2024 16:26:30 +0800 liqiang wrote:
>> The optimized code is equivalent to the original process, and it releases the
>> lock early.
> 
> By a single clock cycle? You need to provide much more detailed
> justification, otherwise this looks like churn for no real gain.

I don't have any more information about this patch, I saw that
the lock will be released regardless of branch true or false,
so brought it forward.

Thanks for your reply, Jakub!
:)

-- 
Cheers,
Li Qiang

