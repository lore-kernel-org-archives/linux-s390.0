Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7084C6F0A
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719071; cv=none; b=jlTapngugR9dVH/eQVi8yh5QQc0uOlzeBwxPsRiLmB/Fx6/q/IGuXjm1RREl9SGmu4/kTGHdtH9wKlcKw2dvyX1ecrFGozqe6rFtuR9gRfJhuhpGq1zP3Df7uTnoo+9KwqSA8PFId59/WHK1isLvx6KXEFkrKLSp9MfPwYnmxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719071; c=relaxed/simple;
	bh=YZCF4nH65+6leZ972g2jHzva47IW7QotuP+bNf6aKt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF2yJ5AC54IJO2NZSTOk6sxe8gp0xMlK2neXzs+U0CnLA5VuOvPv/NuRw9Q3jx15Q9WmboiNZLiqj38rLtralkJDsGUzk5HVD3GqKOs+ylqVMb8gY1yYhpwDkZ8b30iFqeH4Ey/pLBLBeFQnlwviKmtQH34iraqVkQruT27DWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ZFzt0IXi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ZFzt0IXi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f7444576cso2419994f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784719067; x=1785323867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQzmdQrHHjzl2TIMLkjd9uZ5aaE+riwTncnOTTjJPBY=;
        b=ZFzt0IXidfCntRTSB8FtweKm/iQddm8/CP4G3T7ED0pqkjoBbQYxRtGPyeI4oyg/tG
         d+lp+kJjTIx/zEpnU4Tz/N97Zr/cI6I8qA3uoWzhLaNqKD0LcAYxAbszWRuPoOPQFGG2
         cT1XM3t7nOpxJ4XSIhb5JLy8iQEDVc2x0U2RUBegHPXZmliU/iO2NYaDQNMsLUjaIEWY
         XON0KrCjUlSne72d16qeROhaF15D3hhGhzqOESy1EiLgB0UkunLoRBxGhGEoHmuKOsbh
         1mvCcdoVXD7MYrs/tsvIPbyMNU3yrmwDJu+ChxlhnjHqm/baKBihPMJYlnpbpLVAK0Cz
         rjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719067; x=1785323867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQzmdQrHHjzl2TIMLkjd9uZ5aaE+riwTncnOTTjJPBY=;
        b=jyJcFOii/D9pucOiT5ZM0zFBmVkNoGaLU00+r2Lx+Ld14l1C3CC9M7d76m1LMrEiVc
         96AuGfQ7ai9GfjO4C35zM5U7NZ0CfVTXw7xltmCzzX8xADt8bs+vBlmsdNoFJ3VYYYQv
         Z3emeiJAyXHgiE3gnPyRaSX6pX9KbFc3qynJXHsyvU6pqWUtiK8S5y90oc8vHfonEB44
         T4ezRSbwyEje91BMwjlxp1FuEZo4ed43emE3qV7JprRBN7quzOCML2PcpwVkxiR47iVo
         2CKafo14JaGoFF73ST9TPbtb4fVu6gnJ9oqNdWdvC+75bmaMyFpF/6QEMrPAeaf6tBj0
         lmow==
X-Forwarded-Encrypted: i=1; AHgh+RoHnFfmgyJQsvkgtJqPtv4+4nZ+2HOfkM+LGq9rlOICERCQRVAqRpTtjKETTAZg7Xl1V5GsyPa50gGD@vger.kernel.org
X-Gm-Message-State: AOJu0YzPzGWb3jb+910PQxwopAZHtZvg0IMU1T27H9PZvhxdjvYRtXAX
	0Bvz/iLSAJv/kpz5wC7eNhddEL3AJVu7AQVFOEVNgp1oQifrOgGWYkwl9j4+YCDDzex30qQNxdO
	cttDH
X-Gm-Gg: AR+sD104CdJKF8+2PvAAQJN5Zj+NhiU3UR8i0VknfNxivzNC5PrVbaCnGki8wLWgyHX
	mL+G/oA7NoIialu1HjDmWPnfbGQghai5G8Qdv94jU8zyqYPNO5D4wScyMXZO9uVR6JU19YOlPOm
	OTRgVAR5UzySf+SyK6qs8ETnrFK6jRaa0br0B2ZM0IgKBdA63SSfoxfvhCQBJJEvDXvzngDy8LV
	jJdJioH/A6IObcPwZrh1f4t5eOqvlEBsiaYvD59BKUZF7MzldRL/TG4TWnkVGZa/cqHUA+/6DZ0
	F4C4HviuPTC5wktoCIE9QLx8EOCYEC9Kn6Ww7cASju3QcVzGwpAre6DsCo8pNz0ICzjjrdhVGBs
	gFjplwRCoI3w+vs7JBZjiZDtqpxJeDNwHhHYjRO8a/dBJxAgB1tc8Oy47Hc+4q1rCo2kFfhO0oc
	uRbbWoOppBydGIrz49oBzpDA==
X-Received: by 2002:a05:6000:4a19:b0:475:f100:3607 with SMTP id ffacd0b85a97d-47f623391c8mr25765066f8f.54.1784719067091;
        Wed, 22 Jul 2026 04:17:47 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6287csm5624448f8f.25.2026.07.22.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:17:46 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:17:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, tj@kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, hannes@cmpxchg.org, 
	Heiko Carstens <hca@linux.ibm.com>, mkoutny@suse.com
Subject: Re: [PATCH rdma-next v3 04/14] RDMA/nldev: Report net namespace move
 errors through extack
Message-ID: <amCmyqEQaMgJrtg5@FV6GYCPJ69>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-5-jiri@resnulli.us>
 <20260717132425.C9FBE1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717132425.C9FBE1F00AC4@smtp.kernel.org>

Fri, Jul 17, 2026 at 03:24:25PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [High] The newly added feature to support renaming an RDMA device while moving its network namespace is inaccessible from userspace due to a logic flaw in the netlink handler. Additionally, providing both attributes silently aborts the namespace move.
>--
>
>--- Patch [4]: [PATCH rdma-next v3 04/14] RDMA/nldev: Report net namespace move errors through extack ---
>commit dd68e4a951ab0b58504bc034673213514633a1a1
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/nldev: Report net namespace move errors through extack
>
>Thread extack through the existing net namespace move helper and report the
>main failure reasons from the core path. Keep the existing move UAPI shape
>unchanged.
>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 77a7580801486..8648e95700bfa 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -1195,10 +1195,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  		u32 ns_fd;
>>  
>>  		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
>> -		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
>> -		if (err == -EEXIST)
>> -			NL_SET_ERR_MSG(extack,
>> -				       "Device name already exists in the target net namespace");
>> +		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
>> +					      extack);
>
>[Severity: High]
>Does this logic prioritize the device rename and exit early, preventing the
>namespace move from occurring if both attributes are present?
>
>Looking at nldev_set_doit(), if a user with CAP_NET_ADMIN provides both
>RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD in a single message:
>
>    if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
>        /* ... */
>        err = ib_device_rename(device, name);
>        goto done;
>    }
>
>won't the handler process the rename and hit a goto done; silently skipping
>the namespace move? This could result in a success response while leaving the
>device in the old namespace.
>
>Additionally, it unconditionally passes NULL as the name to
>ib_device_set_netns_put() in the patched hunk above. Doesn't this render
>the rename-on-move functionality completely inaccessible from userspace?

Both concerns are resolved by the follow-up patch.
