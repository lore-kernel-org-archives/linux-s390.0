Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C347F795
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071692; cv=none; b=GTuaeRIPRFVnxhe3X69pln6dpCgoriF6iKVORaKVo4BV5FWRB38qz5mYlwEH7TJ0XEYbfR4AsJUPVY9KH3LlQ+o+H0EU2ND72WUPytUUrcJPdtJwR9Ua7okq5YTAZeMZ6JyxxpT7IWu5itjVr4QoK3PG43RhaMD0FZ+YdRbwoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071692; c=relaxed/simple;
	bh=WLOiVMQK26RbZRWdGKpiIWpxMZear4L2nWNLj7Y/KF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cDZxsUGTM/VaU6QlTmgqlY6i8x3Gha3uwuArlfijotGBwOcXRExmT6o7+CFVslx5dHh4G19mD5QF8i1jfGPv09k8CG/N8TgW0xrHJt7JXa7OTk14DaRdxooTkak+/8xGFIY8jJYkU/xziuwjc0L4TeQC0OoS0qSE8hIPrpXvWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgWcQJ7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgWcQJ7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E201F000E9;
	Tue, 18 Aug 2026 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071687;
	bh=KeeBFy8BDaq0e8FuKaTEFxNG3P8lupg5wKo7AiaDLWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgWcQJ7yNZMbwRoGQvXNfCZsEEW3qJtwxkfY/J9IAKariR/C8SJXUVOzpE6qsg4cg
	 nmAQr6Jv9kvqY8QF4taOAe2j98UNpE6b7pV8DaLnrkJyw3zI3oJ6Y5TZuzyC5d9PLU
	 mYA0lkj5a13Z6c1aWG+PrI6CgQZBNY7x//fJmRvbwt4IhQlaQ5cz3tRYC8vPlfWEsv
	 jsk339fgfwXnEZPRqj71kRs1FI3FYHx2HaHsNCeSl0iIfH4vgehgMYY7XPMD5xMcQv
	 9HPSrsFA8wvQk4FAZOXpp7/r9BykepWg1LNVeuOeqMJOnus3eEDpNbJSw5mBvwlnvK
	 F0o0by3D8I3gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] s390/iomem: register initrd as an iomem resource
 when retain_initrd is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Cathcart" <josephc@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818163902.14422-1-josephc@linux.ibm.com>
References: <20260818163902.14422-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:48:06 +0000
Message-Id: <20260818164807.34E201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The logic to conditionally register the initrd resource is entirel=
y dead code because it is gated by a condition that unconditionally evaluat=
es to false.
- [Medium] Using `strstr()` to parse `retain_initrd` from the command line =
incorrectly matches substrings like `retain_initrd=3D0`, creating a state m=
ismatch with generic kernel memory management.
--

--- Patch [1]: [PATCH v3] s390/iomem: register initrd as an iomem resource =
when retain_initrd is set ---
commit baa672ec021ea4348cfb0f9915360847a352531c
Author: Joseph Cathcart <josephc@linux.ibm.com>

s390/iomem: register initrd as an iomem resource when retain_initrd is set

This commit adds the initrd memory range to the standard resources in
/proc/iomem on s390. It conditionally registers it as a child of
iomem_resources if retain_initrd is specified on the boot command line.

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3d..45b0e19bdab2c 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
[ ... ]
>  static void __init setup_resources(void)
>  {
>  	struct resource *res, *std_res, *sub_res;
> +	bool retain_initrd =3D false;
>  	phys_addr_t start, end;
>  	int j;
>  	u64 i;

[ ... ]

> @@ -501,6 +508,19 @@ static void __init setup_resources(void)
>  	bss_resource.start =3D __pa_symbol(__bss_start);
>  	bss_resource.end =3D __pa_symbol(__bss_stop) - 1;
> =20
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {

[Severity: High]
Since retain_initrd is initialized to false at the start of setup_resources=
()
and hasn't been modified before this check, will this condition always
evaluate to false?

It looks like this block is completely unreachable, which would prevent the
initrd resource from being populated or registered.

> +		unsigned long initrd_addr, initrd_size;
> +=09
> +		if (strstr(boot_command_line, "retain_initrd"))

[Severity: Medium]
If the unreachable code issue above is addressed, is there a risk that using
strstr() will incorrectly match strings like "retain_initrd=3D0"?

The generic kernel code in init/initramfs.c interprets "retain_initrd=3D0" =
as
disabled and frees the initrd memory back to the buddy allocator. If this
string match catches "retain_initrd=3D0", would we end up registering freed
memory as an IORESOURCE_BUSY initrd resource?=20

This mismatch could mislead userspace tools about system RAM availability.

> +			retain_initrd =3D true;
> +		if (get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
> +			initrd_resource.start =3D initrd_addr;
> +			initrd_resource.end =3D initrd_resource.start + initrd_size - 1;
> +		} else {
> +			retain_initrd =3D false;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818163902.1442=
2-1-josephc@linux.ibm.com?part=3D1
