Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684984;
	b=smyHVJ4rrdq40bsdm1DGKYuI3+/GHqfLBrWvEv5V3bMbywSRW+C/ULoCufzs32aHlE81
	 21XtuHwWZXRWn5pwixbOvucX9zB0ZLo4z3pPMxc9H6nVcNa6nuVgg8BsLzKFqtHuk+UUz
	 8socfdXLjJFSA+1AF1NKzGW7RpHap851w64M4AuricRF1qK9547Cdph/hXa9WwDHlSxid
	 P9UiWaBwhwz82lJZMLP6AYlhPphNTjhrv751/891A8pqqPmxeKGXjK7gIJuOv3dM7k1fA
	 uRIhLByX2GHpxNMN77zr2uLIu+YCibvnphI6F8AKb3cWPMDDsn84ksRRvbDONgO9dbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684984;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yWyZ1Z9Pbd4bxOXX/sgjyAr1HCnwtGuzuy6z8VWTlYM=;
	b=YjhnLs8Cl2sq4kqiH6eBwaecUvB3YO6f8JRfNcPh6ZSm46uJI9NUDoHzclaVZUJPQrMD
	 5xSFwpsoDyZZhiMA2wIgVqLnufdk6Lgq7zpttWAAm7TbgvOvvDkR6T1/xW6Nn9NyWtXSV
	 QU/4KfyEAjj3T2ZB99EWN5bQqijlBp3hGdgN4HREam8seyNRD2CEk5Rnj9i5mNzZAzl8r
	 VpL9xvrdXfyKL8ZSDapoVyo152Vqw5+VeSW9zGmvXCMZZB35Hbo/q082RgqdoPcXPlHmV
	 7z1ZzPdtWveWSYugNu8z1nntA430puj8DlLNCPVqYVHtP0G1iyxgE+4l4xruG9wWYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S+Hr1k1Y;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qFkJpBZX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F077606A31C
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 09:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F077606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S+Hr1k1Y;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qFkJpBZX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795684982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWyZ1Z9Pbd4bxOXX/sgjyAr1HCnwtGuzuy6z8VWTlYM=;
	b=S+Hr1k1YChTvMPunMRiV16r5lcOMovr9Q6P25OnLBdQTO/M+Fg9l9izQUvELyP1Baeye3K
	nn0IT5aWxsW6oMMZkxJwcx7bh6AMnOHZtHI+8bRkKqzF39ycsg+mhTfz1EhDtQEMj7nF65
	jCoJNPsh+H5Wkk1/LuTO3IN1yMcfEM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-jWRX4JMaMLa54pjkM4vDYw-1; Thu, 26 Nov 2026 09:23:00 +0000
X-MC-Unique: jWRX4JMaMLa54pjkM4vDYw-1
X-Mimecast-MFC-AGG-ID: jWRX4JMaMLa54pjkM4vDYw_1795684979
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb9379a835so31405385e9.3
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 01:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795684979; x=1796289779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWyZ1Z9Pbd4bxOXX/sgjyAr1HCnwtGuzuy6z8VWTlYM=;
        b=qFkJpBZXEyThetAAwO7vPpWaj37KdxAJ6F6O2SQRnneOLjsdVBVfTHGTqVeZ5TIOR1
         6PVYWBWciDPvM9B3YcnZTnqMhIRo6Itmo3XXW9ZfUxR+Rz7XFYzhnqEFH+g9dKZ9tfOA
         MxM8zY63sJHh3kO33LYnE0w330Gr33URguexvpXMNceJEnD1/qloqI0c4u9xDT0Ch6jn
         ojRIgkrZAikz6LTrIVKp12c+6JIrb9VEoy4Q+zszDRLA/X6L9cVPkmWLPbOAw45hDhFY
         tbpPC41w+BZ9AnfO0EpanM3IpTneyBf1rR6IBw1W/ljlfXMu7aHRkehXShtJh3JmaNND
         BnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684979; x=1796289779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWyZ1Z9Pbd4bxOXX/sgjyAr1HCnwtGuzuy6z8VWTlYM=;
        b=rMuzXCupZOvUZm5MVFga2OJNSkseL9cGgrrMtapEzlrcxTkEE0Jo1Et5m78lZpCU0y
         rFoXbzNJaTfY+Hbn7B+T/vv0INhe7FQlZ0sMKXWrFL2fdgoZpW/Ybvwz1QavS6ObitYO
         4YDXw5dsWgxIydvwUN8pAseclZHBlLo3EmrI12dW8JkIeVbKO8YSYfJBdM3BK2MMxsh6
         5yYeqo5McWhaqiKJvXBhu88Stg1/qBjRkGVIMbyCnvoQt3YQedCvOe9aX/x8/j6atxLO
         puZbfS75MSYjn7qKfrQCfYX5uXzULZh7UsmJOkQZcndOO8OdwzfVJMms8zjkBjQFQbPv
         PRDQ==
