Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C31F236C
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505297; cv=none; b=MnCm7dIL85wAfYBq6MdKbMZwbsO9XAYLSh+TdTYy4ChhnYunlpy4wQzbKrlgtWDHEFpvxE1IP/MABhehp/2JP8yaQ5WaSFHPuEEqRmPGaK7Okov1Qe4a7DzhBYM/0ja7UOisJ0FPeBsfLoET5tCrf4WvEONx7cnHBIKny2Q/Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505297; c=relaxed/simple;
	bh=ivqGICVxLEozQGBTawILTTXP7Nl7eMNQhKWIstBNXQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRaO5TReBZCO02Sl+FvIrlV6PcL7+wk5vcY0QQgaSpa2QjJpRsgWHDUVtb5wKpMuxAhbAFvGKS5WzWGn/TjTylZwsUmVkcs8yoDiKzfSCj2haUNBuUAC8LatYM5nxDMq+Tc9gST5Izue5d7sOxcYBDwCVmBPOdgGjWVDUheZ7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjAyiasr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjAyiasr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743505293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
	b=GjAyiasrhevW6cVHilPOM816h0Cs0zWxsH2fYaPIwfeDC+3PX7ommk3W95eCqzSNkDaEpN
	HK3d7vupsMFaqTqSv2lVk/B5k1vamzRv6kSsuHX+Zgq0az1GeysUtnvMOhOztCGFbeGH79
	zmMXSt1miAZX+XaSufktDQts2U9xMHE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-z0k8IZN8MdS2Urbt5AYbkw-1; Tue, 01 Apr 2025 07:01:30 -0400
X-MC-Unique: z0k8IZN8MdS2Urbt5AYbkw-1
X-Mimecast-MFC-AGG-ID: z0k8IZN8MdS2Urbt5AYbkw_1743505289
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so30853405e9.3
        for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 04:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505289; x=1744110089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
        b=rkphG9lZ+VbwU0FRUPPzz1HMOcTcQaASyL3l3IS+AGRgDANxjkdoBRFde9vAZBKUHt
         Wuz/ZdAE/AFSgrVE6G52kLa4S6B+iRhAlFyylLbz16Glj2aqRqdpuFVvCMODXhRajOoO
         5N2kmkq/TZmaBkBNleZsx2M/SIZpmBNEGRiXfaYWmxmH6D/+EMK6dyKfblZc9pkHNKWN
         VryoVe0GMQx7azYb+Dyg/wfyk3mfZRA/9R8XkIFSTpdTvYRgfG9+EvmtSq4vzQLvWhAb
         5EEFIWXfmbfabqj547he1opMSG6xpO3rGFuRla3QA2iQUhoMQrxuI/9jlcvUVZJP81KZ
         sdfw==
X-Forwarded-Encrypted: i=1; AJvYcCVwSm3jG7PjCrd+aBp+qLmDishQNJgQfJWPbmXJu3MkF1cp3T4C6FrnTDPUSBBRdF37jLKBSJsJl1I/@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjR7q9trEzGw6QE1F9z/OsqOtBSw/s8c0Oqvry2Xr8vYmQDiW
	IjelHdGv0KewuxJ/KP9McM0rPBgQgsRJzbmczK681XfgymXXIAAQLLeUjiObW/ZAAL8fYkYJKCT
	PlM8EYy1Nwn8KIHZ5KdqLP74m0h0PP5q5KE1NrOTQ8CVo7HVWgLl0pI2Gkl8=
X-Gm-Gg: ASbGncv384/MHMEvkhZi0UVHQNWW1KXl/86i/s+sQjH1AWJVp2Yflf6aYSQiNcupDOY
	9ctCwmHKIf70jZbkrZQa/QMABnyYLmlgzW8Z6uv76v7YSEnMlrZ8qQ11d9Y+h3h6eudF49hxmAg
	AZP023tgJEYSQiOXtFq63nef5FDbn+GBVqQgU5NEsRntJvjwu63R6eQ9rTgC7ueJixgbD9cSa+V
	DQgxRdUkIfm1jUwR94i56inVu5bgTwxLKXkMgt/LcXSdMbnO3T1njsfSa/lcBO3Ej3gIbtlSlAQ
	2UKO+SjyEp55+DxUviF15Wj3bDUn3xa0ofqM7zugftb2Ww==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536705e9.12.1743505288649;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWR6oGgrBc9yh+EIWLu0f/Rl10wsiQ6GwZIk1/Jim/OUEtWye5DYg+AcOZjj2bj4OhsRKyqw==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536285e9.12.1743505288311;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm194280015e9.18.2025.04.01.04.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:01:27 -0700 (PDT)
Message-ID: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Date: Tue, 1 Apr 2025 13:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ubraun@linux.vnet.ibm.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 10:10 AM, Wang Liang wrote:
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 3e6cb35baf25..454801188514 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>  	sk->sk_protocol = protocol;
>  	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>  	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> +	smc->clcsock = NULL;
>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>  	INIT_WORK(&smc->connect_work, smc_connect_work);
>  	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);

The syzkaller report has a few reproducers, have you tested this? AFAICS
the smc socket is already zeroed on allocation by sk_alloc().

/P

