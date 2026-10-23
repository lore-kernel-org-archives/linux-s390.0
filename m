Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778994;
	b=IyYlzwNBqoP11EqLlNYYW2frNm+jBSirSXbkYzE4SjusTznlIDLlzpLgqkrx1tOcPpLT
	 i7wyGSRP403BrtUHe8bOt6L7tb3kcSrPRg1SdMldqf62AnLpYc2JC3rbv36Q/w39O8nf3
	 owlEQU6iJLxrBiO818oE+IL3oHU2WDK3p1+RCmcM01ZFOBVYJg2TYD+gDIMM9AF2xxpFu
	 tNjxm/9tEBiiz3Rs/VoaT3Ev6BenuttOxWz0RvOLMBoCiynmV30sLBvdYp56t0UFFDr3L
	 yMHvrmt83AD5op40ASsLrThJVJHVrWy0AlEbjUslC242/kWZwWgAx7PzyvRNpUniTgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f3CieYSZh3Y9Zt1i+wG+yNioir98pifBRtjSOl4O9Ig=;
	b=kTn9DEV/l7txLxpTo8eMJjfCU2GNfHBq6ZbB9msrYwsHLttsOSWjrIQ6NMMKRqvYsvnt
	 Oa0eenu8s1VeC3FYGhvUEiH9X6Qt0o0ilt85R8Hdg5MGXWUQciacZjZxObuHJQJbTvCl/
	 lwVPDLXZMZFZA9zPmFJusMb54HN7Wnbu3NTJoN+jpValgtL9pqU1P/UY9nYdZ7cKiGwOF
	 iooJ0hC8OxKeTnlahAaNxnKi0NicepkKeCeg7oXjSoOSdLx1oJ20sPY6PvjzAS5kyZR38
	 k3n3w6PMW0+0jJ7KNHAeRl9cKuPHWGVNCjQ1UdY3rsbvNFrw9HL0lrxl0iNSPugn6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSfhRRdl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D5606A31B;
	Fri, 23 Oct 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSfhRRdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04521F01825;
	Fri, 23 Oct 2026 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778994;
	bh=f3CieYSZh3Y9Zt1i+wG+yNioir98pifBRtjSOl4O9Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSfhRRdlhnuO/kVNYwEVKE2YHV7KsyVApHy7pEuelUXYR34w6kJo1MD/Ji4F30jdl
	 NOeEmS1ZguARvhwh2qclMO+VP3+IEhDgouWBMvx8yAEsuagxJMRylEbLqEl/RPO7YT
	 yF7rj38dvJ4NUwromO7c9kBj+dtcBtqQ7KOOIdvV+58BJx8/f6DgX0KEtKL5Gh/4Rx
	 zUx7lq2qA9I+Tx0uGlcDFpfUkpYAauH+0sE2ZqSfefDtjCFxiib8dsmhWw/waNcyCQ
	 2qjJAUXlup5nzUfoNsHf8UEt13HgGwAzSVjFBGgRt4HGJV6ZSpLVPM+7ZoS7JkBGvN
	 qET7S6BCj1PsA==
Message-ID: <sashiko-outbox-183045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-4-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:09:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/vfio-ap: ap_is_se_guest() checks host in vfio_ap_init_migra=
tion_data()
--

commit 79c297f4ef408f423e0eed3174df28dca4e407f2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

This patch adds helper functions to allocate, initialize, and release the
vfio_ap_migration_data structure and its associated migration file state
when a vfio_ap mediated device is opened, closed, or released.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index f01a37e4c418f..ba86a1afbb332 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Live guest migration is not supported for SE guests, so there is no
> +	 * need to initialize the migration data.
> +	 */
> +	if (ap_is_se_guest())
> +		return 0;

[Severity: Medium]
Does ap_is_se_guest() check the right entity here when called via
vfio_ap_mdev_open_device() -> vfio_ap_init_migration_data()?

In drivers/s390/crypto/ap_bus.c, ap_is_se_guest() is defined as:

bool ap_is_se_guest(void)
{
	return is_prot_virt_guest() && ap_sb_available();
}

That helper checks whether the currently running kernel itself is executing=
 as
a Protected Virtualization (Secure Execution) guest, rather than checking
whether the target KVM guest attached to the mediated device is an SE guest.
Because vfio_ap runs on the KVM host where is_prot_virt_guest() is false,
ap_is_se_guest() will always evaluate to false here and matrix_mdev->mig_da=
ta
will still be allocated and initialized for SE guests.

Additionally, vfio_ap_init_migration_data() is called from
vfio_ap_mdev_open_device() when userspace first opens the VFIO device (and
before vfio_ap_mdev_set_kvm() sets matrix_mdev->kvm), whereas an s390 KVM
guest only transitions into Protected Virtualization mode later when the gu=
est
executes DIAG 308 subcode 8 or 10. Can the SE guest check be performed when=
 a
migration state transition is requested via kvm_s390_pv_is_protected(), rat=
her
than during device open?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D3
