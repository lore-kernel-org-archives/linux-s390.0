Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFB64F;
	Mon,  3 Jun 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717381299; cv=none; b=p8CM1W4pFnakCe6YwS1nAqEkoTeI7wc452KuWsXCH7GQa3Vk8WjW382DfdCLaagr1erhwchx7sQGtvBSR3VbFKbpwZugESbg5I2s7kEob6yVDfHw8KI7ffmjgT0+UX5zxSQm4ZmI1jo5zuThYM9cmvFb3Y5kncUfOlzOaC6f9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717381299; c=relaxed/simple;
	bh=GxsG4dkWnrl6biBJJU/FZyFxq7wrlNkODen4UfiLAU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOh5GkiVLwSmJ3usGW2tlcIFFvySEHnKSzcVnljfrcYfZJYgG5AmFV8YDFPByL/D60VaQwq04SCbQc5vStu/aPrICNyzcfTMvlgXM1gAaVKzGxPYOHvtg90+CSkXIWq9m4wnPS1Ecu7FSmqtV0hiCd/YREv5JqcYx8hAflwnqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n/twqi65; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n/twqi65"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717381287; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QEa9UFXOBmvQ9lQIuD1SY9wFvJzOEIAY/T7O4TOM0TM=;
	b=n/twqi65vFTXgmJXYeAsqycDkiYkNvhEzAD7uorwaW+z/+x7Cnw4wniEQvuwtuPaygVd5BOx+SmcZImHI97jxbjEBEruuXlZrTvuJZnrqJeuVQ46JUFxdweOSoqK7pgJB6osKanRXXxlYFQDLf7JB7ZZnXAahNmr16kEnCM49rs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7gQOiA_1717381285;
Received: from 30.221.101.211(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7gQOiA_1717381285)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 10:21:26 +0800
Message-ID: <9bc9e02c-6114-4790-8afc-7166f6e0e63f@linux.alibaba.com>
Date: Mon, 3 Jun 2024 10:21:23 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: set rmb's SG_MAX_SINGLE_ALLOC
 limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined
To: Simon Horman <horms@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
 <20240528135138.99266-2-guangguan.wang@linux.alibaba.com>
 <20240601083517.GX491852@kernel.org>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20240601083517.GX491852@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/6/1 16:35, Simon Horman wrote:
> On Tue, May 28, 2024 at 09:51:37PM +0800, Guangguan Wang wrote:
>> SG_MAX_SINGLE_ALLOC is used to limit maximum number of entries that
>> will be allocated in one piece of scatterlist. When the entries of
>> scatterlist exceeds SG_MAX_SINGLE_ALLOC, sg chain will be used. From
>> commit 7c703e54cc71 ("arch: switch the default on ARCH_HAS_SG_CHAIN"),
>> we can know that the macro CONFIG_ARCH_NO_SG_CHAIN is used to identify
>> whether sg chain is supported. So, SMC-R's rmb buffer should be limitted
> 
> Hi Guangguan Wang,
> 
> As it looks like there will be a v2:
> 
> In this patch: limitted -> limited
> In patch 2/2:  defalut -> default
> 
> checkpatch.pl --codespell is your friend.
> 
>> by SG_MAX_SINGLE_ALLOC only when the macro CONFIG_ARCH_NO_SG_CHAIN is
>> defined.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> Fixes: a3fe3d01bd0d ("net/smc: introduce sg-logic for RMBs")
> 
> I think it is usual to put the fixes tag above the Signed-of tags,
> although I don't see anything about that in [1].
> 
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> ...

I will fix it in the next version.

Thanks,
Guangguan Wang
