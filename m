Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904088;
	b=pswkASGoLZFMfqOfcmJzFxxVPxgfJzWKTCwl1iCUk9jd6Q+ivy05pVBBTGo1mHO/AJWH
	 mj6FACf7+hGRDmI3YKjPBQY9ntd/NoCv9GjTLO4OlS2l97GTKeT8j5gjk3ecEQKPI7H9s
	 LzBSSZGAB/3PUTRgCktlWfGtCuJTkQ1FPgakqhYgZ9PspsA8rm8BFMBD0DDyUYjFWmBjw
	 ecrKpNAm3ICQ5W8ZrTT4TTobLOnful3UpEhLXcu7llpDjcGfXrjm5WZBlpQWyi24qRPeA
	 qz9jCuSBkBJaaieso8+6Iw6wn44vpYY5MzZ7gbfAb//qUShLFWA6o43ybZOZQKTP3GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	b=U65frLj93naAo8dxksJRgSOEbbVjvStLXd9DcxGzuRxy8LTYkTklFQqjCA4GfdFfm1Lt
	 Zi+Nh4FPGOlwXE5g+GVnXygZSEGZ97VjJYzZKHt+ONo0VpjczwXvgh1p6Q1rJ26jEhK25
	 H/jkiACB+hKadOhmRcth8ThoXC7W/uzMALbI4KQbThQ4x/dwNMkJ3DfZxZa0DTx0/3d9b
	 vzoIKWsqlwzZeYTumNiHNay9m+xKHTJc5PYREjnOHD02YENHLbo7yp19QqQHbC5LKUwkg
	 Cmi52K4N0JC8Npg1xL+6I13Q2PBtaHZhb9hPRrPgcMz6asOtTLhlC5I6DGWaGVGuHiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153C606A335
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F153C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso31738395e9.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=G5kPAzk6YKyHaocuCdT5IFslrUJH5/ldhNVhV6xYWUthrOIppv7Y8kBtZdevqAkpzI
         BDRFsu2jrF+YCozPia7EV1j3KLeZC6Lnc8BgBdPYFaePytvbOESC0m4eRkryqhoEbPxE
         WM5n2Fa2IGRg+WkSIkgfyoTemIrDdEbfzZV+2Eacmamzzj+t+HuCPRqV+GPswkKxuMa/
         2fm9UdrHUV6v7jtlgmqycAcrxGUcSbURHcUFMMj9LS/XjgTFJtp8hDDDARovdS596Fjm
         xwkar34XXNuYsLWY+RNo1AZ45FE/L69efZRvwjPbSAF3CGRgr3AaMHZz6Kf/cz8pCVs/
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=jxRzF6cnKgYodrfCSRlUKbEFaTi+ufhMkrZUdlvOLVCa1gSskkI/t9uJIcdaskXSS0
         EOPwjUKgn0e5W8KEukOTtesFPDDGCxMG/RltNYkauRf+l2QZoYeZdZDveNJSJ33bZwC9
         4/mOiSqdXVkO3RPa2rFo+aIsE9ApNV3jewCB/6AcQSJZ+Z5e43Fc9vJbHbk8iusmv+UH
         5h84YY01du0AQfcjD0I9Uw1lIUXqMpDBY6opfJ+8hfqf0YhFqWws6jCxJn11PmrnS7f9
         hQPdW/FMREMydBgzM28/01o1SL9BuQ5BxfRZbdOFRXFSCuPKbBVo9dzJt80ahYXzvFsF
         wGzw==
X-Forwarded-Encrypted: i=1; AL+hErEjaP++UF/avvUjRnjE0U9+7Zf/nOS16/dHh3lfeiM7Zx6oFGHrViuxjWJzsVfO/Hr2xOMF0UJQ49hT@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZbjgkR/IYmKjRcT4/JjxGATLMnoZigINEDDt/AN7a2Tkqd2xG
	Nq3XIm1SvC5rvffUZLgVDiPjiD+a+aC+uL3VXPDXJ4gLh8Nsiel0dDnfQOhTBqww+NKj
X-Gm-Gg: AYBFou2WVz5ZB4MW36et1gqRiRt2A6IHZu65HgvkIBRUZqqDcCsICIP3qiHsso8QZOk
	CIBoWPukDWuKwpG1b0ISMixSVxqbP/spQilkm6NRsgX6+MY8aH26MrLfKZAqNT7zb2OqHw6Ih1t
	8jWrcMhIohtPaOikJYHk83ZX/tstyZorgyo60xJEglqFiuHsWkuZeEMSYvITtOo755clJYety4r
	WhE3OU5UK085CVnEXs+cYnZEo2kAYlhjjoLn7CAV9raOYk2Vpt13jbrqRFabwH9Rg0mqKavqr3T
	3cIXNzEZzOcO+Ai/hP+PnegfwSiDyC/jK2tjpRqh3xZxDp6nwVrp05ly0dNnmQyVq450N4Sml2V
	J12O6OFlxKE03015XYUr0qeX5M00DPHAOXdTU4LuyBM5hwyotm0eF3O2PmO/BHmMxotRX7wxkXT
	4xf3FhLa7fxgTi8SvPABX2t0l2OadKftkHfcyEOGMgXOPjF0aFNY6waMJvo8ZBajTUaMKaWYAVT
	DHqTNzB3wLOvZaTnB3+DUScOWOokTWQnX7fTO/VtlJL1SrwCllkb9goU6czgf9sZDviqpySaeId
	ioktQ6VprQmhh3frw0MVqsxC9YlNBZyc22cLXvrhzEaw7fYvI2kuIwRnDBzeMVS6N4FGyeIXLYe
	QPrj578pKNjTUw43n+/aM6OmOTYeR9mCZEHnDihlLNCdeE+U+moY9G5F/
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
