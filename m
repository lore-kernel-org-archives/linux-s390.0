Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564189;
	b=qFA7J94IEBgBg4C4lwkPlIjTnqqrG521zQnoLRUmoQ86CqMVUY7uGroYKQcb5s7nP7bc
	 ENPuayQOazbJyte28rLnQ1iNuxhcDTEhBOoFmGI3/3DyWrJRH7viqB89yJhTIC1BQ9zns
	 XgS4LuCtv5Ccw+pjob0ITYT4mNtDZqQGQdehfjmATVvrWMG1aSJrFPinPykuW39dto0wu
	 Y/x8rWVdRWCuuyHeAZw5lI5oizyBNa8l8VE5w9CpXR1hDI2SqbWgg6Qfv8GBzKDCYiCex
	 Yie8/OWdrCtewds7t2e8yYZm/vrTWJjQZKhMnDV6PkFt3DyCudPrQY/tNK4lrUhhzUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
	b=iwTZxez1Im8HcepZA77e0CB8Ef7ouRBcgOQspBC5HIE2bt4GHOJ1vuN1od60pVAb0WXt
	 aHHydTamueTOCCDLQYhKHnUPTKjGNHNDY5ERXtjGBOpLcA3j22V4W/rkb88cONq2s2+Up
	 7Lz4U5p94rjqHhuNabIRzWpHMydDAFgWCrpIDuYTe1Vt8H/amFaEKtcfnRb2Jp48Uh10z
	 nvXNpeZvd618BqCO5g/CKiMfU0Pj0s0pfCxVJ5Z4squ/TV9MkzdDxrKP04JIWI4m6I/gt
	 CKCFog17mnmsit41Wayn+Hb1Yuhhjzv0bBRfhhxlVtMLfRwmyVS1jE2NnE/7IgPJ4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PwLaWWEZ;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65549606A8A1
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65549606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PwLaWWEZ
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50a4a2132cso50319866b.3
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564188; x=1795168988; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=PwLaWWEZlovk3BcnO0ZG64105bcHT1OuSddm6BbnvIqxbrPzt9auj7esmk6BNbh6fX
         VcVz0Fb5EO25ZFbwJkkdsGMVKdakOQPzqU2f6LPhtUiDBhEZmXH+cAuxyn5j0/PSwsaT
         RO2aU2TU8aCmd84MLoXz7vnHjZWZq5qT0/Sc6gtTAg3UhyfQddRWFsH5ep7YUVPW4oOS
         ZJYdPFjeA/srAxsT7bXr7CLtpXwYO3HrhRePJ9C+1IlKmxOGPfhyvFsMUb4DHUYdYyHA
         n68GAxpj0xAii+OfqqKyb+8UpP8WFZF+WeKZ9rpWrZ/4EfgHnKqz0J1mnDjnDglQmq1u
         ISGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564188; x=1795168988;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=lmbTJFtT4f9BXUo0uLFVosF335AMIhdv//BI6QbK+4p4oZb0PZ4/uvfXSODgB23xwF
         Obc12k7dfF7xCPx95JGUXh+Jgeiy37p8xOQBuAFMSOv6q88Q9lK8YWwpeXggFRdWmphq
         gE7ozhTnOuafkYJPXv24ujw30A9P4zmeY/8L9BB0I0Nmo7lt9AxxFuTgfl+iVLVW+K1i
         kS/IGIkIC9GAvBYmQOlZYVXs0ry5aVyIL6aU0NsNPJ13bAzadtA1nIJm+pEsEiQqzdzM
         Mc4vXYFoyqCwqGPYYhpQ8s587uDga+LXrOMSNfPxy+qktCxJCD5jzRIBiydwsN9QLxXF
         PhAA==
X-Forwarded-Encrypted: i=1; AL+hErGezQ9nN87+5PBIrAixtrkWHZf48gXEN5pKf1cDDRALEtuWJYAINA66J+k247JH7nEuUByVrc9JMA/Y@vger.kernel.org
X-Gm-Message-State: APuU4Z93UGDG5FHpk5W7rBd5PheBc8AvQlxlDxkIKpr0u6zfuiWGRu4a
	1CT062V8cEPO/YH+XBdk4HrMTYqEd/IhUiDjEr+nH3uLpEyY1E9tDe9BfgKmR7IooCml
X-Gm-Gg: AYBFou2W1/nNaVq/tjPx2AhtN++rCnPipljwtufMKw9dHwXuBX+SulktpaLfrxeufpw
	OFg7sPvbZ4KZKoIh+3KxSj5fkolVo8IgWIMPdj8GxW8HWfVvDcjZldSRlQELBn8r9/5zMuejv9E
	g0pmLG3RCx6TIEnsyFDn+oAugI4H0dZAqpSFbHsG2Qk7fcgZ2KRpTMwD8AUU+J3kwGmbLOPds3/
	K1ZoBl93dxBnURNLR4/JXgibEjOebFcKo0pkJYBNzd+9i5qIk2bWN+gSd/Crb5kImssSAjXP3a4
	t19t8S5RLVZW650xyK2fBvIsCmAMPau9OJhNJKJXq52/OmXtB5OCvjZaCRmAX69ab2LBRi8qArO
	gQaq5z1DfTcrhNQivN2GnyP03Wf3ZQRhdMfIlwiTZHncFbT8zKg2xiqkOU7FITvG33TsuNCxmMD
	mmsK2azfKDd4LK+GVe9PgO9QJyk8snOvAWDaUWiWatwrbBRUyGyJcSdX+Ue1kcJc8jN8j7joHVJ
	uw9nxvJ7QYCrw7DsM+e/eD8rSMNIZO0rwleBc0JAStrlc0vq+nuEQxtSJSz2BxJANgjORo6nx0t
	i31RWxByHRXESrz0mwbbhDI30777krdXSS+9nOYsPBtf3ezz
X-Received: by 2002:a17:907:d12:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c50963dbee5mr161853166b.38.1794564187801;
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm74933966b.32.2026.11.13.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Message-ID: <fffc4f7f87fd5f03d1ef409df76f71ddad552213.camel@amutable.com>
Subject: Re: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:05 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
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
> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/binfmt_misc.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d945b4f6e158..7dc233becd98 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/kstrtox.h>
> =C2=A0#include <linux/limits.h>
> @@ -1575,8 +1576,7 @@ static int bm_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	if (user_ns !=3D current_user_ns())
> =C2=A0		return -EINVAL;
> =C2=A0
> -	/* Never exec off this instance and never let anything stack
> on it. */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +	/* Never let anything stack on this instance. */
> =C2=A0	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
> =C2=A0
> =C2=A0	/*
> @@ -1660,6 +1660,7 @@ static void bm_kill_sb(struct super_block *sb)
> =C2=A0
> =C2=A0static int bm_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bm_context_ops;
> =C2=A0	return 0;
> =C2=A0}
