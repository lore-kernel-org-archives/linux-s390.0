Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5C143C45;
	Mon, 25 Mar 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337702; cv=none; b=p6QfApu4PJwr1NJnsAokuJgCc+NXUif/8ggc9UHjGO7pMw1V10bn6Bg+XHJCymCBQ6TarqMCQf0mb22bD9ivQr8FQZ4/T5kVNXsNqA0ifkmGA9EAokFIdsmimagxVWS4rL8BlV+h9WGAlQWTkjRcL8nPKZew/Aeu01fOupYwjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337702; c=relaxed/simple;
	bh=0csUpLdZcAisR9lZiWaOn5cqz5pVHfZLbcc0vjP850c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8I4bFttI8Yt2bAdbdvcRwDmHyhI+a+wL4A0PyDkptdXoAIqyLKqyeU+50m9SRfZ/zyTT/DbPfocyHc+/Mufn4FnOb/prI6mHQwaretV/Jt5GLyWq2yN1GkxDCaBc+5iotn39eTP/Np1odDRoBdkw8A/N5LJTgAGBKasBBXY1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V2z596SQNzXjdf;
	Mon, 25 Mar 2024 11:32:13 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 87F6D14037F;
	Mon, 25 Mar 2024 11:34:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:34:56 +0800
Message-ID: <30820fc2-4d98-651d-fb17-a3f2a05ba3ee@huawei.com>
Date: Mon, 25 Mar 2024 11:34:56 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] net/smc: make smc_hash_sk/smc_unhash_sk static
To: Tony Lu <tonylu@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240325012501.709009-1-shaozhengchao@huawei.com>
 <ZgDsX8-NmJZ1KWfQ@TONYMAC-ALIBABA.local>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZgDsX8-NmJZ1KWfQ@TONYMAC-ALIBABA.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/3/25 11:15, Tony Lu wrote:
> On Mon, Mar 25, 2024 at 09:25:01AM +0800, Zhengchao Shao wrote:
>> smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
>> static and remove the output symbol. They can be called under the path
>> .prot->hash()/unhash().
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
Hi Tony:
	Thanks for the heads-up. I'll send it again until net-next open.

Zhengchao Shao

> This patch's good. The net-next is still closed for now. You can check
> here:
> 
> 	https://patchwork.hopto.org/net-next.html
> 
> Tony Lu
> 
>> ---
>>   include/net/smc.h | 3 ---
>>   net/smc/af_smc.c  | 6 ++----
>>   2 files changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/smc.h b/include/net/smc.h
>> index c9dcb30e3fd9..10684d0a33df 100644
>> --- a/include/net/smc.h
>> +++ b/include/net/smc.h
>> @@ -26,9 +26,6 @@ struct smc_hashinfo {
>>   	struct hlist_head ht;
>>   };
>>   
>> -int smc_hash_sk(struct sock *sk);
>> -void smc_unhash_sk(struct sock *sk);
>> -
>>   /* SMCD/ISM device driver interface */
>>   struct smcd_dmb {
>>   	u64 dmb_tok;
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 4b52b3b159c0..e8dcd28a554c 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -177,7 +177,7 @@ static struct smc_hashinfo smc_v6_hashinfo = {
>>   	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
>>   };
>>   
>> -int smc_hash_sk(struct sock *sk)
>> +static int smc_hash_sk(struct sock *sk)
>>   {
>>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>>   	struct hlist_head *head;
>> @@ -191,9 +191,8 @@ int smc_hash_sk(struct sock *sk)
>>   
>>   	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(smc_hash_sk);
>>   
>> -void smc_unhash_sk(struct sock *sk)
>> +static void smc_unhash_sk(struct sock *sk)
>>   {
>>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>>   
>> @@ -202,7 +201,6 @@ void smc_unhash_sk(struct sock *sk)
>>   		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>   	write_unlock_bh(&h->lock);
>>   }
>> -EXPORT_SYMBOL_GPL(smc_unhash_sk);
>>   
>>   /* This will be called before user really release sock_lock. So do the
>>    * work which we didn't do because of user hold the sock_lock in the
>> -- 
>> 2.34.1
