Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7E6FD5;
	Mon,  4 Nov 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684475; cv=none; b=uAncqgk+crZInhKzgVU2QnIHl7U1SnXwdbDE0CwAUy4hMW9Ir98GUuHED/dVgzN/rr8M8dGefcTIFZj7BMhtIVjMoH4vR/Dc6V21bRlK63NhbdrjPPP8p0cmXVh91y6mbyG4rbkPy5L0yd3uXocq2LPBCyvEWetZlpNUP2VMxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684475; c=relaxed/simple;
	bh=XBfulSdet2Bot/bH00oIYGqahI6km5MzkxXPLWv/Wqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxJrGR366bYorAoH5ZHJ+qNA5A0O9GLZasC1igzaSsujdtlEQlZCpl/+kAMCSuPOCnoqLuDuwCRfjroX7tziab4VGUlQAcRFcQptJNbSgxCHyW5h63JkRonne/eAt2yezTpBG0fdZdVCKbXpG66x+rTUO3Mv29izRG9q0o8JBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o8uIcoOP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o8uIcoOP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730684464; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JmAZLh/wVHGCcxbi8G5jFz5suwrm92Ok3F5NRCm1Gbs=;
	b=o8uIcoOP7rbhyPH2H9vF2qJvYw3/1VMLpQWqOncpekKH+y0ISbwx3zcAo+vdgNOm9fLkjoxyq6t/GYjU+6PnCp5snu79OCPU7jgdbXR1ykFc5WUfoIWacdzgw11xCeaQd1hlauerXPjFb3N+JRodS7A/Wgkbnw/JkA5RmLt/yDA=
Received: from 30.32.103.163(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WIZYaUO_1730684462 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 09:41:03 +0800
Message-ID: <58333f24-ae0a-4860-a6a8-37fef09165a0@linux.alibaba.com>
Date: Mon, 4 Nov 2024 09:41:01 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
To: liqiang <liqiang64@huawei.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
 zhangxuzhou4@huawei.com, dengguangxing@huawei.com, gaochao24@huawei.com
References: <20241029065415.1070-1-liqiang64@huawei.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20241029065415.1070-1-liqiang64@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/24 2:54 PM, liqiang wrote:
> We create a lock-less link list for the currently
> idle reusable smc_buf_desc.
> 
> When the 'used' filed mark to 0, it is added to
> the lock-less linked list.
> 
> When a new connection is established, a suitable
> element is obtained directly, which eliminates the
> need for traversal and search, and does not require
> locking resource.
> 
> A lock-free linked list is a linked list that uses
> atomic operations to optimize the producer-consumer model.



No objection, but could you provide us with some data before and after the optimization ?
