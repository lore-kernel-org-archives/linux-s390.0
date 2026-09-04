Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AD424D6E;
	Fri,  4 Sep 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502786; cv=none; b=jI5R1Cd6pMKJlssiaNTGXQO3hFT4Tmo7YRYPhEWZayKjeSlBB0qjt4trexJqFQe+YULWgb6tRrAKNM1PYbZ/vNVCaAmcgIqcqzDUuzBOb8T59652BNEmo/hzoeiu1otZYSkPe8SDy/fV+mhv6waBM97O0WmG7K0WWGtMvt+kbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502786; c=relaxed/simple;
	bh=ZXcL4bqhZ0ca2QteGVbftuyk1SlG08x9B7iw318er0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/Iq1lpMwf/lJwTYdS+JJExdokBtepQEduZSuUcfcNmErD6oF2ihdLTaUDCoT/v2NRqSIlPs0I8dPeDN7dGzG9uHJ8YTCVMYVF16JZMak1bIlROKW+yrOP0YXd3H+A5OiypaLL2+6u4lrq0ID8xfS7BFDXg4HAqLhS5M4uzm4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlzahyX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlzahyX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB18F1F00A3E;
	Fri,  4 Sep 2026 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502785;
	bh=HzzwEl/i3jyIjDH1YWUq7xC08GTgYHTkiFMiRdaQuE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OlzahyX1fjkh5OE5UWdvkBl/Ap1dlkiAqC3wAnksPQUsgowYm6X5GCHfW8gMfSU+H
	 /m9A/6fWu0u+hPw8krTJJTjA+SJBlsEbNdQ77BnEfII+WedPOqNs8+VDkdf4yHojuD
	 Q7HwpKrric80RhhDwrlRjUjjL6MTvu/lUXqFbfe7IBW8XBr79vRNqsBH+SWzXqcGsK
	 peOZSumIHs7lwxaWC8vEhXCFFg8CPuJoHh8n5su37K/fbzpW95NDvUg8guH+soiHFi
	 FjfIVJnAIo/CJnMIghbYCc10gVLZyxRST6rDRSXOP4I7ejp6pNAZEfDTsIj7GT350y
	 kknXRiyi0O8tQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 05/11] KVM: s390: Move all code into
 s390_kvm_mmu_prepare_memory_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260904060647.562443-6-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:19:44 +0000
Message-Id: <20260904061944.AB18F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Migration mode is permanently stopped if MMU cache allocation fa=
ils during memslot prepare phase.
--

commit 946bbe22fec184c4059d86ca088a0d825405309b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()

This commit moves all code from s390_kvm_mmu_commit_memory_region() into
s390_kvm_mmu_prepare_memory_region() to allow graceful failure. This fixes
issues where execution would continue with inconsistent page tables.

Message-ID: <20260828115439.145885-6-imbrenda@linux.ibm.com>

> diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
> index 4c8054e184908..c2ffb5e59ec63 100644
> --- a/arch/s390/kvm/gmap/kvm_mmu.c
> +++ b/arch/s390/kvm/gmap/kvm_mmu.c

[ ... ]

> @@ -69,65 +76,41 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kv=
m,

[ ... ]

> +	if (kvm->arch.migration_mode) {
> +		/*
> +		 * Turn off migration mode when:
> +		 * - userspace creates a new memslot with dirty logging off,
> +		 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY)
> +		 *   and dirty logging is turned off.
> +		 * Migration mode expects dirty page logging being enabled to
> +		 * store its dirty bitmap.
> +		 */
> +		if (change !=3D KVM_MR_DELETE &&
> +		    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
> +			WARN(kvm_s390_vm_stop_migration(kvm),
> +			     "Failed to stop migration mode");
> +	}
> =20
>  	if (change =3D=3D KVM_MR_FLAGS_ONLY)
> -		return;
> -
> -	mc =3D kvm_s390_new_mmu_cache();
> -	if (!mc) {
> -		rc =3D -ENOMEM;
> -		goto out;
> +		return 0;
> +	if (change !=3D KVM_MR_DELETE) {
> +		/* Enough capacity to add a new memslot */
> +		mc =3D kvm_s390_new_mmu_cache();
> +		if (!mc)
> +			return -ENOMEM;

[Severity: Medium]
Does this early return leave the VM with migration permanently stopped if t=
he
mmu cache allocation fails?

In the previous block, s390_kvm_mmu_prepare_memory_region() calls
kvm_s390_vm_stop_migration() when migration mode is active and dirty logging
is off. If kvm_s390_new_mmu_cache() fails here and returns -ENOMEM, the KVM
core will roll back the ioctl and the memslot will retain its previous
configuration.

However, the migration mode stoppage is not rolled back, potentially leaving
the VM in an inconsistent state where global migration mode is stopped desp=
ite
the memslot update failing.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D5
