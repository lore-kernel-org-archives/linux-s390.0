Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8017C6C;
	Wed, 31 Jul 2024 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395898; cv=none; b=YVnWbPP5kjHI5Ag53O3PJ8+7EcG1Jyxk3ExXuBB5lhyONcKK7oPa75abu4vHaKSKjYNk5aMpZOza8uJv3NoIxUFS82revm7LoEmbUV9v0Jvhlx0LNuEjdd3f529kzBM0sN5qYtDxLQNd5/ZFsp6l289aDapvoW9oO/tR/F+Pg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395898; c=relaxed/simple;
	bh=HPWy8Lw+yPkKkrw2lliNUVofbxH6ohVYie2o+BjUhEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7IuJnBv3fEuzWR3rKkcpFeBKUR5FORcGZJKuoS1G/463LbJaojzN1Foac5nwIwD8pwoq7W5wYcMKy7JvleOEAimQNh/Q3htiGgAtBrwkovVyv6QQC68g8VsWhQ/KdmUBpM74NNNR0O3kl1ww7AneGb2KN1HEXMMSdnRth/YvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HLT95xZz; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HLT95xZz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722395888; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I4HKqJF3789bI2/mZLHSAkjB25sbJWb3dsLY1D9KOeA=;
	b=HLT95xZz6dNSYGwY7E0e9/WpkYn3h6U91VJYp59R3oscJuKs3BpI5jMSZtvce7Z3siJY4/cQMPdeZgZz6EJPRp8uCqUuMmMUZj0WUiUVvh0Lx/zWK9xgb7shwpxDzsfZRupq8UfmrE/Eh6qNWoXnEJYbAIH6/GEz+HKXTrHjhw4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBhiguX_1722395887;
Received: from 30.221.144.225(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WBhiguX_1722395887)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 11:18:08 +0800
Message-ID: <24f2895e-8d2b-479b-82a0-90e353ed0774@linux.alibaba.com>
Date: Wed, 31 Jul 2024 11:18:06 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net/smc: remove unreferenced header in
 smc_loopback.h file
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-2-shaozhengchao@huawei.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240730012506.3317978-2-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/24 9:25 AM, Zhengchao Shao wrote:
> Because linux/err.h is unreferenced in smc_loopback.h file, so
> remove it.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/smc/smc_loopback.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 6dd4292dae56..04dc6808d2e1 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -15,7 +15,6 @@
>   #define _SMC_LOOPBACK_H
>   
>   #include <linux/device.h>
> -#include <linux/err.h>
>   #include <net/smc.h>
>   
>   #if IS_ENABLED(CONFIG_SMC_LO)

LGTM, Thanks.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
