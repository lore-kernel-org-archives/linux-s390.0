Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565073;
	b=5YCYUwyAF+BKFxqYEHaEJgmxHF5z9TnSzlV6yHhEuz2bWfTHsu1GblCFtOZu0QLqy6tB
	 MnLtPg8rpMhsAAAlRufEyuZQCcjhIDDkyGXfpMerYpt6sQZSlm57hPqofqlMQICrBAoRG
	 koiNLcylhMg5R/B2J2uSA1W2icmw/TRBBB9RQxD3dNjZJJkQr23HbO8QUP0I8bZBVMJdd
	 f2jTXuFDcN2P14IS3LCLVRFRoSyB+PchhTVKPFzgL+0bKEkhRLawkyi4rRqpMqfgKLpka
	 rlW/mZ9muMswg5Bcihghcp0bxqWOfeQYzCHU+VslVuN1z/tuteaWJrnf96yi7FCMKHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	b=iWdCJqGOMX15DiZsrrGKOGZlS5i1vPwdKvCaiBP6HBcTZRkkRdxPKa9XVPJ+HI07s9Oy
	 jGc6sM36SVwhVGal5JLcTEPiwHVmg8A8Q0f67zlPwMwFIlTDUdH3SNC4yJhKq9o5Zv8C8
	 X2HfV2wemw/byn0ji79MDHN+kO+bfjJK4IfXPKhw6hNxDp2Sy5H53iiq82xNXGEVPd/a+
	 M21El+vO5GlFSnhoo/WcNU4TEvs0nlDCfcBJLk3/GqLX5DoG2fchZ6wq+UMEsHTae6hD1
	 xyhPpKF1xOX9L3Q+JlwWmV0EUzJPysppszn3i4NOeSEg5hv/OWdQ9Ttx3EcsNB57zXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E0606A883
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669E0606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13807565e9.2
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=hEEG7fG6RzQkOoGSL66zkn+hWpy0b8TxpW+CxGFBwGxbhLfdgmFqwESmbjaY7MScGa
         1TTEC4ZDzMo/nTmQbATUq4OC5CVK8FiegRjrCOceUr+V68t+3IyOPEhrmauT/typpuMH
         7BtZ7bLX9twnpc3pST7EzNdPnkg3BFhqHXhYG5RTwPNXEKUOMAEYxir+CLBCGEbp4xnq
         ot2tG8XA7sYEn5cZCga4RcL6w3I4tCQX2A1rGgTmCQohN7lvb4NCOhavzOt0i7fRXz7K
         0fiOYrUI/s1Mo3f+qCL5v2ciULr5WU1WUhy3OFmgCMCM2mU4bZM+JgAT1J65gELN03wt
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=uNP4CrEUDOssLe2MfMdsfHNGcnT5Mh1pmRwfWgc94XpZBElCCppZyRaeEAZTj+cF/w
         BVSmu5PYORJlZwk2Qgs9tDKCpKvpmozSO8EAfadTlslktyyziAKrzRhl7G5raz9IRehU
         1HVT3sQXahEvSpxRHDiTIl1aNMbCme6nzCj1R/6N1QT0N/aKQJq/Zyp82xyHGyMsRlA0
         H4vjjkFjrhg6NXROT4LQv7dFVdHvnRcYAexXTJk64SkK/wZypXDDOMpSyA/J843dTO8j
         AMwyIU2yovfMkxH6Xqqp4ACLebs2PIk0AtNGIrNWs2r+yXho33wv20TU3Mf6TaNdsliw
         AFuw==
X-Forwarded-Encrypted: i=1; AL+hErHddAGF2RDgqTueQOv+aC/8Zt4nIrQ8EfPCs+Bx3laVbRDNv8NL+8srMzKLUAeftpljKI4jLvuXPKW8@vger.kernel.org
X-Gm-Message-State: APuU4Z/7XqHc5a3pp5Z0adXAs7BHxzWm+Jdrq/MY1RymNWSFZcwh2mtU
	6G1Fafmzs8jNgscAAg2wP3gZOe5YhXDC4a2+JWSA1E9r261NCCQVvPVDIWHrW/pwd1Z5
X-Gm-Gg: AYBFou3s+C+a++9+U48shSSZZjw76Ai5cGiwiMrsD3Gh3zEzyFnpTYKGN10ph2VULRK
	eyJ+4bOKQpUokEW549r1ZXoqKZ9LxcsGqj5EILZJb6jKVGFDO4KEmNIMAf+kun+6dmgzDBju8iP
	I8X2Qfc51GDqtq9W7Lps4oleZaHIl5axw9K63aIQ0hacu+s19bH9KAovFOfoEH4p0Dr/GTvxxn7
	eSX5YtSS5FdSI24SWI7N+simEPARZjTep8HTgpkMage9zj7lA9JLowOc3vgUnTLkeUtEHhRmMYm
	Bl1FaqKM9Krtue5oR7YhkdZsKWUlnvcreUbH6OLiHZeCcJBmz8yZroR7fe99NKQW8ggs0gy+crO
	wXZ7Xf7E/aX7o+ePLj+RgD3DgGfp1gSsIyrTacVTdOxUBlIJfigqZv4wN9+8y4Pr+LIpqAH2lFZ
	MXRodqB63C2nthnwSWYoFBNDTHczY4batX23+Jn2wsmx4DuGmN4WPn050FQ2upt3LAu+D/R6czw
	HQbOQJ+2EXctPGABgFMMKPbCJkXPxC+wt8RywoGfSI6+jUceLRGKMxPAmddul1loF1XNL07ey+W
	XnbhTt5760C8oS4lY7Mo5dGeuT7lbbRDTP27UVqTjx++W+ksvhcbVXIWtOIfq3o=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
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
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
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
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)
