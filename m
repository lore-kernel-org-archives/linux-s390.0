Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1530C63A
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297228; cv=none; b=Q1c8jkxcGZ4LYPhnYZDwX3S+FeChjvapH31WlOtdR9gl6R9vKDFn4NrUP815K3mqbn1PePE5AWSB21yj6yBPHig/D9jl8S/DVHkJQRvZJcI3cxOiXnZasF/mnXmy5Fncg5aN9+Tutj+ujv+cZ5eW6ana8Z+Ivote+j1ti04mYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297228; c=relaxed/simple;
	bh=niIAMeWp3sfWWDNS+nr3CeGnrS7IWhMy8sB3hlByAiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW2AxXYws1KQrgTtugHJ1R/M6HRZhmQsJDy7/EVPJG0/74/EnVWazipcpy+sdclUrqaJpJUmewdjmsS0S+laZoZ9UjjvsAApultWE1o0+dd6IoB2OXZxoe7WNgvjBLrlnef+cuVrGg2UZmpl7lGocV/BMYJBO2Sr6lpO+xg9ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=lBEjWvle; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="lBEjWvle"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so34241335e9.2
        for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784297222; x=1784902022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZBETXE+xVYVuA7yrbznrJ7UH+vvhmgnrffSRGRbFAk=;
        b=lBEjWvle4JN8W3vlFNMxKG2/vo6vDR+qW4qJgrRaYEQNIlwy4Wjz3y1uzeAbB0zbZ+
         f2SR1UBVJl25CG9SfqyeTe+OaPgBG1wpJ11VSjHTjyNYKW7Xd9RK7kyTpqXcEqeaZpId
         H/EZCwDF/Ue96hx8XGxaNxDnscOnJbw0cEyLvcgtHlawCoFp8nXpc58AVmZnRyHFV9B+
         pIAPUVqorPG1ObPFPr49bAq7yHcih5mUIXNJK5bcQ4l+tyHGTRPBCUJfYCs4UgPAP1qf
         p5eBjoRnKwoisHpOS9qtHw1a2viQuacelbHcxM4ZvwQ3vByGj3hlt6R//Y0oKBP/zRi9
         +N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297222; x=1784902022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ZBETXE+xVYVuA7yrbznrJ7UH+vvhmgnrffSRGRbFAk=;
        b=fKjTbgtG2eQ3wM0bb3Hxi73PfgHiLFEwp6fjW+kElfzhJ7FIO3wjxr8F5QcXGMXpMk
         H6fyu5BwIx0FFhuNk4XYWPWVlAQ1LufCHb+EGkKN5pGXQG3aHPnY/8QcBQ0Q67rx/Cty
         ju9mAq9PAnLKFfjYP6FxBjsQc8whDoiZguIu60gdewWQixxggpbL2UXhxbc2nigVlzRk
         TUBmAhKcDiCurI3cGQ5+o6IDcNbu+nC3yL2eeCrQFD2Ge1Eob4wyU/UAiBk/4zXw+IdR
         SMSomo4JYiMmTIY6Tu3tZdquYazYxV9PHi4g3cqts8DFbwpfR4zRYZi9jnJiRigSI0fw
         5cvg==
X-Forwarded-Encrypted: i=1; AHgh+RqPkjDHAOD46BZYzc3ojDcGLAcaaZKuhehAdbcxQ5bPVL6QAIw1ilKzYa962oqHeMG3bU/b36CAPQ0X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xnscQI5qewJHoYeJg3AHdNgdWAhb1wmYXofne/TVhNFhZlBg
	vTYQu2uZu3QZdO8kL/BWp1R3gg+2V0ycyXabTUrlU5EEvs0dfLQ3wKNXrp32BwoV4B4=
X-Gm-Gg: AfdE7cm2PxHuV1BD7PwIC7hnOdsX5jFJOljgKzPwnHV4+sTxNHs6w3MZUaTyBo3fZtF
	VWSqwDriyo1CJ4yYqoY8ra/iJiPFzoQiVwFmsB81c0QKDaIKGZEWCpaJ7MErFLe7Pp/vQWdBS3O
	nmrKHGATTEmLyXQX2ZG9KIKSoFZKtfJHpCnVaKyG5byhmdNJyE1U3SXBg/DR6GTPX4SUIUb14fS
	RnfPyFOkG0qw4teHz7/pLu7MD+tj723T20ZbkOI1chy4F9u6x81lQxgroGD5+jwHL9vW9+CdmEN
	jdzIslnaT9tcSeZw4wDAWkPZwN0x5XVu4cxKpfCI1flu4Su+RSGlbXaTdS32vOXLzm9/Bp3K8zq
	SiM0j+mms4IDp5NostN/tYiEe6U/VOYCTkewUIETj/HooxwvG2WOLUf+6JEijpboGmG1vxyOsOj
	96hSUXSJ+8mz0=
