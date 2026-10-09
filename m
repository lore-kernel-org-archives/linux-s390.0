Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7434519A0;
	Fri,  9 Oct 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556574; cv=none; b=oUhJFxUAFSjuqnJPX+w/tKGzIV/EUlsMpsXCeuvRqgOg6nEsAQHR9eUERmPx/7UCsSbweOWBrZ0qW8aRgRUFfzdYh84KtR/9K6mrL61ZVTF6Pqmhji+YrAvlr3cOsD5Xa3/QB4XAs4OtjRseQamB/ZGHS7YOsAzDPPBOTphPG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556574; c=relaxed/simple;
	bh=DJtT0gPGacfN079NMIGOcottjBVat7ijIGpmRXQmQg0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eKwZsxG3FXb38FTkjGEJcPq+gwm0ERdZm7FKI5fG6c1SalJ45TLf/WPwlyMp8ii+TyhY/LSIMDXXj975jemglqCMyx+krOzX4l4c/c2/qzFkaxuD9CNeXdSXHFb7Q4dcLgSIaxfrkNyhkICCjD0XZSS0meATmIcloXBfgzmxiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVEucOvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVEucOvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6A01F00893;
	Fri,  9 Oct 2026 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791556573;
	bh=Jmd9VrYssV9NngNVB6gh0YmpfvbCbeA+2WwgTev5BS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oVEucOvW1YJfMsne7vyQqgf62IB9gKrsD5yV3nM/tcfffgoPrAmDwHo65jQyxTlEY
	 s/6tkxzalmdqjXnBjiGf6CJGS2o9/jnHrmLJAPlUfop1DFOKS24/WaNpmKljxGzNIj
	 OWFhSgBXaeqzm0z8sCJg4ggUXlSxxJOoHMYQMiAL8TTnUWfjXKzEMQahjnLiSTScjP
	 PNMwd4emfj8EL5JDiunNMNtGdgaN6JG44Z9kL5RJF2Q5nOpNuh1wJC+OY2ad3Akv+X
	 W2oFWh/8SzYJMUBCV0DCZ4okg68deCK3FiGA3kD9waVB16IzBBxqLFTT2Zvk7MrJVt
	 8q9hlJX/poHTg==
Message-ID: <sashiko-outbox-165722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 3/6] KVM: x86: Use file_to_kvm_x86() in SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009142749.186650-4-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:36:12 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: build failure due to missing definition of file_to_kvm_x86()
--

commit 10a7cd7a1613201c02ffd0500ecb15453fab9d30
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: x86: Use file_to_kvm_x86() in SEV

This commit replaces the open-coded file check and private_data cast
with a new arch-namespaced helper file_to_kvm_x86().

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 944aaea6501f2..2787b832c9e0f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2121,10 +2121,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm,=
 unsigned int source_fd)
>  	if (fd_empty(f))
>  		return -EBADF;
> =20
> -	if (!file_is_kvm(fd_file(f)))
> +	source_kvm =3D file_to_kvm_x86(fd_file(f));

[Severity: Low]
Is file_to_kvm_x86() defined anywhere in the kernel source tree at this
commit? It appears to be missing, which will cause an implicit
declaration compiler error here in sev_vm_move_enc_context_from().
Could it be that the patch introducing this helper was omitted from the
series or ordered after this patch?

> +	if (!source_kvm)
>  		return -EBADF;
> =20
> -	source_kvm =3D fd_file(f)->private_data;

[ ... ]

> @@ -2839,10 +2839,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm,=
 unsigned int source_fd)
>  	if (fd_empty(f))
>  		return -EBADF;
> =20
> -	if (!file_is_kvm(fd_file(f)))
> +	source_kvm =3D file_to_kvm_x86(fd_file(f));

[Severity: Low]
Does this invoke the same undefined helper in the copy path? This will
similarly cause a build breakage when compiling
sev_vm_copy_enc_context_from().

> +	if (!source_kvm)
>  		return -EBADF;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009142749.1866=
50-4-borntraeger@linux.ibm.com?part=3D1
