Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0F14A4D2;
	Thu,  1 Aug 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475359; cv=none; b=jqjac3ovyrRwX4vhpNmwfEYPPsHVxTfHZTtwTDDh3GCwOwQr1epykDASHDh19+ZMvu4bcr1ahb7LzPP5fIFkeqdxg0fSpRgxcANl28w1AquLlUS9bSj9VfH9WY8Uku0J6RkKEDdx/i7uehuAKgzSPCPnxNS2bRGWPzZknHAFX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475359; c=relaxed/simple;
	bh=+DMds7fVaPDjKCj7lGJ2/9hrgLIkk0Z5eLRcjA5ikBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E7Oqr87QqNcAfFVt8vvMsPxkfYkjzMjjd70Y/l3nbgs7l58/rAIpqmSacbxSZE+rGTwIujTJWyy3OfDTeju8syYxaqIx4XoFQ29+wCyATbmFkvVASQU0ovR54AELgGAMa2xKHt8QhqG4Um5ULvmWzk640R+kt4B4kG2fQrrg9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZB5m2crtz1L9KR;
	Thu,  1 Aug 2024 09:22:20 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E54A180AE6;
	Thu,  1 Aug 2024 09:22:32 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 09:22:31 +0800
Message-ID: <70dea024-dfbe-1679-854f-8477e65bc0f8@huawei.com>
Date: Thu, 1 Aug 2024 09:22:31 +0800
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
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <4232f3fb-4088-41e0-91f7-7813d3bb99e5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Hi Wenjia Zhang:
    Looks like the logic you're saying is okay. Do I need another patch
to perfect it? As below:
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 73a875573e7a..b23d15506afc 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1523,7 +1523,7 @@ static int __smc_connect(struct smc_sock *smc)
                 ini->smcd_version &= ~SMC_V1;
                 ini->smcr_version = 0;
                 ini->smc_type_v1 = SMC_TYPE_N;
-               if (!ini->smcd_version) {
+               if (!smc_ism_is_v2_capable()) {
                         rc = SMC_CLC_DECL_GETVLANERR;
                         goto fallback;
                 }


Thank you

Zhengchao Shao

On 2024/7/31 23:15, Wenjia Zhang wrote:
> 
> 
> On 30.07.24 03:25, Zhengchao Shao wrote:
>> When the SMC client begins to connect to server, smcd_version is set
>> to SMC_V1 + SMC_V2. If fail to get VLAN ID, only SMC_V2 information
>> is left in smcd_version. And smcd_version will not be changed to 0.
>> Therefore, remove the fallback caused by the failure to get VLAN ID.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   net/smc/af_smc.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 73a875573e7a..83f5a1849971 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1523,10 +1523,6 @@ static int __smc_connect(struct smc_sock *smc)
>>           ini->smcd_version &= ~SMC_V1;
>>           ini->smcr_version = 0;
>>           ini->smc_type_v1 = SMC_TYPE_N;
>> -        if (!ini->smcd_version) {
>> -            rc = SMC_CLC_DECL_GETVLANERR;
>> -            goto fallback;
>> -        }
>>       }
>>       rc = smc_find_proposal_devices(smc, ini);
> 
> Though you're right that here smcd_version never gets 0, it actually is 
> a bug from ("42042dbbc2eb net/smc: prepare for SMC-Rv2 connection"). The 
> purpose of the check here was to fallback at a early phase before 
> calling smc_find_proposal_devices(). However, this change is not wrong, 
> just I personally like adding a check for smc_ism_is_v2_capable() more.
> 
> Thanks,
> Wenjia
