Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428417;
	b=VdynAKKuS2kOlqR89sKs4xh7U9Zh6TiJvNX9ZqEUjKj6fE2N24v+IAQMrFdy37Do5A81
	 aGQX9M9vCpTzcK/Z9EqwxJ7IYAbuzwV2mzLvYf6lDZkIFqVl3mLX98LOO89VPeVIb6uTS
	 Yvt8bjuQoXYo6084o7wZJhLAQuQ/cYz32eVdPwbHVaRjTlgehj9QImbeYTopUUMlVzU64
	 9FM2c3wXodH25TxizwtAP5oOMGlr0CHucevIAROWiKjyWPlGGvNOtpJDfxbl71U3+EZ97
	 r7qAd9n2+hHclY8Kp4Xo4XwZLLjEc90oIaR3O5lVBhuJJTIOKtlIaX7sd8nm4zKXN+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428417;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FaWoc4xkT13jdcSfr+uIEyXCAVPqZoZxRxYYQ7fe28c=;
	b=YA4z34Zek0SuMkiAG23vQ/pVKUl4PgPHtw/CJggRM2ynPyyl+hwfoj8TlpJeDyFGOTJ6
	 IDxPt+OBupQtNm04OKQAh1DDeYHbV+0ps43pH/z+X1Q3TKbtpP9gi1wdJW4iWm7amNyKQ
	 WoU4OMndnV3FpZjIhpLPwrlP2XyEYPJNEumzkfp2TkogWUbaML4JUgvZbooflkeH2KGkZ
	 swZQzNv+7vk82JWelZFCqN0pE+s6KMla60rSfYXMDGdjpR8IeuaDE1hh3MCJPwcwQKZsq
	 8l01rCro66UhMQvhv59yKXceMK1Oc7rXZlQadluSzqi1nwcmgZJmfuMsP6kIEdDSMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ztk3FmS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15083606A333;
	Wed, 11 Nov 2026 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ztk3FmS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9171F00A05;
	Wed, 11 Nov 2026 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428416;
	bh=FaWoc4xkT13jdcSfr+uIEyXCAVPqZoZxRxYYQ7fe28c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ztk3FmS9XUshAYeMcEujH7YOwbhpPl9AFY8yI+kNzGFOqBK0F6bzXNQ4azWPqQh1I
	 D7tUnhGyX7w8aaU7X9jlwedz6ZuJoTsGF0pFl5CepMBbEqiAywEjmOlTPFt1gGxsvf
	 WAH8XPzFu/Kq88u9ZQXgGyiYG8X9IsLR0iIAF+OkKVnrutqcWpHzdmW8BRBECoyNVb
	 To24pM04GdqSd4EgU7EM0tGjSgJaDo1wVFwEDzU0CZvMEUF4UFb10Oi709kcBh7U3O
	 efPFphupJHbPseof6JUlqfZGrg3Gu1m1cbnYD4OurRH0OxphFU2tqxDU9teSfWYmm8
	 3zSXioWdd7GiQ==
Message-ID: <sashiko-outbox-209633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/14] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-6-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:20:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] s390/vfio-ap: wrong SE guest check for migration in
  vfio_ap_set_state()
--

commit c3e849ed613219846146b19663fa802f6bc7ff34
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

This commit adds the migration_set_state and migration_get_state callbacks
for vfio-ap mediated devices to support VFIO_DEVICE_FEATURE_MIGRATION.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 94772cab1e855..df012f80ed0d7 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	int ret;
> +	struct file *filp =3D NULL;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	enum vfio_device_mig_state next_state;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	mig_data =3D matrix_mdev->mig_data;
> +
> +	/*
> +	 * The mig_data pointer is set in the vfio_ap_init_migration_data
> +	 * function which is called when the vfio-ap device fd is opened.
> +	 * Since the implicit pre-open state is RUNNING, a request to set
> +	 * RUNNING is a no-op. Any other state transition is invalid before
> +	 * open_device.
> +	 */
> +	if (!mig_data) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		if (new_state =3D=3D VFIO_DEVICE_STATE_RUNNING)
> +			return NULL;
> +		return ERR_PTR(-ENODEV);
> +	}

[Severity: Medium]
Does vfio_ap_set_state() reject migration state transitions when the
attached KVM guest is running in Secure Execution (SE) mode?

vfio_ap_init_migration_data() tries to skip allocating mig_data for SE
guests by checking ap_is_se_guest(), which tests is_prot_virt_guest() &&
ap_sb_available().  That checks whether the host kernel itself is running
inside an SE guest, which is always false on a KVM host.  In addition, a
KVM guest enters Protected Virtualization later during boot via
KVM_PV_ENABLE (kvm_s390_pv_init_vm()), after open_device has already
called vfio_ap_init_migration_data().

As a result, matrix_mdev->mig_data is always allocated on a KVM host, and
vfio_ap_set_state() allows migration state transitions for SE KVM guests
instead of checking whether matrix_mdev->kvm is protected (for example via
kvm_s390_pv_is_protected()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D5
