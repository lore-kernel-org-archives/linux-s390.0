Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272A4248A4
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297306; cv=none; b=tQjLMOaqrcUnHvRK9E+8vOch5YyilcMmEWA82hfhXQWHXXw9b/DDjEPSr+a6SktZbgrOXj8wmlJ45NsN4PJkauyjA0y06nFRk81Yj0DT4lVV40tnrVCsbjGf0e+vpQJCiPXw/LJHCuk0vgl5NSkOhvxbHRPuBQ8xH5dUjh4nqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297306; c=relaxed/simple;
	bh=XHrLfrqMhOnwSAqqJE2eiDYz9T7bCK0U/3kXl0cj3MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1lSRK0XAigWUEgQ9UcjT2EKzemXkOjNZBuvK1VrdHq4Y6dSxslNz0KVyToEsF6wFJXAlAniXCzG9oF/pegCA3qAAhdpzPNbDIx2ImKzevqnjyetMJtpyNth9sAk+zB6dj/kn6DEew+AFGYiuC5Llb/j/QnoMiVOKOpoR2LHFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=bKDBbTaY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="bKDBbTaY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso2984615e9.3
        for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784297302; x=1784902102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDShIOzPBvzJyBY084ZK4U4pFvb4W0NeDIeOEkdFeUI=;
        b=bKDBbTaY8uLvW8o/VyW0tIbKMaQLLD3mE2Sc3KEd5p1yVo9QhLjGIeCByR/UiIUIBS
         YkH4r9NGmuMbnM8AuLHkjzdSdrF0QdWzS+o5zzCyY/2MaqkSgssM4N0SiKRE/0gRloZt
         Z9ZKV8Z4Ekp8dSlzjwAGHa4lpOeKrPlCcpms4lFj7/nZys/8pBVZGnQZ2N3fYIVUiAsU
         pCLEfd+HSPa5iIU4Ptl67eqlEKZqFFOd+5QruIZzJCeJBInz7BkO0m79gD2V8/6DrnHM
         pk+AXmX1nv88tr5P8FiFThj+wLfoYtlYeDxtMT66+oCeacwij3y++nuJ3WW0Oo6Du7ia
         QKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297302; x=1784902102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gDShIOzPBvzJyBY084ZK4U4pFvb4W0NeDIeOEkdFeUI=;
        b=GHigho1eKiPU0MgjaxLS7dRjzGV9ewjEjPhEtNgJ269v7KwgWO3iEN4uZa3jt8Pya/
         jZ2GWfkEQdMHvSceQKEaRtTNzLC4K8n8WFqkwFZ4coZR1GXCwKr+93Yv8J7Guyry3r9R
         AwIfNOYIsdYE54xNvZJpESypS/JBuXdaC8BaDNbRhajAsr/ozs8GIv6RZoTW4Y1Gx1D4
         lyrs3v/wG1bQBx5n0tncx/AgzpiQsr1VzQ3oBUTYObj0IDZBTgzHNnyFlrHlrwv1xRMK
         1hNkmyKEBbdUvf9NtnOhSr0W8qrciLpcx/fjASB4yrx2h7TYrMILDZDvUsvN4uwpmK3i
         8ugA==
X-Forwarded-Encrypted: i=1; AHgh+Rqo/UnbgwGdxxBoP54K81FRsEltKQfQvPAU/XLqmDAzYOJYmJAppPrH8oTkzRweIiLKMeqkvH8xwVJH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c2xOdKaewq9Q3CBNfetcfd0ii8S3pDAguAgXZRGrka2l2T/a
	cT7fuBguxxXAtBNX1zWWm3RU4hdoXJp006UWGCateOcsTSmx1KXMWGgdt2tQvGxGCGM=
