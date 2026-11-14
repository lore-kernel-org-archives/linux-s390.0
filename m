Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=Gws1re0bADb0qqqfFHYsQOt2S4je8IkOEkuY/JUftwF35yCp5tJUopNIQrqVBqejPIHN
	 K7DrcclH8IWlW0e787Hy9we5MO0l1RI3tHAFBLB123sL64uO94ViULMkjkIUIEYMqxf2T
	 FYysiYm0B4F/3wsUbyifbwX1ykjULJpsgHCoNLRp9E1XeJWhlNNVf/jj25wpMGkmbIvK0
	 pC07ve+d25CStwCZE/gVSa+Z/TgIVn8phYP/KI0jnatZyi1Orltj6wePVa8Mf4i0hLkGX
	 7XTMWDGdsJ30sN83X/BKdWeLmjdEZdDO/apHQSdwPo4OcAdfzokgyJao6oMZJ2hLQtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=j8MrRAY1VGjRo97sJ7PqJcaRekoMw0K8sBeIP/xvcjSSFezvT2tOAoZtsSy29N9xHr1l
	 ss6h+WD2EE42ux5jFJ6tIemQwsDdAlPHBn2/oSzDNpIx+S0DEaRsOz9hvLJsWXMHEKOwb
	 XNLiDGmARb22RfOW5w0eoKHf1D9UYTtx1/CbIE+HTjHmQjbenMzrQPKWnAwwAv+EpziF0
	 8T0OFbXze0hNb1QwSzX+OClEDGG3lZcQ6cSsW4cnnrJ9ery6/BS5xSOrSOlbeeOcauJh4
	 W7XlxBvu3Q+AcGg/mNmInwK3OXyM/B7oasJf7/DAG15sHZJygOd+QDvPcndGSFiTezA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142D606A337
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0142D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso4502087a12.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=ntzWu86ZEEFAAg6ypouZARZgIZ12nsKW81PcFF3OPnJUjaQ97H1DbvE2U790Wh7lXd
         BPb4LpQsPtj/JHcEe8ieSyB5ksHZhWK3utu+QdHY2Pz9r6A2+1BtK3dIvOij2oyX+w90
         5floSzDJcebBKnb3fRNKvv8Qcp5/KsIyEfN6PqchZNj9iTJ+YE/3e5rhW28a+S4zicdu
         1htE5Mug5TbpItGimQXOWIS9m7aOMB7nx9c/Pv4hwPPAnPbqUBo2G+4G0SyKNN5CVpzd
         dWGCRe28mGj1DmunwtASXEWIiXEE0hG3CW9AdxBLx3MT6EoMCEFO1hQKDhTOlpONP2sf
         s/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=sLbsC9FJTNTvUEaECLgN8/Nb34283kmWvwLlRXFQNqQ=;
        b=G/rLVBk8Olo9DYbLLDjOpMHb16USlg+C79+2lgGHh1BY2cn79KfUoxENH769Gb/m2r
         5Vfu6o1+zC+6Qr3gSpNBnh9LlnCmeDUEJ9etxdGExXhe5cXY+U0RfDSQOzP9go7sd6+J
         Jv5rB/v/BCIolAAv20R53B+cyTe9jaa8K7GRN45qHm6rAg1073OB1NpmS3dBX6qekLtn
         XXiQtCcYLTAqzQzoRq9WNkfvdvQUZDfjjgnX20mKOBcpKv+/DvKjko9aN8b5lzr21DOd
         3usUEwO5Y+by0Q18gBARPt4RlcJxjtrVZzVlYRQp+iWHN87S8WgwvP6kMZedujF10znF
         H56A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=Wbqk67gvgvDKedl5X0Gtr7PUJw+f7iW0W8rN5rYzJb+1VA2m8c0PZ/T+IJPkHR95i/
         AD/ih3UlaMkOFEtFXyIo2uGEME7VXpi5qfttCebausaSiklNF+Bl0zM/d0nP//iYonNI
         rPY8eOaMZyDaggu6ui9DA5R7tS0qIptGFTmNKTL1Dzb8orE4AgT2Bbx5+9MQb/kIA7xU
         fcu0/UTkg7uxmdxPUYiaP5hEtQhZ2/VWJ1dl0ckNig2edXbF/AFo9mEuZe59bdHX8n0P
         XuJpR0g8YYWA3I2HW9oOWMBW5VADzBmUwUzB1iR2D0sC6j9f4D4lgVCGpXsfLG7FnakT
         0urA==
X-Forwarded-Encrypted: i=1; AL+hErEcDjZ9j0/rDt94DDL0/wSEryOFRl/itgFxfE5OsbB0XVxqh67chlp2FHeW71hDG4USLKfWNrHpbOxq@vger.kernel.org
X-Gm-Message-State: APuU4Z+nrD1JDP8EC8mMeW3PjmjVqvtz9aQH3G3NytBaTBjSp0M+1er4
	6ffvEMENMVWE7/+DdG7Ns2YY8Tux0P0IzqLpOI5w+G/WHppW1Ogy33lAGoy8UxIhll3icXi2B9V
	53NEilZSeinEsOWVugA8g/8iAecARu6w=
X-Gm-Gg: AYBFou3FzLwbvolCXtI/5s4K3lfojqDJnh5OMUaQ7uhRZPOq0A/jbpvGvecO1uksstF
	Ilh/0vNce97LRlPIGLvhXq8Zl8YjtmCrIsrKkQekzCl8KuQwBDQFDvLHE72+1Y1CSG+6c3ypRQU
	Q6xeZ8ep9Kqk0LraOW3j5jIrMDRqaHGFC4NzVHxjkhfRgFlAW7nXmIMufdd0f6DiK0xedtowjOa
	sfHiJx7lEVpeWjFU2MRRg97jFi2q5rENQF3uUJwJ69JGy7DXYH18prZFlL++Bi79Aelj0D3Kj6A
	ig/ZqvAomBprhnn1AkiBMTbPA1ezeBgs7gy6z27v8yovDD70z84gxKBluhN90qmzrGALaCiBbGh
	ohG/e2g5whFllgImfa7oLVC5nBmjptyJa4/GA5DtpDLjWQzl27vJnm8fU9SctQiNj298NSA==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
