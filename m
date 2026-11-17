Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904595;
	b=eYdva/lf6stU9Gk+B+Q7tXMuSYOnK6YgJgxO4q4e6NB28tqNrkUEY4R7rYCwmrQIZ5xm
	 G5a1+nTR6GYJbuDoTtlV0bakxU080bjnOM5F4h6OA1jtmA1RnPTl8bmiFuKkDUgLqfOcL
	 ahABgiG8UlNOdAuIhOSX3bhdutI1UMUfRXgw94TvHOOwZxrfv1MLNk5Qltm6qsHO6F8W8
	 N5phAuu9V8CPlqymFMs+Do3X1fediQrKmM4HuPSpUHTOL6uA1wu1Idm5jvUe2sd2h9WOK
	 OHejBawTpPegzyepcZ2kTHpV7Zl40MHjdvkK/eqXVQlLzcWV2l2veaVtj4gJVD066zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=ZvmZkP0bOVc87wWrfiirIsuUovUUFGGcqVVXTkZdY2ydAV6oHCJ5IK6pG7A81jxoSqhL
	 bp15gdSxZeD2kWD7WMR8ydLxlYQZ1bIyzYu6RLCF9KtfDbb6kPjbEgZRg8w3NjY20Entl
	 Tv+30dD/22jxh0vPWzFJD5CXYralo8x49Io/uKrcmbzcn8l2OJp/OIlCAnO2VMJf+qa3U
	 vbuxkVs2RD7bLXZTuSb2t6M3AQDRszzPc3nxpz9d/+NJ1w5KEnhbCllLYV2hxT7T6W8Gi
	 exq9EApe4fIA4A+qzjUWDbF6L6gX95O5mt8YR91bcIuqXdj57JT9gWvfK9gkZCFQ/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6919606A89C
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6919606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so17252375e9.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=gOJDdYcvGA+TDwMMw2WGQCLhnHAuAqKss6WyTbm1Dq3g8jUIT/eUZn4LeO1G8U21U7
         MyJasafikrOb9J0zP8GIl8hoTeBBxh1aGW31TTIGBPPN7hMQ1opGYADHOyGE+rGQqcbY
         JPRj+oswM0rPv5BzYCoJiFg/tu6k533OBj0Uf7TV3Cljce3gOe1ChD6Wq18WV6HQlBKK
         zALlsQIc8WPxbwYBnHoCOvygXOfd2jUP04HT3ov3lP4ciGRTOeaF65JJm7aXIK2w8i5R
         GnOG6MP7eNDHPNaI+PTWwrTyepI/8fjkilZZKkWUJhxPz4A4tMeWInNuwbjzDW97hQ7R
         z9GA==
X-Forwarded-Encrypted: i=1; AL+hErGD1Nt38UGGNWo3sVGPUl5kKHJs6cmwnwHzNR+utohqYmXnhQ2/lD49b6jnD1E6z3kZf5x8v5thPQzK@vger.kernel.org
X-Gm-Message-State: APuU4Z/iDc8yGKVqdWPK79EMDaVK4denGK3mf+qwMXBi3zAnxfarJ1JT
	KL696IGIVRcA10IOCGXCj7JBE13FMAnLlhpGILUVpah1hE7ou4Xv2DzcjE+fclEh6SHZ
X-Gm-Gg: AYBFou2c657JSQxz9FfpMTetQfSBbPmEqPh/lkr0F+Sfc7sAru4WlFaebXIjMhX4Nhi
	d432NFCugCzk/PV/wHx9RLSM1i8dCPkeCHjVFu8ulguNT4Cxz4Nfb2PD7RGjmI5Wk95ISagaTgU
	xuio3MkRcEY7HYZHK10omef1iorcQiPUwtpLdqkBXH8ndmmyB1Jmejk8ItC3C40jcmrW+BBUMP/
	PQthSRPEMY9jR5dtUYG6kgF4yOZmzQAyMqvgkT6K4mbDp9in7kDDiA15S6FyMJTP5Q1gYcwmxko
	twnGaqmR9tNKtWUuWWWDGG4oC4Q+UxlUnHWJ+1PghGf/tmuR/8SxE4od7TFTb9+oQVSLYItyNcc
	+Y3vQ/Fbke8B43sW7B01jMWiAPRxLEvx19rIVHnkOu6eXrAvs4IEuIjAln/nqy+Y4ptF+GaXqEz
	LgbtK5G3igOqgBnEJe+0yWBojCcNf5YKe87OI2FH+9pm9MbyOKQtd0Nf4//f7n0wfap2RoWTxTG
	6jGjAsoRdnD1BhkrDCOkY6bJLovAbzn3hKMThdsXU9epqjmGXJMya3Ed53zDNabVjWH+0HVEruy
	6PYxV2vPnijdrMDh3M46CybeBP4pVbY/Ro3sM7dpsI+dh0bJfMXK5yE8CZL7QunPqV0xYckzoXZ
	09hBQ1+b+RdQe2zrFloeFKhZHSylAM/9lEWHiQyo/NRkACM3Aq+3sHLN6
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
