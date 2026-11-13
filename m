Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564704;
	b=jOzhbVBOO26zymKodVx/wz5VFdXfDfkP551KfZSX+FQLcL8umr1LRW9JuwkEGHcUxapa
	 qfLFRGqvUVrR9jNboheLaj5f02JUL3RfdN/6D57wsNj/0ori0gh79B7lGJLYHhFv4hksq
	 1XJDmK/tZMQiAAYxiC4ZZG+Hg1v+8HXiPhdsGXPLj8BeYaUQiXylmlHBPCT3Gxth7Ifnu
	 /OOzF14bZ1uCAkDkmJCYGSffKqv0bm72sPFP0DqTAfO8CHRwVa1TVBljTuObVwqF5koiB
	 iYVjpjwML6oYQmnbhRBlvhxtv/sM2R6o/Jiud5yYjuu12f8hW7QbovZA2u9njLP/eTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
	b=P752lnQCIut+1Azx8LPPyD/+dq1DZzfujDkqc7yCd2xst12KIOi7Y3xBQZOZeA04Sp/q
	 BLVNQsg+Dua52G/89b1Za5YIoLB4ThkAT7M7pdoiUdqbu2aIeGGK/8BH8WAdXay3+7fZu
	 uVLdOihcKXFMS98tQ5f3ExpLf4+5lP6xHRxAAYcapNV/6U57bEil/5gQLqfE9WFCDU7j0
	 EguHg5+w7qe0a41BxTAavKaC+zpM+HIxMk2Y/rX8uUCnwsMRWAdyggtxa9odU98zAJi1Z
	 RgqO1xY3m6o22YYnrjKF2yAqQmATdTl97r78iuqdEi+qHyUDBlBwk9pm1mAW87P49zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93083606A886
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93083606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4922523d1afso333864f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564703; x=1795169503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=BADxd+iUI5Bylfm9xHmZjb4pgHg0fbyWkyp8vNCt747iYknkt4pGGRNYLQ78EH/z4x
         Vbi/Jq3+E8iOs58TJRk6WPlWSpFf2OpeZbjgHeXjXzKeHm9XnJ+eEvU2VLt6liCBRq7I
         79Td6VY4SiSTAXWOIivpd5ztVkC+DBAB/J4OfHn49+YeU7s/KQ9yNfnwb8sPZOTKoGu0
         Zirp8LScbJznGaQAXzatlGuiy/pBfqScnET/jGobuhYjlwMbyAqyeVJ7smTe1nJkO+dB
         h89eeA8CIS4pNdPKyjqDo55n+EKX5qBSzrC2C/95dZzzzQLBvHRJ+46c+P8Bzg/7r93a
         +u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564703; x=1795169503;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=2wii+hlb53ugeTrvWlyElORwQXAP/K1wSXsUAjsdv0k9yrKRB/kvDCMpvPto4GXi6q
         w0Biylioyvq3VOdNZB+Gr1n/Tv31OHlQGvMeBt8GZrDsuhuUM2epjy3W1u9Jw92cu20+
         FtRI0ezK8kmkXL+FCtaBnE3ozW8DliJBWUJKajfqfFBcFO+AHXWPtQLrty9VdQ4MySrZ
         EBxr5OJFYzhQqOyYriSJSrN4GNuRSXzy/SPu66PAgciWQ0I9mp+lGB/CsPurqng60Aev
         lKddV0xpKGawyItVw5bfB2QhKOfjpu40ivHjRsCMDhi2N+HXCXXwrmze3L1SbgyCDCTT
         Aijg==
X-Forwarded-Encrypted: i=1; AL+hErFJOCYG4wecNaB58CIFaeCaboyyXm53dFGjoKM08k6y2hQkAhrKix7rk+98XIyjuIJTGclRW1GoXqsb@vger.kernel.org
X-Gm-Message-State: APuU4Z+LV/yAm+Jxb10pm7q6x3Ov6weDakpjN2keixXPHInQcxnDAy3/
	Tx6KBM+SdeX77DGT2fA5QSRpGdLxvI/atNWgL0tWkHecq3H68XPEmabSCcUyXqvejMtw
X-Gm-Gg: AYBFou2ThSzGgv4YkgK6W7mfWtGfPHKL0cCRoDdCnynakpUrFNbNe0Tw8QGBuwB45i5
	ARxuMhb7uNFDrtJiRBLe9hNayZ/uX103kPmQxG6yi+hdEmm2I41fMARqpBDMikc/8wMKprTi40+
	bPtK8gVx5+1FtOUypQ5MWvQS3ZU/NKuQh1LGu+wT+ywc0lMwoQiiUNSUcb3xvIu0du3ntOh/KLD
	sxynnllDzYVVHzCsd1nu1Km76h48+HfYtwdmv2Mi1cGfLuvggvy0hX5bP/ajP+B8DycXVXhM8rL
	+F46AIx4iWHopKXlkBXX8K3HAPNhbKANztNHhI/7RK5sCWHGsOCVtc5gT6eqbNxRDRNZ5PTyQEP
	FsbMcuMKlDjNLztLsPX7Di9tkqwq0WHh/sbTSmUeydqgvPGueHRW5jXPF82HpKto7kmJ5+RPGwS
	ZuSUNkQlvkcxpDgXWZAE13r3upKkb18Np0taVrWwepk1PgmgwU07YcRHWfXPzPSXqMv10Eno7MA
	kqSLUbh/axr7F0dF8CuVaptq+c2fHDb0xzmPRUcT01lBf/LUtKLVfxnXY9RLqYvr3ALjluLxfVE
	r4wsO30GUobqzWmKug5oiLlv0rhuBJaSwq67qMTK8aYg4izvHpocMOfvZ3i7PVQ=
X-Received: by 2002:a05:6000:2501:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-49c73259cc3mr5012611f8f.14.1794564703010;
        Fri, 13 Nov 2026 02:11:43 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm4931434f8f.11.2026.11.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:11:42 -0800 (PST)
Message-ID: <ff6d2a8c8623f5476d5c352dac1ad98ab3da303c.camel@amutable.com>
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
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
Date: Fri, 13 Nov 2026 11:11:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
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
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file
> descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't
> care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear
> SB_I_NODEV
> again in sel_fill_super().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
   I.=20
> ---
> =C2=A0security/selinux/selinuxfs.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 310e19efff1d..d7ae853b6d68 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/hex.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0 /* last one */ {"", NULL, 0}
> =C2=A0 };
> =C2=A0
> + /* Android init opens the null device below by path. */
> + sb->s_iflags &=3D ~SB_I_NODEV;
> +
> =C2=A0 ret =3D selinux_fs_info_create(sb);
> =C2=A0 if (ret)
> =C2=A0 goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations
> sel_context_ops =3D {
> =C2=A0
> =C2=A0static int sel_init_fs_context(struct fs_context *fc)
> =C2=A0{
> + fc_init_pseudo(fc);
> =C2=A0 fc->ops =3D &sel_context_ops;
> =C2=A0 return 0;
> =C2=A0}
