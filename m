Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904112;
	b=t2U+4jpkkbV35ffSdXT/W3I70BsalN1oOgSAnIiES8EgsfIGi1ZeQOj+N0OZOF2TLUUU
	 HbOtRAibc1xYOEASaColHZEd4gLxHvcawX+ocFSBirKRjyX12wJwMy7U5x3wIoye2piS1
	 vZRmP2T0A3jf1uHiogd9R/7dz3QWZ16LNJfmOSMbhEK4IlzoErMuTC8R+unWmDDQh3lrJ
	 9kJFehqZJdK63ccexCSc71424fJSIYYdmBvswgieNu4EkMPq5JKHuLb6CdQGKotRzXedS
	 FYAzxeooOXejgH3nndsyydqYKXoYwYEN9SuCHfD2RPTXAEKMt409vffJs2U5d+vY5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
	b=dz/C6K4/yUcxaEJCapmnwVlmo9PY4MafEsEi/BHkOz0dQcT8qXcFKkETmGe5LNNa/Z7F
	 duFkkzWdBP6ahc8Lpx2DPEvvvxSK5y+rZX3Hhn1ZgeYysMqmCUvvSexVJ4rdGRcbeWTTQ
	 A9ViV/Au1zvuiMYoaEFHk2Hr3799fNBBmfcLGLQUdxkGsOzKN/j7aUpvBk9X9JPryoQL9
	 dVmCfsiTS0eS5WQwGcH3yOLpYFQ57/FSPYpehurOXvv/K1XQxJWjI6MkG0viQt6WHM5nj
	 dzWr0Ve1DSZ4QcMxIYCw+j2Di8UxevD+u3FMkoKloAdxcM8OL+JvKWALP0v5nAIpqAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="lDHE/E60";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110D60A2608
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E110D60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDHE/E60
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso28247915e9.2
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904108; x=1795508908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=lDHE/E60fAF7y/GcfWe7zssqpibfABjaDWc4DbPAbANFwY7mipSCQzk/tGna/Yk9Yp
         5M31Ja6Q4S90Eg4jWdoE2GH6TurYV9Y9Yxd6SoBGFySZlSGgcD3Nf8Ac20Morq/IEeLi
         HZNDCkpilOoqmPVEk/N5paMQG+RjNO9OhPzIDtVn6k+5pNMY8rSlnV+zGCrptyxwBw8i
         uHdMwH/Pby0zhrQLCKl2b6izfUmExSZrUoQCnWP4NFP78u9vhGGyVwUcvE3no1VAV9ln
         DDlxdlg3j7mlBLcF1wQFzdXfstbmRKgVspXMjOajtHMeg5NsSNAba7k+RMZ1HFntU+s+
         8A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904108; x=1795508908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=2Y2/f3+w72GJLAH6+kFS4fjbSktax++eT7Cc4ULxqoMdmPpLerOjX/2Wssl0NS7kzA
         oZoYsFz/Z6bOeDn5XPxCDzDZTDBWd/RS6wtXSoF9rtvwAUCLS7dGG2eFNGGkmymd1cm4
         T3V5jCCmW7+dENC8Ohj0D8BGtGfGGBysqmbfcY+eyHjrwT4iO92V61RCtD+hOJK46OrS
         GgBGLHjy5T4c/EBGzmkIXPftrh1D7tqCBWcmFkdwWFn7vAPnK5aKOKDWBFM7htjFiFv3
         YHoeD/TnLCgIBb0c6O74jcafIywtoNJndhwZvDi+GuGXYCWxMJrAcbPQXu8nOEHXmkXR
         7qBQ==
X-Forwarded-Encrypted: i=1; AL+hErGdboy9YNnPLNqRAvqfKCOvDGuJBUbhUb/4I9806HpSrjkiYXk2DQM2WJpXOXfChHeLFEE6JpmODmtQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9pn4CjgEctAsCtr+amO1Y03l7btclXdellWH5EjCMaMTu1BK83
	6BBOu+7G7bPVqAo5Bcn0UHZYFU2tD/G/8dFBs3Vyf7KxsF1bTYFbElltLohMa8/VH/iF
X-Gm-Gg: AYBFou2N8EFLibeAr2xkc77F+ZxdXTDhYcoB8MK9PoshS8gRrzMYk+0hHWrvgQLrdxX
	rm61EibXfGeMnBEAg0e7UrjdfDuIA6r0FMB/or5ezoGMEno8Bhn/eR5NjBdjLuKC7C1d9JlRYV4
	T4JI17oN+sE8vzBIsEq8caHWQkHqLDLXdn90vszRGcATjUayUw3leQW7s0M3kezhHm8UK9rtu5Y
	cGn7Ki9Hy3VWmXha4xqaPZpz2xhUyBECQmFCXwfiNE9s6Hcz3oSljcZYN8fuX4ZubbkfvvvtOsj
	1ibxOaMNRuoIx88MhrV62IWv2RYK+l4pVKdLwBNhLCVwnYyz2/SP4VCo7T+Nkegi8zUBwasjBbz
	5cb/zYEA2jF660JkeYKXfxOriFX2mJRzeihWLhbkWI6409P3FTFzj1Icp4vOZ6X/X0WuLEuSEkV
	4BKulZ36IV1deUwB26DVnEG8sl5FWT7F5P/3eKNhIjBURi+6V7dcX7mrYBNR50mCW6eFGzVCr1C
	K2Vwjxl5OsIMtig5jQUx55bVXE281LQaFSPWKZTq5TXaKvhj+NLXude7jzQDs3LgkKyx4cPeZy7
	M9yj1+PfbeiGmsME9TaD9AyR5TLOaDU/MRWuAQLLuwO2irKUMCHAtDNrToFOqPxrRKwoemCcXvP
	XRzzZjipMQf4lxlCiozAIqdIwYxrt321WD5vGU+osaCX8l8WiM44pxxvx
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr255399085e9.5.1794904108278;
        Tue, 17 Nov 2026 00:28:28 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm75197335e9.10.2026.11.17.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:27 -0800 (PST)
Message-ID: <afc070a816e3ae5eb3c9e2d62d4f25c59ee61df2.camel@amutable.com>
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:28:26 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
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
> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/xen/xenfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 37ea7c5c03469..aba7d038ed735 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0
> =C2=A0#include <xen/xen.h>
> @@ -80,6 +81,7 @@ static const struct fs_context_operations
> xenfs_context_ops =3D {
> =C2=A0
> =C2=A0static int xenfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &xenfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
