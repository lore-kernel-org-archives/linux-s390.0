Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507B20ADF8
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029165; cv=none; b=UNdn+NffGaG8MZeRwOGzsQZbYqzZyzgxxAV+rRAqBJ5i1I5zVhVvFOF5TFNqptMw4I6vhv574jX8gqClylO3JtNdwN1NQEhQt0mj+0o6yqhDf855uopJYbl1XAvZOq8bH2MKEkSa3bm3JblIOQkrHnkqBwr393AQFBZj6mqubrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029165; c=relaxed/simple;
	bh=JDGlkO80/4eCZ+xaiLytlvS5xjqXuTVj0rvJyW8fk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA/UrnKm6JPj33pReMVHEf5OFrWJI64vSaSAF98zqr+XSok2TSH5Gq6Y07XqWemHMyVg6Qb19xEt1z2+pI2onW3iTqhHIqfBIzfzYugC2VskX/vP+VMK75kS5IwvimMOeWvk59vjQKjAYZ47yYwQfjZ6S+r2de66lO2kPDHDLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=zhTNYRpH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="zhTNYRpH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so3705281f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784029159; x=1784633959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YVAZD/QZRiDNfNtUy5ZL8amdKrMPkHTvglBUm1ucEk0=;
        b=zhTNYRpHngZIR13oxWatl7kCC/5u7DLRypaENSAPIjZRms9qvZjoz4JB4t4zyxtJ9Z
         Xb8iW2h6KmE+HtKWJZ10Hkkp41prUNauB3Ah1RqCSznq4QBxI1BIR8gRSUF8uMIv9Cj/
         Qce200CW42aJzRDqMevBT9Zf/jMdJ502LoKv+pUDkHgtHz0XzYb114vYYMTvtJ+X+iSC
         5lBt7t0AhbIiztG9a9WpIcfIeIplVLl0mwGWJ70MwARlzfRqAYcpS0OiiucDFj0uBjTt
         0VgCajrO9ur+omqJa2xMoPKEjR4YCyCtPSzlkBTay9YPba81i4jVccQk1eVeDGuAna91
         b7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029159; x=1784633959;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVAZD/QZRiDNfNtUy5ZL8amdKrMPkHTvglBUm1ucEk0=;
        b=aC0aXPRXj5UNzTP9+9v2dApG5/ekgXUhC4rHrYP1p7YBh2wPqy9QqX/Bs2G7eQibl5
         MxMcL/dJL4YnV2h3A08wEBKZALaEHkNJE5vfuD7Lny+m7ofGfPybfAD2lSxh4ChY5M19
         rFgTUOb+YZHouGKQ7RozIt6x4FcYjbx9I0VpPdsPBesFknyZq0tNrtMz9dQN10hxY19h
         SxH0JwhjuwnPAjbE49FT9+ymtmokkM1+ratpi1WQyXkNvOLGwz/K8MCBliRG9crOIq5b
         FpRu4vLjciEAW18zVZW0K21xPzei9Q0sir2vSE9UAG7fNL53d9hoVNemiPErnaC8iURR
         sK3w==
X-Forwarded-Encrypted: i=1; AHgh+RpFZK9DQYmdPmHBVGYz6UfVel3R4TdJdXQLuilnNjHthVzaSZEZKyKSNDFBU4zw8zmDU0hXEe6IHkGh@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2X3O8JXPPVliq57mfYl6frSd08u89/RIdkZoFfOaOC7HcazQ
	/xnrwFY0ZfhV7rNMsW3lhCpJZPGq+EOAfJhMBiFwcfabI1IbyJUPbxTOk9k0M9H26jk=
X-Gm-Gg: AfdE7ckDt8T2Y9xsKHmpiBTZUAXr1KRcRwiXfaZsJ3xTYZk/SIqr6y/yyEHC+bIKmE3
	B2LqXsAvtRF36I+CPnjFnWnAOYuvSmroc8XfbuT++7RUpQT/gTWYD8xcl1pW8ObWkxNbe+7Puk/
	fCyBlJjFQ04QbHeEmvF1IYbhdSGMUux4dzZXSfMQMAg7GQEZTEeakxGt18HKnmoQJq2lyhv4Mt9
	KTTbZKGzUWqqmmV6VaIE0COQcre/upnQJlpVuPxor2Vmj2jwn29iflVZhu6L4451QfLfnGm8ieP
	JUhwyM3NGWr0Aukcl7eFJ9GtfD6IB9qeOfa1E/MEAS9jNdmQ5rOlHCW7wzBj/6JdeCHSBWURbfP
	b/Sv2dY/JpaSs5Um72op6QFWYIg1VaEAsBPoiS++K+KGkecY7QI0Ov3gVLr3jkK5UvvDpziQqHv
	YvNA5n6nAKrEunz7Fsaol2hQ==
