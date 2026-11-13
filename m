Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564728;
	b=lK95fzBS4hueNOQyUava+KSq4MurVkGfmIaWW+RGqN0IfEC4+rseAVsQvs1FT8KCOhxG
	 7enZyBvYLdIf+jvVQX2VK0Sih+co4igoFxtlCdb6yUiQALKeDUXUTH99y07B52w8QULhl
	 nEQUrRu3ZtSx792QH5biIM5hGAPLwHKJwoof9oebEmaDE+nzfrymrsFJqpW2FTIK6YcLA
	 qInxW5JFRm+KzROwdzCTslXN9nucXA8GVWRSwQv6vhvUbC/cd0pvGIwTItAgoc9MW4xVH
	 4OnPz0gFUihAW6zUxK/oYyPPqp5wrsMuoJEilxsZttEmjzi8p9pQMOcFAbQZ7QNRNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	b=2B3Qf9/IsmIPhtKzUxsPawZ4KWhhsbeY8viF+TLc68bPMqXb+HOaiUq2q6z/MI7Pk37h
	 XkT1GDQtMzmX0lrhzz5OjgEpc2uuEWzUgc61om7toqisVqv99a/LtXOk8KsWXRbW/lPCa
	 6cdmTIEsMDxUd9bnXVzbaYIsHfzhCzYucJQV8p/lCcP16HYtXL08TUzFPi1kFDndefhBp
	 tt6n8umI4Z7Kjg1QP5YNGDJ8CTlcVaQBhd95uhFI9WZ0gYDhvZeBzcexy6O2epHXfouI7
	 CrIrXnKg+O6CcLyxmzal4j5yt3+v3sJZdz5W4Sa9yEhq6QMOCgDF3cJ0IpW2ONaKdWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA9606A331
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EA9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so8032585e9.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=JofFrwonLml2YmEXhdcViuKQhdgodt9TPfkjQoH5bRE5MuhkX9eapeBcuLoN9BMOMG
         mg62x7tr1NIo2ce3//xfxGBo2Glw1JnMwrRUE5PKg9cgXRmANAsmerUzgfn4I+APSoic
         nLUkrr6h7Ej/6ZnsBOEx8OEPXrCx3CvMaGkTszs9w9WOs3gF62hftbL3MH/tr8iwAkM5
         IEqdn+20vI39qrHT5Lu5B20ux21tBPJwfptIyU9tNUhlU5QyFDk51k8ZhbiJowoQswf0
         13eatahih0uhEB44iQMwucAarD0vNvZBAG3aTkRmepVuKD8cgol5N6Bgv+DPTP+kX4Yt
         YdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=VMvniUCHJe/57CiC5Ub2HLPr+ApfHCowbx6TjsQ0gSZUl6r+MwyfK4dwDYVnQpUmHV
         eq5j+FwdJheKopb5Ea1Q49GYFfO87RoqSx9SlqnFGjqb2kE6ru68jv5zlwZJwTvWuLSe
         pNcpfHbF2L0NP3RPCZTsun2E+xZWvaw4VPoiK4jqcJIPRunQ5CogTNZKqUprkQs8FVlz
         rAskyi0wj1JOucF1Ao/Ec74LN7Bn3QagIa42vRRf41a0Gq//VvCc3qcXkJVhnoTRJN0x
         JGMh1zkKiiKFV6aIs1+c1wQrCVBvpUc46myIaqkquvuHlCRVAI3NSxSh6T67zVTSi4yO
         NvdQ==
X-Forwarded-Encrypted: i=1; AL+hErGSl/sZxL3YoNblfXq3Fd1eIFMCAzLjoqJTJU7Nex93rzQt1UE+W53yFA9jSuNQZwnirhX3KRKt+Z7l@vger.kernel.org
X-Gm-Message-State: APuU4Z84guwBfAjRW7l7dAB0qo9z7BFSmJ/NB4vmr3Ogb1rJCXxcfZ8A
	LOm9yS5rrrEakWOCCavxbsHFfe6fi45Cu0GExq0WJCGN0aCe0HSUT8A9ZsV1rm15qCdN
X-Gm-Gg: AYBFou0rfp2ikEdfmqicsdl2MrB8dkFtprf6oi/gPUjAYILXIifiTWqdpJV4dkxA+fT
	t3QRbV4JAPTqT7qIHAgjiMbJOm7KDpz2YuvuEsRvlpHZ2TxNrV9lTHsQMwGCDltPzZ3j3csCgHG
	RUUcEYvVkOU9goGqi9/qfiL8ab7D3ZzwtanuwwdiF+Z2lEHMPbaWQNMX4jlQLPFLTE3tRIEXv9N
	XgLaYdFrHlB0O+rSZSctjglUvhjQxVjKjNavXgi39256XueOh9pqFcfNFgZccHCrOVwmEprhhw/
	XfEfewR/vFR9UzCr8hWkAtEaoiAwKgDo/ZOQEW0Kb/YfN5IFekvVsBEgTDXuJ0srw71aLEpflPT
	hLRHJLiBMThZckSjh32cgpS5+Eu+q9ZDP39VSWTHWnkj4bq8mBYtAOGMSDPy77doUoNH4t90e+h
	nRT+n5ykIWqy9A+M9QIHAbI+delBo1n1S9caAcqdWdu3d5ZC8XI8qLw9GdS0dSjUeB2hqjA1QX/
	q3HNUZvBM7Ddz+VR1Xfv777XPuNHW045kEmTu/p0/tI2Uqo3afBxJiaz6KO7m6+McoLgIlpx7vy
	xte2KNqZyPm/RFATrsilcwMoqcmaXX62ClwNMF4dTicYu5BJOU/0qF+Km+bGeXkoT9orH5l0JfI
	8fsftjHHK
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}
