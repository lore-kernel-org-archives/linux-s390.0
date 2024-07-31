Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC571AC428;
	Wed, 31 Jul 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427182; cv=none; b=XN95tawmmgBBRuNzGyrvA9mlGGPmSJMO1mgZkX6vBbw3R/rXgFY1YJj821OWGCBz+kAC4RkSsWAui76/Qqvg7anLivBj3kANr9pETW8Uxi3Bs4BfgQiPpWx6RznbuIQqveqMITgkj6DKq4AsIMu81DNz2gg1l9AmCzdhGLIPWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427182; c=relaxed/simple;
	bh=ZUIGKHb07shD9beXiPKfF8JpwYGz2rWOoYygJ+gyXfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhMSQGOobehhqDVds4fMRq69mqw85J+pyHUOYcuo9RC7wW8gd3/wD2aFZoVwRUJCh6lnvH99zt+NjRrHlglh1NgXkeUXOAhFtlDzx95w51DF6/me0WJuiQ1Bc0BGqAYVvJidmEWOqneq2CF+RIDq7eSGJevF2VOiK89IdY4QT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=no0pA0hF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="no0pA0hF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722427177; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3Nz/jfAKOav0RK+CtnBgOLY+/7PjlsWiOtB1wLej+Jw=;
	b=no0pA0hFeIxDnvooEAkC2Cf5+omz7AX+KPn4IPIkjo0iv/HlbUa/qBWrSNj1zM97gPyKX0WYCSkl2Gw1eOLfoifDGjyaXNkNA5VGyVLT4eGEIh9TGnyk1L1m7Ufykh8npxmY1taHGnCnZFW6iDfHgpdP2I4uyauS08/7jeO8vfc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBjL2qC_1722427167;
Received: from 30.221.129.245(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WBjL2qC_1722427167)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 19:59:36 +0800
Message-ID: <f36c7740-392c-4ff6-9772-ddd5d3d043c8@linux.alibaba.com>
Date: Wed, 31 Jul 2024 19:59:26 +0800
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
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-2-shaozhengchao@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240730012506.3317978-2-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/30 09:25, Zhengchao Shao wrote:
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

Yeah.. I used err.h in several intermediate versions of smc loopback,
but forgot to remove it in the final version. Thanks!
