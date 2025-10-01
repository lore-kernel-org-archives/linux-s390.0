Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B232032D
	for <linux-s390@vger.kernel.org>; Wed,  1 Oct 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303277; cv=none; b=RRj7K1pEr1LCuc+TruJEZuMo4ZY7HtMyCfr6UGQG4Q6wWkZfia1gNyYa4yjIMqZuv1PmTrfjn/sfj10KULoH/diwufWM5TPA96Ro3+RhTdscEM8XbBMIyDO0iI3wJv3VSuZtzNN0Bbqy8sfufmr3inTGsYPogBuS971vs49HO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303277; c=relaxed/simple;
	bh=ZchBe3UVZFcajzAfPm5iupGhaT45ZKDAxK04VZzhIoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSD7xfSCbhrS171t/Uqn3jZ+cVfD5tsTgfdBNtskFlMxSfCsKkLxza1W01BSyDAFeo9BAmkHSQsDzfSP2NML/s2aZwdRv634Z3d6jgU4Y0md7i+xRMxeXI3py7cLGekquFyGDTfYmGwfG15osUlbsTxpysdtut+nnTQvmn7U63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcnIQXbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcnIQXbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759303274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6TphmWVV7btIJvjp1CTjxC8F2bt+sldx5I/c4TiGGc=;
	b=QcnIQXbpCqa3QuGfqc4LTZ8GIpfHs/Pm5KZBIfi24tc2rfSsgskY8NmNRBU6Nc7rYHlZ8J
	2SmPMOV59rEommb0W5rz0GNP3K6LUI21Nnp6RZfBHGwC32VYRMAtu2hG+DGK/2H9ckDvrs
	zTNR15kwE2CWrpyXNEcUPQZ/Po5NURM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-dVWo_90RPuKV5iZFrCcABA-1; Wed, 01 Oct 2025 03:21:13 -0400
X-MC-Unique: dVWo_90RPuKV5iZFrCcABA-1
X-Mimecast-MFC-AGG-ID: dVWo_90RPuKV5iZFrCcABA_1759303272
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so3666758f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 01 Oct 2025 00:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303272; x=1759908072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6TphmWVV7btIJvjp1CTjxC8F2bt+sldx5I/c4TiGGc=;
        b=Q2ROzudFisiDxLIMJxp5aGjezGInDP7UIQvm7Ks4dcorxi2TORFp1awgzBfI9Bo+BT
         TPISw2IAq7rCwMiVM4i+UunKzgf9tSoyJybM1aL6QM8q8sz+MkGo1cFO1zaQzH78/jLz
         3UMVXXP5qIC4bLkT78IOpKPsm7kYap8oWuwhHfvTiNpir5nhoSq24m7tqx74lvsdNGlb
         9wa1L6sKAuoeNMqkAuCgdqi53nyxeEd8cnsxR6F+i6vsKwnpN+m8nWf3SiJ41xiSfchY
         ugGZFOFQDp7FoAmldM8nketUgr1KKLfSo/K8Cm1ENOMKwhm6xtmhR/fy0Ahm/lsjGr8y
         Q64g==
X-Forwarded-Encrypted: i=1; AJvYcCVLsJ1xIlJP4CLyPrUztCObjbjT0HzANngcH+mnPn9e5545nzyTUyjVsFDCcQdf+dUDh42ODdKUAWUK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KkGBPRkdK/h66R5tSDremC1vA3huWdriF1WGfNWUDTz90ai7
	+tJJl65rXD8uvqSKwiftI30LwOqqUonvhMeU7rqP7NA7egakXDvWAYosQ4AXAibWYE6HvMH6klA
	ElWo3zUT3L8Cil0v0JKohx9XhqWUsTLdzR5wxlPjbpeCESlKct8lTr6C4ng7wZgQ=
