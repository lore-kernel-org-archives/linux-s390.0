Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564337;
	b=izMpnln/nnmRtyOPuku24ykwOaKznj/fKvudIMBOasV9Z/lXpvGrp8TPlFUgqhXiYmwW
	 v+rHV+ObgTT8QgYRLn1P5JJiC2Ml1waoey/U6r8tjvZ2T5G0N40Q2KY9zetYmcD5qzuvP
	 oyCVrqruUIpq4OZjs7QL+1PcrE8bw+ox21iv0gc/smM8C14vyz43uXIx55nJX8UgXdITw
	 xPyWsLcio9ExBIsltVL7flQyYgRpAfxRV60f69mRXy+Eyj9ZwXf3NRVx2pcPsWuSBssVR
	 XDDvKGeWQhbloWERd7pNyTaNwe4JX5e1rTI5xt+u4tTeuRNL1p+9cpopXO5yvj2xaSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=RZiGLkrjuWg0pIS6WCbwYYcmFvItXJ4KcZ4Umeyf0ppXnW/mRIfG65QpLVTu8HrGHpLh
	 4D3TA7BkkDB8D7ymLc3UmsoY72/xHbzVTFi97gpQoPsiwEQSvEsRYrPuzyhJdYMJEW/AN
	 QOdlYMPB8Gl1Pfsip3XYJvfUVZSnpK5GC8oSu2Jl9fP5+GHnkek11stswvNalV0egi3z7
	 Vz+MFTGF/MXG2anoxAkXAq04YmodbN7hT3JcHLLg1ZmZiGgm9uHkSLvgQ25q7nD5ppBsh
	 whPIbj5TEqna3Z0RATx4tF6dYKnCmE2fK3Iw1VSmN9AUknshC0GEZrNfFbXYBT3+80w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651C606A8BB
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D651C606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so1381280a12.3
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564335; x=1795169135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=nUCLd8f0G/K2fMNIytq9u2LWpw8l5XbCSUxsIs6+S5nVG1T3fI5ErIjnpvRMTRJ1g3
         66+hupjWTQxex7ntfQ08B69tN3G7DYFzu+MIzI3GxWcQnqgZu7yay01l+4mpEhy0Ef02
         xbNHIv/PH0KitW7ZH+pZK/qyW26JriIVV4HRgFAXvls3DDajVpT9R5cy9rfpfJ9qOhH/
         quuiU6KaH+bd+1MNp1oe0tS5lHpOu5FifqraRZhGcQQrLcBdrSt8hi6RHYJpJDDneT+2
         609Jb+e8BW/fqMWXfEgOdGZ8nZZS6I2LapQ01HWyupMw/vLrZIn5Q4gffAveGLQARYQM
         rrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564335; x=1795169135;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=erb+zz0ZnvtxMg0MNliO36SrGfhnBwhkxP3H6icYH2R2EAKTH8q3bzfaHiSfLR/pSr
         xtvi9RotOKjhtes5CUSaL6MVCq2lYC00dulPmldPlqDqyVis2yoG1WatgCb1OCS9Fr3C
         fpUjJRz3ezhTS6s4TPGPLK/+gYcWa/buzPOy47pS1C4bBbuXHErlEQ2NuXkfUS2zGHWO
         zveC7vsNGRl+3u9YHgeRIchid7sVHaxoMdECD2SdJzX8IcnxeRIyp1HhENQkIOI8KFap
         bWs3BMTxkczq5bQ/aX9/L6VxnDaGAbwa15h6yymSK5+3TWLH7pwZBJgNLEi7dWm/3uN/
         amrw==
X-Forwarded-Encrypted: i=1; AL+hErFvuBdCeKBalVWlcmAFeDfSaa+rLPp9aQpV616AFwJjm7J3HmV7IeHQjF3E62dY9pz+Y51rFTIpaxy1@vger.kernel.org
X-Gm-Message-State: APuU4Z/18JncW4abWdyfRA8Fq0X/dd9sRYUJTNtno1eqDPlBldo+vLd5
	UR4z6i39I7FtBOXw9v49UIf4DiSvenbo25nfWOkPnNpJVJgDL9c1d44aJX0RIszGdw92
X-Gm-Gg: AYBFou1PZuNlki9vyF1wUEwrbW4XuhO7NEsW+Y7rcfbqhkxGfDZrCtw4XD3+TtGgEZf
	306iNTrJwZKCM5Qyw/0jbxDwxV9cBiHrU6N6vB1b8RaQ+DMqq53DLlwJcXClvdrDoClngV/efr4
	HZf3JLV563WFFfSmEE8weoVjFM/8k9wZyjjtxlOuV4kC7L99giu8nkkJGkIV/1pJ6SguRIt4TU/
	oUwEjlweVXCtm+PzqqYyNgdHYl/ABYvbgh6ULNjTT3g8TNkdizhJvgn0/z5wx1cCfq0LQhXwqwK
	Ob9kv3gKGBbm0UOQqJ4ZIFGIPvpWD1E7bFR1e/QMAPmpPKoO3U14wWrcjJOWB8DXtqcJ2Ukc0GG
	/abDkqFQB7QOvGPHKrncLejj4X8/TyqYC6fxnXqBkFzqNJ//fyoQy2TrbWtTfE02EictLdy7QYu
	mVLmTBuUfjydKJFTX8vjq8xKQNabnYWwnWAaHpbOkjDcNT1bOrbeogza1BjjpKejjJxLM0hNaI2
	YuOWF6+NyqUcQKcA7uPTUQSUg2T00ZD+HQZpZQm/ns4ZVv3ixHdX65gbcOz087ACHuYJcxB5w76
	a+yM/G3XlGhXFLX2sq7HY8fyCJTZx3M0isnmNJrHM56ChthDv+bCA8lczlkKTLA=
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}
