Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5771376BEF
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186298; cv=none; b=mou8gOx/Htr4o1QltAyXILO4jF8oPLG3BPgcFiHL0hrw+BMI9/V7OxLf/proQv17uGpX4wNPcO3oC2MT715UbzcUN9B99orAryEZJD56nB76+LPLKM5ywG/gsjEGyEj6noUca110HGOh+d8HBgMBf77C/1UKQgqNQAfO/15WPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186298; c=relaxed/simple;
	bh=wCOrf4Gl1Kcl375uPlXE+ALtdINw1fX6Rz+X+UFuWis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCIinNrAWy6MB7y/jjRCVIswEA0dNXvR181rk5YCmvY76G5X4peHxlJ58wstBXb4s2JO/4fkxu5paROIVXOUZezfCYIvSjJVgGgEU7Zlt/NS+7ehORN1MGcqf0iUQ7FYo6lBAftfOezeUX77e/oknv0dRWHMlsW5mHoHr1CTj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=txBfEPef; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="txBfEPef"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso24988215e9.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784186291; x=1784791091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixWQT49fcvwii9ShrrSJHWLi6DgSNOGFoa6xSTGg1wM=;
        b=txBfEPef8qMFPcU042gNwkqbqtrFeAkv/xuSZ0HumNpzXFzgkyruYX++F8wvzJySun
         nmIJOF5V0MK3gf9DfD68NP7VVNDot2epYg3D4TtaONVBQDrhKU1mDHKnBDMXEX1xpVSz
         D6c+iQN/IsNJkIJ/hUZ0TlswpX4/TOyPyVEC/Ie8K0xGK6KuO7HPQhlJqXY6fRmjQfgB
         f/VL1oM8vsFA4Xy49M5Yp9jsr78bzIhSEMEo1tm6go4IDDKLC/efqjzeuWSRvUK+oDjt
         UA6dpP+mARnmeErGHNq8HoTrwLL+RmY8lVuRnkBeqLiTx670kN2E2DIdoFCUTGxQyPN3
         1yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186291; x=1784791091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixWQT49fcvwii9ShrrSJHWLi6DgSNOGFoa6xSTGg1wM=;
        b=UbhL0CmGkWom1DjGJZe/k8QbBRMG749RgjgSq4/VduuJiB8AGX1GI7GeMsKgD0VJN3
         IqqkQwf31EF9VUrf8jEitN1084j/6G4wAKmgKlXoiX7M8Hnazm3YiME5XWiV4oG6dmcW
         YrVW58lGixJfquy5R1Qog6phWevRpBHghFGWY7MmrwZ6UNp8twx6dDvdWspsgfetJOds
         x8o77xCDRwCp2AJsighj5yOPZf3n5J/l9obZjTTCD86tagSmi/zxdnRmq50ZkYKGRY5y
         rTmu28DVwrP2ous9WPJ7afkO9xll3owyh3ZqvJgpHa7vrX3/MIlZuetyCsR1VoSgxRG1
         mAyg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/X8hRH56UyKZHiIPScxa3KB2sulAQwpjGNu69SsJK5xHrImf56v1BVLMd5V+Npt8aCnAp39YP7gaT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0GMdBX8Qy/jJsFdLa8ONjKClIrmVBiBzyBXIobuGUGcXhMyn
	f0qClo3uOuRQ60egLMmIzdh+e0M6/MpT9Ek61YLB2lVk6xWv8JvvZbJWaSMtHZvDADk=
X-Gm-Gg: AfdE7ckzJG235kbjm4VMbLearka7gmvo0fgMPizLRFqWGndvdt2UVfjZOMdZsthh36H
	oA7mC53F6pyHLGfcT28Nus6LAhMaGnf2EJO81kY9KUq9hrn938ZDR0Bm1lfCQZKO4g5CwLiTAhL
	9Q+iKaTJuja0G1fsHDx6lVjgl1NNsvmbkRed6LXaAKfBbN8HtQdQAprvIhUoCgh4lmaLWYbU6qv
	KdMvmypp3NsPEGXJd6clN3dAsbrncpkPDD7NuphzGzB3EiU/PM3CFfYvMrDBKmbMY42/hJ15vNV
	CwOTbWLFcYt3g5GkYE9qXbSEqFJCErqtuNuuoR1Hx7Ris1y/7XY+D6MNRLAxYhuAxuoLdLeLQ2H
	fsW69W8qeWbnH1F4POaZGbU3byZkI6T3toLXh94gUpEFIJlLxBjE/ZVT56vvlAWIrkWifBTR8Go
	mxXl+cn/tcRiI=
X-Received: by 2002:a05:600c:3e0d:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-493f87d6118mr220650365e9.7.1784186290293;
        Thu, 16 Jul 2026 00:18:10 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c708313sm67561525e9.1.2026.07.16.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:18:08 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:18:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: hannes@cmpxchg.org, Vasily Gorbik <gor@linux.ibm.com>, 
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com
Subject: Re: [PATCH rdma-next v2 03/14] RDMA/core: Support renaming a device
 when changing its net namespace
Message-ID: <aliFm7wdxDf-56rW@FV6GYCPJ69>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-4-jiri@resnulli.us>
 <20260715143041.A46771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715143041.A46771F000E9@smtp.kernel.org>

Wed, Jul 15, 2026 at 04:30:37PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [High] Unreachable feature and silent failure in netlink handler for RDMA namespace moves
>--
>
>--- Patch [3]: [PATCH rdma-next v2 03/14] RDMA/core: Support renaming a device when changing its net namespace ---
>commit 4056da04c986796c81666352d7fa9e90d5591d4e
>Author: Jiri Pirko <jiri@nvidia.com>
>
>RDMA/core: Support renaming a device when changing its net namespace
>
>This commit introduces support for renaming an RDMA device when moving
>it to a new network namespace. It preserves the literal-name path for
>user requests and keeps the fallback naming on the teardown path.
>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 32b6c4d68ca0a..77a7580801486 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>[ ... ]
>> @@ -1195,7 +1195,7 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  		u32 ns_fd;
>>  
>>  		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
>> -		err = ib_device_set_netns_put(skb, device, ns_fd);
>> +		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
>
>[Severity: High]
>Does hardcoding NULL here make the newly introduced naming feature
>unreachable from user space?

False positive. "RDMA/nldev: Allow setting the device name while
changing net namespace" adds this.
