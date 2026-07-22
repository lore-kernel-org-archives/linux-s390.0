Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90589339367
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718161; cv=none; b=DV4AT0x+ltGNmatbw8A7Sjl4crWwjYvAAIt+W0JESM9sIdhxDD2JRF8sKMybGHj3jQJhKs7qub4L/CJ8tBRYnm9QU8s8/B1io8fAmffE0zedptgWHbibE0NmNVhUQVr58kzzVCCLaL198mu1SJGI5w+5yQY76N26gdlUxmbVWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718161; c=relaxed/simple;
	bh=PoWrgcilFVeYgz1LhgAuDmmYN6nV3HHnRHjqs6a7dyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy7uI5kpKUdG0HEb7lTqezfcj1TI2AB/NYOJ6Sx1o8wtBqAbZpHzAFXhCx7qKg63bJd/STMBqdFBpuZv76H9ft1xR6pOiu78KM8zBWAbIlM1KBWI+sjXBiO8pk7U+PiGRiwaE0rxqIRMn9C0Vt6uJTDoRsPgsTjK3+h/QWOebcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=hjzvHsZh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="hjzvHsZh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so64852505e9.2
        for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784718155; x=1785322955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=puSHlHrcZhn/nHHDjTYsLB+/0H1pwaKLgByKszhMo9Y=;
        b=hjzvHsZhdCO98ljPQmT+Qoy+yZBIbqZeJC4oF9yh3KIA4meLwAAcp46JT+xviyAEyQ
         JejgCUNTvzi8qU7OnzHNKJAk1H3ZW1N1BFbdY2I3C2qO5dHncDda+Stkk7ZthVkR0sWt
         BBnsNGl1Y3OH7D2mX7meIoAu+wzF34L5CMAXNkVnL/tb+9teHCzwJ+VlruoqqZQx5efH
         xfhGU7w8lAqd4EMuvIquDwMMhlOjB2BE9zDmC0j+ebXcz7vJKO2w+mKG4Gu2QbRl8gwB
         Vf4fc07/7213XT1Vk0q+S1tnLgaQwhELc5dCnC3rV8RWyzs/GuYy7oXhuuxw/GkpTY+N
         zI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718155; x=1785322955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=puSHlHrcZhn/nHHDjTYsLB+/0H1pwaKLgByKszhMo9Y=;
        b=rlVduppqExQbCq/TTwCzNDXoXeQWtCSXALM705ZY8KN5aMz5SyZUREDpHRiwlddNVP
         Sd4Jrjqm1Kyw/+kQCasqeFBLJ4erYZGoUdXrNTe3d881+x9y0ZKbSHxLI+pHYvuHF5Mo
         TKbmie3sidQsGLRYSwcXxcz179dbNcQaJm/m9oM7VH2w+s5MuiTjw+fu4fyZ7hzSkdC+
         pEgAR1RsuKUiDLkuTuvbINK/dz4seqIw67FqQ1kXbdP/6Cs7HRneHyRW+QA2O2nDsiS0
         OtGkP+TF1vs6icFoETb/uxhwAGzFTiGPlnZcAk3d31TBBva3Zw0zLgdzY7tTesLQzmiC
         0lpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4iE7A++T6svddWGocGozT1n+861f5th8hq85PsGnzeoFBvYk4IrjmhSQp409lH9xWyOgKqRWJk3Rn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhtx5bwIvhdpLdW9GGoT3jmdLVCjqWy+KhmLfa/puluuhqlmA9
	oqiPc/i+wSgc/9Vm54HqPGVwOQwto3rAzjLEQGLynC5y0d0QyzORMJbK71uMgIwiEuo=
X-Gm-Gg: AR+sD10OYQ9pjdaiI0Ez06dhv5w9UosdZD0tn34wpiyDWwLwmjZ8MZ/igrsHFacJxgS
	k/nvLA2CEXYpFqiHrEgK63hESMmQiqPVLHEvT5KIcX6GcJvIiSPMb4uiKZDmPdwQiTLWwgjnISp
	a3GcR6IkszllCEnLuHdCOx8pBP9gm7UGbTplHlnS+VArPwB30HQ+GPEC38R5R0CKDkCBFnRcIi0
	bnC+y3Qc2DGaIa5cU/IpzzZfp581lIVa4dQObMKEkhQDh5NVmoUcgfHzm8Py0+vigHsnZjgzxhn
	ZLjhWRE5e/t85CnN3jxaLyTwUKYo2ZBuX/CkpXy8BfC84J7cQRQpbFNFq6Ho0lt/oVusbAdx4cq
	onZ1x0aHrwI3pv+xidvLn7c+P/skTGWpHDV/E2imVLKRg34oXJk6YiyMDDiX/oX8A/kxAS/f0at
	K0TtuImLuwm/MYqi9jedpj2A==
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id 5b1f17b1804b1-4954a3d06e4mr247929605e9.5.1784718155392;
        Wed, 22 Jul 2026 04:02:35 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm57223855e9.6.2026.07.22.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:02:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:02:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, linux-s390@vger.kernel.org, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, hannes@cmpxchg.org, 
	mkoutny@suse.com, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH rdma-next v3 03/14] RDMA/core: Support renaming a device
 when changing its net namespace
Message-ID: <amCjGk45wKDz5Z2u@FV6GYCPJ69>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-4-jiri@resnulli.us>
 <20260717132428.686441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717132428.686441F00A3A@smtp.kernel.org>

Fri, Jul 17, 2026 at 03:24:28PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Medium] The netlink handler fails to pass the requested device name to `ib_device_set_netns_put` during a network namespace change, and ignores namespace moves entirely if a rename is also requested.
>--
>
>--- Patch [3]: [PATCH rdma-next v3 03/14] RDMA/core: Support renaming a device when changing its net namespace ---
>commit 65e19be4bcb60d41b06e567081d99cee8fd2722c
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/core: Support renaming a device when changing its net namespace
>
>This commit adds support for renaming a device at the same time it is moved
>to a new network namespace. It allows namespace moves to request a specific
>destination device name, falling back to a trusted kernel-controlled pattern
>if none is provided.
>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 32b6c4d68ca0a..77a7580801486 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -1195,7 +1195,7 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  		u32 ns_fd;
>>  
>>  		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
>> -		err = ib_device_set_netns_put(skb, device, ns_fd);
>> +		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
>
>[Severity: Medium]
>Does this hardcoded NULL prevent the core feature from being reached?
>
>It appears the newly added name parameter in ib_device_set_netns_put() is 
>never populated with the requested device name from the netlink attributes 
>in nldev_set_doit(). 
>
>If a user provides both RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD,
>the rename-during-move functionality cannot be used. Additionally, if the
>name attribute is parsed in a separate block, the function appears to take
>an early exit path, bypassing the namespace move entirely.
>
>Could this be updated to properly process both attributes and pass the
>requested device name during the move?

False possitive. Next patch changes this.


>
>>  		if (err == -EEXIST)
>>  			NL_SET_ERR_MSG(extack,
>>  				       "Device name already exists in the target net namespace");
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260716132316.1495242-1-jiri@resnulli.us?part=3