X-Received: by 2002:a05:600c:3553:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-4954a50e75dmr34323345e9.27.1784297221977;
        Fri, 17 Jul 2026 07:07:01 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm53164435e9.12.2026.07.17.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:07:01 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:06:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, 
	hannes@cmpxchg.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next v3 02/14] RDMA/core: Handle device name
 conflicts when changing net namespace
Message-ID: <alo27vVuMMAb303f@FV6GYCPJ69>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-3-jiri@resnulli.us>
 <20260717132424.DD4661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717132424.DD4661F000E9@smtp.kernel.org>

Fri, Jul 17, 2026 at 03:24:24PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
>Pre-existing issues:
>- [High] Skipping device_rename() during namespace teardown fallback leaves the sysfs kobject tagged with a dying namespace, leading to Use-After-Free.
>--
>
>--- Patch [2]: [PATCH rdma-next v3 02/14] RDMA/core: Handle device name conflicts when changing net namespace ---
>commit 8e5328bda494a60bcfbc9c96c81fb95f503e0fdd
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/core: Handle device name conflicts when changing net namespace
>    
>Prepare namespace moves for per-netns names. Check user-initiated moves for
>destination-name conflicts before disabling the device, keep same-netns
>moves as no-ops, and make teardown moves detach from the exiting namespace
>even if fallback naming fails.
>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index de610f52c9b23..b55fb075d0aef 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>[ ... ]
>> @@ -1704,30 +1778,63 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
>>  		goto out;
>>  	}
>>  
>[ ... ]
>>  	/*
>> -	 * At this point no one can be using the device, so it is safe to
>> -	 * change the namespace.
>> +	 * Recompute the destination name under the write side of devices_rwsem
>> +	 * now that the device is disabled, closing races with a concurrent
>> +	 * registration or rename, then publish the new namespace at the sysfs
>> +	 * level.
>>  	 */
>> -	write_pnet(&device->coredev.rdma_net, net);
>> +	down_write(&devices_rwsem);
>> +	ret = rdma_dev_pick_netns_name(device, net, fallback_pattern, buf,
>> +				       sizeof(buf), &new_name);
>> +	if (ret) {
>> +		if (fallback_pattern) {
>> +			WARN(1,
>> +			     "%s: failed to pick device name during namespace teardown: %d\n",
>> +			     __func__, ret);
>> +			write_pnet(&device->coredev.rdma_net, net);
>> +			ret = 0;
>> +		}
>> +		goto rename_done;
>> +	}
>>  
>> -	down_read(&devices_rwsem);
>> -	/*
>> -	 * Currently rdma devices are system wide unique. So the device name
>> -	 * is guaranteed free in the new namespace. Publish the new namespace
>> -	 * at the sysfs level.
>> -	 */
>> -	ret = device_rename(&device->dev, dev_name(&device->dev));
>> -	up_read(&devices_rwsem);
>> +	write_pnet(&device->coredev.rdma_net, net);
>> +	ret = device_rename(&device->dev, new_name);
>>  	if (ret) {
>> -		dev_warn(&device->dev,
>> -			 "%s: Couldn't rename device after namespace change\n",
>> -			 __func__);
>> -		/* Try and put things back and re-enable the device */
>> -		write_pnet(&device->coredev.rdma_net, cur_net);
>> +		if (fallback_pattern) {
>> +			WARN(1,
>> +			     "%s: failed to rename device during namespace teardown: %d\n",
>> +			     __func__, ret);
>> +			ret = 0;
>> +		} else {
>
>[Severity: High]
>This isn't a bug introduced by this patch, but does skipping device_rename()
>during namespace teardown fallback leave the sysfs kobject tagged with a dying
>namespace?
>
>If rdma_dev_pick_netns_name() fails and the code jumps to rename_done, or if
>device_rename() fails and the error is suppressed by setting ret = 0, the
>kernfs_node->ns tag for the device's sysfs directory would appear to remain
>pointing to the dying network namespace.
>
>Once the network namespace is freed, couldn't a subsequent sysfs traversal or
>lookup calling kernfs_ns_id(kn->ns) dereference the freed pointer and result
>in a use-after-free?

unrelated to this patch/set. Ignoring.


>
>> +			dev_warn(&device->dev,
>> +				 "%s: Couldn't rename device after namespace change\n",
>> +				 __func__);
>> +			/* Try and put things back and re-enable the device */
>> +			write_pnet(&device->coredev.rdma_net, cur_net);
>> +		}
>> +	} else {
>> +		strscpy(device->name, dev_name(&device->dev),
>> +			IB_DEVICE_NAME_MAX);
>>  	}
>> +rename_done:
>> +	up_write(&devices_rwsem);
>>  
>>  	ret2 = enable_device_and_get(device);
>>  	if (ret2) {
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260716132316.1495242-1-jiri@resnulli.us?part=2
