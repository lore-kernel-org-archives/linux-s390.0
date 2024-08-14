Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47483F9D2;
	Wed, 14 Aug 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607902; cv=none; b=Tp+izhTmfc/qaTPOUMMO93qU8RGHnvcNqTzoKNoWpjvp+z2/nYLoEkecWjsoJ2jvJVTzSfBfOeEvbqIxgHOUtJELuB6KNqeZy0IOvEV65QU5YrYPofGqwmW/dn1XEeCJdyhiFcli0n0K6/O/n2oizw5p0uaG6vo/XDS/I5qelm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607902; c=relaxed/simple;
	bh=MywvLjGFnu0PuDALyBiz0zB7O/S8FusLCbWrv7VDYL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+Km/49tR1pJ40QsNwoyLkz5GOFhYpNm1QgVtJLjNHtkSX8hMP1P+yxtC1ZsI0B8JpcpyVK5FSsCsauXxSBRk9XFmTzZS9iPXw/LqpFNVMpVfovFPHKQy1bwCdpvXseLP1VaiP+tTkIK+Yj8JRB7/gj1JQkRkiNvibK9l/Dxdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9vAQxMO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9vAQxMO"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db23a608eeso4432917b6e.1;
        Tue, 13 Aug 2024 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723607900; x=1724212700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asVqmMHKTJYyqQNuXxax/chZqdGHjEmq/OlhVUVNg9s=;
        b=k9vAQxMOrv4euQtZ6hu/1TE9aj80zeKQXIod5v7GjaTxaOytBn+3giqgBzrwmG+H4a
         UreCxgxJf95FDzKTQ+oO5rU1kc6qn6NtBm99/dJlwZhD8BCDzwReSMyyPN0caqSCQIlz
         EAMqOiDQpJkwNVa2qU0GtyD5uW3r/5dMXy0Ueq4qsuvWJXeZkxKavIkAC+id6iFiivWn
         WRcfs/aZjY6s8zEqztbS9fOla0Jle0nukbecc0oCf+jnkrF2EfYz/+dkCDrMxbMjFxbu
         Z5Hp7pTNlNce3vKbDbQAxxoStALfCwVPmgXa54mBCHhUaQdLdfwtZIA7xea7ReLBBoiI
         lgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607900; x=1724212700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asVqmMHKTJYyqQNuXxax/chZqdGHjEmq/OlhVUVNg9s=;
        b=t62/ZDiunrW53xhsW71CA1qlyfbJoSdo6xh+4t7YhSw/i23RSkFfCb1ebQdGgoVdQ/
         fYnuogAJRyQV+FkIEbc2LtafYBm2LmTJdY1hxWAv6ErkP+tn7vOYkqcwm+X3T2YimbrJ
         BrIL35dNJPRgrTmrtSPIcZBE2d5w7YRa8bO0FywW0wNmdK5XqRma5iyw5HAwyv19lxAE
         menx7IhVmkUimjz9UUzi5MTJfWxz4rtFFj1NVumS2A85mZ8mieSfIgFjpvyfAIeCQNA4
         uTVBnG9PFj83UrhAR/e49tQFQUMWJ0uh3DA9XLrwLVSGCGbxvHYEWWPWYDRkuBPN8RDK
         bAlw==
X-Forwarded-Encrypted: i=1; AJvYcCVOZN5qe+uI+6WRYPWt3Z801BSoBqbl7KeOQJ62trjOgV4SxSbrwub1vDhM923FAC9Q1hr5ZPNuwBgjlXI=@vger.kernel.org, AJvYcCWkiDHdl0WlMhGxZuO5eB4740TmgfGksZbqkphu+Hv0pUlrrWZffnhJq+uI97dqFvdRpagdcreR@vger.kernel.org, AJvYcCXN0TQtX+339tuW2uHCFMpln0Sjrnwv7sAYWdm6qfhhUwCQEFsFusHu9OhhjmrVT8K/TRocB9eOdJ67rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfgnNEItvp8oGcSWyG6HFm1oeCzoa2b+PuF2ZzTM54ygQfBzp
	0A15JkStbgzraHOUneFXjSYYqBdxLn4ryvHnGs8puKlk6sqT/NEA
X-Google-Smtp-Source: AGHT+IG6MR8kpk2Z2A693IQiXuZjNyKq/lYek8L2cI0UvC7yGtFnaJXFtGVMHtZM0HwEudIyv5AbFQ==
X-Received: by 2002:a05:6808:1707:b0:3d9:1f05:845 with SMTP id 5614622812f47-3dd29907957mr1598986b6e.19.1723607899705;
        Tue, 13 Aug 2024 20:58:19 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a72c69sm2221137a12.83.2024.08.13.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:58:19 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: alibuda@linux.alibaba.com
Cc: aha310510@gmail.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	gbayer@linux.ibm.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in txopt_get
Date: Wed, 14 Aug 2024 12:58:12 +0900
Message-Id: <20240814035812.220388-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <56255393-cae8-4cdf-9c91-b8ddf0bd2de2@linux.alibaba.com>
References: <56255393-cae8-4cdf-9c91-b8ddf0bd2de2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Because clcsk_*, like clcsock, is initialized during the smc init process, 
the code was moved to prevent clcsk_* from having an address like 
inet_sk(sk)->pinet6, thereby preventing the previously initialized values 
​​from being tampered with.

Additionally, if you don't need alignment in smc_inet6_prot , I'll modify 
the patch to only add the necessary code without alignment.

Regards,
Jeongjun Park

>
>
> >
> > Also, regarding alignment, it's okay for me whether it's aligned or
> > not，But I checked the styles of other types of
> > structures and did not strictly require alignment, so I now feel that
> > there is no need to
> > modify so much to do alignment.
> >
> > D. Wythe
>
>
>
> >
> >>
> >>>> +
> >>>>    static struct proto smc_inet6_prot = {
> >>>> -     .name           = "INET6_SMC",
> >>>> -     .owner          = THIS_MODULE,
> >>>> -     .init           = smc_inet_init_sock,
> >>>> -     .hash           = smc_hash_sk,
> >>>> -     .unhash         = smc_unhash_sk,
> >>>> -     .release_cb     = smc_release_cb,
> >>>> -     .obj_size       = sizeof(struct smc_sock),
> >>>> -     .h.smc_hash     = &smc_v6_hashinfo,
> >>>> -     .slab_flags     = SLAB_TYPESAFE_BY_RCU,
> >>>> +     .name                           = "INET6_SMC",
> >>>> +     .owner                          = THIS_MODULE,
> >>>> +     .init                           = smc_inet_init_sock,
> >>>> +     .hash                           = smc_hash_sk,
> >>>> +     .unhash                         = smc_unhash_sk,
> >>>> +     .release_cb                     = smc_release_cb,
> >>>> +     .obj_size                       = sizeof(struct smc6_sock),
> >>>> +     .h.smc_hash                     = &smc_v6_hashinfo,
> >>>> +     .slab_flags                     = SLAB_TYPESAFE_BY_RCU,
> >>>> +     .ipv6_pinfo_offset              = offsetof(struct smc6_sock,
> >>>> np),
> >>>>    };
> >>>>
> >>>>    static const struct proto_ops smc_inet6_stream_ops = {
> >>>> --
> >
>
