Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565648;
	b=v+eh4iWwkfYhyTGGUKWN2s81kpEbIiBvAtdZxvg9lfADEduQ223gbzv22wh7BqtueynL
	 YwtxYx85tb5IV6WSbYW2MnxhswSG3XKiKJpPBbHKE/SxCcshisnfVSrYhgvy5Bm3351Eq
	 /fgTCC4dFGYPDGkA4s8MmL9eNwPzmSjK95KzYfNWtij9SDZXSzPUJYPJMbnUkYs2jSzGR
	 AbJAw5NBKOclFQSYs0HzdSOLnMuty85B232OMSn7B0czH8LpFBRCZcGaE8GntV0PR0OvW
	 WToJ5gptUI428JtyVlR8lY6393ZdRZh0NpOHIDhGflxleRBEzQpa+Q/yS+WpP5dqS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
	b=CagUH0cq5pYCuHKpCqeUyvnmbhhRkaei1WKsRv+zXbdTdbtzDTTJ61pC8LFDy46xttD2
	 xhWf0T9gCRUy9H0KmqWWeMtjKSLWupjCB0tTCdPjXbnv22bqf2NTUCQWw6pa7Uin+gI0f
	 RH2NnSrcdBF1uxxcEpxYpAPvozHjooTfqf0tLZkVKo90TUnXwiduInbMtPaMChpMzkvIY
	 t+8Mr1vqgbX2LD9V5LVkNisARxI8gP4xxK9M1Vdoc5mPJ4ANxkEVd96QFJfd4edvaNdEx
	 KcRFSLR0OkqgRxYC64WsauGEduDjRrcb3bFq44P78AP5Oi3uXoVEdwto+BoCdcGWpUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DA606A32A
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 449DA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so11123025e9.2
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=N7Ff61ikIQ27nXVrR+i5fFuiFp+kpNCkSJ8kzzwXsWXF8oHPQYaaEtIn2sVJ/R61Yt
         eN/EgbWtaqyPzsaKr2MVnoSj+msmKBheiZS6yCjGNfIw7Nev7hKixHBvdeyifMwCAuyY
         p4HuC2pLhsdw/6s4IDRTQYVk2XreSuuUeA2/lEtpnIKw65+UPm9cBNCU3JmsoFXsrPGj
         WUoovGImF4s4dFS6xRIsBa0e81egoKAVqgb5m7AbWjvbiu6rsFasaFfPaH+ik5AAKzYn
         61DshIaK40jfv3WiwMjZKKDrEIOQNGX/IDgIqQj4sI1tIu9ZETTA/xF/QESgBcPouNO3
         9yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=yu9+GhDksAKO9hkgDey52TFDNbnB0UzSclFyJs5X3x8zstBmACUQ0uevrM8O1AEJJe
         LSm78cc6o6w9ig+hELo2qCPf6aYTnAM9cRHXg6WuQA3LOkx6AyuDZSzIaZEyfhnLO+IA
         XujjoiDOInmS10MfEEAB6DePrKqjd1D+M96PTHw2OmIRWPAfupcd5uA+SsWl0Dnzbyz3
         aXc3hUb7vJNqRAAK0KVKVrUChbUZtJlBDW9BZsNodtMeSATtiiK7kkiaeBZ/z8/MKx2F
         AQiY4jtPpK1jVsoc3PrMa7hkG6d4HLTZv3GNzrdGWnOitU9jjBkfcjWnNN91yk9YMzre
         dvIg==
X-Forwarded-Encrypted: i=1; AL+hErFOq9gueFw/8GV6dGdYvrCpPT+uItQnVhvCrZmZmOOvmxcA9UWCaNuUQlABYKYptcvc/E2EseQNg7Le@vger.kernel.org
X-Gm-Message-State: APuU4Z94eU0hnW+h0x5olIBsmH7n3pWoHvayR97c80tkcuq1VAOh1RK0
	LdmQUYmamGx0J/sNB4gTvbeXmWw0W/piAwUlzrO9ytgg3bOBAA4ChI/Nw94PXH4qUFAv
X-Gm-Gg: AYBFou0WQoCay+fnWkrb5MLwVEJ0rcG9Nq8HgLqYpClC8fRVIFAESjHgyAFXYKkBMAK
	8pca/8m8JiStOhCHtaGXoIXW9wgb/XCAkg+xRZHtnYbk/5c3w2CIDNuIIu0+faKKEyF2neJnPqz
	Uacraje7HRQYEEGyDgvjJI8l4SFFEa6fZgi5Zi8zwePoHux3QjhTdBleW3s7lGq4dRYQ0W42kqm
	Z+q9WKK2+L0+O9Yj5tsuwShrmUzqmSwd8vZQz16GTPoGmgXpPEAnxhxZ8OeGMOnSNbmlZeUgXww
	vVS7DAJhqBsvgPkyYHubrnLRmzUTnMpxIxgARvYjNpPbkbvVQ7o17KJJqKdwRwZy6PeIfLabZt8
	vec25BMvleLWMcYMoWNFYtd4weytLUiLGcUA7rLcwhc8StW0va4xIFUrGBUPL9GzAvzdrFy0eY2
	uvXf5jivdarCoWptaLXtcyloGlsf60aIc4y/gjFzD3Fdj2VuW3+zsh6RuCf2H8Okvthu7uglPYz
	TJI5NKikkESxFms6f9OYp/cm6bfPT+gKZv+L9tRikKy4mBZcDV128wmwT0FjDevh54WmVNDFKJd
	RhHqG1Hug0U42PnwdlUhspUmzrXLMABzz5iwliXAKeXRQfSRErzlCyQH0tPHrTE=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
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
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0
