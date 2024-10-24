Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AA1C4A31;
	Thu, 24 Oct 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767996; cv=none; b=OZffgcsNape1CyYeJEfJpNneTexVLjwa+CVOXWwXoI7H9z0G3SsiBHL8QB4feOfAJqZ/3u6LQbYDmhUF8RyW0cJzGYgxmTkwhWgrkqGrwQ1vxF6TtJPYuKgfJuqdZ6mqBfZiM761THcfgWXNMw1bnnFeK1HYHTKDV9Mt1lOKyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767996; c=relaxed/simple;
	bh=BtbVbKTSOo2sG4MBMHZUhIzlD4JURdmwYcDfyJvEtqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZTsdL/m6mCcIu3gRZzZnYW9wQOeFnO+xS6626vShg/wPT/NkOLpEsFOxhVtTJFcvPhV3dOidnQPYQjIc72m0TIrYeZGTf4FFEmt4r/X55zInqtCoDrNuOYMLJjUj+sbXiEtb5ziAaTXC1WcVu/0RvHqzQ0No0Z/iAK1f490oNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eCPMjtmH; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eCPMjtmH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729767991; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VvJTI601DIOzBox3X95ACOvJLSHb8asIvG0P9I23aQ0=;
	b=eCPMjtmHqZGXkD9x1HQAf5uIfyPZ5Fzuz8+faQV7CbeLGpfkY/zjDD52rqrP0zEmcu3K9AcXNDK9BawwhSLjp4QtXsOmYsMUULWBWbpuFOGv0sM4KcX0lSc/tpaxM5CsSWYNwPhlTiyOMKF/GlBqFQpPpnhi3w1NZ40mqdVu0lM=
Received: from 30.221.129.46(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WHowPg-_1729767982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 19:06:30 +0800
Message-ID: <ec3a2232-7787-4e0d-a0bd-a75280c3982f@linux.alibaba.com>
Date: Thu, 24 Oct 2024 19:06:20 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: use new helper to get the netdev
 associated to an ibdev
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241024054456.37124-1-guwen@linux.alibaba.com>
 <61cf578f-020e-4e0d-a551-98df5367ee27@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <61cf578f-020e-4e0d-a551-98df5367ee27@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/24 18:00, Wenjia Zhang wrote:
> 
> 
> On 24.10.24 07:44, Wen Gu wrote:
>> Patch [1] provides common interfaces to store and get net devices
>> associated to an IB device port and removes the ops->get_netdev()
>> callback of mlx5 driver. So use the new interface in smc.
>>
>> [1]: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
>>
>> Reported-by: D. Wythe <alibuda@linux.alibaba.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> [...]
> 
> We detected the problem as well, and I already sent a patch with the same code change in our team internally these. Because some agreement issues on the commit message, it is still not sent out externally. Now we (our team) have almost an agreement, I'd like to attach it here. Please have a look if 
> it is also for you to use:
> 
> "
> [PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
> 
> Since/Although commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an alternative to get_netdev") introduced an API ib_device_get_netdev, the SMC-R variant of the SMC protocol continued to use the old API ib_device_ops.get_netdev() to lookup netdev. As commit 8d159eb2117b ("RDMA/mlx5: 
> Use IB set_netdev and get_netdev functions") removed the get_netdev callback from mlx5_ib_dev_common_roce_ops, calling ib_device_ops.get_netdev didn't work any more at least by using a mlx5 device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> "
> My main points are:
> - This patch should go to net, not net-next. Because it can result in malfunction. e.g. if the RoCE devices are used as both handshake device and RDMA device without any PNET_ID, it would be failed to find SMC-R device, then fallback.
> - We need the both fixes, which would help us for the backport
> 
> 
> Thanks,
> Wenjia

Hi, Wenjia. I see. Since you're ready to post a patch, and this one has some problems,
I think you can supersede this one with yours. It is totally OK for me.

Thanks!
Wen Gu
