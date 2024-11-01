Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900615A849;
	Fri,  1 Nov 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458387; cv=none; b=EZFb5Rlzf9+H8cBgz4qmMSHBLGr6LvmtrQofWAF2/s8xk9L0M+JAyPqW+VVyqrEIO7OcKp4zsPbA0lohmPwOUPFxkoR8fvF6ZgbTeiJG+5pA6swYhhPOFZ7oj1uxcKSZa3vSW4Mhbt+LXDwgXk2zm3WhUx3IeOEQ0T5vSn0MYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458387; c=relaxed/simple;
	bh=jrULZg4ou+aDyNcoBXl/ExbJGAa8QubISoiQ4TyKDp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8v8iOnWLK2/LfyMCCXCzhRxGvAosQ9HLiRpeyGZ1jVkkbN+QLUV3EF16VSphezZOHnPbi/4vc52jtsRuzEpXHQjq3UCMWcsukKUeFANc9pH84Nw1zeWLXkbWuvWdxhZXbuuqlqqm/MEcPCeYi+xk8/4Q7xvObWflSwDJ6QCSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r9VzzRi+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r9VzzRi+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730458374; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=GlyU/jmz8E+JausTqFQnV6XgtV59/K6paYp/eLXbSPI=;
	b=r9VzzRi+TAQ0rrZsKlZFmKidIdjwhmlRjeq+gOmEjJxLxvkM4PGJKEZ53PJ89nvm9PVsL+xFdbFRHDI/EA1sNWPIojJOu4rNWgbN3l7xlPUx4zsuqb1QR10K+zA2+qe5nAtLIYDnnFSnuePVkVpRGtVXpTI1LKIFczob0TkzEtY=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WIRFmgx_1730458373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 18:52:54 +0800
Date: Fri, 1 Nov 2024 18:52:53 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: liqiang <liqiang64@huawei.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
	zhangxuzhou4@huawei.com, dengguangxing@huawei.com,
	gaochao24@huawei.com, kuba@kernel.org
Subject: Re: [PATCH net-next] net/smc: Optimize the search method of reused
 buf_desc
Message-ID: <20241101105253.GG101007@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241101082342.1254-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101082342.1254-1-liqiang64@huawei.com>

On 2024-11-01 16:23:42, liqiang wrote:
>We create a lock-less link list for the currently 
>idle reusable smc_buf_desc.
>
>When the 'used' filed mark to 0, it is added to 
>the lock-less linked list. 
>
>When a new connection is established, a suitable 
>element is obtained directly, which eliminates the 
>need for traversal and search, and does not require 
>locking resource.
>
>A lock-less linked list is a linked list that uses 
>atomic operations to optimize the producer-consumer model.
>
>I didn't find a suitable public benchmark, so I tested the 
>time-consuming comparison of this function under multiple 
>connections based on redis-benchmark (test in smc loopback-ism mode):

I think you can run test wrk/nginx test with short-lived connection.
For example:

```
# client
wrk -H "Connection: close" http://$serverIp

# server
nginx
```

>
>    1. On the current version:
>        [x.832733] smc_buf_get_slot cost:602 ns, walk 10 buf_descs
>        [x.832860] smc_buf_get_slot cost:329 ns, walk 12 buf_descs
>        [x.832999] smc_buf_get_slot cost:479 ns, walk 17 buf_descs
>        [x.833157] smc_buf_get_slot cost:679 ns, walk 13 buf_descs
>        ...
>        [x.045240] smc_buf_get_slot cost:5528 ns, walk 196 buf_descs
>        [x.045389] smc_buf_get_slot cost:4721 ns, walk 197 buf_descs
>        [x.045537] smc_buf_get_slot cost:4075 ns, walk 198 buf_descs
>        [x.046010] smc_buf_get_slot cost:6476 ns, walk 199 buf_descs
>
>    2. Apply this patch:
>        [x.180857] smc_buf_get_slot_free cost:75 ns
>        [x.181001] smc_buf_get_slot_free cost:147 ns
>        [x.181128] smc_buf_get_slot_free cost:97 ns
>        [x.181282] smc_buf_get_slot_free cost:132 ns
>        [x.181451] smc_buf_get_slot_free cost:74 ns
>
>It can be seen from the data that it takes about 5~6us to traverse 200 
>times, and the time complexity of the lock-less linked algorithm is O(1).
>
>And my test process is only single-threaded. If multiple threads 
>establish SMC connections in parallel, locks will also become a 
>bottleneck, and lock-less linked can solve this problem well.
>
>SO I guess this patch should be beneficial in scenarios where a 
>large number of short connections are parallel?

Based on your data, I'm afraid the short-lived connection
test won't show much benificial. Since the time to complete a
SMC-R connection should be several orders of magnitude larger
than 100ns.

Best regards,
Dust

