Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E733DEF7;
	Wed,  2 Sep 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330145; cv=none; b=GQgT6rt/0bf8qGF+DwFo0DUrvT6h1/6QidpYP3lqnsA/esD5hw+6eY2aHi+ecdkYA2KKWr8xpbRS32slvhIhC9ounMu+mqVryA0WmQ2bTaO9mEXMRkwCP7EeQyDi9YN1kLlDw8S1adXjovhc9z+5ea6mv+O7+AHu2li9KyuOIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330145; c=relaxed/simple;
	bh=L8nsjKybAt/DQYhKJpxZOdikhJtbOxXF2E4uEUfK550=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2jAJcryyWxn8Eyj14V+l/98VFa1FPmZKBY8VCNv26ZSilV6+FqTqL4F3WLLKDhykchAI89EH8ocXTZrTNvJsmxyO7Tdi6f+5+wymIKJTUkdCaC1YMIJbvvcthfYRJ9J1527hC9r+qXQ6T/x4yk3ypSz4W/H9Il+6462D4gwzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJK1EGM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJK1EGM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5295D1F000E9;
	Wed,  2 Sep 2026 06:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330143;
	bh=NCR/gBUTX6YqU7geMEQCdCUdFPUQLYfjV9jns+bIYzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJK1EGM0H8Das1603sNooRu3MhqLv6hd/KTTRtTshFHs66LAPabk1mPQSe9YyLycn
	 Y5DyO6y+7qULPXnCgTutlK39FZ/XBKXHOrtoMgd5dTznr6N13XHwPhrIDu065B9e3c
	 hwmAUVYeq0HFvact8bbpZCgmgxjV8oGr1gEUZYWghv1pMrtg9WZINXorgn1aC95PD9
	 vdy4pvvQWOK9NPwve5Ze27AUut2lpet2hmeaYHnmZWqLmLYi1lQBp9pObD3XFCgjHM
	 PUzMqE3ObM1njmOowCHxY4kp3FqmCFyF3Uvr/B1+gARffTAXPi+JPN3OyIm2r1G6TQ
	 BdT+GHMhVPCXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STSI buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260902-s390-kvm-v1-2-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902-s390-kvm-v1-2-3bc0986550b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:22:22 +0000
Message-Id: <20260902062223.5295D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing get_zeroed_page() with kzalloc() breaks the hardware=
 4K alignment requirement for the STSI buffer, creating a Guest-to-Host Den=
ial of Service (DoS) vulnerability.
--

commit bcd4e89cdbdb3a1d43d3845b698f4de5d334121d
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer

This commit replaces get_zeroed_page() with kzalloc() for allocating
the STSI response block buffer in the s390 KVM subsystem.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index b3cb2c2c3aa71..856939acf012f 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
[ ... ]
> @@ -911,19 +912,19 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  	switch (fc) {
>  	case 1: /* same handling for 1 and 2 */
>  	case 2:
> -		mem =3D get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +		mem =3D kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
>  		if (!mem)
>  			goto out_no_data;
> -		if (stsi((void *) mem, fc, sel1, sel2))
> +		if (stsi(mem, fc, sel1, sel2))

[Severity: Critical]
Does this allocation guarantee the 4K alignment required by the STSI hardwa=
re
instruction?

While kzalloc() for PAGE_SIZE might often return page-aligned memory, it is
not strictly guaranteed, especially if slab debugging (CONFIG_SLUB_DEBUG)
with redzoning or CONFIG_KASAN is enabled.

If the allocated memory is not 4K-aligned, the inline stsi() assembly will
trigger a specification exception (Program Check 6). Because there is no
exception table entry for this inline assembly, this will crash the host
kernel.

Since an unprivileged KVM guest can readily execute the STSI instruction
and trap to the host, could this allow a guest-to-host denial of service?

>  			goto out_no_data;
>  		break;
>  	case 3:
>  		if (sel1 !=3D 2 || sel2 !=3D 2)
>  			goto out_no_data;
> -		mem =3D get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +		mem =3D kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
>  		if (!mem)
>  			goto out_no_data;
> -		handle_stsi_3_2_2(vcpu, (void *) mem);
> +		handle_stsi_3_2_2(vcpu, mem);

[Severity: Critical]
Similarly, passing this potentially misaligned memory into handle_stsi_3_2_=
2()
can trigger the same specification exception when it executes the STSI
instruction internally.

Should these allocations continue to use get_zeroed_page() to ensure the
strict page alignment required by the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-s390-kvm-v=
1-0-3bc0986550b1@kernel.org?part=3D2
