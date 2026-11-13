Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564785;
	b=hQRHKa1PaM+5UpE1C+qgSYtyb+Joo2hPC6OmO5J4CBuwONfN8HuiaYIRw03B3KsSE6Nv
	 4YVXSyWaLBFsqIkUies6r6KW+ygsaL9MTSWJROcKWJh5y15Y0fQLmDaKjLzJJjos/MBfm
	 SS/VHZkSxo/FHUXwAcUQ18ZuEqqSq9GwwI3YUpbl5IKZGgQa6He2JwBIBMnCBP793DTQO
	 zeCcijyTJQ1e31ApTuQNp9yYHsWUB9oi1yeCrKlt70Ehec+t0meeKOYSVcBsE8kPVBq1U
	 /OJ3UQXy9MCGV7AfvUcRvXHxoXm9WmgGlje1ozMzkGahcNewjGJrZG1uk4toUyaXMIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
	b=v/2ecnKb77pLcxFO0NzFMtatBVbtt+xRPucbuQvDK5IUS09mAKh/7hpAe/cYMOGk8GkW
	 VIQIhxa4aaEBfHwAltPa/oIe716AnfCZa7jVHDDwh1VtVUWHxn2IUS8o1EN8ONhsFwdo+
	 xgxk1tgZQQFWOCKzxHFrnIcUSbm7xHicOHImebjIb4L7iasInuAi8svV8zwjN2fLtkm02
	 /pC/LN3skrT7vqOy50dz58TGtn+V4Jd4Y/vbqS7GJ3E670T6ZrQWK7Z06JknlbP14PD9q
	 nQvYWdkABet5CdOE80+bwtx/rh1Rab7S+LLA6IH3j9C01PGbB+eC3geWKbEvXPwzbcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C7606A885
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4C7606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so8045465e9.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564783; x=1795169583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=qhgXZLcHEG/xp1ftPxi4Y+VtkR5xPsdZusiH6E7v1UVOpu+pQQwW0vkLZszWZiEzcA
         +BIaLUI7scE4yUL73wk7QDgrWayWPrLwdz+Upaai9wvZdfIC4mpAyM7/MboFd4cm+sgl
         6S6dsMSsgGsAMWrOW2SdAqPT3x/sY2fNDxpywpmU57N6cPKU4MQNdvXTLk3fPNzTNPjQ
         TN2vMd0rw8z+5ZJqFwtlFaNorLJKFpgZtePYZzAG9uux/UTV4iwPxrV7Aluh/WlU8Te+
         mKwCC2bzY5T7ZateqcC/h9wnCcfLq6dmSfmWCE2kpyRSPYXephvqiHzXHW2gW5l+Jqy/
         ZrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564783; x=1795169583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=L+FczDjplP3cozqSFREgeUbZ6g2GHJ3Nhs2qwsKaN7XdnGQk0lPdaLikeVMrooo+NR
         CGxMROu+Pn34b92oMIgQzEIahanMKkCpBBRaXTPjp6oxYgUUTLwfhGoS890v7dZ/V+T4
         lK/bD6LmS7OVKDBY9quqXHbZaEb1Balm7mEBS2GHDZ7w7q6WXQ9n1K/WEFapEJMXmiSM
         6t2wpRZTT6/9Ee9mJSmtuN1xmv/Q8Usi0pqxm4GFT7XQi/kMukCVX9V4WSciubCbiRqi
         biI0Q3Enhiq3/xHqP05GLJVmg2Oo+jlNhrQe1f/72PcBwktKV7/HSZAKCWwR+GW1rn2A
         n3lA==
X-Forwarded-Encrypted: i=1; AL+hErHR0VsLhs/PzNkZ2EYiTe5cQcmvClw092nga2wx2aBhlA4E/tEUocvJqaQ1TJBQP40CSpxeGlKynvgO@vger.kernel.org
X-Gm-Message-State: APuU4Z+0YmTaw9ts/e/0yQYdOX6p753tNUaQkvikHyeTGBSZi/tLv+EY
	Hijf5WFXQuRpmePIRKn0QTKdzYTUU1XuJP5Ut+m3NAJVvqFmuL7kB7dQZT9C61k5C6tW
X-Gm-Gg: AYBFou02uKjIlmtR1AkhLwb5O9Dt7UuFbOYF5T4e2dgeWnYphpYrfvibykqhABhNKei
	q4p7y7SIbMxb/ZSQrURqcmdUYEBDAf65j5cyIhudcgmTrLDWc5zsY2stj7lCiO5LFvI5hzYhCZC
	SoS4sHKfSslWWdcpqI45jds9tqN1QH9F6G5Oi4kbfKfKsZQdfIuRFQZNMornnqUqZD4QbkOTJq5
	o9oR6Xx5HE/1rc98MFcIA+RLwOmzZeYgn3zonlorlLdUgR8Ni5hMQ+5yWflrDBbFSOxOEB4BQSs
	sB4YkysK+PZXuOzSiexfelNPJ/aXdm5TunV2SQOrYsMg5v9b8jAp57l8Bx0BHt4i0/SsYlmyu0K
	h8oHevFcsiA7kDhPoZwIM32DT1NnUiKeHOjegUVoxpVEksMs4i3jmnNFwLHm9Cqbg0DPhMNVfug
	N/8FYBS9+zPafY3fQc4PuEOPDogFVPSeMQ1Zv5hTEf2+x57Xd1Y30nuq/FuXjYS3lx7G6Qur8Jv
	lY52AUjBL9LBgEmus5W1lXu9xCE4ZECJyf6DNg3S+3wWyHlDYj5BXx4iPwaH05Sn6TN3mjwxqe4
	GDN0PrdCIE9hlq5dxM3xaHhzGri0LQUCtLXvAKIkT6Kgd79tJQJ5oQmJ4KgmxUcH
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb55a47602mr36814615e9.10.1794564782834;
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm4056955e9.12.2026.11.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Message-ID: <94dfa5ec75f4479663dd79f3ce05c1dc6c080185.camel@amutable.com>
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:00 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0net/sunrpc/rpc_pipe.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 9d349cfbc483..37277a6d2415 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/kernel.h>
> @@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &rpc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
