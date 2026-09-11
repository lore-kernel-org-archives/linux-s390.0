Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0349E129;
	Fri, 11 Sep 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138116; cv=none; b=DeGLcf6YgzIcTtnBovUjV1sVOH821SNDbkbQIlga4d/cKkVebjyYpEc7qLKKRrVtOmXk+/RFronFKkVeXCzPnf0GG4udNGchYANC2PX4qDD9GSEpvSby5amC7JuPhOc5U7ETurjrKW9A1yKtZIwnJUmgEbvE4WBThbU5TpkhpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138116; c=relaxed/simple;
	bh=WUYfty91sJUyHiBT+RcT4WwdSUG7mTZDYh3MT95ZI3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZAtotRVCqjIWrKdCxFQPqkukXo+ZrcbsZejby1ArF4H1TwTQShf5PNYX0ny5P8HnxnWtWEfgxntsXP+03mhQRz59kNp8OlrEPxyxzmlqfi9WyJbhOlmkDEl70xcNteqC1MgFrCsovqytCp1fvsT644hKPtPab36kLzx1F5iIW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzLwF9jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzLwF9jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862291F000FF;
	Fri, 11 Sep 2026 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138113;
	bh=WUYfty91sJUyHiBT+RcT4WwdSUG7mTZDYh3MT95ZI3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzLwF9jmiRuBbdO0SsULSvhItBBtNp85wVftjdJ6796heyiCI+MhvIRWHzhdnrXC8
	 qA4YtnrVTH/876QSzgw5/8wu/Czj643HAxiQYSFQ2FZHR/tEEcjWOXj0DTahz01W0n
	 8G82e6Le2pOYOAD1cfQpnePKllCQ36NfgeYF1y3BYI2oI4gZ6j69I+qA6kYV0pbzWU
	 mZ8o+vkWrRMne6UqSKPNaWhOVAo7rqCUWvm39hr2lAytL/3hV9vJSJU/2x8H/sXWWB
	 w4Z3818WBc832MjIpNk5KLBSOVQqZ9B474FYxkKITKlqYwTnMmNBk0HtKsg3esYjD4
	 /rcLuyiC75qCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] s390: Remove the asm/mmu_context.h include from
 asm/elf.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-modules@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260911-module-include-elf-v2-4-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-4-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:48:33 +0000
Message-Id: <20260911144833.862291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The asm/mmu_context.h include was added to asm/elf.h by commit 146e4b3c8b=
92
> ("[S390] 1K/2K page table pages.") in 2008, when the new macro
> elf_read_implies_exec() used disable_noexec() /
> current->mm->context.noexec. Commit 043d07084b53 ("[S390] Remove data
> execution protection") removed that macro in 2011 and asm/elf.h no longer
> needs asm/mmu_context.h.
>=20
> Several s390 files currently depend on declarations provided indirectly
> through asm/elf.h -> asm/mmu_context.h:
>=20
> * arch/s390/mm/mmap.c: check_asce_limit() -> asm/pgalloc.h,
> * arch/s390/kernel/processor.c: enter_lazy_tlb() -> asm/mmu_context.h.
>=20
> Add the missing includes to these files and remove the asm/mmu_context.h
> include from asm/elf.h.
>=20
> This is a preparatory cleanup for adding the asm/elf.h include in
> linux/cpufeature.h, which would otherwise create the following cycle:
>=20
> linux/pgtable.h -> asm/pgtable.h -> linux/cpufeature.h -> asm/elf.h ->
> asm/mmu_context.h -> asm/pgalloc.h -> linux/mm.h -> linux/pgtable.h
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D4

