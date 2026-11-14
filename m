Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686759;
	b=i2ddRXrR4+Nr/HO9ZwDltLm9+aeHjvzeBBWBl4cMOcROKlUq/cHHoprMRmgSW6UQjXfx
	 612Af1v6gkkI4AXnUvGbsEcAz0y1Hyc+kfKIingakg1IOPfLJD5lbIA2dARuXH3Is0UQN
	 zAtoMUW1r+HXLJF4k4epbJyQEh0Q+dMm6P74igL08iZStq3gdWG+WhhsjBA12Iz3aR68T
	 qhnQHamZirJAY2lZdGckOzS9GGucEdvh6oaZjWE7sHC+7o28y2ptm1BMdEYBofIXQc0Dp
	 3BKMgK5Wbv2ntGkkf5zX7x6M4tkigQlg9QRi7x1aW/2CftbzKtSB66O0/py+nFWYoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=zoaLSs7ds364gxrN7WByIVfu7Rfu1UkimMw00onyIGCN813GUI+BSGhDUUxYuHpEvR/K
	 c7+jMQ5FavCthMj3CD7IvxSIIeR9RI8etgRT8QLuJr4vZK6fTix76LwtQeZGeg+Cl1f88
	 jiER+yikiQ5gLlOyLMnfhHj/muuYjTi81YmIGRjw+FsCaGBm+ERzCvPWUEbYfnMnP15c1
	 0e4eT7gqjclvFu23ypzJwqilJVA57xt6JLTg1rWAyHBrcMqGDqrfEJm8FEItP7YLpT6kB
	 bCQFCOa/xxPfm2UJ7dUHptL5VbjeGrMwlIzykP3v9xOcTNuwZ+f+eszdMjYILOQVnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D860A2604
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B1D860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so814319a12.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=uyG3d2Hid91gT+szA2zj3Xxx16csf5ihZ6VvLnW79bukw6hHJ2OHIujXmxHyNdzLe6
         AHFKOdUy8YLcrx3pHwHXTRrposy3JNveZd/P9dHBbhXTw3QvUh2fcuPMFRxGIcBTc65N
         IygSc4drqQQQGVYZf9J8lAEK9h9AYn5igvmDSxAFrtXiB5d17wnGYFdrrOpEs3bmiwOF
         lOYCXLjD5a7Dpm0L65+HdaBvJf32/uNbYhcul8Nm6fiemEAN4ScBNxPLBASHgJrdZk3R
         VVAa5aVhAZTsN8dGZZSwL0goVaM1F3Gd8p1497m/jpolzCW6e/e+DF97Udiq/n8+fVt5
         Yp2g==
X-Forwarded-Encrypted: i=1; AL+hErHEFgtX9Y/f4tQQ3MuptdqWj5fUlFktzZDZV0cB50kd8WNOEBI1wG3itZ6/PYIzpSws7UXmOY74+raz@vger.kernel.org
X-Gm-Message-State: APuU4Z9ruLoKHkMOp5AiG+zlQVupxcDHfLJiFFp6Mxqmo8utQhuEPQDT
	pVXeX8pTOeryPV+115jUIeBWrJnKOFhjdSmHaBTvl73JUTPq8/UMlEfAB4wuhQzzA/E=
X-Gm-Gg: AYBFou3XYEdBeYhLLAfndqbDZcwV+mQdjTMEwJOWuZ/CHIGwo+znMTH+yvGUEiJ5LAK
	Y81SPs7qHnPSi1VL0KBNX+36YeFdfWv5k33llcoe7L3j9Nxwlq6znwa89M9yBCJKlZAh1IsRRBN
	cKHhc3qSvIunBkkEKrcXy/kGzvMqNMOEEHahyvcjUujmoxTNmsWw48qCjZammq7jCIYkUlA810e
	kK/UmrZPcK6ESkEKZOdv6omPoT14XDgcaEp8Xvqm0a+YsuBsqDKkwG0LNomX0ZGG8sOdgV05RQI
	TAb92TfWCcGXopLY6kvkf7ZhfeHURhA6CDYfd6TLs1UE1yE/BFCZsTfaGsS6g4hwWeL7Qv9NKD8
	N9r0UDAycfN2CopohIdhs7c11YzzCJ4sm1Ttx5xCP3OZNcdboBnB1z75uLiTSxR/6L8RnMYlAJz
	fGiVv0xzOzdT3baB9+uG5t3XZvNb30m91j/zlQY3hTY0Lg7OxKrJSarGvkRoVI4O4hZP5H7OsRF
	Hu5dsq+e34+qMGz7AgsPDImaBiCI0eyMu3LRQG1+GyQt5z2M8nLKBRJCqiQI6yqZ63bpVW3PBHt
	NKW83TB2z4mTgbNu9nDfKTqrKjeTDcVFzaG3ODABUSiYyWX+UtwS/uoAaCT3QSUSCgKSMVys3ow
	iJMfvjdfLWQXR1v0Hj78JKht61tcLHO7GQ0dmkHyPARvteFLs2BKrJ0wXjlVjQuhJS45GgSnBzL
	vwQhWF7Fdbf5KukrrtwnBV97K9wH+uolv0qqqP2XVmRhI3LvU+BRvfFoE/
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
