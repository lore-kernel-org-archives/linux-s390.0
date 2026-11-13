Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=a+w5jDRYgqBJhNf31SK/cFe3faL7zQrIWDnC64zK/pGAGn8yRewe1RHe/uaJe8CRiO/s
	 ezjqAlyuGXuifWvzGaUWWWTjrmh2oFqVPy9TSV+xsYklJp1AwG/lyLWKkwtqsppqVkQT3
	 mYYCO/X6CWI26ZBBS0fWwkNoBti8SP81yxXz53NZO8w4NCp2W3PN1nAK0scMrliK+wuiE
	 /LvAKaFq9sfTp8pO6CQzQGQP5wRjRIL18NKG/9rTECm8MWFhtHJ7WHuMk1+LkuvJa1F36
	 xNqy3GQ2os5qx29kQhfZ0KKdttXlGqNb1twEkTWabnSZul83MQCLlmfPyZxf2pnizHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=NAIb5TqRK3rt/a7euZlPDNCMODV4o+8IhZOK2P9D7oJdA9yQnb/Q0/zGGdlqwnunPu7g
	 BlHIOcLln+L/64VguofTeDaLHXLlUc0+chmPMaNfPnfLljzJSPMy6s3nYxgEclub8LjRn
	 /4eug9RxTI0nborWI27ISz6gO0EeTq1NF84D5lunQQpZQloL2jyCBoU7DXlF8LpkwHtR/
	 E6buraDcNQJWLkAR3YkJhgJEx5bMUHVGFdne6umsiPeu2S0EYEW1gINkprSGh5k+QYdWm
	 xoL6vButnt6iECc4Gy056VX2nUDtXtatZFlnm5VScenvJOXVw9H9eadeNSGmKVoazqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D53606A89D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D53606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so3385672a12.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=izNqWzxIdBmWGX5ja77tq5888FY+4mL1OqRB5ikRjnENpDZ5RVMxRkfbGWfn71fk40
         tFgu9Z0Jyr6zdh1qQrZHZyje0XFgIshbdmMms68UV0m1tfpVQRliajnzQRHQG4Nz/ngl
         /I8kP8cA165Fo8z020Rwp/Dd4NUk77dNfB+iRuiU+lKz/xz7xXz5fjLhah9lQKzEdRj0
         5Pw4liiZOW6WhSrZSqvhjAyhiYI6LspBHjOrtPtnnfyExLfQgoCD6pAS9AljWlRKSoma
         gslncSzAF/qPmmqwH88BTUf9mYJx0gh6NLrSjcPDTtm/qpL6nSkMdhPxLyXCoE2wTgcj
         POBw==
X-Forwarded-Encrypted: i=1; AL+hErGYcpoeJiLB23yDBCBLpfr8fp9Pm0cO1vu0n6402vXrp0CwJmo33bSR6zG82EBQYEMvbT6iHN2tiaw9@vger.kernel.org
X-Gm-Message-State: APuU4Z9cs/lEn0ZvWbSwwqDCn956k9VwyVaIJl8iFRdO/20m/cs0huXs
	r7wIS897Vq4i2VV6OYCkMcZxGqCaFa5aA5m/VBtHdFPoGA0lNsKAZjTID5GBsy3vYuLw
X-Gm-Gg: AYBFou0tw5HZ5LF6ENwCXji7/K4Oa7q0RgZ5EQ7UeI1n4qHmVjDm8qSVesgkOYiUtQD
	Pq8ff5a5snYkEW9b/N1bR4+6zAQYBsED+qKPdzoIJFUh84UD/FVwCvEZHqhWMkUwRJpv4AZqFQN
	x+UoUlIeu52swjCGGVgmp1HwSwLkPOLXfDovy+eWXIreyudOCvDZ6hDHeJ5HOQHETpqdBu6IUh+
	7pP4N2+jCumiHVO0EEF9RhL6QhYrQ1PkxVw+O7DTc1llUFqzFNslChMw9TBkhS5YjQdrVYgx0Bx
	80RUjYcQjuCpi+Qk8UmMfsknhazvMwWp2spqamg5OQ+t0FOYmiEgrR2etaqeez8YTsU71zaWBdS
	isCWE+2zQKO6tmjvqjO5FDbAG9+cucjJaK9H+CDVxz+2sC77JT6Q5cneHsOCtMcw31bYjxMpeJ1
	uIQaYRn7Ul4poxwxyWPrpqsZ0HrN/Ywc8LEG57H2Q9ixDRNygZHJ4unkHHAOagdgVcW2kdQRy1a
	BqUyfnmHrMucfVjIMPYdvGUS1csEz3vwQzw8NaYDpeS7KQD3iyr/s0GmoktmKKUJj9iA0BDjzrd
	0GxlLrl7ebW+/P53Lj4COoWrn0ZyFDyv25F5lSHP4k6GyGfr9eK6RMk0jOVbQaE=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}
