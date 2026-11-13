Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564364;
	b=OGKiogPNa1E4W7UnP9kWTHxrWS6gVFjQjfR4XEBzodNzpELypkYIi1nieTxSx7Gr+1Ze
	 y8D0cs8FzCJ9uePMKmPuB3+T4TP5wGfZi1n/HrPplk904GT/Lk4sKtOYOEXHBPRNzTrv6
	 gJo4gSADAdzwjOTMdvmcZ/PJbgZ7SyuS3jVx522ddJThPrmQ17zuw2IFypWbbzLSpvfPJ
	 pNBR4IwrSFjqRrp/DPs06czQkXY+uUaEpjC+iqdd7yskTM53FgVsA4jcQ5F/o1UHjxKND
	 LdArgYNmQ9gssac2E48s53cske3Su8x/j1n716kvO9z01ytjltF4QvWaHrfjFFCNQHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=SvTNulzcxiJyJEDEPosPRRG5NcnKiF4qfJm0Jf+s3+2NdgUIfWa4OFHSI5sGFHwcqrjE
	 kxIC35q/6uRBuYPgXfLtKoLb46RUZ68cqHApCfPbtH761ZlUEH8sSp3NKKZFItk1Sv7mi
	 VdJo7DGx2701hNfM68fWk3rAVYiI8d57YUtFtydZ2UYNbty++hQLdTxe4G0oTpHaaVUhM
	 U4x2QhN8F4kbWeZVmQwQVitCREOtYQ1J4NtuAg7Q+LL6R5N8WxswsEPbU1nun0ITBbMsl
	 3akPGTWc3BaowIgh+GK2PSfFok5lJhY98IxYKg7Saaksel2gz74qjUHw6PbQpNAVVsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE160A3809
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EE160A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50a4a2132cso51085366b.3
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=dLXV5WO1TCyY5yZ5Vccnkqo9ojRTsF23eymSkVWT248aoYCfCxU+cG8xqDd4n4dkMs
         EmUxvHVsPb03oPmITWfQWmLqUUneC4RbG2Qnh+WjK2nKgl/eCvMc/CL5HUX4ND/0oDO0
         j2MgI40wj99PZrIb5R15OMFjP1hNbHq0FaIm9/PECQ00/ZyVT4/hUG8WCwLUcAK9ykhj
         MAfZENLUhsWbFyXHIST/YM7kypBONOu1BP36RFAkYF41PSpwyD3HMJx6ez71UsnrJitm
         FN86FNsCmKCylwemErdZgJE2Bi+gQfwfMq3JcqHzEHFqKp9QsiHBQJ+hslXkNXcojTXp
         hWRg==
X-Forwarded-Encrypted: i=1; AL+hErFfByUu2zaZMTTI0ZVS5Evly1WFscv9Cd6AgU9y0AS+XT6WonTpsoP6sSuLh5kwzuDe3+bd2LsaQewL@vger.kernel.org
X-Gm-Message-State: APuU4Z8lXsVR7NrVXyfEYImbgOaRWeCPG1GjQRAkyf86triKizXjNLsS
	vswnjuC/x0JTjkCGbTvVgYEAK541ZTbGZCoYU2OVmhLqeDo/lkKS2QGsZmqPaqM8d2ay
X-Gm-Gg: AYBFou1m6ATEESNlzufiUd5M0ImyDED6HWoCZac1ltnyR4BR4pE4knGYKpeQttDtI3c
	OY/uiJfpjx3Tq55+iq4D741GRvADemETiHJuZY5RnemkalrqiiVsCmbDWJA42evHsmc9n2NIxs0
	68n6YkCmUR58Fqctox903g4rSpgvQlIyNgUaoNY5chQU0RCUYNNEdeHrIi91kZ/jIGohaDuX0lU
	OPMkVZ834CJ82BOvRPkunPg6p1ay7jHuIRsfu6MS8/QUx4Otlk6kz2KaScPK8BQnUJAqrvPrK2J
	ZKMFbQtI4Sfa9+yXRGWXE2Wrg9XcnvNlHBeDpW2gGL8uVbnQu3/4sHD9fNQip9YxpS9/6M8UV15
	96kR1S3GhS6dz7oUFjnUNxLvfCOrp7HTZTdAqyqdRnQCPn4PZ+IyNkL7nEaRfMfnG35PQtPN3cK
	mUYl3J43BvQ+WSUeg/n3CYqy2xvQBhxXtob7ot8Bg1dFDeKS178a8F4BHdsM4ax1Xw4UogYe/JS
	z9g9SDoWFBt7Ue4e/8KUHIHILisNSU+hU424x5FfFGbfYJIs+RwzjloLLZjDj6bvSTZS92US8s2
	1YGglRpnn8LTUriuVTes/Ozfd090rhAK81ArIrLQS6oR46DKAgK8vekGdCaj/CM=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
