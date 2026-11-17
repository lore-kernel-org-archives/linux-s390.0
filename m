Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904006;
	b=FUxhbNWdhO8IeQ5AqZ/btrULuTEIJKMDpM2dQjS/1gvYUjgcw2AU8rLB6ZN+vtD4DDEE
	 nlFhikd6evoIYNOlbTN4wzW+B2g79FWNqiFqAYnwx3T2E5naqGk0IOUg0AwIUu8SMmcYK
	 hu6kXo4AX4JAFyExJLm7NoBanX/preVT7+x1F+da7xhH2aEyuiQca3pGznuXArdk/BsGD
	 cYekVshPC1PMYgwrb9+CGsWsE3cSZ1pDkxNpg68mYlql7jfa8RGav98bf/4DuVeiJcw6s
	 Py0d6DoGdkwfjSJOKVvDuF6I8COCIK18q1yllex0keT7K0n7wmigradhiy0U6jCp/Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=0nkyP4NRoo3YFIxAPNLfxRxG947cUJaVQbUJLz3cWr/udFlt15uu7ZgdS7Ey7I8B69lj
	 xZH6U7n1rlcKwvubEK2CS9eF9IE+tH82dgIHu99GPPOYo9urWeh1XaStuNwHQsTmRr/7r
	 fP9PJ0r9Xfrh6nmEfrPrfW+WRsXYYMoERfe8waLo8gcVuNN9FsF+G686F8ZIBm0fRsE8B
	 GzVvc3MtOosmRraZXTcl3gIwkMwxgf18JXNS+uejXbPu6tZvfIf3HPRb1sM91d/V9fZJb
	 oddRhl5JkL2VaeuPFpNSItqJNn64VKOzqxXERfmR260j8Li1gS6bOX0Q/hO91DbHO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A77606A337
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A77606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49412eb1474so2231634f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=u9vMpvq7KSLxRrK5Rvm93EjcM+vYs+/bI8BTS5kkAfsxj1AzDCJJcMIk0WF5BeRnMl
         cmF6r3XvAhHC/Qh3jtsTXGJfBxa8mxCVIUEt4S6tovdZ/2qRsMYirmCRTXgEIzbNuQPB
         thSajvlLgHla48yJYbhAkWyTrpds4pybYhnaO8mnjnD7ExwhTfdc2IhdMI4tmi76fEBE
         cgp1QCqbKOAhFSNJcd7lvK2oLtOWuaZWtqcIL7aNZ3Oehi1hy5/Spodf3+0X8MybsJuO
         4IfVcYG0KRZQ2V3rK6gvQFoFaeiR+Wjtp1tAPRo4VDyUzPwYRlhCI0BlBWn1VERpnjGR
         /aEw==
X-Forwarded-Encrypted: i=1; AL+hErGCqKhjHvI8B+a0nZV6s8n2FwDQqwYAQ0vSuru10Wfy4kWVckMlmtbjfL9fjP5fHww4PTIkV/AGgj62@vger.kernel.org
X-Gm-Message-State: APuU4Z9DY8OLlYhyWVDNKkfcP3JDLVdOaJLJBoaFt+X2yowxcwPXgP7H
	+VdHzGlwkwdXQZwGjrHtK3J/Al8v2kpwZ1bsV2tBPrJwupZBUwXcW5EGzHrqDBUV5RNE
X-Gm-Gg: AZFdTZc7hI8NIiqIxAbd4bvQ4ejfztmBnOMuhJNRgh+U8VSBGNq50m649ubqs++rY85
	k8GfjBcqrRfGjyEmGAqigPdl/NS2eVXTnc3ENxEs6kEXWQnpNdvpL4q5E1yb3G5Q7a8bIbAdZOT
	RPQQPyQ102XiI1DysZHtCiCkeJG5bg35vLGiXe/mK3oNgJHKcVdy6jgJjIrEVs1psP4+qyz2xS2
	uwd5X3QEmD5Wikwg2QDLICHK/ZvSH4HffxykAORNj8TvxON/InQS8pfssaQYhqcw+N/0zrIr0ad
	2EJh+4qrQM67YoODRp+dFV/4gq2252GPYvKT/WDZLyVqr106Zf6W9mnPD1SJmIDEKd/8DieNJfD
	OJZrepnn61gpwHfvUm6kve02wKOJkHkfTQ/PRcLyR+GgNg/NyNHIK72C4/m63qhtCKbpgcm3ga6
	dx8fMN4mmvIwdHbj7ExOrHWqLtrT82yCmniNSbKbiT99B0+nlZal4I/P+nGZyYGrW2wQfXVIor/
	QMQdVI3r5tRdtJDVVNv6Vp/m4AYACUi3JnU9iHT7Pz0caUf+0apowMI63hvj5TZR30es58omoQw
	v49mfLWXCbmMQraCznOu5llqiqfy2CUogwT0RnzzxCkbcti/lKl/pKClTM1dR+VDCeyLHDWpdgQ
	tO+Wcy37QEXFOIl1hlyY5t0tdPS7UqnQZpSUcXadaLcB2/eobi7SOLYgT
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
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
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
