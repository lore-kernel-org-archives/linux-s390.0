Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564173;
	b=iEBkJ2NLQQu2EVXLJFyh4BPkOzpvVTxDoNL0AbU7MeOui7dXAtXV/OfNhegwBfm5O6+P
	 OuAOckcFx6oORKe8mndAkkCl5SVZsMf7AG8RQrzwaJB7a9iKGrLSMaahUgLXs+GCukF5f
	 KsC/QF65aVkvhVRZZ0VlVseno2oY177/ML5J2cYKLnYp4EO6cwmLN5jfBRGisUlbnkJes
	 94q0BuvprrtSklwgWB9EA/yXs+PmfBhszosVqk4YB2oLzzXh5RWgDooXTP5bTs7WTPz9I
	 qEq//5R487E/woyg2KYPkUsrkZTDHjKrO+bA0GJN2pCfVSle3XTkw5JTAc2hkqrIbZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
	b=jRiFE7vF4VN6NRIiOr5aOaOVWWSxQf5uIhkeTKjfh1tIRTuz3V3+Ga3mVwMlEHMJEfVz
	 91M8QGCmwYUPkrA5l+nl9A/cQKXkH/Ktmix18mk/0RWBreB9fIoPMvgMjA5tcO1ljt63U
	 6uWTbowkQqfJO9ZQ1BBoH618EsUil5P9RTofWIEA2Rasn0qMOBVi0C7qTGoatFamWWNvc
	 Bi3v75lHh+zAQgQWCt32mPgDGU3NHsvJDWf9S5w6GcdKgTn+1LeRwfoXVWK2UkKBW8ROt
	 J9q9UgQ61BflGg92kloGZTB5BcsMJdVqw5l2nDO0JhzdzHuEDfpFJUy40BM3GZxfvlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80F606A8B2
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC80F606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso1234769a12.3
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564171; x=1795168971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=BrRghWveZPMQ2lrGbo6B+XUgpff5EufUxldGFiTipoIaiFawRH8FVJvDBChKSCm+0U
         qE7NrwVrHQo2b1oiTPINBjADcjfu8j5+2hiB9wPnUB0Sj/3WgVbhatfBxMm3U8N4KnOM
         ecLP+89NGaRsX9nOgSryY2U8lUIJARrslqQpZFBfoMRf7b7aCNcM2ESlmVVEcyz67Zq1
         nmg/xl76oWVlPrwozco+e18C71yw30j2TPM9TFHhbc2tHwAu5TUUkKbNr7mrc8DWNqok
         L5mLyN847Ry543yO7VRmUF69tZ0RGoya4bqZfEDQ44XXZ70j+SgMCotFLrfSWds1gzqN
         VQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564171; x=1795168971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=mdCZgowib7kWJ1O80ixjFz86HXES/7COpYJO4te5Xk9Ffewhc3qnVUU+o6rF8pvaQ4
         M+i7po9ntKUxPi5B5oOfb9OdjKs7K9KL6JyZtWLWrBFa+DMXxcBb67QWkJBb2KmaB0BU
         UzKie84fzys+byyA49vMk2hFDLaQCxer1n5xxwVSQn5aO3i3Wl9UouKHBegQlfZUGhzc
         kd0Hx+bIoAEszp0/G+yssUZ7b1MZPENNAdHTbAaag6JN5+D8V1+mkihSb37AAnWvVHC0
         SwJ9bgLZOU3WTLYo02vtyl7PLwEqC6k0IMYtgNCq6rff4haR3/5VGV+FBusjbJXzRuEU
         YBmw==
X-Forwarded-Encrypted: i=1; AL+hErFeTWDQFF2cM1tqneS3M6v5xqvD4o1xppdlorcv3y++LjB35A8YAfz06AjP6ow4HLcv9CsoLiOhuHF8@vger.kernel.org
X-Gm-Message-State: APuU4Z+kZuVGMfNS6yTg0KQ2+LR7Sq19W7ebCi2eozCcU/ROqHPrqoXA
	VtguyEIQzYd3rvfcJhuTdoO9SFqg/hebigBOxGZSsaT5+zfFGAasmjpgBaweoE/FkFqt
X-Gm-Gg: AYBFou0NQVr9O1IA1tOMHEFiMIFfNZNmvTgnKLOvUF559aKazFrUtRpKhQJTfKlaQWL
	vSOylQwNTzMj+pUFvC5MSUBWyjfwVS2Lk5lhVV7u2PlQU63aSqW6yvCAj6rTIGD2lk0QGIYQ1Ds
	+ZFvq3IWdobmEOvCjxoBTxI2mNsWp0W/E4TuxDy+nkAWcl702VpE9BZmjdCcQmthnrFP6DO+D9I
	D6fWcgAWoQIAxrIID2dTOiJN/HniTpRow8g8/0vpqKFsTEcKqVUq1vLCceDmalRdl60Lcu5ruR4
	Z0uI15/cjuYlgdjeevJfbyFk+R3OfxTQhT1oXORFOINTKbdrmaXTOYr3y9LtpLd+tfbrN8LdLlv
	vU/wlcEVtBzdtdwNiyQU0XOgj4N8KGtqNYAsgxz9KRHoxCkJdOSn46Tg31Q/5rZHQ/gvkXervhl
	g/zYAWQ22x7VAlldkRdxhMpb8SpMKOo5iuBdWCkSm6t2V/MZBqaOn4dguuas6FM/5WriT8CwTTv
	S6oITnHMqnY2uR8PloRuWwmMysgOgP++w/WoYen9ghciNxBHimx9L/6cNKsNcp9IFv0QEK8B5qx
	G03BZA/ubr2DKtnzhAJRD0LTwwcLz2iFkrf2I1orTBelQ7sbSQa49WMrpqyBh+0=
X-Received: by 2002:aa7:c842:0:b0:6b7:82cf:f69f with SMTP id 4fb4d7f45d1cf-6b7c0ceaefemr1298014a12.41.1794564171137;
        Fri, 13 Nov 2026 02:02:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm739270a12.33.2026.11.13.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:50 -0800 (PST)
Message-ID: <06b194053de4f4b65895248d1f2ba29d42a21b17.camel@amutable.com>
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:49 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
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
> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> =C2=A0fs/proc/root.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..ca0e75081934 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/user_namespace.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pid_namespace.h>
> =C2=A0#include <linux/fs_parser.h>
> @@ -265,8 +266,6 @@ static int proc_fill_super(struct super_block *s,
> struct fs_context *fc)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* User space would break if executables or devices appear
> on proc */
> -	s->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> =C2=A0	s->s_blocksize =3D 1024;
> =C2=A0	s->s_blocksize_bits =3D 10;
> @@ -350,6 +349,7 @@ static int proc_init_fs_context(struct fs_context
> *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &proc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
