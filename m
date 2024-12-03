Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63F1E0B6D
	for <linux-s390@vger.kernel.org>; Tue,  3 Dec 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220264; cv=none; b=enjgm4UaXUSX7ZOF9ONTrfE8LApTylQY6jas8QblwpknbXtlifZha5FArk4PD+szkTWuvFsyQpFJ/GgJXmJRY89HI42qxFvhDG7ex5uUCqaUs6wFLFAw42dq1ytt8lhLL1LHcf+kdjafyVloKqrmbyjZtgBmgmusjfULBzpgY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220264; c=relaxed/simple;
	bh=HQ44SPqVqENJTbQrYY2kZjK603Ln//DhUNKAfXJorFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB5+IYCzcyBNhNSeotmvuuFvcM/q3hynn4rsPaoylqXpYJ73PQPVS1h3TulL7ZlY8Rmwz+xxdzYND7kA2kYXbkgHhXCksIDk675COkcfv9op1DBET5sNh1z+MeyPhKtSweBdG60ivwtPdJNnWAZLxdK6RvsygDMJoxEt6w/uLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf94aAZO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf94aAZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
	b=Nf94aAZOJCVXSxtL88LrW8Ew07q6rdGyD9N3eJWUMkYL37Or/37vph3cpdVus/KZYEFaFm
	RPOJZuG2OdnCG0lvsh6zKQuiSWRvoOmdPVtr090xR4jySEf3t/DrF9TL729h0D/nOs/U+/
	24hxcpaI1GM3KK4vvmGRh0z2gy/82RM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Jgbd-BNsN4y9H7_Ifouh-A-1; Tue, 03 Dec 2024 05:04:20 -0500
X-MC-Unique: Jgbd-BNsN4y9H7_Ifouh-A-1
X-Mimecast-MFC-AGG-ID: Jgbd-BNsN4y9H7_Ifouh-A
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d87cf1f89cso93545456d6.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2024 02:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220259; x=1733825059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
        b=j+rZtryV9PmLLY14XyQQzpEShU68hi6q/bZBr0VxRfFKOzYM70XS9iUAwtrvgrhuCH
         i8QrDx8pbO11GZNznhguui1elORLRRJvFr8InzH/Z5vsogUg6KavGQ2UUNAQ7KUSqqPr
         mBpVmYOCjJS3f9ExclocJZLt0SHlYh42fSweinKK/GuxOM4cJSlBAf8KywViSkSHUEXX
         dvfF/4E2KIzQvcy1YEHnnNMz+oXoUjxjteTsO9x00XriNXC2pvqgCua6Wcdi7z6so3I/
         M5+mSoDd2tBGWKF1wP54ROgtW4x0r1UcgAqapGLXvLI7lgOI2QxL1P8FC6Sg4gQwKzUe
         nSZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVGCF3Wo1jvVzI3CfPqER2D0hHjHti6z0pNCzf8tuLDfRk25llZWinvo8I2K2xwNrbn/5ywe/61dh8@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQGL7ifsIMSNhJv1yBi5E/YzhCiRKjnJZiQ7FS6vm0RJ2kg61
	GGw1Jyzivh7Tdy5Tm3cjbfMLZebpY6EZgILlwqpo+JVKIN6jIhRnM9Qlt3S3lRZ/XHc4diutWU1
	cOZEyQIs41tanxvbQQ9c98es4/iaOWZ/QtfJnSsopptmZtTlwYxMqRHiuQ/U=
X-Gm-Gg: ASbGncuJfPvur3lONcyP3P56NQBYhbWJ/30TJ0x0ZxNw7x0C/JjWoFK7D0cX6OL9Jqu
	Y4YAlMaqJiSRKTbKs+baNS3GNODlu1bMdxDCTsGeWF3POwP62cCaUnw+HuDi36tssJ80iJ8TA+n
	vQRl2hN6iHYAyXshlzLxOR+odYdS/LJybNsk8xccBcxLPBA9JRBBIm25nQWvfnrhuLnWo3n7T++
	kIKMG/X/bSm2cpcZd71Lz06N/2qCXetIbUquZ1fjJM93cdkO2i2jU4wIwbID41YrBdG9HqqeoYb
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032346d6.25.1733220259676;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1K5nqkk2YWvJZ36M/30xTQ0u4uphAR9Xza3eEbd6ZgDvKckxS8QXJ6vo2298noBcWsm6LJA==
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032066d6.25.1733220259408;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849c35efsm496606685a.118.2024.12.03.02.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Message-ID: <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Date: Tue, 3 Dec 2024 11:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but
 no sndbuf_space left
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
 <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 13:14, Guangguan Wang wrote:
> When application sending data more than sndbuf_space, there have chances
> application will sleep in epoll_wait, and will never be wakeup again. This
> is caused by a race between smc_poll and smc_cdc_tx_handler.
> 
> application                                      tasklet
> smc_tx_sendmsg(len > sndbuf_space)   |
> epoll_wait for EPOLL_OUT,timeout=0   |
>   smc_poll                           |
>     if (!smc->conn.sndbuf_space)     |
>                                      |  smc_cdc_tx_handler
>                                      |    atomic_add sndbuf_space
>                                      |    smc_tx_sndbuf_nonfull
>                                      |      if (!test_bit SOCK_NOSPACE)
>                                      |        do not sk_write_space;
>       set_bit SOCK_NOSPACE;          |
>     return mask=0;                   |
> 
> Application will sleep in epoll_wait as smc_poll returns 0. And
> smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
> has not be set. If there is no inflight cdc msg, sk_write_space will not be
> called any more, and application will sleep in epoll_wait forever.
> So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
> smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
> even when the above race happens.

I think it should be preferable to address the mentioned race the same
way as tcp_poll(). i.e. checking again smc->conn.sndbuf_space after
setting the NOSPACE bit with appropriate barrier, see:

https://elixir.bootlin.com/linux/v6.12.1/source/net/ipv4/tcp.c#L590

that will avoid additional, possibly unneeded atomic operation in the tx
path (the application could do the next sendmsg()/poll() call after that
the send buf has been freed) and will avoid some code duplication.

Cheers,

Paolo

