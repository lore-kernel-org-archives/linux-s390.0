Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB022AE76;
	Thu, 30 Jul 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430069; cv=none; b=U+AGhndgxTvyjh8YpdaCoJYQNohiPeDlwj5jlwy1peorY+lNCunxZr7IiQBi966VyFddxzD51oRFMbNt27vfuZn6uDR6xosK1fuU7BX42qX8FJwJbxrkf7MCTAsPnnVGTohulypt+8fZA+BE+Yx6UTZX+yEEQBR52e5zGpc7LiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430069; c=relaxed/simple;
	bh=e91rwKWpR8WeKBq3MLEOO79gXrL2+Rm1MaoKlAuUA9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mI+EjVCr3YZ/76yZy9nJ+KTVauJjL4HcdYhtHOYOe09Cg9YCqpd9x3BdW/zswL+6pI+Y2r4jtvpQYN9zvSMmOHRFNT/hh0sAkJVaEc6UdEhj5SuxteaHH4RwRDiW/t5/b4z0iOUm52vK+o8g3OSmlt9DWkMpwk0+dzqFmQekOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDX/JUFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDX/JUFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444331F000E9;
	Thu, 30 Jul 2026 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430067;
	bh=qT4puM0dwKk8nNKsFKyOXGNwQW6sSh59Na4XR6MhbqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDX/JUFhtUBMk+mKeevZ+ZcvkJnVmVoPJS1BnhezSLioldjnZ3SwCFymlMKWtclJK
	 bWTAVoezX77uz67OUKD9NcGw0hOS4YXJ1dtBTbgumsy/PdmGmkkN2yBGqA+SmjpPof
	 +LyPmnL4hDbFT+UdYiJOQ8ngNCi3LkW2l4APLNslGbZydjnVdPkA4L/FxbX2QPzYn+
	 w8YaqQUzyO4yrUP8eQniEf72TaPACHhMu/t9prYcZrx20twzOIXlft4CT7XZRE7HYS
	 B77YLolqRNWhtj4kzGEKtP6KiZ5v96bpwN2e8iwu1ULQtbFL4cAIyaS3WGPXaTEAmB
	 DpoFyPq70s/zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/14] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260730162714.133327-7-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:47:46 +0000
Message-Id: <20260730164747.444331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] System stall / SRCU stall warning due to holding `kvm->srcu` acros=
s a long-running page table walk.
--

--- Patch [6]: [PATCH v6 06/14] KVM: s390: Fix race in __do_essa() ---
commit 8a0e7e6fefae191da0effc8b1bcdd717dfb5216b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in __do_essa()

This commit modifies the locking around KVM s390 migration and CMMA handlin=
g,
replacing slots_lock with slots_arch_lock to fix a race with __do_essa(). It
also adds a srcu guard to kvm_s390_vm_set_migration().

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index de3cb6111bd44..24c3bfcd5db26 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -1300,7 +1300,9 @@ static int kvm_s390_vm_set_migration(struct kvm *kv=
m,
>  {
>  	int res =3D -ENXIO;
> =20
> -	mutex_lock(&kvm->slots_lock);
> +	guard(srcu)(&kvm->srcu);
> +	guard(mutex)(&kvm->slots_arch_lock);
> +
>  	switch (attr->attr) {
>  	case KVM_S390_VM_MIGRATION_START:
>  		res =3D kvm_s390_vm_start_migration(kvm);

[Severity: High]
Will holding kvm->srcu across the entire migration start/stop cause an SRCU
stall for large VMs?

Looking at kvm_s390_vm_start_migration(), it eventually calls
gmap_set_cmma_all_dirty() (and kvm_s390_vm_stop_migration() calls
gmap_set_cmma_all_clean()), which iterates over the entire guest address sp=
ace:

kvm_s390_vm_set_migration()
  kvm_s390_vm_start_migration()
    gmap_set_cmma_all_dirty()

While the page table walk yields with cond_resched() to prevent soft lockup=
s,
yielding inside an SRCU read-side critical section does not allow the SRCU
grace period to advance.

Could this stall the SRCU grace period and block concurrent memslot updates
across the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D6
