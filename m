Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA73DEFE7
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130352; cv=none; b=pMqGz6KQWchRqSh1wJYPVB6Y5eUOiaMSUF6ILqZtKbfb5I22fLACP7DvrC9Kmm5Vw1lT36CKqSYYT1NGkUWsMRrBhY8P3LgK0yarw1NJrVo6bXzdiBgrhRKwIpWa5+WMVkpHNLZyfO+5dk/Z4BbaagQ7JtO4dLLbuSt8Ac5P4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130352; c=relaxed/simple;
	bh=5FXzLefDB+zYnjVET7mdO/aFNp0KF8E4CsvRlU64RUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fmgAR+v5FW7WadpGB90dXe/uq1txELfqq8LxBEOndLr6IUkrLtKqQu4qrychTCJqoAANxXnSuFzy4F9LfHL2Q1tCFSCzp179wQDwl0//VdEijNq4gbBXHcCR4+UZN9DpCgRvTjJDbMaXNZYxIcLPfv77XFETCKaGb3HGnBowshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzIE/zfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzIE/zfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3EF1F00A3A;
	Wed, 19 Aug 2026 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130350;
	bh=3yOaNe4YID4yXm0+yF82/A5uz1PuRBkViGP2b5/I8i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzIE/zfOOAaKPZKZMx3q9/o8DD53J5UdPbn0aBWe91nzWthZqs6QrqDX0otY/Fcx3
	 fmQvelZ5Uw4VMf4AFIufTPyu2SfvbatJkbjtp9z68nlN4RorQcfTIy6m/y764ViGuZ
	 0rZPbgpo7vjr+qdfa+Hn41yVZ73oYzunkfzmVn2TjVIGxlvjHOCgGObrQrYgsWZzlM
	 R6qljH+ehtjxWtGILNXgZdoXRpmW9dG501ekwDIEqF7AdwqHU8k2OCZYaJnBaB2zV8
	 aboFHkPac3UH4jLC6m8r9bGrY0CumCfi8Np+baDsboYuNQBupPxu4TbNNkRwR/vibk
	 yns75buDc3dzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] s390/pci: fix resource leak in zpci MSI setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-3-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-3-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:05:50 +0000
Message-Id: <20260819090550.8B3EF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] zpci_msi_teardown_directed() unconditionally frees `zdev->max_msi`=
 vectors instead of the dynamically allocated `zdev->msi_nr_irqs`, potentia=
lly freeing vectors owned by unrelated PCI devices.
- [High] Missing `rcu_assign_pointer()` when publishing the newly created a=
dapter interrupt vector to the globally visible `zpci_ibv` array.
- [High] zpci_msi_clear_airq() double-counts the iteration index, resulting=
 in skipped elements and out-of-bounds memory corruption.
--

--- Patch [3]: [PATCH 3/7] s390/pci: fix resource leak in zpci MSI setup ---
commit ac232ab92e1500cdc9f0a1a221f03f9be96fffe4
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: fix resource leak in zpci MSI setup

If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
ZPCI_NR_DEVICES summary bits (~128 total), reducing system capacity with
each failed device hotplug.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 94b03d16006ba..5e934ac990ac1 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -320,8 +320,11 @@ static int __alloc_airq(struct zpci_dev *zdev, int m=
si_vecs,
>  		zdev->aibv =3D airq_iv_create(msi_vecs,
>  					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
>  					    NULL);
> -		if (!zdev->aibv)
> +		if (!zdev->aibv) {
> +			airq_iv_free_bit(zpci_sbv, *bit);
> +			zdev->aisb =3D -1UL;
>  			return -ENOMEM;
> +		}
> =20
>  		/* Wire up shortcut pointer */
>  		zpci_ibv[*bit] =3D zdev->aibv;

[Severity: High]
This isn't a bug introduced by this patch, but does this direct assignment
need a memory barrier?

This pointer is published to the globally visible zpci_ibv array.
Concurrently, the asynchronous hardware interrupt handler
zpci_floating_irq_handler() locklessly reads this array using
rcu_dereference(zpci_ibv[si]).

Without an rcu_assign_pointer() or equivalent release barrier, could the
reader observe the aibv pointer before its internal memory regions are
globally visible, leading to an invalid pointer dereference?

[Severity: High]
This is a pre-existing issue, but does zpci_msi_teardown_directed() free
vectors owned by unrelated PCI devices?

When a driver requests fewer IRQs than its maximum capability, __alloc_airq=
()
dynamically allocates exactly msi_vecs bits. However, the teardown blindly
frees max_msi bits:

arch/s390/pci/pci_irq.c:zpci_msi_teardown_directed() {
    ...
	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
    ...
}

Will this cause memory corruption by freeing trailing vectors that might ha=
ve
been allocated to another device? Should this free zdev->msi_nr_irqs instea=
d?

[Severity: High]
This is a pre-existing issue, but does zpci_msi_clear_airq() double-count
the iteration index and write out of bounds?

In zpci_msi_domain_free(), it iterates over nr_irqs and passes the loop ind=
ex
i to zpci_msi_clear_airq():

arch/s390/pci/pci_irq.c:zpci_msi_domain_free() {
    ...
	for (i =3D 0; i < nr_irqs; i++) {
		d =3D irq_domain_get_irq_data(domain, virq + i);
		zpci_msi_clear_airq(d, i);
    ...
}

Inside zpci_msi_clear_airq(), the hwirq already reflects the correct index.
The bit is calculated, but then i is added again:

arch/s390/pci/pci_irq.c:zpci_msi_clear_airq() {
    ...
	msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
	bit =3D zdev->msi_first_bit + msi_index;
    ...
		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
    ...
}

If nr_irqs is greater than 1, doesn't this skip the intended elements and
corrupt pointers in unrelated active IRQs while failing to clear the
target vectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D3