X-Gm-Gg: AfdE7cmzGtPzrvXumOekgTvnN3yDr6wuqKDTyI8h115v+sYbOF7/oPTvOGzVfV8NODc
	JpSK+jRdrQ/jIwkjsYZrnLwKOhiubIwYOu/s5cQvZBlKWHrOXNQi23D+FoUhFAMTHUOoEx9LABb
	bDHQV6505G04kJnScNgyjD3GGPS6HcqH2cDdDZjYFQMmbMyDTaaZ+SPci8Ro0HpiEWo8X8JoC+r
	ICPD9khrQlJqyEZU/bGSMzevPu4dJq+lOtMr5yj7IJkj29sRJJ1KF2LQOuPvNhQhT0BhbB1Qjlw
	3pqtGSE2XV7FF3biRepZODM8jz6xGhk89x5FI0ljfXdESS/J0qnbMmlLH2O8E73O+oLRWdHW0Zr
	6m3mm5rgwevejtkjpGvmTJls13WJbNKukkIS3Er5IoOmM8wfPG549JZ1GibgTgBLUv2maAhTQo4
	QaPJMl35VVwU4=
X-Received: by 2002:a05:600c:3b91:b0:495:4c62:9d43 with SMTP id 5b1f17b1804b1-4954c629e5emr24722955e9.34.1784297302169;
        Fri, 17 Jul 2026 07:08:22 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c9c929sm48330635e9.12.2026.07.17.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:08:21 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:08:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	hannes@cmpxchg.org, mkoutny@suse.com, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 06/14] net/smc: Look up the pnetid ib device
 within the net namespace
Message-ID: <alo3Qx6ou7ElY6Un@FV6GYCPJ69>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-7-jiri@resnulli.us>
 <20260717132427.82BA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717132427.82BA81F000E9@smtp.kernel.org>

Fri, Jul 17, 2026 at 03:24:27PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
>Pre-existing issues:
>- [Critical] `smc_pnet_find_ib()` and `smc_pnet_find_smcd()` return unreferenced pointers leading to a Use-After-Free during concurrent device removal.
>--
>
>--- Patch [6]: [PATCH rdma-next v3 06/14] net/smc: Look up the pnetid ib device within the net namespace ---
>commit 22bac16fe9606993a05fb72609386eb7b37fed92
>Author: Jiri Pirko <jiri@resnulli.us>
>
>net/smc: Look up the pnetid ib device within the net namespace
>
>Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
>cannot bind to a same-named RDMA device from another namespace once names
>become per-netns.
>
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 63e286e2dfaa8..ff9c9c35cc2f5 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>
>[ ... ]
>
>> @@ -408,8 +413,8 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
>>  	return rc;
>>  }
>>  
>> -static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>> -			   u8 ib_port, char *pnet_name)
>> +static int smc_pnet_add_ib(struct smc_pnettable *pnettable, struct net *net,
>> +			   char *ib_name, u8 ib_port, char *pnet_name)
>>  {
>>  	struct smc_pnetentry *tmp_pe, *new_pe;
>>  	struct smc_ib_device *ib_dev;
>> @@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>  	bool new_ibdev;
>>  
>>  	/* try to apply the pnetid to active devices */
>> -	ib_dev = smc_pnet_find_ib(ib_name);
>> +	ib_dev = smc_pnet_find_ib(net, ib_name);
>
>[Severity: Critical]
>This isn't a bug introduced by this patch, but does returning an unreferenced
>pointer from smc_pnet_find_ib() create a use-after-free window?
>
>Looking at smc_pnet_find_ib(), the function holds smc_ib_devices.mutex while
>finding the device, but then drops the lock and returns the raw ibdev pointer:
>
>net/smc/smc_pnet.c:smc_pnet_find_ib() {
>    ...
>    out:
>        mutex_unlock(&smc_ib_devices.mutex);
>        return ibdev;
>}
>
>If a concurrent device removal path acquires the mutex, removes the device
>from the list, and frees the struct smc_ib_device via kfree(), could the
>netlink thread subsequently dereference the freed pointer?
>
>>  	if (ib_dev) {
>>  		ibdev_applied = smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
>>  		if (ibdev_applied)
>
>For example, smc_pnet_apply_ib() re-acquires the mutex and writes to
>ib_dev->pnetid, and the caller then reads ib_dev->ibdev->name for logging.
>
>Does this same unreferenced pointer pattern also affect smc_pnet_find_smcd()
>when it is called immediately after?

Unrelated to this patch/set. Ignoring.


>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260716132316.1495242-1-jiri@resnulli.us?part=6
