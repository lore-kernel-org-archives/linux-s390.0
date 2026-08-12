Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585B1EEA3C;
	Wed, 12 Aug 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562601; cv=none; b=JAQ5EDaAihLFeOSaKwm5KLd6NZXq+p1F/eZqzBaZC+9vLZ3QigYj6xZMjQQVqwBPEhIMV90FCku3dsIUnfTOf6ehcue20NppROK45Vz8Al3nOEcB9EZ7x4IAtn8ev2Ih8ruP7CdhoAWJsgv9HR8mSK2liSekNK7q7Lg2ZmRlvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562601; c=relaxed/simple;
	bh=YuWNmHKllj0s2L7Y3sD378lMg0gxXQIXMjz2KCCAI70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCSRGQqljFFEWozDQSmQFVlTJ9fsfph/fRfezVXxZIGrmw9whfNXiXLXsVqIjJ+lgyYcOHiLIJUEfRs62aMXYCvkduSvpa04HcLwzEQ7aVoVkolunKPN8ybbqsRrxDyeQA2GpB5YwZ5RiiCBV4OXgLzCZEckIF7HtAtmDGqiN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDwlfm/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDwlfm/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF41B1F000E9;
	Wed, 12 Aug 2026 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786562600;
	bh=f0IbRL6aGae4qhSy31iPofuE9UuLdRiWY8C6l1cp7J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PDwlfm/nEZQIKfrTNRZO0rGsBOdDcil8dXCETJuJf3H6SjwuWkTnLLrZuc5Q+edh8
	 4nR9CWl1zSlMUCPczWdQUP7ID5o637yTRgVACSwZrkfPb6AL3EFnmo9w70l4F2rXep
	 ODuJ9onqQjR0nhRxPsz+Xi4gMX3Jdj4r+hqm7GUqNdFCdJt46qu5umcUk/BkeoZQs3
	 RUJs26+FDzyHiub62+BMVD/ZX9mTxA2c2LSY2+GGX5mW2TPNhV0skrKsfdeeNJ7VmX
	 tTOFoixaU9QGIVsfwrwN5Q8MSWBGkRfow26c0wmYjY0ZwhfsrsIcnHxzsNCQzAkySD
	 ONykblOmmZ2Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio: Use file-based reference counting for KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
References: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:23:19 +0000
Message-Id: <20260812192319.BF41B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing SRCU read lock when iterating over KVM memslots in `kvm_en=
able_external_write_tracking`.
--

--- Patch [1]: [PATCH] vfio: Use file-based reference counting for KVM ---
commit 6e2d7f7af50df153e78728c6ab103209dafd02a4
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: vfio: Use file-based reference counting for KVM

This commit replaces manual module reference counting with file-based
reference counting for KVM integration in VFIO. It passes struct file
pointers instead of struct kvm pointers throughout the interface to
leverage the kernel's existing file reference counting mechanism.

Link: https://lore.kernel.org/all/anyhChQlOs37se4B@google.com/
Link: https://lore.kernel.org/all/20260812153631.3376090-2-seiden@linux.ibm=
.com

> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index 7e8195a311bb0..98f133e4f0b32 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -237,10 +237,11 @@ static int kvm_enable_external_write_tracking(struc=
t kvm *kvm)

[Severity: High]
This is a pre-existing issue, but does kvm_enable_external_write_tracking()
need to hold srcu_read_lock(&kvm->srcu) when iterating over the memslots
array?

Looking at the function, it retrieves and iterates over the memslots array
while only holding the slots_arch_lock mutex:

mutex_lock(&kvm->slots_arch_lock);
...
for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
    slots =3D __kvm_memslots(kvm, i);
    kvm_for_each_memslot(slot, bkt, slots) {
        r =3D kvm_page_track_write_tracking_alloc(slot);
        if (r)
            goto out_unlock;
    }
}

Without holding srcu_read_lock(&kvm->srcu) or the writer-side slots_lock,
could a concurrent memslot update swap and free the memslots array while
the loop is traversing it, causing a use-after-free?

>   * register the notifier so that event interception for the tracked guest
>   * pages can be received.
>   */
> -int kvm_page_track_register_notifier(struct kvm *kvm,
> +int kvm_page_track_register_notifier(struct file *file,
>  				     struct kvm_page_track_notifier_node *n)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vfio-v1-1-=
5cfe0b1fa4e7@linux.ibm.com?part=3D1
