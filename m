Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564808;
	b=v7KPU3nXS5VG3r68vMdssYy4BBZ8jIQFo+Dvu881icvgDdPUGW7+gY/kuhlDwLeLGtE3
	 nfUYmqzqBv0zK2MdjkzrYQGGqPqUZYXAi1GZdrXil59c/ruE8uUtM8WiiJopiWaV+E67L
	 Ym5vZEm9kGE7KLcAQ5bxMGwIZSY1wILpdcztxOnG+HB9/lMqeyXNg3+Le9Alm+WSn9k85
	 LvZHmazP190tg+DB0T/1XfC+E4x68GbxN9xYhMIBB8MCVnD0JMkVH6bvM/JZaLz980EIo
	 Ig7aUJhsZ6ps+EgKPmnuZONIID8ouF8dsWvzMIgk8NwhnPD0CAUPOMfMgtjhMoL2w3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
	b=qC80Z9wtnIfLW6plhMY+YoQ2UjtZNXF42KHdVD6XOkiee/8AouDvhw1c5lJePbcxVVVC
	 BfIVGveT9/D2vHK8oFjoOyZHEOMPc/bZzvdkGF3iLEimWTzaK0d4qZufTFeVjTNbeCqoP
	 qA+6rgAoOn4MPE2TrYPMGNRh4fzHYpBby4RIad9YQhtZnMAFyy2qR7IrLxJFvcStXekDY
	 h9V7wdIMK60QofbE9QtROL8I9v7nYxjHlCYQY+tzn6FULlFnVhek3BiOZFt+IuhLqua0N
	 is8u92dXNE8ldz4RwURJ1NIQeGb7vDtV9rk3M7frxxF1R5qkbuCvBqCGYmJf4X/kBfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3A606B114
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C3A606B114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10630865e9.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=rqBNEWhefqtER2dpEJNVPTElbe19fVdkNyIzbVbNULqUnWk9JP4TtodfrAxZg35Ufq
         +ciPTMXXDC3Fn73QdDq1nxL10hoZ0LEMTSuk+HTluWLCH3mNQBpp5ecm/W/Lr1PQghIv
         NQThaRjLVubmwKFzY9W4H2pkvpw752j1vTd8XwcKuq70wsUgwzLrChjclsxLFe4j6CXh
         P2+zI4RYwkyiSmtYnxi7mmM5Yw0kfqLENKBervoD5JNkytp6QIULxp+qmuf3k5WOFN+d
         HC6ACfaHkSpUVoBZwd9XYoAangfmrtxV8FymQjjH9iY0qoozDauX1oxEdXhYxV5zTWYW
         c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=Qfe8GuvD4/EM/H9K3KHSmzKpaoARscb1mrvxOTTLxdi69EGx6keTHTqupsI726QQZo
         n4o56cCUozqy5k2hw5pLrDOisZzY6Bts1+sqmzhMGDoxzHqlrAYe+Puw+FFqAxqgTsmj
         0eXtSj/MimLMzWmzif+rDbid6N9QkYD4fCc7orNl6xXnijKH5sn8FZxHnn+96Sjn6cKc
         Tb6CoCTq7iufs2m5pfCZfJeCUBALwbS7jNItkyGPM17gf2OT5TGtmck/IKT5ApeYhAv/
         qAJtH+OwvzK0zWDXNEE0O7ijJvCemrWqXvGWT4EcqVuDlWeFiGIu1k0Qu7TkoaWKRkK6
         Djeg==
X-Forwarded-Encrypted: i=1; AL+hErF2faHtO8UZyW//fhKRmyQnSTTyA/Q6P8sREODnfB1AojMtry2odpvDhp+DpmpnxN5ZZQE9GHZ5Ckci@vger.kernel.org
X-Gm-Message-State: APuU4Z9BIn/y4ueQn1sx8mjAsEfCuKYkAdb4sHKRmIX9tkf6erC9fW7F
	EHKwS2SUrStgJp4eSzOidRpNLNrnh3snZCWR5Z8I9T7zag0pKx+qoE0682jG7HpI6Y+P
X-Gm-Gg: AYBFou3+vVzhPAuoyY2AKgPFCKaDJFpVNN0l/peafahM3aEX9KuKMIUEAmExrklkHi3
	aNVEa+G8DSpFdeAHxR38+8BkVyMclEx/WPCu+iSqP1WriK+z50TfJ2J0BHyGuIMXzJW3UrfrHUk
	TAo7L/pCAH/6odjAhubIIyMUOQgJo41iKfb9/K5GPrD4SlRH3VQ4JfnlaiANubrf5hrWqoYUZfK
	MZ69fb0qdsZgUsz2HWKAvrTiyHcMBORloYKgIFeu1wOU7609Rqt5+1iJYXctrv3Xv5zHDEvqF2K
	9NfGoZwGjhUIOfVYJlWPbufxlRhJMMdsLYp5PLg/ntXt0FqT45VgUSK0G5MhaM48kttShWv5dqD
	LEtepINBXZScKk1aTb5MotEK7phdCKlX0eEVGG9o3e1kNEblMKGA7nkAozGdg1p206dRBsL9dzY
	CfafZTtF67xBOWSghOIuUG+eTUMZi1xAv667qVxm+hD8PRFG/mXNU2b0z/4r/rf8OudZF6gKgZf
	bubchTbrSNllRqcnBt6cjf6ZYeMvFhdOyp3/0poe3iJNnHfK1RyncKryIIi4pyRH+jv5Lym6+O/
	DrTOwkKYkiZxWlup70XMjPrmOJRKeaH6atBXg46mVY57VKWdyi3TaaY1f7yQcIM=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
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
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
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
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}
