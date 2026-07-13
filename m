Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D233F482D
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945941; cv=none; b=PxLO5+3RYBRZZGxrFBuLSDbds9yC7W+T+WFG7uyMDBlwPlJflg58GtYu6YqqIpgiC9VfIFm4BuDm4WZXKPoMMMvFvxNbNY+jFP82oQvWnmzYFTnIMXn+0X/xjPD9fTG6pTj1MMPHw9W09zC3rD2r7NRO1TOXXT4/DjJEXoORqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945941; c=relaxed/simple;
	bh=GHwfMfdmDB/k7iCIFX7dPpwYZPHSeTtGeIuOh/UewSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO1rZ2+wcegnmBLW0FyYeCBm/zRP4s6Qb45ip8hgPjdL6Vyosnm+UMWD2Z3bsSO1DBfRneAZ9hBFk+lyxHvnEFu7YC+4v3XQMkN6LatvvYW3vSOHPlrimjrb0LtN2T/4DX2LwHDjMAr40aNYQqaYLbwtmIOGeCDNfk7j1GZbC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=RaNgN0zx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="RaNgN0zx"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso4648552a12.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783945934; x=1784550734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWIlou6pGXT2W8CUCigSSPTJIoq7gvDoH/QUvc3TWhM=;
        b=RaNgN0zxp7rCfRVmTK8yZzriqj9m8SjO+BM1HYPWNLPWbWOKXf/J413/dIitRQzrAr
         cF3iEU//awF8LFEsiNwbHRvpaR4bvYWFirzQZIuvaNIBeA8Hmw78eHrKEqj9XVftcil4
         0JualTHpxH2jMrvCT9u5a8Dm0xQRR3osBLnZ2pNyzrplju7nSQ0FTxQsNscYwRLm8L6s
         1Eyiq0o9yC7BTqkQA/yk708UtnZ5T1dQnJ7t9oumd17qij54+FdLvOJsuDGAeKbBIsJf
         LgHvroQVwQ5L11kU4CS6tCAGRomML+MSl08AP3fkKSVD6pvNRR0HwVB3RyLoCGom8BMI
         dCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783945934; x=1784550734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qWIlou6pGXT2W8CUCigSSPTJIoq7gvDoH/QUvc3TWhM=;
        b=IXsqsUST8Soqa7dPirJMuDdPKRdGCexaje/3IsVgQLc5U5ITUaB9D/wDhZkhQPN2fy
         Mg/c4akVRd2uxGJA1GmdUcmzBu65cJOg9+aIVBgMh6MaZvP4Ab0ZXt39Y1P4j6aw9w+7
         csfS7r2Kmeonn9KkYZ0Bu3+XMoBmbLCgyi5nhvy+4ocvHUAIDAydpzuDkEwXvD23bDx4
         6wLQBu+ukwk+o5/wC7q2LspCMTF+oVyq3zfJVnQzALLwKfsr5LIOS7My1a0vlzennD5E
         MGCJTPApj3yXoG/YMquwj9dM1B/4byDkSiFEcICFzuQmh2+D8S/5IPg9PLYQr84cEbTc
         SslA==
X-Forwarded-Encrypted: i=1; AHgh+RpdY4apy9mPKB/ddj6bHDSgI46w1nHIZMuI6cc1i3Pv/uL6irtKS4MmAFtv0kc95X9YaJFADHaFqSWP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96aoDzxtmgvtdG/JLViYDyxCwrsGVfALxq5kKREpglSipKecs
	DQtjwmjJF3dwElXnckfeX4nCU1bInXPA7MHdT8UBoZy+oFd5ZA+1zfwhvImLRA5IeCnFddGtBJh
	RXyLa
