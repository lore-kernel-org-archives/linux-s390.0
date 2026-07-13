Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEB340DA6
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945049; cv=none; b=Kfl18/54VZgpHPmIyhInTSQVO7ME6QQeFakE11o++mfaj4f5RDhADYWJGZn66Rn/BgcuxQE/VX93YYuoQro3UlgGQn6g85/spZknj8Z22RE5l5TBYo/RkSVlDh/VNk9Z4tdfctAduFCH521FOdZVvLhhEEzTOBb6MzNDz+tuPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945049; c=relaxed/simple;
	bh=9i51v8tN1xgJRrJ9WSgLuUY1ovtA8zvPwAWbhpfAuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5E7NxQgHd1EnGBtqysShJ798Hz3Iw3K3tAHWKjsK7AYe2HCjrjBFzfyXjaPz89EnimBLS/y8bk8S/nPiEdCswk+rEBO56LGWT6Z51eClJK0/sTd2O+wE9cBtV1jr5iZBMco8Y+mciQuxFmEOD0VHURihGNw4y/iReNiS61nbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=DbjL/JXu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="DbjL/JXu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720f3bf164so2073369f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783945042; x=1784549842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CvvO5eNtwchP3KekI8fxlbAhhKHVpfXdj5FV7ePCzQ=;
        b=DbjL/JXucCyK3/BzK46uOzFgrGD6PTlGbx+yiTU/cv8Vk3kSus0EdKo2OEj+I1nHmT
         JkInym1EgvIw3QUumR+z50c4MjjhTDDkBXkAEpugr6V6zGrXT42Twx5dEgDuBErnEEUq
         dcBZxmGx/oUzs41abts3E1+1fvq5m63Q00Z4O06rNXBpN2esM1itHYJo9fFv7XW5XGIN
         Xe5LzcS05P6Iz1ehCmKxEwQx/byUGAcc3XtC5ltRvjoMVQWgDyLIvKoe9cP+Ko9xUOS6
         qZN4YqCzf0hnK5w81LGLpT8YUWazRAEC4SBcPp/TWFbXdI4QTT0vEg8jnkxOqzvOnD+P
         7qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783945042; x=1784549842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6CvvO5eNtwchP3KekI8fxlbAhhKHVpfXdj5FV7ePCzQ=;
        b=giBo06j2Dsq9fOAFElXAz7YqYC+bY28mb0rctDNfjHUm9t0RjTWIZ7LpQfQd2u8yst
         oz+YHXi0/a5xllefM9VvYQcF1EtdF/JJEx/zk6hIkLEOFgssBqWycrUGxL7AFAY4jlU9
         pjKKMwoAzcBq0byBVV1AfQmVD6w/iqHF0MLSYlROWsy866BwUerWpI+q9B2IPKBkO/0Y
         zgXbEPfQmlDqpf7DDoOs+/f/GeM1NhFs3y9oSYrGk7VNBKie0EZF0c3hQeDv7iJvXrnD
         xO3lHyZYt9HD262iaV+HF43zYS8GgXHmjvoHPS5ZZPKjQPKX62zajoNttA8gE8PeyBhd
         WyJw==
X-Forwarded-Encrypted: i=1; AHgh+RqIdSLp7HaxhVgv14L1jPuaAA8uz19zGuLdjGiHjx90Nj4B+oqnh51B/zSt7zVTAKbP0uH64GyupPs9@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzLTiJ9LA75MB1k3cbM8kwaD6/TWHkCfRZ9GMN7Uz1d0O+aj5
	eVJxZ+YOPf3kHElFesEmUXW49YwP0Epwd21IUO+PpRRbupZSv9c7DMaUAXEEwRKPM3Q=
X-Gm-Gg: AfdE7cnxYcL0LJVZ7eH8RaDsgNwJpQlXSAD3hb1IsM4onynJ4oFZ1xAtTu9NKnjOZSS
	J1NvS8Y5UYiuPEQ2UUObNxk06ib9YNvLtJqlwcVrQJ4rsOYMPM5C7+WbWZnix17oHbqyxyljBVW
	oOcyN5G8nHsdubK+BKft6TZUMk98Lu7YFJRVsSgEenpTP0TOew4TuNZJDp+xy/Z9g/0LQTXDpxs
	Kk5Mq0+sAJ7qkQ8o5T8AsKAQFzXe3YbsA2+/htTUcAyDfBhmy7ZvAoRyIk1jHuUnpSTSpfz+8Q/
	8ErljHIJZV4g55myorECDP0HJ2/lmsCI/dLHewoI6rbpN/WUU9gbo2uWNaJpgOq4w77qVrmJE25
	erdpoxvoKpH8EcgklDGdhVSenwapntkiQmx/ALQl42su8n1qTQECB/nP6vt1CAy9a+qpT50I9L7
	yMjdb5GAZvfBTNsckVeY6iqw==
X-Received: by 2002:a05:6000:2307:b0:474:88ef:cdec with SMTP id ffacd0b85a97d-47f2dc79e64mr11292771f8f.6.1783945042394;
        Mon, 13 Jul 2026 05:17:22 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm85576467f8f.25.2026.07.13.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:17:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:17:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: mkoutny@suse.com, Vasily Gorbik <gor@linux.ibm.com>, 
	hannes@cmpxchg.org, tj@kernel.org, linux-s390@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next 03/13] RDMA/core: Support renaming a device
 when changing its net namespace
Message-ID: <alTXKYuAhGdT_oG_@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-4-jiri@resnulli.us>
 <20260710095626.D434B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710095626.D434B1F000E9@smtp.kernel.org>

Fri, Jul 10, 2026 at 11:56:26AM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Medium] The destination device name requested by userspace is ignored during a net namespace move because NULL is hardcoded in the netlink handler.
>--
>
>--- Patch [3]: [PATCH rdma-next 03/13] RDMA/core: Support renaming a device when changing its net namespace ---
>commit 481a893ec5cd10a7f8be8c8de249d86cc283c470
>Author: Jiri Pirko <jiri@nvidia.com>
>
>RDMA/core: Support renaming a device when changing its net namespace
>
>This patch updates the RDMA core to allow requesting a destination device
>name when moving a device to a different network namespace. It modifies
>ib_device_set_netns_put to take a requested name and implements the naming
>rules during namespace teardown.
>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 3a9ec43a16f1a..3540cb0b9d4fb 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -1194,7 +1194,7 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  		u32 ns_fd;
>>  
>>  		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
>> -		err = ib_device_set_netns_put(skb, device, ns_fd);
>> +		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
>
>[Severity: Medium]
>Does this hardcode NULL instead of extracting and passing the user-provided
>device name?
>
>The commit message mentions allowing namespace moves to request a destination
>device name, but it appears ib_device_set_netns_put is always called with
>NULL here.
>
>How does this interact with the rename logic in nldev_set_doit? If a user
>supplies both the RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD
>attributes in the netlink command, will the code enter the rename logic first
>and return, completely skipping the net namespace change instead of moving and
>renaming the device?

False positive. "RDMA/nldev: Allow setting the device name while changing
net namespace" is doing this.



>
>>  		if (err == -EEXIST)
>>  			NL_SET_ERR_MSG(extack,
>>  				       "Device name already exists in the target net namespace");
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260709095532.855647-1-jiri@resnulli.us?part=3
