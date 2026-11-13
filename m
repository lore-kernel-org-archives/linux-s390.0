Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564824;
	b=UcoAOvlgl8Lpg1gRoohOvXVcMtu2J956RdnaeywTUgdffvt8bSMoFQ3IhnS6gHQ3KckL
	 gOJ0Gg+dgaLDJhTMcnatllrg52TOaYaZNH7hMmrKOh2Pp0PAGhD02DHZXHpnPxSMTrllm
	 F6WWnT62rhmmPIRuwoEmEg7opIBPexCEa9t3pOWJqQcTgBbJ2bxlViyNvvoirVv11kN3s
	 yd0nHFcAZFCk4UKLVmiHMdKJBvC3n39k0PKN2SM+5NWbu8VpLidAwIgKTSWdzwKL603BF
	 Te3VrLYs2RlQNp0JCj3Qm/Os6JeUYTh66816mMQKmgR0d1cxTZb6JPNz5XkLnO2E9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=BWGj3EQoSNoBVPyme5xsg4Dc1iu9zOUn/VpXbHyU9G63Mrus2G/XeskKJsEqvSztHAlr
	 JtTfXWzyEPvDX9mwqo47ECy2Ln6wJCrx+HMMvBdyGu76CGUStDwqSQxqr8ps8EvPCoPPI
	 xV6cOY9t1y6Vh5H2BtsXOv2QGml1foC4eXZDkhgdYMVRBtx/6rTY6zfXRwee0B6/LpnhF
	 IjAtSEWjE/9RWE8QjZ0+ECMx8AklUUJnudBxmJ0wzDlISZJYkEIwzoQgZB6s/TBI/u/Om
	 sDgowMsVDKJ9LEQlUMBlgmmCCAI35+ZKUQhD0zNom1Xs/IM9pPr6ElBOrnlej9JswRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DC606A891
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E68DC606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso1051561a12.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=uXHS0mE0CLc1f3ZC8AYXRydH5xy3ovZFeQ3xNm1FAKmvj/MTmMYADFGzsPlfYFd1QX
         MqY4b3/ysAjy/BMPoNv/9Y67858CQ272DW1RCJHTq+Dfjr53dtUGVHzzZ7FvQIpEd+ty
         RE3rGtdFwKlRl7+4vjhOfGFoCbYrkZoHO2yBmZjrDG1SoPbewXTMf7v3g8wGJoZGSk2L
         GQGGd+HeGcrQPEaeTvubOAJVkTSXT78W759GmvuunRuQ9tQLjM0V/6QgY5/WySU778rP
         NzFkgAh0wIU7t0DJ2CvCuMDHXoLnDMj+kfT+leyfALVRVOLCw87bBuijplmL4tiQnE7r
         wrqw==
X-Forwarded-Encrypted: i=1; AL+hErEDEdfjVG5eadDEMoK8AM87AasoKnPz/3la4+RRsX8APSgV+nHsPCuQpvIahiBf8ILDN+ICckQyLTC/@vger.kernel.org
X-Gm-Message-State: APuU4Z/fW1ZZhIrhiLLGDIlgiS4+cKJeFd5RG2TsFvn7EPTXXOhViciW
	FHxOIT8SuATpFFMRl8DP0bE8hs0kLNTTEkOIKM4Qeybol0CM3pKHhZ//CRl5CEQ6tB7H
X-Gm-Gg: AYBFou29ExhKBfwDC0cNubx+6tLZiUmlKyDVaeJSVtbJ/Urk8P3jQ/AwPgd9ykyvkK9
	TWKbUSawIpPo+wkOeZ3g3uqT5pJO/T6WSFXAp/BykS/iD1J9vo5DniTYOEvWSQitJPaZaAsWQDw
	udisUuuY+KoCk3TfUfynDsKB0s7Wnt68kw8Mz+dg2zWVc0P9k2PSWPpOUvqAtBbsShhzZSxdppl
	0glKNGV9+82FJFmvzW/YkUWvfZ6+JAibsfCKtoGrTrt0YKoZY4LpRRq+hqJ9QhTKzmmlejP4L+j
	nM9YhgRqNb2RwMagmSMKWyDcUFwLgE+dsICYYdNCRpFcc02v87pc5fnti23THP74HAs+010Rj3p
	gqZITqYz/8rECi0SXRq/YRn07lZ1ZMNpN2U6oMQqhooVbBIA5TC0+j/PuGo0SfCFs/kNJpAkybm
	5CZRJXVcLgk73Zpb+frTjIw5fI0x+6pGjUaQBFfUF+HGsDF3qevxn5+rtcP7qDbEWv+j6m21ON9
	U+PsN+Y8Rb2eojLB1g+U1AbAY4+oAqaoYvGHxU2gZk7XjCELNmnLIXG9efaTTzO2ZthA37U+6c2
	cI/rcX1z1R3j5mVQuk6h5m0t+Zn9GYpseQ8ZbLX8GYTHkSmCQoUebB22MWEQ/GP/xnHc7x4UECe
	vpAyJcMqd
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
