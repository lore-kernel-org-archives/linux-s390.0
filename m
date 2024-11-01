Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAE1BDC3;
	Fri,  1 Nov 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443824; cv=none; b=cblh2bs5/zJ33EaCzIlNh1RWbBpgAkLate2p9Wy2KuMy6MY0a+WUC+kLchfdqX1pdaxcnIA/mr7ajWNawJMmsppAzOdpMQx9NDm5s4lBPKOeaSALVoY4NviMlelANLTty3GZHdIQHVLkcacBrFdyWkm7UGHjm5bNxucjFX/wbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443824; c=relaxed/simple;
	bh=9AjYrDRfrt2dlnkqfKkc4nDTPj9cEzsbZx6Q7WNiE6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVBtRT6hWld4438gnBl5/8T6nnF7vIO7ZzCBTJ3PMN8iQbyM12ZNs/JYdEEdWzsdYVs8C8Xb/6c/iLd1IYxknk8NjSRhJVcwG/haVZnxbS2Qw52rji8Y/7b3/VD6ETFgAY1uw9Z7RooKQFGuZpuO37mniqmcwhdPujtfzgvwEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I80ltO4a; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I80ltO4a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730443818; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=mMzuwGym0W9IgDLYvUhELEcEyQ7HKYamDIN/ohfczXo=;
	b=I80ltO4aNpI/7qtSr7MF/XWXZJQ5ySzTr2nOPnYh9Czy1SKYMYU5mEQd2aIRA4YnnTjYbGYmOP00ZMQAOTf8NMlUqM8/a3dP5caCjQewfusQ8Gqok42IGBCxrMI6LN71V7oxxlDkqNm19rGekWoacJJyiSP8Vpgq+/qpWc2WXuQ=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WIO5zSF_1730443816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 14:50:17 +0800
Date: Fri, 1 Nov 2024 14:50:16 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: liqiang <liqiang64@huawei.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
	zhangxuzhou4@huawei.com, dengguangxing@huawei.com,
	gaochao24@huawei.com
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
Message-ID: <20241101065016.GF101007@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241029065415.1070-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029065415.1070-1-liqiang64@huawei.com>

On 2024-10-29 14:54:15, liqiang wrote:
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
>A lock-free linked list is a linked list that uses 
>atomic operations to optimize the producer-consumer model.

Do you see any performance issues without this lock-less linked list ?
Under what test case ? Any performance numbers would be welcome

Best regards,
Dust