X-Gm-Gg: AfdE7ckwRdLoJuEsXc1xLzS5i/xuOYlP45KmvdlAxZjvfGsEtMEIswEXmYodxJCzKBS
	C8Q3zGptS6T7vE+Q/zZv+9123AQVUa8ym7BLcqidZxRNIajc4S/p5yjEtI0DJx3TGFAHS4+nUY7
	pn+ftfZicjRCfAEFOhk4oSlIVreA4RGyoLN5Z4MYzuizhOry32nGNHwGj83dKCPr0GFuJoqm9A3
	6fM7XF/s6+Djr5gqA6jGz5ZXWX4cA5L5EJnZfTXVr9tgzL3SeNcQ7SyfrIplS7SvDfEmqlF7a05
	flurCS6KLmWkTO42Fdajk31l1GymmejEMjJTsckr0lClZf1A9ouc7kr85ptcnmelduKgL6luaO8
	A1zBc672OVWEa4+zbnH9WV9qxaJxs6AsOY60WjbDGI2ztXvfrW7vCW7L3v6VSvbm5n+oO5lgjsO
	LJzcXnNeUITaM3bLJ01H+bNQ==
X-Received: by 2002:a05:6402:2345:b0:698:6084:db7f with SMTP id 4fb4d7f45d1cf-69c5ef9b963mr4310709a12.10.1783945934103;
        Mon, 13 Jul 2026 05:32:14 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm8025465a12.23.2026.07.13.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:32:13 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:32:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, 
	mkoutny@suse.com, Alexander Gordeev <agordeev@linux.ibm.com>, tj@kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, hannes@cmpxchg.org
Subject: Re: [PATCH rdma-next 02/13] RDMA/core: Handle device name conflicts
 when changing net namespace
Message-ID: <alTaFHqRYVikIHw0@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-3-jiri@resnulli.us>
 <20260710095627.CDAD21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710095627.CDAD21F00A3D@smtp.kernel.org>

Fri, Jul 10, 2026 at 11:56:27AM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [High] User-triggerable WARN() during concurrent RDMA device unregistration and netns exit, leading to DoS on panic_on_warn systems.
>--
>
>--- Patch [2]: [PATCH rdma-next 02/13] RDMA/core: Handle device name conflicts when changing net namespace ---
>commit 05c3f87e2143d43f2f1e27d0f13e1b1f97f35bab
>Author: Jiri Pirko <jiri@nvidia.com>
>
>RDMA/core: Handle device name conflicts when changing net namespace
>
>This commit prepares namespace moves for per-netns names by checking
>user-initiated moves for destination-name conflicts before disabling the
>device. It also ensures teardown moves detach from the exiting namespace
>even if fallback naming fails.
>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1160,8 +1168,17 @@ static void rdma_dev_exit_net(struct net *net)
>>  
>>  		/*
>>  		 * If the real device is in the NS then move it back to init.
>> +		 * Provide a fallback pattern so a name conflict in init_net
>> +		 * cannot make the teardown move fail.
>>  		 */
>> -		rdma_dev_change_netns(dev, net, &init_net);
>> +		if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
>> +			ret = rdma_dev_change_netns(dev, net, &init_net,
>> +						    "ibdev%d");
>> +			if (ret)
>> +				WARN(1,
>> +				     "Failed to move RDMA device %s to init_net on netns exit: %d\n",
>> +				     dev_name(&dev->dev), ret);
>
>[Severity: High]
>Can this WARN(1) be triggered by a concurrent device unregistration?
>
>Looking at rdma_dev_change_netns(), if a device is concurrently unregistered,
>the refcount drops to 0 and the function legitimately returns -ENODEV:
>
>drivers/infiniband/core/device.c:rdma_dev_change_netns() {
>    ...
>    if (refcount_read(&device->refcount) == 0 ||
>        !net_eq(cur_net, read_pnet(&device->coredev.rdma_net))) {
>            ret = -ENODEV;
>            goto out;
>    }
>    ...
>}
>
>If rdma_dev_exit_net() runs concurrently with device unregistration (e.g.,
>module unload, PCI hotplug, or link deletion of a software RDMA device like
>RXE), rdma_dev_change_netns() will return -ENODEV and trigger this warning.
>
>Because an unprivileged user can acquire CAP_NET_ADMIN in a user namespace,
>create an RXE device, and race netns deletion with device deletion, could
>this be used to intentionally crash a host configured with panic_on_warn=1?

Fixed.


>
>> +		}
>>  
>>  		put_device(&dev->dev);
>>  		down_read(&devices_rwsem);
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260709095532.855647-1-jiri@resnulli.us?part=2
