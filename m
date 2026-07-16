Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DD393DC7
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186336; cv=none; b=LCV5v314nQVjGBSJ9p2lR/vVFztYKK/gXAASvOpXcygPM7tcaL1uzsJKPfSXLgZ35ZUtm2vLxuu/g4xI4povn1D/UMsWQVPMmWv3Z0ATR+I9zd/T7Fx1qJixjk45loFsQUGFSvvzeyYYb0INdQxhoViWkn3b4U/nibBSO9dWdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186336; c=relaxed/simple;
	bh=8nnOASWEJf9wnFPTtpSZl+pGkbaX09Rm/eaNCoyaCSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izKGMbmK48Ps4KboIdQxyFDJEUKjmzptmS2hR/wmEiFInRfMjh8EPhqPt1dwq9c3v8senV5Zctv6QxWd2yLAp3gF/PLc1qCK7ihpQB/ssJ/bKe65QghwUIBoOh02ojKw82g0xy5vflNt8u1PoYh0Iym7ZHsMwtfrJYKin1Rosq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GPkCsYNY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="GPkCsYNY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-475417f010dso3113461f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784186325; x=1784791125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DeKdX/3Smbb9NgVSq5evfrMeYX1J7raVEFT32QHvpg=;
        b=GPkCsYNYLtzT77idlPCVYSFXSm7ucfl2UY7e/4w28dTyIyAUSUPL4BLTShedAwYKQT
         G9K4X0N8MxDhMX9OA3kI1+9kgAbLOcFlxTbBfvKr3dhQzMSLG0Gp6YcdaFkp5JMzbRsb
         gPISJEq1zvsv9xekEMzM6sPfmuTEm5Qg90Q1iZn+ivQvZAizAwLfnj9cFrPPet9wmT5n
         U+RQehVLD/oT56HJ0szt6xH53avnsUZsJEuUtYO3MKJjwBLjTk5fVNAe+rahXOMMpnG5
         dTRckfWKdgnKDdYX18h9wMpibKixkMupcQIjL9ivQaTEuvTyPzT/C4ZRKoxSikQo7Xi5
         pyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186325; x=1784791125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DeKdX/3Smbb9NgVSq5evfrMeYX1J7raVEFT32QHvpg=;
        b=LHxuGTee+OzaiM9PMwPI+bqr0IW9XmKZCcbOh8XdMp1n8Y9SD6hUStcqnfrR7u5kur
         2bwWLsRkbCjKZ+LsuYkco3m/ISCVvWVkqPU7vEtGpgIFKI4ukCMZhUardqSr/B87k7QK
         9NRebFfZE3SzGlbznZGw5GcE1+5vMhm/pJspROWgIzUkHBqGxs7KZC5r/hldYwAlik+g
         P2tHsPTSgQ1KUc5x+R+bqFE1AzzhkCLMt3cUL/8W+U283oK4lLOk5lvM4LNuPWFqUlaq
         LZDpdWzc8tOV3hv+7b+RwR2lueQipaCeuacsnhKKkhaD8Sgy2Sq2N3JJtGBMus80ffg/
         IfPg==
X-Forwarded-Encrypted: i=1; AHgh+RojufRTvkESsc3y7dTgL7oaqPxgPRbCnL5yLjznVZgu4zCQyw8HsPCQVk2+tpN5k63uPhwflPQwexvv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2qrz83GlHYo7ZQ3RFYkRuUai/vxGQoGsJkYig2t8v+C1x4uL
	2AXgGY4Pn2monC/+coeUAscmLgW1Yvs5kY0e6jHfUgLYLQFidzfOnFTIw59nljXxqao=
X-Gm-Gg: AfdE7cnPMoQArlo94y7jk5m0ORVxry4RdreT7PJ7MLUPqkTFs18pVWfAASXtycgKI0m
	yNt1ogCFh8Lwo4LMx2UPp3buEhuB/8KjaIYdw8PN9sByrsBK6d2xJTHp26Hvt1a1h0uc+GDaviu
	Uw5G9ah5cDN78S7woVE3Bpu5tKhMo4RAH+F3+UZsSqwsR/IqHQWNQZcE6B7eO3e1g8IKQ8ARIhe
	nC0qyVTPeWUDJtLVLfYoqIQpmsBAOO3dB1Bi4nIyGMNMkvLe8wcMvnFu3cKtKncSLuIORx8fu2o
	z58U1RF0xxeOkBf8wG3Wf8fs/FqMIygKQsCyVeUqw4t899o7N5OoXMRy9JtivnMqY5nnJd3B7Ic
	jliBFVeiRL9I2Wr35MWGnF2y1GCjZ8CPCJ0DkegkRCsgQwLs8vI8JE/WIV9MXB3Kc7FuH/nesrE
	WXGtyt3YeuYvs=
X-Received: by 2002:a05:600c:b8d:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-4953c14ef45mr61678205e9.7.1784186325189;
        Thu, 16 Jul 2026 00:18:45 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm23000181f8f.22.2026.07.16.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:18:44 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:18:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, 
	hannes@cmpxchg.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique
 per net namespace
Message-ID: <aliFulxrT8aFLNXi@FV6GYCPJ69>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-12-jiri@resnulli.us>
 <20260715143044.E91711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715143044.E91711F000E9@smtp.kernel.org>

Wed, Jul 15, 2026 at 04:30:44PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
>Pre-existing issues:
>- [Critical] Format String Vulnerability / Arbitrary Memory Write
>--
>
>--- Patch [11]: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique per net namespace ---
>commit db3597c8065e66f96858593e01ba04bca7a7d075
>Author: Jiri Pirko <jiri@nvidia.com>
>
>RDMA/core: Make device names unique per net namespace
>
>This commit updates RDMA device name lookups and index allocations to be
>scoped within the relevant net namespace. It uses rdma_dev_access_netns()
>to ensure name uniqueness per namespace while maintaining system-wide
>behavior in shared mode.
>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>
>[ ... ]
>
>> @@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const char *name,
>>  	xa_for_each (&devices, index, device) {
>>  		char buf[IB_DEVICE_NAME_MAX];
>>  
>> -		if (device == skip)
>> +		if (device == skip || !rdma_dev_access_netns(device, net))
>>  			continue;
>>  		if (sscanf(dev_name(&device->dev), name, &i) != 1)
>>  			continue;
>
>[Severity: Critical]
>This isn't a bug introduced by this patch, but is it possible that the
>sscanf call here is vulnerable to a format string injection?

Unrelated to this patch/set. Ignoring.
