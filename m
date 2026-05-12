Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6048C8B8
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574677; cv=none; b=Khe+9HHuhWIqSTd9G1ZwT//9Ewf+HuwtLJNg32bEOipZFfZrx5TFd6X/xCR5unSZ+BfmTtKBqpwz/ZwgmkOnpvTebUuRYQ4C/DPPvn8Nk1auGxrmbIX64WEuWK5825BR8ZpUxFfzMKy0BoufxaHzFupwD+etGj+PRXPg8NIEIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574677; c=relaxed/simple;
	bh=fTGplt+watJ4CCJ48471v0saEF+Ue/1jSJxh0KQ0ZFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS788vsVfg+lfUplNzONPnLY21UsNa0f9ZyRTkuAFcJkpMvFV1qFeyW41wVAl2XWDRonv3JtUS8Q1q/NMQFQvdOI4rmRz003mjaMCTgWGg/ZkJCy9ZFkTJ9dydJ+a0H5sLpUjrchyKRx/iIvWBYyUOME6Licw/a0NbcFU82NwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0I0s12H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXM1Zubc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0I0s12H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXM1Zubc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
	b=U0I0s12HeLoaQgoXGTDqH/aawiYOFDDCEkpR+kPpbSBmLz93eiB9zg38Ui+RAlNG+Lh7uQ
	8RGUt7tOS2nVG7ier/QS4ijBSdDfEAUnRySurXX8OUJ9kkTDqN6rLqghKXSnYgFL6qfkQz
	3ru2vW16MZmN8hT5evDqJvubQYZ5I84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-V9kHmmWbPzK0gjoousf7kA-1; Tue, 12 May 2026 04:31:13 -0400
X-MC-Unique: V9kHmmWbPzK0gjoousf7kA-1
X-Mimecast-MFC-AGG-ID: V9kHmmWbPzK0gjoousf7kA_1778574672
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e89faa62eso6682965e9.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778574672; x=1779179472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=iXM1ZubcFs4fu4W/ayBLZWMiqMZOOKDTtDbyjHXofib5CIgcLwXfYibmfGFVw0n7nj
         G7FR1UvhoKrgpdk+NEiXbQSTDKq3qMBwV3mXCC/w1mFfpQCQl/VG9ObcQqcZyAnLkOA/
         ZtMqy0tIEpXOKXwMXd0YHAWNlEK0McZ74gsp20WS7Kq3lxDP/TAPqXoDCFEoZ4HGd3s3
         xDNZ/4wMYlYzopEVu+N9PBtkJSzyuzQj0Es1CPznfTIwo+R+XIhYFAgL7VsjS05e90ZI
         LBH8IiBXZHVCWq6QtfnsdXbk17nKPUVEM58ADc4dG2n5MgWMQ9YrVhFLDrkWYVGBQXOP
         bAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574672; x=1779179472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=WDI72HGnq5Ku/Se2bXGvo9J9b6v1P27bnVJNeytzvi+HCazeVcXoFdyUhBrWAuVcBE
         A4JlloZB1tl6sbomF6ANyhM6MGZVGaCXPLKubSf8JHhzdWo0rZkWetf2rPy9Zu0pB5Sc
         09dUjHH1XF3QMOklmDZ49fqJJV9MqwKU548wA96eiih1GZetiw3EN5UxwyCDeFL2fqCC
         q5Q/ieduqNsrwzrrqyjqIGqJPHavf8acA3oTgg4BpGCa+L5pLIxbqYp0LA1mSPTUg8B5
         fMqnd81S4SLehAecAq6yns9vP02df8+Rc9Hy+G7hQqGJykyeYxsiGYIlB8fp3SR5FUjI
         1Nfw==
X-Forwarded-Encrypted: i=1; AFNElJ84EPCrlU8X+MPddvUjyWjeDyFDeR6LKHzHTVuN0IzfT7mwj0wA7pgeYtErl2RWE74SazJbIILWmZq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfj94TnY/EhVD/xhbwAq5ljAbLnERujixE6UEw69RIrRweG7X
	9sTYOWU8KfFC0QyxLsilE91LmZhj7uWOh+fp/F/BJ8GuvVj9wuxEz+jFsftwfK876zwoyymOQZ0
	pnqxV3N+XWHPLHZB/wMD+aj/UK1ib+GtDHymclMBkzJskidTEoJXeYjTZ73NS93A=
X-Gm-Gg: Acq92OGpCuF1vPWwUP0K9nPX8YW69m0uJrTGgHBHqGvx689Tl1nmm4Htfz4oArNSPqS
	ofhsEmv6QKpCSSCpy6f3QNocFu1TDNKyu8e+SAQi7ftqRA1Do4EZh4opj2uDxoA6QUvV8y4taQS
	udETB35ApEs3DBtv5E2bd0Yn5gfsaVfCIdZbVzcylMYxWph3nw9XL7FMfcP6DOvVsc+EGYJCrfC
	xi8IrBoN0F7iafuJuVmrXieKf9m1JohzcjKFpsujQPWkqnkMx8SiUM8sv0Xmp2iUZ0L/yVOCtVt
	5IzGMzXz0xgb7tm/ZtyvNxige5n3F7JkIeCchzqSjqhu9A1eNsMPeeG9EKTgRYZYwmRlknNPd1q
	5aMCBgykIlp0t50+Dt//S8Lhe9XIEg5CXnBPRJV6GN4E9zSZ286srSPo=
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22343195e9.20.1778574672093;
        Tue, 12 May 2026 01:31:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22342675e9.20.1778574671605;
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm29414592f8f.1.2026.05.12.01.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Message-ID: <7aeb534e-cf2a-4a3e-83eb-d98a3a5787f6@redhat.com>
Date: Tue, 12 May 2026 10:31:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Simon Horman
 <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com,
 Eric Dumazet <edumazet@google.com>, Leon Romanovsky <leonro@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260508063718.101622-1-alibuda@linux.alibaba.com>
 <20260508063718.101622-2-alibuda@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508063718.101622-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 8:37 AM, D. Wythe wrote:
> -void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> -{
> -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> +/***************************** init, exit, misc ******************************/
>  
> -	tasklet_schedule(&dev->recv_tasklet);
> +static inline void smc_wr_reg_init_cqe(struct ib_cqe *cqe)

This and the next 3 helpers are used at init time, hopefully not
critical/fast path; the `inline` annotation should really be avoided.

Note that the sashiko gemini instance has more concerns on patch 1,
please have a look:

https://sashiko.dev/#/patchset/20260508063718.101622-1-alibuda%40linux.alibaba.com

/P

