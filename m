Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06C1EF37C
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514335; cv=none; b=HWLgj/iC3BHqJKB7w8efvj1kDgTaIeKzWVij1pMX+7zAY6/12N5qu3NvXV8tiCq50WEok+vvDSitw5juxQfaaTuEvZaNkwMoxZW4qUV48uC2nEQnm8hKpvuATLxAUuA3+U5oo4H0igiCMsORbT4Kzh8cJYhNDeGCtWQOL3U0q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514335; c=relaxed/simple;
	bh=/tBD38mp4DS6jkQtiRDsu4bhtmz7msq1iOn6Dz0mWmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA+rgSLlMmH1fZDEqBoFG3X5/8hAq1Sv7vIdL+js8MXZ0agf0wn67+R1tk71qZ0SfYjigy3Qg/LCDqXd2VTAn7s+rSr+++mdXA7Ssi4rU9N3Tr9O2t5cdeMYRo+V2F7nxRFcbY818HYz+iDiZdrBuIzplkTe8Ee7KU3C53yaogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KD+77uEm; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KD+77uEm"
Message-ID: <052a9a59-b555-4867-9ec6-c6fa719adb61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743514321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg826qukLI7doC/5Gq/qEXLkMQocti6S+kHz6s4mVhA=;
	b=KD+77uEmnJzlYVcl++uqZFBZMmN9a07Fx8ECI9PCoqSh/jw7WXEewlggpwX8PDEVyAMA1U
	+cYLjrSzc0sQ2PLj0iCRoZUwr/85VG6tB/qpTBhSFucK63Mtf0C7byMWasHDffa4s6izxx
	6ZPeccmb5AmrKkR4s764ArJLFtIiFoc=
Date: Tue, 1 Apr 2025 15:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Paolo Abeni <pabeni@redhat.com>, Wang Liang <wangliang74@huawei.com>,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 ubraun@linux.vnet.ibm.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01.04.25 13:01, Paolo Abeni wrote:
> On 3/31/25 10:10 AM, Wang Liang wrote:
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 3e6cb35baf25..454801188514 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>>   	sk->sk_protocol = protocol;
>>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> +	smc->clcsock = NULL;
>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
> 
> The syzkaller report has a few reproducers, have you tested this? AFAICS
> the smc socket is already zeroed on allocation by sk_alloc().

Yes. I also agree with you that smc socket should have already been zeroed.

Currently in this commit, this member variable is set to NULL 
explicitly. I am not sure if this can fix this problem or not.

Based on the following, it seems that this problem can be reproduced.
"
syzbot has tested the proposed patch but the reproducer is still 
triggering an issue:
general protection fault in __smc_diag_dump
"

Thus follow the instructions in this link to make tests.

https://groups.google.com/g/syzkaller-bugs/c/YwENRImdcsk/m/wBJo6qGiCAAJ?pli=1, 
the following can trigger the reproducer.

"
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
"

Zhu Yanjun

> 
> /P
> 

