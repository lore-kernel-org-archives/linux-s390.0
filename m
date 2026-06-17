Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF43227B94
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696815; cv=none; b=rq87/VKQj6puVsLVsOMkezpN/U5i/a8BFbVGT2/6pUsiFQf0+9HXIcQ9i0eJJhtD1MG7oO7nTbRRK2JUn5uiop+y3uENAzstDro6PblfdKDng4LUU4n3cHzoLXxCqkkl7zl8SiKtRspxZWy6qovqqOOa66wnNf2YLYA5ZkqvGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696815; c=relaxed/simple;
	bh=yAIT6DpF3XLdDoA5T09P7erR2tEXZVXcFatQgHulBk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m7fnpcumZy7Hdu3IfsgP7VvUYx/c5/wpcrFbVA1Zj7NNV0I0IeCTmffMYVo4X400IRrzyDo54EIt62YlsLBA3URXjoCzepK1lQ7KTKCRerA+uDVc2yfBJ0/Jnxcb83ng9hYTHJedrFUstUgiVAOpV8VmkApYVAnkKMLrL53Ar7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP/TyDY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP/TyDY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6131F000E9;
	Wed, 17 Jun 2026 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781696814;
	bh=+87Dn0diNfpEssHnqMV3Y0aEjuZDexSHBBhx3Qb7Qik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AP/TyDY5GCS5HMH+luMoRLAjUo+3Qb46JUGyU7yJUWoNj/CkR0BhDMuuY+jopwwzc
	 XZiJjCWRFj5pUqnDW/MXCcFGBhjhdLt0Q+uwRbDHDe+3RxurNijEUgwBA8e0VcpSD4
	 ewwk1+UZD4kTQyhXRtdV1R1WM37LeeHkRgQmuWz6BDRjQ3C6srqnShVxdXfCzQfbvp
	 S2MazY4UM2uUPNbL99Go9f6QMt9sY8wBNvYDN0Xy7wXYGj2jXlT+II4ze6nVojAhmY
	 VrS5wuO5qywgMADwWLTrsGg9RfK4AVjiU7C1/uwZ5LMHbM8htACA/Cg/zHAXiTe0ik
	 HHGHbS7uAShAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/traps: Add exception statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260617113726.2079324-1-hca@linux.ibm.com>
References: <20260617113726.2079324-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:46:53 +0000
Message-Id: <20260617114654.0B6131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reading the `/sys/kernel/debug/s390/exceptions` file causes a guar=
anteed kernel panic because the iterator `v` is dereferenced despite being =
`SEQ_START_TOKEN` (`(void *)1`).
--

commit ceb79d6258f172b6199fd66640ff5b739564b3ed
Author: Sven Schnelle <svens@linux.ibm.com>
s390/traps: Add exception statistics

This commit adds a new debugfs file at /sys/kernel/debug/s390/exceptions.
The file displays the number of program check exceptions per CPU for
debugging purposes.

> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 564403496a7ce..3de5c35be2f6f 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c

[ ... ]

> @@ -393,6 +405,36 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>  	percpu_exit(regs, percpu_needs_fixup);
>  }
> =20
> +static int pgm_check_stat_show(struct seq_file *p, void *v)
> +{
> +	int cpu, i =3D *(loff_t *)v;

[Severity: High]
Will reading this debugfs file cause a kernel panic?

Since DEFINE_SHOW_ATTRIBUTE(pgm_check_stat) is used below, the file operati=
ons
are created using single_open(). The show callback for single_open() seq_fi=
les
is always passed SEQ_START_TOKEN (defined as ((void *)1)) as its iterator
argument v.

Dereferencing v here via *(loff_t *)v will attempt to read from memory addr=
ess
0x1, which would result in an unhandled page fault and kernel panic.

> +
> +	cpus_read_lock();
> +	if (i =3D=3D 0) {
> +		seq_puts(p, "          ");
> +		for_each_online_cpu(cpu)
> +			seq_printf(p, "CPU%-8d", cpu);
> +		seq_putc(p, '\n');
> +	}
> +	for (i =3D 0; i < 128; i++) {
> +		seq_printf(p, "%02x: ", i);
> +		for_each_online_cpu(cpu)
> +			seq_printf(p, "%10u ", per_cpu(pgm_stat, cpu).count[i]);
> +		seq_putc(p, '\n');
> +	}
> +	cpus_read_unlock();
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(pgm_check_stat);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617113726.2079=
324-1-hca@linux.ibm.com?part=3D1
