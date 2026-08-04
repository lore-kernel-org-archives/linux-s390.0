Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC43C5856;
	Tue,  4 Aug 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845659; cv=none; b=EqI39/jBO3EX327MO4apVlSjhwQy5FWShhOZRnOQgumbB/EgDfkT1EoJloYrV5YuK22wBB0NtPflzoPJcslNDRlziiWHB5p308sGegW0ntO1J3adrXyFCwVhDCUF0iv8Nor3XZrpPLuZsetEHouJZf86EBGPLQH6AKAHe3Ccs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845659; c=relaxed/simple;
	bh=i2q9E4hjJIYycbQPzz2VdUb3R7j5w3coKqI+7KL2AF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DT2xBLMTNnjxgvYdDIlo0Gqo3M4JDglF12sCbtEn3ZnfyJLk0PHOPoafJarrTDf8bpw9dYhRZUYkv6b16rmrmHBcY5T8JuG1qqo1cIpI2dBs0e5NSR7wB2PP/mZEGkVj5p4ExGTTNR8c6OkOFBeCZ6DeH/Vh+bALcXCMqQqA3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0i3gaYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0i3gaYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1D01F000E9;
	Tue,  4 Aug 2026 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785845656;
	bh=lo8F2pHYcPGGO3cjI9cGy2z2kBDlyc/XA0gqGb4TGhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0i3gaYTjhi6Jo0IJ0Kt8kWvKLnli3ns9F0MgkWmNGsCwMPjDD3IJQ4DLl2fjcA9N
	 WneUyZnMhJsQ8ncYx8VKIK8sv0zWj3M5wJD+tURNPk3VQPubmxDjwLrzcuNgR0L59q
	 iEBdAp3xK91gzJQsbtxfv/BCNumTn6EygwDNVdTYnIi+0Gn3aQaVhGRDRVdoG3xhu0
	 9cMJHShljELSqFZpSZqCMdZ7UeiXkufB+9ShaN62Vgwe6MHRCZYlPJ51hT+92sEzBG
	 qXynHGm8v9nEsfhq3xUA2jR5/lR4tRONb47ReM1h1pTR6U6hwDggjuhV6ABA6WWdjh
	 q2PCCBsh6jLlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] mm: pull writability check to
 follow_pfnmap_start()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260804120529.1730187-6-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:14:15 +0000
Message-Id: <20260804121416.6C1D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All callers of follow_pfnmap_start() except s390_pci_mmio_write()
> are following it, if they are doing a write, with a check that
> args.writable is true; for s390_pci_mmio_write() that's a bug.
> Also, most of them return -EFAULT if it is not.  Pull the check
> directly into follow_pfnmap_start() through another input parameter
> args.write_fault, to eliminate the need to do it in the caller.
>=20
> This also fixes an issue where follow_pfnmap_start() would return
> 0 for a PFN that is mapped read-only, and the caller would not
> attempt to call fixup_user_fault() on it; this can happen with
> vm_ops that set .pfn_mkwrite(), for example.  Instead, now the
> caller (for example hva_to_pfn_remapped()) sees an error,
> does attempt to fix it, and only returns -EFAULT if the
> fixup was fruitless.
>=20
> Reported-by: Sergio Lopez <slp@redhat.com>
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in=
 mmap")
> Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=3DbE=
HmfnG54qyBAHFg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D5

