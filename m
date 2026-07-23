Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E71D89EF;
	Thu, 23 Jul 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832600; cv=none; b=uR8AbL0YlFH1hbsUfJ5CoOi7N5Plj/npsQrB3S+c3Z4GwTT86v68zDJF0PoQ3T/zMXiZwKmmIZ8p/6DtuOk9hFp8hjKhCvtS3IsF0/1Q+DYsXIf5komPzS87xonwt7BaRBCYH7cKGYZgGm60RzAIAD3PSzJUWzfbmwRe/QAqlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832600; c=relaxed/simple;
	bh=uZFHDBNkQ4zsrVHk2Bc62OMUA73+VL7FItfPXuZ0KuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZemTvKNtdUoXh9L20EuAnZq9EqtbISFgD+hKN1G0wPG6Xm5tgK/s+2vdCWo022xLjjLGvPVqM5LCOfd6qMpbQzI00MatBEn3Cj7kuWmhSdjsXr4F6i8mxVCUpxzita2Socm2+SO1CNIXz03R9FHb61kqtwTz1ZRCqf42gyYxYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKzjESZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKzjESZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0AA1F000E9;
	Thu, 23 Jul 2026 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832592;
	bh=eVuGWarSRd9qR8Q/DSOsgH97wxfYnNaZpx41i1ZMKuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKzjESZf8xwyw2m6Um17hnb8poVNlvghBcdiknpiOSsoGrKlLrX14mx6gDqZqFQpF
	 9hOZ2c0HGv1V0j3qSAcHCMpUc2W+A9K8hryvM0mJYzpEiCHIPTaKTkjTBqSZxMTlCH
	 FFVVKT6cvvU69KffHgNsr992i20Gf05gMEJ9qdMKtpNscCKH/tMBcoBMqQkvv4MWNS
	 UTX8fhF/R7CSPyAvU1v+t/vNvM/vLhsvYQn/VIlQp/lQ8jrVafuQBY7j85IBBty2cb
	 tvmIHscsOIgfmf+mUh64liRO8pPrVDh7HIJwLNUGZNULNqO5c2PpjuNf0M/MF7HJFw
	 yzpnWkpZje/wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723183440.3271-3-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:49:52 +0000
Message-Id: <20260723184952.6E0AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `unaccount_mem()` on the `airq_iv_alloc_bit` error path in=
 `kvm_s390_pci_aif_enable()` leaks `mm_struct` and `user_struct` references.

Pre-existing issues:
- [High] `kvm_s390_pci_aif_enable()` silently swallows error codes on failu=
re paths, returning success to userspace.
--

--- Patch [2]: [PATCH v5 2/6] KVM: s390: pci: Fix memory accounting for pin=
ned/unpinned pages ---
commit a95fdbf06d99bb2d6418c3a7ae08bdd93d3f75d9
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix memory accounting for pinned/unpinned pages

The account_mem() and unaccount_mem() functions leak struct user_struct
references by not calling free_uid(). They also incorrectly accounted pages
against current->mm, which might not be the original context during unpinni=
ng.
This patch stores the pinning process user_struct and mm_struct to properly
free these resources.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d2a11cdf6941d..44c00e5e32c57 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
[ ... ]
> @@ -279,7 +300,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>  		goto unpin2;

[Severity: High]
This is a pre-existing issue, but does this silently swallow the error code
if account_mem() fails?

If account_mem() returns an error like -ENOMEM, we jump to unpin2, but the
return value isn't assigned to the local rc variable.

Does this also happen if airq_iv_alloc_bit() fails later in the function? If
the error code isn't assigned to rc before jumping to unlock,
kvm_s390_pci_aif_enable() would return 0 (success) to userspace even though
interrupt forwarding failed to initialize. Could this leave the guest hangi=
ng
while waiting for interrupts?

[Severity: High]
Does this error path leak the mm_struct and user_struct references?

When account_mem() succeeds, it takes references via mmgrab() and get_uid(),
and stores them in kzdev. If a subsequent operation fails later in
kvm_s390_pci_aif_enable() (such as airq_iv_alloc_bit() failing), the error
path jumps to unlock:

	bit =3D airq_iv_alloc_bit(aift->sbv);
	if (bit =3D=3D -1UL)
		goto unlock;
...
unlock:
	mutex_unlock(&aift->aift_lock);
unpin2:

This skips calling unaccount_mem(), which would drop the references and mem=
ory
accounting limits. Since kzdev->fib.fmt0.aibv remains 0, the device teardown
path will also skip unaccounting this memory.

Could this be repeatedly triggered (e.g. by exhausting airq_iv bits) to
reliably leak references on each attempt, eventually overflowing the 32-bit
counters and causing a use-after-free?

> =20
>  	/* AISB must be allocated before we can fill in GAITE */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D2
