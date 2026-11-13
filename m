Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564657;
	b=JsXtwJJ0mN1m6Q6D+PVqYWDGNdeFZkHrRyAdL9fB0qWJx5xBl0lBQga2dnCt/6kdQAMX
	 NMpNMWgseSfM7lUfwxQ9BfZUvw12ZVisGsMvsxYYcxnUfB+KuAoQflLnvaWf6yLb2O4jc
	 R+M0UEBUTShLMJUBaVqUooicq7LXAi/iYnqiBd4r1fjIRf9M5pHe5e/DcU+mEwUYCwsZt
	 ninEsOAhFvnCMTZEToeEOEOdobZmbGdygarb02SQHttPLljhdN2ZiJCokIZwphr8C4hnZ
	 7K9v7kl/AH/xwwxlxin+F2UR1ycgPIyQ3cGUXVGhGYCIwaQHIEHfn2CLxpJ6/MELfjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	b=WS6H4CXxUFeCPJh8qzzLesOl9uzubQp332cAbo3OD8T0jKyhpNoUiM88hWYOBV6rqbus
	 yaQNiN0UnoZ5V5HE+Zro9Ixriru2rMtQtALMvpz1d4EDsb4si4wNRyjTns70qPI5aLHeS
	 ypCpQ/ksMB1RIh9FoUt2Zia7YMeMbTv6LLMjbdnGC8F0niYV9eHSBC7OSiFtCCU1yOuNX
	 PbF8fuqbz+i7h+4tZYz4DdrQ5qusGfNaORTNAWxMuGvAT0EhXkjzDX6qHxZVXE5TZU+8E
	 6coFZx+lCwLrWv1Iqt2MMK2qL/1jHErPlKhn73J0dF8l/8IIij5HnJwioPtt3J4YkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5A606A33D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD5A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso395265f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=afSYRRYW0Lzg1RjNF5a8Z8fp4FTD8+wBAkqEEgX+uXVLN6iB/1Oe+S3s3pjBsHkfPy
         t+OYs+BeBV0n1jEyBb10NVx3dBSZolIBqoZV0sAqk1NmAyPkc8BtADcPrCcEDzdTW4+p
         zgkm0FzjpTOQt7I53MJB0zmRNwJ5JPK+9oiFhFL/qPiFq6x22bgZ8fSq9Se2ho9ikF+q
         rg0gx4TedCmdQu2h6zCkoXcFHWmQ+ZQsRVeKTv2sVCXhncyHGZ2k8DCVvoh7926dtvhd
         5w+l12l3Dd1UCqA4z70s6tomNhqNtGqcJuf3lRDB60cxVt/wNhZpOgzeegjchzcaCyfn
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=rZjrNRDFUc5YwMjTSRGF6FUhUrLP1XLTTWZM8orswHSypNSNpf8KBO9nDkQP2wKcjJ
         rRvNVBULH2Q20t3QyppkhzhgcQ0C1noGqf8NAHIX75iBG5pfG2mMlC6nOyGHWJppZx/7
         PaZc7YMWRwzXpHVwFpalIlIWR3A8LVzAGnCOrltsWWRDlpqmbxNpBszQ2mPDDhu5i+Su
         qvO2z8tQBCsnHD3jiwpQeVQ2Wq0Qp0ywojApuwvf6FRCgxkIhP0m/qvxPlgCjI1ZylPm
         mD30RcVt5uVSrTGXjeJReypGxjcOJ/Rbhucf4m4nfYWH+aA5Gy1p5qjLPcGcJpjBczbu
         QhUg==
X-Forwarded-Encrypted: i=1; AL+hErECmaJpY3Z75SVtoaqqk+N1wh7+aXc65DSJnWkHGPu6gddD36v9O3d+Rx498HLEnyaLit0SmvhoXnfh@vger.kernel.org
X-Gm-Message-State: APuU4Z9f12x6uZZsXzOi879XJOgRfF/cWLC2dK+BKJOTLaaNLi1GSP8a
	LS7z4eNjZLsC5Zmw7HEmIlcNfGoujHpephQXmCBKs/D7+rVMbPJoydImRk1c9T7ajoeI
X-Gm-Gg: AYBFou0N4FdbT+FaR3C1JOxF8WAQ+pnZa3BcQG0Dxp4LoSeZDiQgD7xAOjwZ9dm3LMd
	fQWiO0A6yHNzdcqGy+P5sIEA78UMu6ZR81/BK4hecvhqSAJi6+tBNLyoV5IhyWvxQE4e6i7etFp
	LpmTQvQnVZazNgLw6X+9BD+x1iy6fku1cQ9Md0dz1TZB0/q6ScXZe9kQMqVr2P7eg1OCWbkn1KP
	h6zGVFxTuNZYz5Brxpcj7BshOKjyzVn1/nd5Dt0OslMXCQm8JQvXnspENhrn75OSn8UJn+gpqz5
	E7335tpnZXXpDW9w+R/Q00ogCBW0FxBZ/gVFv4eCbgCJBecsbjbcNNx8OvS4PT1DnGUz9qI6l+f
	VZui5E0Pw6L4cJk/mbJKyz80XMyHqm6vft1/RydyTwBCrY26Aw2crVMF5H10RDgZM9LFM7PoqUN
	tNdv5lKF0yt8ng6myIIXmnu/4mqhNE7IYm3W7QabxxgwOuQ1YkwE2mQxLUAfiExIUlgPV3mvghQ
	Dq2GxX7Olxx2w5/BbZLKjxR7eiExekw57qslxSNbUjFk7EDwBZWzpelnZ5Nf/uUV+qHSFX1VU5l
	4NVYL1JbPEuBQRM+g1L/EFS7UGPGeTnCUCcullgj1h9sE9uowqb1L1dSASRzRaw=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
