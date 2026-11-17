Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904346;
	b=MusRvhD4/jSCJuuvM2SkC/5JjhO0+Aw45tzmyTdi6nO9ljJFpibEK7IzvMsdOSlIKJ9p
	 5vDpz6+U3XYFMjOPq89TIxxdoIQGxG7bEbuIv9SG9q3Zztm27o3APiocJizzhW7CzpOg9
	 BaOwn209/3vB4KbKaJsYXSCzktAVyeYFMBrYlIHMJXm6sc1ZVY4WTgGC6GF5TOs/RQSPX
	 4d8+H1cZXqbYROvL1CMp5COIwWcP5pvaXmIWTX4wSvju4WgliX/ZOCKkt11CWf0oC0I2J
	 6YzIEHZ9Y0/UkVFVW+sUX0AiFKssYnfRsUPzd7aHA35OVbScbhrcP9RtU6QlM2YADTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=mlt5lyv8so1t7ByWyweI30aKae7eQs0CDKzHn+y+DkLb4GHvQisJ/tRS7/+kePmMgF7z
	 hPzlswj3QDfAOv9fYFqQpESZ+kYhbYFsfNlzArsVi/yajkeWtIkU+ofI8DEzxmf/Gy9xR
	 1kdQ6wIn7eW/Jn9EDKGxDWlm1elzKjFR/yQbnD1sqYTb4EtHgruld/7ndr8EYgDXFiUzb
	 8jYOawbEwjPrD0ilaa4O4jZTCRwLrIcxNzq11xDrpJPoNjIt+S3xOKrYwBgQZ8TXSAHEH
	 EE2p8iFXCqg8Ihm4u5nRmgQD64cLB+HU5xeYW7cpxzBYbgaeYfeHb862B54dfELUo4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586E606A8A4
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D586E606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1762458f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=TDV8xsSL1E5YTxDsbYdT7ifFMoJQjRi3avgt+tEO8pszEcDcZV/nDfa3T08/uxFe3b
         JssCC3y67d61cQDdTG6VLDqaKkEne+rGkO7lMcBeSJbNvpls4ynD4wrvn0aPyuj8SwY3
         f1EAg2V80ZEP9kLQxNi3IRjpLJN0JRFFPqnqLw0FFC/d559vq7Spa2IHoUzTwBfhbmQT
         YjQOn/eqcjywcWJa/yYK9Zj73hDBwelWs9iSQjpoIfWqG3aYeXhk6dFgkBB4C3mFb1Tf
         5iYnCYfVheHVSy3WKlu5JP1IL3xR/NfijtPXNZF3UIX/TGfBij0m/B6Hixz0EQ+9bU82
         k1Rw==
X-Forwarded-Encrypted: i=1; AL+hErEn5rLB1U5Zxwh1AtgpSkAg1AA9Sk80FXl29ZCgTpYzsuw/Q2F5IIgDEVFj3+1QSD1pXKOnFHfLAgP9@vger.kernel.org
X-Gm-Message-State: APuU4Z/O7ekdTSfhBnRrOo6YOPbhqQwWzdkcI4Anu106JL+NHZ8NAA3P
	b243/Y7qCSHwcb0MS2VRcpAFfjtcI9t6uONy0fLEH7LMQ0WAcBRQdk765IEOiWAOE4fO
X-Gm-Gg: AZFdTZeE8pSQhWJzDR0XmJyZxZB0Y4kf5EsGe3Tr5ZJ0Xu8nIFuQ5TGozUDj39Im6wc
	ka/rqBhwwKOBNrTB6eep/K35cGJANjzXpY4shPQdBHSOGLz0j11fheapg56x09aZiM+52gMoaNG
	yrw/vG6ZFQcP0k5g0ITj3sdk8R7vBRrMiuCHVCMlXVjui0K67OPbbZEOnnlS8xyfwlcy8rYjCaa
	jw/y046J3GfebO9YXIgeDL/zN2jaV6jVIuEBMYHcifF/BbijG9JYdV1t6W/EhHz0rpadmBW4Fpb
	mxS3a2HOmvrzcE257UsndbrLhj2d0P38P+lXFBbaS0Qi3H7HtTmSO675hREYgZHoTzyVtYxGzOZ
	pzMMwpWqjJew3vUJ78XIIS625LE5VLQOn+XAP19PxtTLkyT/NqAf8SqQUuccPb1qGhihgzVQCdh
	huBItYaR0A06cSrCa42SG8HQ7yOGm2MW0Fh0xg0waD3laG+ss0uG4QDkO+BbYT2yPHt2bCs2qaB
	FIkQSrEp15DHPlpFChkHJubt+HdYM6Z/at8789fkNmHwZMwOa4VgEq0/stvli5y6NQe6NwK5eMk
	EGXx6HUT3mfF0BPi1k30ZvoqJou1w7WwGl+g0kcPKJmjq40XMNJU7311xhODEaQEulU7tzE+b7p
	fgDe4/K5zHGx3Sp0YcU5ZZ7jFlq4Vip01TotmECoo4YcNoc3zk6/T5hrm
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
