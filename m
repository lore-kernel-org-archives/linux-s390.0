Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933E20B27;
	Mon,  4 Mar 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549492; cv=none; b=pPQkZRVLSTqw/Ky7cbtp7HZb+bczoDXeO9/4fZZ382k1q8P4uQwmHyve8uHAVMqKOO3XkboxrKhlqgB2IcR0QQGZA1gy4UevifSlXVv9nQpqlcdJVQ2Dm3llucxrmtMvH7CDnQe/FAwkkwMQ52E5gD4nRD+Jr56ne33A2W/0Jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549492; c=relaxed/simple;
	bh=IcG2Jj/dlSvolrRXXvO+UrYwe632lh44+gT5R8zxefs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivf0BtiBA/GM5JwjThWgVqJPSuiQWN6LSSuKVDcHkbcr3WcUZwER/AMKN0jRiLAf5mzKIteOFwVedMqUDQ3hGU+mZT50baJsSzoCSN6Smwmr3296vviCp4PxS4hp0u2dE7X5caGz4UsEFlGoWKMVhCka592oaroLy/zaVek/JsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qFJ17syC; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qFJ17syC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709549487; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=q+eNbfqNvdJbam4DpnzZdP5ixKZD3BeB29qmHQNSuu0=;
	b=qFJ17syCMgmysubEURa9Ks9hDSvwr/uAi6DlmkpxsWN4nAqKYiI1oTHCao1RFUrtT5Ybvu9MUbdUX4AfwGlGeLJrEYxE0yPg8K0ej6lpAZbW+lJYWclBasoRChg1kxX82zC/XGWWP8uJlOQHsY4XqKS6z2fn/IA1sIjQ52ocRkg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W1oomxl_1709549486;
Received: from 30.221.132.253(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W1oomxl_1709549486)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 18:51:27 +0800
Message-ID: <cff8e035-b70a-4910-9af6-e62000c0b87e@linux.alibaba.com>
Date: Mon, 4 Mar 2024 18:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reaching official SMC maintainers
To: Dmitry Antipov <dmantipov@yandex.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/4 18:31, Dmitry Antipov wrote:
> Jakub,
> 
> could you please check whether an official maintainers of net/smc are
> actually active? I'm interesting just because there was no feedback on
> [1]. After all, it's still a kernel memory leak, and IMO should not be
> silently ignored by the maintainers (if any).
> 
> Thanks,
> Dmitry
> 
> [1] https://lore.kernel.org/netdev/20240221051608.43241-1-dmantipov@yandex.ru/

Hi, Dmitry, I think I have given my feedback about this, see:

https://lore.kernel.org/netdev/819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com/
https://lore.kernel.org/netdev/19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com/

IMHO, if we want to address the problem of fasync_struct entries being
incorrectly inserted to old socket, we may have to change the general code.

Thanks.