X-Forwarded-Encrypted: i=1; AL+hErHNvG36mDg2pLGE1X9BMFlkSKKAIvvv2b+SKFmTjvsWU8IhTmZcVR6zsfUFICc7vyONJLyQWTVSppiK@vger.kernel.org
X-Gm-Message-State: APuU4Z+rOpVcK7QV4tIrczP0HuPZkGAcH7NnkqJ5ijukzcR4/pL6VPfG
	9FFbMQYCzncAcyTQQmxBszFX+FV3UsCsV4yGVgYUhWXZW8bbFMB+uDvSs1pIKLhc4030YyNyEm9
	zLmxefHu1oo9jn6cd7nr6K7l5gQmuwF8W8rgSJXZmAQgrUkZaXF85y2ciIPE3nnw=
X-Gm-Gg: AZFdTZcSJTQ036o/P16OSWWVlfXjox3wHX4oPHszQfCNT3fxoVi3wHzpQH4eXNolRLZ
	1tcyHJE3ZA4k6RiwbpOQw+bE1T7WeTme2sCt+BqVCbEQbVqA2T4piFYU/VmiSTZMB0unhrcOmaf
	/UhCBk0LE8sIF0fXl5K1sBa2HZMkTMXlUA92vrXM6KeAVtwGi9gQ9lmpwQa6ZETE96ewNXsPUuR
	5eap1xbqP7azpTKjSLimTSX98zxNqlCEg+FCWmp2//d41ufTVPsCIcOrootllhRaYPQP7LrdA6K
	5cKO90tlYXcDLTlupcLHFQjj+FKHiz8ukGtI/H7U5+Vbegk1zZp7o/SSthbwxvRImRehqHQfYLO
	GMWL5BAsb+zvyKlvKdBb0ODx1stuKAGPt218Om1uKwSDvCcVKM3u72H5g3SLm0bAcu8gCjrxE/O
	CCKU0Z43VTSuJO6d+xTLLUIjb02GXvVaaGrtJrVncquCC5
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id 5b1f17b1804b1-4bb8880607cmr384834945e9.13.1795684979155;
        Thu, 26 Nov 2026 01:22:59 -0800 (PST)
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id 5b1f17b1804b1-4bb8880607cmr384834555e9.13.1795684978735;
        Thu, 26 Nov 2026 01:22:58 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm593204925e9.5.2026.11.26.01.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 01:22:58 -0800 (PST)
Message-ID: <0bc39607-b30b-4dc4-abdd-49f5c72fc2e9@redhat.com>
Date: Thu, 26 Nov 2026 10:22:56 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] net/smc: fix the failover cursor switch and wrap
 rollover
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Dust Li <dust.li@linux.alibaba.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
 Wenjia Zhang <wenjia@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>,
 Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>, Stefan Raspl <raspl@linux.ibm.com>,
 linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20261113-b4-disp-1a9ab9b0-v1-0-4a7c8d85d849@proton.me>
 <20261123165127.2453df54@kernel.org>
 <3e66af3fba5b4744b099734fe5054e6e@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3e66af3fba5b4744b099734fe5054e6e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 07:21, Sidraya Jayagond wrote:
> I am reviewing this series now; please do not toss it. I will send the
> per-patch comments today.
> 
> Sorry for the delay. For some reason our mail server was rejecting messages
> from the kernel mailing lists; it is fixed now.

Re-stating the series.

Note that you can have a nice view of what is pending on netdev for you here:

https://netdev.bots.linux.dev/suie.html?delegate=netdev

filtering by smc _and_ MAINTAINERS entry

/P