X-Received: by 2002:a5d:59c9:0:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-47f2dce91aemr14601962f8f.38.1784029159490;
        Tue, 14 Jul 2026 04:39:19 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f47688f29sm5897940f8f.21.2026.07.14.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:39:18 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:39:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, mkoutny@suse.com, Heiko Carstens <hca@linux.ibm.com>, 
	hannes@cmpxchg.org, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
Message-ID: <alYfV5DlIDBw5J3_@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
 <20260710095629.BF89E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710095629.BF89E1F00A3A@smtp.kernel.org>

Fri, Jul 10, 2026 at 11:56:29AM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>- [High] Scoping RDMA cgroup device visibility to the reader's network namespace breaks host-level cgroup administration and monitoring.
>- [Medium] Concurrent lockless read of `device->net` using `read_pnet()` without `READ_ONCE()` leads to a data race.
>--
>
>--- Patch [8]: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace ---
>commit 18e4bddcfb08bd42bef710d6d1b72824d15fa2c9
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace
>
>Track each rdma cgroup device's net namespace and sharing mode, then filter
>name lookups and cgroupfs enumeration to devices visible from the caller's
>namespace. Keep the cached sharing mode synchronized across registration,
>netns moves, and runtime mode changes.
>
>> diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
>> index 5e82a03b3270a..c8b4e3de76305 100644
>> --- a/kernel/cgroup/rdma.c
>> +++ b/kernel/cgroup/rdma.c
>[ ... ]
>> @@ -464,6 +465,13 @@ void rdmacg_unregister_device(struct rdmacg_device *device)
>>  }
>>  EXPORT_SYMBOL(rdmacg_unregister_device);
>>  
>> +/* netns_shared is toggled without rdmacg_mutex, hence READ_ONCE(). */
>> +static bool rdmacg_device_visible(const struct rdmacg_device *device)
>> +{
>> +	return READ_ONCE(device->netns_shared) ||
>> +	       net_eq(read_pnet(&device->net), current->nsproxy->net_ns);
>
>[Severity: Medium]
>Does this lockless read of device->net using read_pnet() cause a data race?
>
>When another thread concurrently moves the RDMA device to a new network
>namespace, it updates device->net:
>
>drivers/infiniband/core/cgroup.c:ib_device_rdmacg_change_netns() {
>	write_pnet(&device->cg_device.net, net);
>}
>
>While write_pnet() uses rcu_assign_pointer() to update the pointer concurrently,
>read_pnet() here expands to a plain pointer access without READ_ONCE(). Since
>rdmacg_mutex is not held during the write, could this plain read race with the
>assignment and cause undefined behavior?
>
>[Severity: High]
>Does tying RDMA cgroup device visibility to the reader's network namespace
>break host-level cgroup administration and monitoring?
>
>If a device is moved to a non-init network namespace (exclusive mode), host
>administrators and orchestration tools (like systemd or Kubernetes running in
>init_net) will completely lose visibility and control over its RDMA cgroup
>resources. Attempting to write to rdma.max will result in -ENODEV, and reading
>rdma.current will show an empty list for these devices.
>
>Since cgroup state must reflect the cgroup's configuration independent of the
>reading process's network namespace, does tying the UAPI to
>current->nsproxy->net_ns violate VFS semantics where an open file descriptor's
>behavior would dynamically change depending on which process calls write()?

This report made me think a bit more about the current approach.
A cgroup may contain processes using devices from multiple network
namespaces, so caller-relative filtering can hide part of its state
from host administrators and make the same open file behave differently
depending on the calling task. That does not look and feel correct.

Instead, to handle device names that are duplicated across network
namespaces, v2 will use the system-wide RDMA device index for
disambiguation. The existing name-only format will remain unchanged
for unique names. For duplicate names, reads will include an `index=N`
selector and writes will require it; ambiguous name-only writes will
fail with `-ENOTUNIQ`.
