Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36EC2C9;
	Tue, 19 Nov 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982903; cv=none; b=Nc8uFEKJbYDcoTUfgRavZSpgqOkHtdjOL8k3LQ0I8YpDRyhrkqduAdIUVmQGUPdKUQnWXstzZdRX+fEnUSbJBhbvHcNTo/BNgmT+xHeiOIoKDXkAQaU5o19tlEFcbGcd+EjCYPwd7JXSlOD9reaCaFFM0aAS9v1jDuJLxFpYeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982903; c=relaxed/simple;
	bh=Eg0bL7dS7IXQsPebvVXHz/7ofRNytSFrJjjigG0XrQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jn/V+SNNr9qGqcBmrXznv1l4oT8pmULSVomBJDfNqlssJm1O+xpe+CQWN/SQZcs2DCHvMG5WaCjn66S8Ng7uvxJWZgRLQHvYTHP3+tSg7RsCIM1fFla29ZxPk4J/iDte1SaQNZM4tnlVQmJIJKCqsbw/MNu1an6MFNyJq2pJSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brAt20Ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brAt20Ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26014C4CECC;
	Tue, 19 Nov 2024 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731982902;
	bh=Eg0bL7dS7IXQsPebvVXHz/7ofRNytSFrJjjigG0XrQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brAt20Ym776OFUZBsn/QAFkHcnljgRBdbZzut3O0Y99wQhYXFqv9+pzP6bOfVQIFj
	 gLJF57BXOdY8TmN0qQwzUXn8PWxfOjK3OgvtVW1XM3wDa53LF+tuHns2SgKGKRRckS
	 oznZ71OLPvpfLxCA2Xr4qij69VvHyh5tRHbf226KbXnNLAIraSGrBJCShxGudHio0x
	 mUOyzhIj+jzRqdqrdGMZ949FaniKOugneaJ5mV6uIymZVPLb3va3PzEv9j7M0ZFqOE
	 01uxMNFFHe+GrZUWZ3vbDHolhiPUjGWmQkBr9kX2Fr2Hrm3UphuMvfVZuzBcYPiwGn
	 qzTGMl6OV2XNg==
Date: Mon, 18 Nov 2024 18:21:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: liqiang <liqiang64@huawei.com>
Cc: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
 <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
 <guwen@linux.alibaba.com>, <dust.li@linux.alibaba.com>,
 <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
 <zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
 <gaochao24@huawei.com>
Subject: Re: [PATCH net-next v3] net/smc: Optimize the search method of
 reused buf_desc
Message-ID: <20241118182141.20471ab8@kernel.org>
In-Reply-To: <20241112092216.1439-1-liqiang64@huawei.com>
References: <20241105031938.1319-1-liqiang64@huawei.com>
	<20241112092216.1439-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 17:22:16 +0800 liqiang wrote:
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
> Through my testing, this patch can significantly improve 
> the link establishment speed of SMC, especially in the 
> multi-threaded short connection benchmark.
> 
> I tested the time-consuming comparison of this function
> under multiple connections based on redis-benchmark
> (test in smc loopback-ism mode):
> 
> The function 'smc_buf_get_slot' takes less time when a
> new SMC link is established:
> 1. 5us->100ns (when there are 200 active links);
> 2. 30us->100ns (when there are 1000 active links).

We're closing net-next and didn't get any review tags on this patch,
either from IBM or Alibaba folks. Please try again after the merge
window (after Dec 2nd, once v6.13-rc1 is tagged).
-- 
pw-bot: defer
