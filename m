Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8909F4ED;
	Tue,  6 Aug 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916387; cv=none; b=EIqokeeiboeQFmyBZi2BTxAm7YaZo88bB0pREuPAidw0NeA28hHFi7DPOmA8dbnlm+g7EzJTGb4NFZTnJO5fUcXKGDC+b4KomVf0uJZChYpJzGpR9IqzfqhQbT10R2+KFvnv1eccKOe4oYAnraNTsKD/D6KY3YH8+iOYVwg6YY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916387; c=relaxed/simple;
	bh=iBIAgpNfjFOWcanfd3pJH3vtDVP3lWkqexHsDtuvqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eMZqlS19AJeIpihlTcW9KSoKU5/3zrQcUV0HgnTNawsvPa++qkYHLUtgnLRtErOP6K02k3f1UROcx6uUkvl2gmGlkdqPPQ6EJ70SIqvFXdC6XAH/WIH7enMOeoNfjQm8j4mvI34892rb3mBy3c9P1kKbTyOaBeRjiw6wZQH79/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdK926cRRzfZ3g;
	Tue,  6 Aug 2024 11:51:02 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C062180102;
	Tue,  6 Aug 2024 11:52:56 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 11:52:55 +0800
Message-ID: <7f2decb7-3f32-1501-91db-c6b0da6baf37@huawei.com>
Date: Tue, 6 Aug 2024 11:52:55 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 0/2] net/smc: introduce ringbufs usage statistics
To: Wen Gu <guwen@linux.alibaba.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240805090551.80786-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Hi Wen Gu:
    Your patchset looks fine. However, the current smc-tools tool is not
supported, so will you update the smc-tools tool?

Thank you

Zhengchao Shao

On 2024/8/5 17:05, Wen Gu wrote:
> Currently, we have histograms that show the sizes of ringbufs that ever
> used by SMC connections. However, they are always incremental and since
> SMC allows the reuse of ringbufs, we cannot know the actual amount of
> ringbufs being allocated or actively used.
> 
> So this patch set introduces statistics for the amount of ringbufs that
> actually allocated by link group and actively used by connections of a
> certain net namespace, so that we can react based on these memory usage
> information, e.g. active fallback to TCP.
> 
> With appropriate adaptations of smc-tools, we can obtain these ringbufs
> usage information:
> 
> $ smcr -d linkgroup
> LG-ID    : 00000500
> LG-Role  : SERV
> LG-Type  : ASYML
> VLAN     : 0
> PNET-ID  :
> Version  : 1
> Conns    : 0
> Sndbuf   : 12910592 B    <-
> RMB      : 12910592 B    <-
> 
> or
> 
> $ smcr -d stats
> [...]
> RX Stats
>    Data transmitted (Bytes)      869225943 (869.2M)
>    Total requests                 18494479
>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>    [...]
> 
> TX Stats
>    Data transmitted (Bytes)    12760884405 (12.76G)
>    Total requests                 36988338
>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>    [...]
> [...]
> 
> Wen Gu (2):
>    net/smc: introduce statistics for allocated ringbufs of link group
>    net/smc: introduce statistics for ringbufs usage of net namespace
> 
>   include/uapi/linux/smc.h |  6 ++++
>   net/smc/smc_core.c       | 74 ++++++++++++++++++++++++++++++++++------
>   net/smc/smc_core.h       |  2 ++
>   net/smc/smc_stats.c      |  8 +++++
>   net/smc/smc_stats.h      | 27 ++++++++++-----
>   5 files changed, 97 insertions(+), 20 deletions(-)
> 