X-Gm-Gg: ASbGncs9PYs5k99Tph48mA+TbmY8jUDskCD9THyEL+b3RpW6tTZVlZZjiO1Lt3Cbjlg
	Vy7b3CwGfnQQQT3UMHhj5SnTLWBxUr1iqhodJKd9V/OovA4b2gy6kyLhDYnB2B87Wwl4DrqpYdO
	8gWCfATR7zBgVJorJbc8PPvmGHZIYayIc+zsMUEIHJ8uwzi6pXvTodkz+9srY0XlMBKAhkCY9H9
	ZfbQGrqqpQByIqEcmmpSDByv+6C6s1vkA2JEZXJR1ORGyu9UUXsDvKTnmVQo0PAtOFUMzhjmdaB
	CxqVFBledwIn+pd2Hw7rpcBVWhf+vXrfAPt2+A8z2I/AXsG3T8Mc9OGyt8WYRjXbp1KX2yFBBfk
	80lC2t0rYmgkLCttiXQ==
X-Received: by 2002:a05:6000:2dc3:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-425577f0588mr1793501f8f.20.1759303271975;
        Wed, 01 Oct 2025 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL9Aoaglcvmq0NJZa7kQLBpIJUntR5wIckFB4bSle6etuGPxOt3URwof3q3OmopFDd6P6LuQ==
X-Received: by 2002:a05:6000:2dc3:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-425577f0588mr1793475f8f.20.1759303271534;
        Wed, 01 Oct 2025 00:21:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb729sm25151903f8f.6.2025.10.01.00.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:21:10 -0700 (PDT)
Message-ID: <acad498b-06e6-4639-b389-ef954e4c6abc@redhat.com>
Date: Wed, 1 Oct 2025 09:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-3-pasic@linux.ibm.com>
 <aNnl_CfV0EvIujK0@linux.alibaba.com>
 <20250929112251.72ab759d.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250929112251.72ab759d.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 11:22 AM, Halil Pasic wrote:
> On Mon, 29 Sep 2025 09:50:52 +0800
> Dust Li <dust.li@linux.alibaba.com> wrote:
> 
>>> @@ -175,6 +175,8 @@ struct smc_link {
>>> 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>>> 	int			llc_testlink_time; /* testlink interval */
>>> 	atomic_t		conn_cnt; /* connections on this link */
>>> +	u16			max_send_wr;
>>> +	u16			max_recv_wr;  
>>
>> Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
>> This means we can now have different max_send_wr/max_recv_wr values on two
>> different links within the same link group.
> 
> Only if allocations fail. Please notice that the hunk:
> 
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	lnk->clearing = 0;
>  	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
>  	lnk->link_id = smcr_next_link_id(lgr);
> +	lnk->max_send_wr = lgr->max_send_wr;
> +	lnk->max_recv_wr = lgr->max_recv_wr;
> 
> initializes the link values with the values from the lgr which are in
> turn picked up form the systctls at lgr creation time. I have made an
> effort to keep these values the same for each link, but in case the
> allocation fails and we do back off, we can end up with different values
> on the links. 
> 
> The alternative would be to throw in the towel, and not create
> a second link if we can't match what worked for the first one.
> 
>>
>> Since in Alibaba we doesn't use multi-link configurations, we haven't tested
>> this scenario. Have you tested the link-down handling process in a multi-link
>> setup?
>>
> 
> Mahanta was so kind to do most of the testing on this. I don't think
> I've tested this myself. @Mahanta: Would you be kind to give this a try
> if it wasn't covered in the past? The best way is probably to modify
> the code to force such a scenario. I don't think it is easy to somehow
> trigger in the wild.
> 
> BTW I don't expect any problems. I think at worst the one link would
> end up giving worse performance than the other, but I guess that can
> happen for other reasons as well (like different HW for the two links).
> 
> But I think getting some sort of a query interface which would tell
> us how much did we end up with down the road would be a good idea anyway.
> 
> And I hope we can switch to vmalloc down the road as well, which would
> make back off less likely.

Unfortunately we are closing the net-next PR right now and I would
prefer such testing being reported explicitly. Let's defer this series
to the next cycle: please re-post when net-next will reopen after Oct 12th.

Thanks,

Paolo

