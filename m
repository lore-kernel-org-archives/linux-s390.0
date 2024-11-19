Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD271482E8;
	Tue, 19 Nov 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004012; cv=none; b=bheK+oiHEu7X9k1VZiUODaIA2TA8XCw4SYl3rqlVxnGiRAjVl5l49Ar2GGfcDY/0FtpKLypBMCUm7nGNEWoja0Bb4WnjOzZUShKmuG2zqPxNlSUKZS/fxjRmU3PrHduIv7fVCrq2G3wBlOu+Fb6VL+dlws9/k3VvciTbLU4P7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004012; c=relaxed/simple;
	bh=YutjBmox/hv7aW2stkLhLIQICRSFJZs1ziNBjr9iBLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P2diMKnfvhemnYGFS6r4uk6hHj+E2AGbQLIdJZP98QvL9I8YdS8NaqEvaBzd1o7J0i8v2GwPNfThL/ylzquikD3aThiRLwVU3TL/F+su/lyHPbJ/VeL191v3dhr7DUn/WorhbnIoCkogZ6bhQG3Kl6iixxrQHuAfUhf2/TaZh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XsxyL5XQyz1V4gB;
	Tue, 19 Nov 2024 16:10:50 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F172180B99;
	Tue, 19 Nov 2024 16:13:27 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Nov
 2024 16:13:26 +0800
Message-ID: <debb5f7d-8031-4aab-93d6-dd54a37c6c1d@huawei.com>
Date: Tue, 19 Nov 2024 16:13:25 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/1] Separate locks for rmbs/sndbufs linked lists
 of different lengths
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <alibuda@linux.alibaba.com>, <dengguangxing@huawei.com>,
	<dust.li@linux.alibaba.com>, <gaochao24@huawei.com>,
	<guwen@linux.alibaba.com>, <jaka@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<luanjianhai@huawei.com>, <netdev@vger.kernel.org>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>, <zhangxuzhou4@huawei.com>
References: <20241118132147.1614-2-liqiang64@huawei.com>
 <20241118204831.70974-1-kuniyu@amazon.com>
From: Li Qiang <liqiang64@huawei.com>
In-Reply-To: <20241118204831.70974-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/11/19 4:48, Kuniyuki Iwashima 写道:
> From: liqiang <liqiang64@huawei.com>
> Date: Mon, 18 Nov 2024 21:21:47 +0800
>> @@ -596,10 +632,26 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
>>  static struct smc_buf_desc *smc_llc_get_first_rmb(struct smc_link_group *lgr,
>>  						  int *buf_lst)
>>  {
>> -	*buf_lst = 0;
>> +	smc_llc_lock_in_turn(lgr->rmbs_lock, buf_lst, SMC_LLC_INTURN_LOCK_INIT);
>>  	return smc_llc_get_next_rmb(lgr, buf_lst, NULL);
>>  }
>>  
>> +static inline void smc_llc_bufs_wrlock_all(struct rw_semaphore *lock, int nums)
>> +{
>> +	int i = 0;
>> +
>> +	for (; i < nums; i++)
>> +		down_write(&lock[i]);
> 
> LOCKDEP will complain here.  You may want to test with
> CONFIG_PROVE_LOCKING=y

Thanks for your reply, other implementations should be considered here.

> 
> 
>> +}
>> +
>> +static inline void smc_llc_bufs_wrunlock_all(struct rw_semaphore *lock, int nums)
>> +{
>> +	int i = 0;
>> +
>> +	for (; i < nums; i++)
>> +		up_write(&lock[i]);
>> +}
>> +
>>  static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
>>  			       struct smc_link *link, struct smc_link *link_new)
>>  {
> 

-- 
Cheers,
Li Qiang

