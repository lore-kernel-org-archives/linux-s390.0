Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904032;
	b=qjE3X/hh2a0II8Bef7b9YSfFyrvmPRrUue2yDacnVSnbLv8xIp2LWZitxS9zOPqxAzhx
	 IXYUG9nuKwOI7wq0XlhC1mqvgWQKV28aQ6Ha4ZHE6CEI6G5/mrXtA73YA0tqQJ6OceadB
	 rZxXOHUnKDZwKU3UX8i0SEzjwfRKg9QfH6TGhWcAPpJVVIJ1y6UKikDyNGMIm6CxJgagt
	 +k3wPUJCL1kiPjMiu9SWh/GdvhoXupb5zpadWQom3T6/qlQAWLPT5iZKL/w9zC0ICCxV2
	 0bRHW7a/9zL4YIfd7V/Ivtplx0ZoZZcfSwMSRVIKQocK6gNk/NtulN5f5DBodBjeaeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
	b=zn3XxmdUzy7UDsZhs8IdP0pTuCcsAMiPKPWEV84adFAlxyxAo0Ar1QcxHqDo/I6rrSO/
	 q5Pq8ksZnDrAofXhBWeReV99w8iD57qpdM3oSwVIyWjsoSCOjAH2gtKnpSsyi0e9rHwc/
	 rTVr2F5c0gJb4go5LscOk3aaZONxrV6I8RlY9Ml3iCbjWQYtDDdLFxQdyVpS4xs0Kq1uB
	 5SxgskJZQwCHSeS96pUcl13R2jyvv7IXevVbccVZbFsaM6WBp3xO1cn1n67lyCWpxEjtQ
	 Uh5Z0IqzRNEg+pMCYqMKCGTVsiB/4iFP+sXIjzz+RRSIZEgbJkEkbp3zO3HQeCotDAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8985606A32F
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8985606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so35729625e9.2
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=m3Y+iV2pelmutPYORVxza4CHQMpjq7iS5lmecWgDjvax6Coso4uWa+KMaCm+CB3bWY
         yM9xDjlaUDqClL2wfFs+3EgMKFX4Q8fuLgup7VSVEO3iDYFOyh4nyeN0Shri07+KD82b
         UFGbuWvBELdRnXkiKa1GIWjPRb4Wz8WRQUErt4eMboeCaxWHABbQwTZk6BuPw2NopAXW
         5935wwOL0Ggt8LD7VeJmtmL6iC6DgtiD4S4DRbEtkaj1swNFS1XEbe90cWaNyokAE8Lz
         Ulc1c4G0eNVUIpLzTdbViN3HgCOMoyHpu6hnCIZ+utcpbQY02w1kBKtCyN8iaUfGq6tI
         6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=1IKGG0XHp9ZGNsFwrOqJvznk18mrD9y36N885KxvVzW9YL+YCgYE/SILpq89ul3ziN
         2XUeV1hcqVDoto7f5CouZzm6UL3xJQm8ENzT9TSdADOTRsTlhzE6C6sOKyMpDDsX9hL4
         +7eH3ccoFbiqqzfV34ao2fmmEmKcO/x6BntFxnlm1zh4bYV43behD9b2xl/hDbs7vAYk
         CAw1iCVzz5mMwWNLpgsrwqzT/H0O+f8/X3TMwpR2t8NaNK+DbLL6jA2Pmp6bx78X60dg
         2448OaDvl981YOKN1JP0PrWMMtVo+zRj9Cjfe2zmgvXb0ELZs+enFTJ/FOADFU8q5YB1
         6jhw==
X-Forwarded-Encrypted: i=1; AL+hErHAzF2DpuT6HZj+W5QMXlqrUpH1bL4o9mwBaIAcJxRJOznAKq3peJrEmPdVEBW5raNiv/0aUZITosWI@vger.kernel.org
X-Gm-Message-State: APuU4Z/DqXLzAU9SRQ5pfMPBUKYEwhmbyfQ+WlslDG6YR1KDCK/bHu51
	5A6944rKirgm24OUaZt30aT8IL3YaERNJ1Y32CmRQog6Cbh+MagMKMmQR1v9luP7Rff5
X-Gm-Gg: AYBFou3fzUSNRqbSNfJjX4rMrZWgOSAN06piNB2/x6aN0+ggc2LWGqLB2wBpsN5es6b
	9ReRRQCyik0tnHxHHuO1gSvUBo0Ra+WaWq+e01HaKewUE9QDtsHrexvnl9qUByu66VtN9mcFnb/
	DH6dvJVzz2VZnyPxJsNazF6gvHEh85i6rQCD37/gr+DlAU4uCii4wFp4myMZHYiWPsLHNwko2F+
	ZuzsfQ4w+qVl5wcgI7LwTCB0nR3COS7WGZv+O9Vj58tzM5lMSeRnFYNY7iDGbixXnoJfROH9Cw3
	Z6+x3d9E9RxcbYF4eiRGI9xvb88q7uesMt0OXOPXOuiqI+UIf2ZKjNpPvPAOxWFJO9M2KBDn04C
	vcgQxhs075e06VJXS42/Yq4j5Rh5soLCg9qHITFu8ufvJhoYErKL7UztZ5mbRfMPHMPeq6Sqlfm
	9axYJGmCrMZGc9z7tL5CnsMH4KeyiJo1YpJVNj8fH0OpXic6oV4uJtQJ0Yaw2IBMEL0yKy84V9p
	NreRFPJJmMcxvFJc0x4E07WWZ1Fh+fCS5WmGAhDmMIxvnPib75GrgDHLrrDGQjpvV/kj0P43Pbx
	Vf05wBic+VwBXtWVIcNHLNcoyJpClpYPXRDPomUwaYx/8awd5lmchXqUOsfufDvG2/w51y4NaKW
	c8lz6wy0W/sk2JMnS+MnwmgI0bzu8EaO3sVzJDTcP3Bh7tn16e+K+MmE8
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;
