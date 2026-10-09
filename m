Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE44471C
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527388; cv=none; b=CBEkyUnG2Rv+PfUBBML59AsEsVNQUX7noQNfnm1RrjFWzHjdAziIg6XJdRtUYK4YpAjo9GBshmspbTy5MWixA1agsSKFuJBFym64AdLJYIte+jG+RmhEfjXZyX+1HY/8eba2RVxP117WLb+4L/Zm0oZ3fS+jDm8xXIXg2iJS5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527388; c=relaxed/simple;
	bh=shflh/WY3VvnRDLzlAAOdLIkk7WiBOgrzCpIjEyPMWg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X39TG4EdLedXEPuTT8kKVLpBS1yBGd8WtAH8XVMV8ESeB4SWGsFXbm7/eTj8gKjmFFMoyRlkeSRILGBCHyqaMh3WMt2+/SOXoQZfXeApPf86z8JuYf1rfrYeVQwMyDDhnaohBIqxdJNBbnJ/oD8WCy4MGZmNhhX6DH/kSumUYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwkgYlzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwkgYlzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D611F00893;
	Fri,  9 Oct 2026 06:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527385;
	bh=1/YTtQ+flV/jt3HvHvaHDrwnLe4uxdi53wQJoNt+ANU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwkgYlzuR/P44FwRHBMOD1xbNV2h5A/DMwaUwBBOc5TcXZwwrBvJwiO/AHRQUzOVX
	 ZvDySq/zcTXNWVpZsq0jj65xYd5ACO9S8DMBweBp0jh9+aNlb9YJCXZ3WbDYuJPve8
	 MNSzaXpWiuZBIRJDyzHXvVC2aTQK59+56L2WyXSM5bqQphFHe2uDQaTqSX1ZZhyw/Z
	 qcWHj+Dc6fhqPwBj5oDc5mLMn/AV5Vd29azTOzuSsMa959z6iUrfwsQliLbP8cTM4r
	 CdqJFpHZ6nod5ht6k2nYgKMN0xEIoYhbQ035nBL9j6DPeeGXIdLT+qMv9OGKYbmECD
	 axc9sXGNFLApQ==
Message-ID: <sashiko-outbox-164943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] s390/pci: Unregister the adapter interrupt first
 in zpci_irq_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-8-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-8-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:29:44 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/pci: UAF memory corruption in MSI setup due to missing device=
 teardown
--

commit 4f6e192e648a7af5752afbd15f3be9f0172b9594
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()

This commit modifies zpci_irq_exit() to unregister the adapter interrupt be=
fore
freeing the interrupt bit vectors. This aims to prevent vectors from being
freed under a live handler during the pci_base_init() error path.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 4b8ebb987580b..16ae80ed2d139 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -674,6 +674,7 @@ void __init zpci_irq_exit(void)
>  {
>  	unsigned int cpu;
> =20
> +	unregister_adapter_interrupt(&zpci_airq);
>  	if (irq_delivery =3D=3D DIRECTED) {
>  		for_each_possible_cpu(cpu) {
>  			airq_iv_release(zpci_dibv[cpu]);
> @@ -684,5 +685,4 @@ void __init zpci_irq_exit(void)
>  	}
>  	if (zpci_sbv)
>  		airq_iv_release(zpci_sbv);

[Severity: High]
Does this change fully resolve the use-after-free risk in the pci_base_init=
()
error path?

While moving unregister_adapter_interrupt() prevents the interrupt handler
from accessing the vectors while they are being freed, it appears the devic=
es
registered earlier by zpci_scan_devices() are never unregistered when
pci_base_init() fails during zpci_fw_sysfs_init().

If a driver later binds to one of these still-registered devices and calls
pci_alloc_irq_vectors(), the PCI MSI setup accesses the freed zpci_sbv
and zpci_ibv structures:

arch/s390/pci/pci_irq.c:__alloc_airq() {
    ...
    /* Allocate adapter summary indicator bit */
    *bit =3D airq_iv_alloc_bit(zpci_sbv);
    ...
    /* Wire up shortcut pointer */
    rcu_assign_pointer(zpci_ibv[*bit], zdev->aibv);
    ...
}

Could this lead to memory corruption when a driver attempts to set up MSI on
a device that was not properly torn down?

> -	unregister_adapter_interrupt(&zpci_airq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D8
