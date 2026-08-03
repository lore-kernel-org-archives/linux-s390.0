Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D233939DE
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778756; cv=none; b=uVmg3mWi4PGbpR0GARG/4tyxZEMcCsj6X4KQbG33mDpJXQZddwhu2JcwHtbqtyxaMROZwvuc7K6350rYmAHKwFwHlFNEz/Nf6vIALOqbQwfsQqVMpluNkWU25re15eWjUMYL2CmhdLA8/y3s/CqX/jm2iHGn+9+y8xLHwMTq+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778756; c=relaxed/simple;
	bh=q4I6bnJTL3wLoNypzsdFjKJI8XCT08y71tF6aW7DGe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RHmcyooP092rYIJbWCx/b0kscOJWnW5eR58P6nsk82Oqks4kxm6pRc4h61Hw6c8xNtOBDZQd0H4Fsbx2gsBU4StWDlBDmb5N3LXgSwRqF6epazKHvdfuistV6LU/LlFm/rrlwTghI5K5MzRM4CD2Es2ql9pLQ0+XhxeI9zm1+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odo/L1JP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odo/L1JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CDD1F000E9;
	Mon,  3 Aug 2026 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778754;
	bh=5XjZN4AjchsfaZ2az0b+LmbmRUF6qwblKs05fQm1Eps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Odo/L1JP8c2kHiYoxTIiM1tITBDLhVXA6V/eI0Z5YKzogqKmLHuWcuEISn9CBUGfh
	 E5A/bUhoFAOdxRLinHQd3637zcHnpuy17IwN3iwZs0KpCp7sPHeW/n/MftlVI8Jw8p
	 3fC5rqsagDqnPYgOxTN7pYsazAzFt+WUWv22zNOnfFv8kLGiclLzJYDSTta3HS73qy
	 m2tyxD5579w694hq5x0Zdws4r8g/wEFW/i075COaVjVohAaNTO4LMIKMIWoXbiaT9w
	 4BCv0x/qwCdJqJ2En2ZQEBE6ts7Aa4/omkCdzSHVso0+htS1AALFObj72B3RCbSn6u
	 vXuYKYaPSw5PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] s390/mm: Add __context_unsafe() attribute to
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803172144.827049-3-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
 <20260803172144.827049-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:39:13 +0000
Message-Id: <20260803173914.94CDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using find_vma() instead of vma_lookup() in do_secure_storage_acce=
ss() allows an unprivileged user to trigger a WARN_ON_ONCE if a secure stor=
age access exception races with an unmap operation or occurs on an unmapped=
 address.
--

--- Patch [2]: [PATCH 2/4] s390/mm: Add __context_unsafe() attribute to do_=
secure_storage_access() ---
commit 679818f3abe10b8b5132294910a12a6eb003e99e
Author: Heiko Carstens <hca@linux.ibm.com>

s390/mm: Add __context_unsafe() attribute to do_secure_storage_access()

This commit disables context analysis for do_secure_storage_access() by add=
ing
the __context_unsafe() attribute. This prevents a warning during compilation
about releasing a spinlock that wasn't held, which occurs because
folio_walk_end() is a macro and lacks the necessary context analysis attrib=
ute.

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6f..5af448fca9623 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -406,6 +406,7 @@ NOKPROBE_SYMBOL(do_dat_exception);
>  #if IS_ENABLED(CONFIG_KVM)
> =20
>  void do_secure_storage_access(struct pt_regs *regs)
> +__context_unsafe(/* folio_walk_end() not instrumented */)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but could this function trigger a
WARN_ON_ONCE that is reachable by unprivileged users?

Later in do_secure_storage_access(), find_vma() is called instead of
vma_lookup():

arch/s390/mm/fault.c:do_secure_storage_access() {
        ...
		mmap_read_lock(mm);
		vma =3D find_vma(mm, addr);
		if (!vma)
			return handle_fault_error(regs, SEGV_MAPERR);
		folio =3D folio_walk_start(&fw, vma, addr, 0);
        ...
}

If a secure storage access exception races with an unmap operation via munm=
ap(),
or occurs on an unmapped address, find_vma() returns the next VMA in the ad=
dress
space where vma->vm_start > addr.

When this VMA is passed to folio_walk_start(), it hits the explicit
WARN_ON_ONCE(addr < vma->vm_start || addr >=3D vma->vm_end) check.

With panic_on_warn enabled, could this allow an unprivileged process
manipulating its own memory to cause a denial of service?

>  	union teid teid =3D { .val =3D regs->int_parm_long };
>  	unsigned long addr =3D get_fault_address(regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803172144.8270=
49-1-hca@linux.ibm.com?part=3D2
