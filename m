Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5B18DF7E;
	Thu,  1 Aug 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512118; cv=none; b=AEHKyaY1SZc27hSDAJis9bkH40OQiuaywDTPTVXfNpKwpDZWM15/XtZqDzvRaOSPbyCueSHxBWm1ZYczRFszjxMexQFNk6nO//3QYjLpnKKAPDJuGz1JHJkOyckWZxPmsTZGEb9HVGnIarPlABBRgXnSn+x282rx08dm4uNpeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512118; c=relaxed/simple;
	bh=hucJDtaYaEwbsPLVJ5F1bWH/gwStpaxJ9e2wLvvtZtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hs98TvXWqChUgq8vztqMxsCutH3LzQpj8tUposRDnJKwWaaK3LS/NrHlxPKJsYk+ji//z0xfClym0qEJUwUyFrxfwSGonfr0ts8lpHwRKc2KWRLSizOtHG+I1aoNuU0pWxKP5dURTJoaxV3Ug7hJv7xD3kBsDpFVIMi5F+dnWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZRfp6c0PzfZGl;
	Thu,  1 Aug 2024 19:33:22 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id E5BE318005F;
	Thu,  1 Aug 2024 19:35:13 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 19:35:13 +0800
Message-ID: <7a8a4774-a973-dd03-ea2f-8817f15e8c58@huawei.com>
Date: Thu, 1 Aug 2024 19:35:12 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 2/4] net/smc: remove the fallback in
 __smc_connect
To: Wenjia Zhang <wenjia@linux.ibm.com>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-3-shaozhengchao@huawei.com>
 <4232f3fb-4088-41e0-91f7-7813d3bb99e5@linux.ibm.com>
 <70dea024-dfbe-1679-854f-8477e65bc0f8@huawei.com>
 <89b65343-2345-4b4f-ad3f-5410c5436e8b@linux.ibm.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <89b65343-2345-4b4f-ad3f-5410c5436e8b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/8/1 15:23, Wenjia Zhang wrote:
> 
> 
> On 01.08.24 03:22, shaozhengchao wrote:
>> Hi Wenjia Zhang:
>>     Looks like the logic you're saying is okay. Do I need another patch
>> to perfect it? As below:
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 73a875573e7a..b23d15506afc 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1523,7 +1523,7 @@ static int __smc_connect(struct smc_sock *smc)
>>                  ini->smcd_version &= ~SMC_V1;
>>                  ini->smcr_version = 0;
>>                  ini->smc_type_v1 = SMC_TYPE_N;
>> -               if (!ini->smcd_version) {
>> +               if (!smc_ism_is_v2_capable()) {
>>                          rc = SMC_CLC_DECL_GETVLANERR;
>>                          goto fallback;
>>                  }
>>
>>
>> Thank you
>>
>> Zhengchao Shao
>>
>
Hi Wenjia:
    I am currently testing the SMC-R/D, also interested in the SMC
module. I will continue to review SMC code. :)

Thank you

Zhengchao Shao

> Hi Zhengchao,
> 
> I see your patches series were already applied yesterday. So It's okay 
> to let it be now. As I said, your changes are not wrong, just not clean 
> enough IMO. Anyway, thanks for your contribution to our code!
> 
> Thanks,
> Wenjia
