Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564919;
	b=xvZZJ3XGQWnHlNgY6U2bGu7CVpWu/33/6niQtjU17DlMoSpmddqJl6pW3PPcpNhUW5gU
	 hpGUG1tzsT6uSZQOg50hsEsEFj1B2zKxZkipVxOtHem8ONqv8EAMAgG6YVgmq6mWlb8XI
	 be+Yly7/SdmWDfmI7UY5zt33OQNzrIQVawtKZaof2QS+V+R1C1bPwbDgRWeaHugbS1QG9
	 i1KnwiU+JJ6TWf0yOQ+iKzuv0wjCOYq6my2ZXzKositfxFmGpXIn25v4KplD70cl8s0oj
	 GUWZcBkhce+4SSQd/7DrqWP7lCNUOBmmMPtQJVeQz8TegGEzE2PdXVc7Mz4XHaqc6bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
	b=fdx0PpkqA8F1L2RO04KhumTgwg+sETuj9gGbFsehM38z+tHQdrVK1u3ZXlogxTjhs5db
	 B1B1dl74/daXTHnXxeFrlUWvH3x+4OIr/3cNntu1+dgUl29GHPjSzhr7JuDFyN3018H/e
	 JiggsLd6UifWXIc3W4lPhSMnd8eliyZJq0Z/axp+U9MZVwiFb7aOGeKemUdSp0FxuFkUQ
	 8tryQGyB16xoibqSgW0cR+axf+7zufMdueL6G7+lJpllDbcX6H8u19fjKhOyD95DpXMx2
	 xEOKXwdnLZCZ74VDDykZpvwMI45As/RWFrN4Do0dLCIeR6meB1/2+Zrikv9y6iCHPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D567606A8AB
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D567606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so4413355e9.2
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564917; x=1795169717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=XokUN4uhZ5cnIDNPS9kLjfaPp8ZSmyDY7nHz3ffF9uftFGQzzc0NaUd0CPxl6tmm/G
         EB2bqVZrrrQULKzHfxmMlarOF7+NP4G1EuGLp1x7hwkFzcf5DKQIlYH5+zTWTg0qLXK8
         Q27+pu7matN83z4kFimCCYFY9EtcVBpSYh+f+WbPWczzC82gi2dU1+IxENiNgIvD4ssI
         1POQJndyP8zOY9I/drEtHc8Rir/wcokVwFCL8xkdsULqRcKqvw/m2pftg5e6OYSufYMA
         FPm06vn59Z5lYx4UA2FpKr0UjB0BBdejlJLIE+RKFWt9/d0/clXrD3SuYpmwDbHdW+74
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564917; x=1795169717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=CHC4FxGqQjjK4+Vu/e9bmuUC5k572aE6GpZa1Db+7UQpxEV+zY8x/Jqw7YaN6ta8Be
         zDpJH/r5aRLGee2Yk9tJwBBLY8gRZPGxO8NG4ICXksTz2IElXC6vnRMjA0zGqfYY/BkI
         NUtIm8kmYLWK+lJ/RHU2uHakqzt1tutYoHAErVcKR/uqajqDtCsQSoEsfaNJBh8JfeZD
         rHM62sRJw+QyGT1HzKCyfVoTYZOFCgoH6ClIBExkYjNURC7mtas0a4q+pwH4kFjEuvUN
         CyEpc8uOmcxqXj/fddWZYpjzIzb8L1/hvrsbRia5xJuEGa3Moi6v7ygp/vY2RgkGRFyj
         AxWw==
X-Forwarded-Encrypted: i=1; AL+hErH1yvwC9pdTJyXN93dHq14gZKhDyC3plZofGyKr1lZqBUJutTuTxwEPEj3+ltddBKvyYdjaOU/7Rr/+@vger.kernel.org
X-Gm-Message-State: APuU4Z9J6JxQMcBATQe+JfZ0sfe3sL0EIH+DOuXZ27BquJPPUt6aU2J3
	khS+n9Gqk0+709R7Ery3yCESbZgs1V0UJwmaAKJuZnQSO3DtL5lTz0QCgI2bQLLaUxOc
X-Gm-Gg: AYBFou0orPLfyHhYReqyA7hcOtSJQsBMrV3m4dJUb15lfE5o04S65zgHGT2N+fTJY2X
	bdbZAiAxxBvWcSCJf5QFiXGdJL2tRCK/l7Cz62k08ZPIMdNJA3SZ/rXaojvlwiEA/Op1PBzPUyE
	7lJoAfuY2WxXTgBcf5/LlOusRRyNPVsbOl0MNjj0i4MaMidAO56sM8QDVDc2PjsIspc5cRioE/b
	4eJOkFs/GRyxdP+62waTIcj3MmumXNa8kGV+ebg2qGu9t4OsxF/RGhkiMpap4ptV4oFqltTVA8g
	a/mr47udW6JCXYLmaNhbCVF0QBcE69O8+M/Zl/E1EpIecBS5Cyc4+9rUzvx74P89hbloq2W2kmd
	AnKxH/cE40cHQn4LR8dsfNG6VsY6h2gMoRh4Yjrln7A3EaiPb4ZTrpjY7Z/23HgTxijBQHqFrQh
	YTIJCwNYSZ6GHnw+EiQ7VHR99+BFPGBBp23DjTZ/1/JCiXBLG2ipWwqYOmkN1Sde7U+dLsCyjDC
	Xo6DyNxnPHcMBlkNLiSRtNBGb6J8dr9TiCVX6UgUxJWXzDq/wwGdDR2QrWYptDfYCeYBK+k6Qjl
	jIyqpDuTPLbK5F0HSwRICowDTVJKGn3BMaIwR3hfhtpQ1G11BUcRzcVm8LzVEcw=
X-Received: by 2002:a05:600c:4f84:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb5599ade1mr43492835e9.0.1794564916955;
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm31982365e9.0.2026.11.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Message-ID: <e2edfa06d185acd86b46945622b6eb6dff97b307.camel@amutable.com>
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
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
Date: Fri, 13 Nov 2026 11:15:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
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
> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo
> filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0include/linux/fs.h | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..407ffb6342ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,18 @@ static inline const struct inode
> *file_user_inode(const struct file *f)
> =C2=A0	return file_inode(f);
> =C2=A0}
> =C2=A0
> +/*
> + * Regular files on pseudo filesystems are kernel interfaces and
> must not be
> + * used as storage. Look through stacking filesystems at the inode
> that
> + * provides the data.
> + */
> +static inline bool file_is_pseudo(const struct file *file)
> +{
> +	const struct inode *inode =3D d_real_inode(file-
> >f_path.dentry);
> +
> +	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags &
> SB_I_PSEUDO);
> +}
> +
> =C2=A0static inline struct file *file_clone_open(struct file *file)
> =C2=A0{
> =C2=A0	return dentry_open(&file->f_path, file->f_flags, file-
> >f_cred);
