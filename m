Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3F3783D4;
	Tue,  4 Aug 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845669; cv=none; b=Buk2fyjAzIAq8wCv305ZSYXj82DBCQMrnamhVJtIP28D9nShmsDE6QO4eunczFxfylXF3q23ZPX/ni+b+2Fm0t2N74kqI0+1i/JZtbKzc99e941rblocguykfHFDnWc/qcc0m8TrQjA26uQMBkBkVN0wMDmx9+KHswSypYE8700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845669; c=relaxed/simple;
	bh=ltkzRjP+TMzzVGJMvQcbS6e0PFLR8JtNZGfaAeWxFZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZ9iT7UUztwdWM0CGSp8ru4LJay5ihN/NpldtBS4n+yspr8vf89J4Lx6utYbZ/xgx7fD/LC51uGGEzk4pSJC0Sy6DhPAgTD1tKp3l59v910QW2vw1z4dbtTQHsxQov5G5imZMak/yDbMUAH0U17j4r0B1w4bo70nHFTYjeMbTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhUFKG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhUFKG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE581F000E9;
	Tue,  4 Aug 2026 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785845668;
	bh=WH2d1IjyHF27DdC6vZaBbK5ZTKKckHkgA9x4Qyrv4ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERhUFKG0RdGHNEDYqqpM90G70jnaf19cZd1PHFi/sxUSSNtTHrz4oucBuK38VE1YZ
	 9IP7wITGurbvbv4Cp9+0LRCYbTP4Q8q7Fj5UVUDKGytnbZfRU0t///0QS0j+kVPN2N
	 lVF+CrA8t7olcsU90Q7U8F/UXQVu0ojDf6vsdbNF+ycOPA9D6KMcWx0OTgohmeFSob
	 C+xnxyUV2kxdvhAcEYELd7mwxlWsZux6rHCBohrRaelLig20OXs5VDOgBvGhESkyRT
	 1L6WJdJskiM0JoXVbzB8vSkOdzoVv1fZVvwheYedT0ncGgcaOnta+DhXEo2X1a7msU
	 OJtXUko9vWc9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO
 mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804120529.1730187-7-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:14:27 +0000
Message-Id: <20260804121427.BAE581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> KVM's behavior when the guest writes to a non-writable VMA is inconsisten=
t.
> For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
> returns -EFAULT to userspace (which is ABI, and relied upon by tests);
> for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
> and thus exits to userspace with KVM_EXIT_MMIO.
>=20
> This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
> do not assume PTE is writable after follow_pfn"), and even if it has been
> in place for five years it is unlikely that it is relied upon by userspac=
e,
> since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
> KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
> to the case of an explicitly read-only memslot.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D6

