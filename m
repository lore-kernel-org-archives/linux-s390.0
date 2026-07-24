Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297B175A93
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859940; cv=none; b=qzpiLcWbzq6uYJGAexUl8ypyUw4hk2Q5EWTqyoKwQ1ZlvvT/BLL3h9XVh16Jo+uTs4o9TGjtIIscD526bik2zDxDh2V0IWe69N8srpI87LiWcYb4fP8ZzSMnzeQ9k8jf5KRR6gTxig0CajX8qT/X1HcpAkaV1o3mjSLviPF6bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859940; c=relaxed/simple;
	bh=eBaPpUKJEi4HzTkKYQ7BhlpfWrS00gvsBXtSF43T55c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6ldAm4RGFTlpAzy73u7wpQ2jjly5V//7YU18AvfMcyGw7q5skHbMmtKQ5lKpKHwRn/6b8r8zVtN+MBgdXA7meqmHYnjfhreQRyNRXQaNx35CSJD6N1jnJz7k6NnQzqYlayqwclLjn+hhCR/+vQ6dooToRCvm/AHlduUV2VwoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STWYEU7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STWYEU7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00E61F000E9;
	Fri, 24 Jul 2026 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784859939;
	bh=oeZHffmOjbwe+uqiAMCfWFlqPLQqdGv3qZU6YYkaZKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STWYEU7csQqdUjueCsZoUGL1ft4ZrhDjOTjIBtxzIyZuUfcQ/6AJO/OK/1Y24D7jt
	 t5Xjd/0yFLUzaQHTac+S6rbkx6p7L7c712W48vh/MwmY39OyQn4W6cpD/LWyTSYCYX
	 boRL/pZT94Y63P2vO6VSXOqD3zF3z2UxNf5cXUKTt1KS9LvkaxVwrOl1VEOfsZn/dY
	 VoRaAZwp0IkPXRG6yNwq79OdvyMS9TMLVWw/Wniua4BHKUbf479TzaEa8i9/wpC/64
	 QcIcOHsVgo3cTjJaFuhnnre4VP68dTFk7pOEewpVUzfvvejNLTs2U4PklB/qNhNY3Y
	 DNXv4P6IWteTg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] error-injection: Introduce parent in
 fei_attr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724021229.47302-4-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
 <20260724021229.47302-4-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:25:38 +0000
Message-Id: <20260724022538.D00E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The return value of `strim()` is ignored, which means leading sp=
aces in the user input are not stripped, causing symbol lookup to fail.
- [Medium] Data race and torn reads when updating and reading the `parent_s=
tart` and `parent_end` bounds can lead to artificially expanded fault injec=
tion windows.
- [Medium] Parent filter caches absolute module addresses without tracking =
module unload, causing incorrect fault injection on newly loaded modules (A=
BA problem).
--

--- Patch [3]: [RFC PATCH v2 3/3] error-injection: Introduce parent in fei_=
attr ---
commit 0dc702571b0f5ae530c81bdc489a7fcda8f94935
Author: Song Chen <chensong_2000@126.com>

error-injection: Introduce parent in fei_attr

This patch adds a parent field to fei_attr to allow fault injection on a
function only when called from a specific parent function. It introduces
fei_return_address() across architectures to retrieve the return address
and adds a parent debugfs file to configure the filter.

[ ... ]

> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 90cdad0412cdd..a336fc565dc9e 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c

[ ... ]

> +static ssize_t fei_parent_write(struct file *file, const char __user *bu=
f,
> +				 size_t count, loff_t *ppos)
> +{

[ ... ]

> +	if (copy_from_user(tmp, buf, count))
> +		return -EFAULT;
> +
> +	tmp[count] =3D '\0';
> +	strim(tmp);

[Severity: Medium]
Does this correctly handle leading spaces in the user input? strim()
modifies trailing spaces in place but handles leading spaces by returning
a pointer to the first non-space character. Since the return value is
discarded here, passing a string with leading spaces to
kallsyms_lookup_name() might fail unexpectedly.

> +
> +	mutex_lock(&fei_lock);
> +	if (!fei_attr_is_valid(attr)) {

[ ... ]

> +	if (!kallsyms_lookup_size_offset(start, &size, NULL)) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	strscpy(attr->parent, tmp, sizeof(attr->parent));
> +	attr->parent_start =3D start;
> +	attr->parent_end   =3D start + size;

[Severity: Medium]
Could this sequential update cause a data race? Since fei_kprobe_handler()
reads these fields concurrently without locks, could it observe a torn
state where the new parent_start is lower than the old parent_end,
resulting in an artificially expanded fault injection window?

[Severity: Medium]
If the resolved parent function belongs to a kernel module, could the
cached absolute addresses become stale if the module is unloaded? If a
new module is later loaded at the same address, it might falsely match
the stale parent bounds and trigger unintended fault injections.

> +	err =3D count;
> +
> +out:
> +	mutex_unlock(&fei_lock);
> +	return err;
> +}

[ ... ]

> @@ -171,6 +255,16 @@ static void fei_debugfs_remove_attr(struct fei_attr =
*attr)
>  static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
>  {
>  	struct fei_attr *attr =3D container_of(kp, struct fei_attr, kp);
> +	unsigned long ret_addr =3D 0;
> +	bool in_parent =3D false;
> +
> +	ret_addr =3D fei_return_address(regs);
> +	if (attr->parent_start) {
> +		in_parent =3D (ret_addr >=3D attr->parent_start &&
> +					ret_addr <  attr->parent_end);

[Severity: Medium]
Is it safe to read parent_start and parent_end here without READ_ONCE() or
synchronization, given they can be updated concurrently by
fei_parent_write()?

> +		if (!in_parent)
> +			return 0;
> +	}
> =20
>  	if (should_fail(&fei_fault_attr, 1)) {
>  		regs_set_return_value(regs, attr->retval);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724021229.4730=
2-1-chensong_2000@126.com?part=3D3
