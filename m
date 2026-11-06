Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979899;
	b=VBfbyqPa0AMM2CtqPOK8b9oJ6MdY+oag/xsFq2bVdPFExwK+aBjplvUnzvFCzwlhTgoh
	 BXZbwKu5A04SlzIhSWMi/HnboWdzP0JhhvwzdSmrB8tMP0USdLxsnde+9ua0XmxJMRFiV
	 g4xoTnAjWTOeykC3RXvTE6ZJrwBWyTg//se8ZcSXPloK1FH8MnlfgzOHPPDFiVBB4w83C
	 +AIactdLV8he6XDCqvwVLduRnVL9NDkowHG94tLG6BetJxtPuLAzbmF4VYKwmI5Q1sfN9
	 GoQLjWLSRtJf7xedAK6bP2PMQxgKE2HJMAkSj3MntreW/RxDwq1OH/pMII/lF8NOH5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UEbohyqL7zLaBDoaY1LCJGRCHjqr4aS51Wk9lepCI4g=;
	b=Eo2YkfSjTJjSOKxc6Gt7NWLrHng5MsR7XZ+SnvmwB/jhL9z2IVF72I2B84KgWgzjBi3w
	 QZUr7W8rws0KnGActku5/ueqzTFH0Tm83TYvHsv98D0xQBhOEPPqtEwtwRE2dc/9Nx0IU
	 QpB9reVX1riuKOYaaMNux/rCrp/eGO4xP+RUNZQ4Dskpp7Mw7tjoCl2VDc28L/aLMCzCt
	 +JlbkTqeeGRUDVeVWLELkvk1tyK6RxEx+tf1u9oHDucw+waSEwkacosScF4L27pZ1fZRM
	 D/MjQaayLD5aIgiA6/qoA5+9XnETyVmjsdP++vb4NjvGipkS3xXr4tKMbqFAID1uSFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFm4qOcT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD2606A329;
	Fri,  6 Nov 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFm4qOcT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2191B1F008A1;
	Fri,  6 Nov 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979898;
	bh=UEbohyqL7zLaBDoaY1LCJGRCHjqr4aS51Wk9lepCI4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFm4qOcTa8Wc0w1KzQA16gYM47nkgslvw7QhrFsMu++WmKSpMq22xhPCQrw62C2LW
	 u5/Dza/mG6W8N88aLMFn2I3LUrqJKI+CRIWDHVu+5JGUEy4t0UEfcg8nJ9LRwNub8p
	 Sn8QDBTnAzEkgp1XB0VHuQW7S3us7ZCsV2Zk+wuUVH0pyLIDGY5onGZZtWnVsThFG2
	 7iu55ueql8DNR98JL6THDiugFg71tbraGF5TkrwdX2UPOc5red8RAkDsy1hokJ49Xh
	 AjvyfRk7s7dTwKs+1Zm1W6z9g7bxmymfwRPQrThH5w88eK6LBasgmbGawwSHA+ppS8
	 JQknBabJCYyOQ==
Message-ID: <sashiko-outbox-201724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/14] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-6-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:44:57 +0000
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

commit 2bdeb1a9bd0e390837450d39cca0f224a21db0ec
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get/set vfio device mig state during guest migrat=
ion

This commit adds the migration_set_state and migration_get_state callbacks
for vfio_ap devices to manage device migration states during guest live
migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 94772cab1e855..df012f80ed0d7 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -143,6 +143,150 @@ static void vfio_ap_release_resuming_file(struct vf=
io_ap_migration_data *mig_dat

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
Does vfio_ap_set_state() allow migration state transitions for Secure
Execution (SE) KVM guests?

vfio_ap_init_migration_data() tries to skip allocating mig_data for SE
guests by checking ap_is_se_guest(), which tests is_prot_virt_guest():

drivers/s390/crypto/ap_bus.c:ap_is_se_guest() {
	return is_prot_virt_guest() && ap_sb_available();
}

On a KVM host, is_prot_virt_guest() is always false because it checks
whether the running host kernel itself is an SE guest rather than whether
the KVM guest attached to matrix_mdev is protected.  In addition, a KVM
guest only enters SE mode later during boot via DIAG 308 subcode 10
(KVM_PV_ENABLE), after open_device has already called
vfio_ap_init_migration_data().  As a result, mig_data is always allocated
and vfio_ap_set_state() does not reject migration state changes on SE KVM
guests.

Should vfio_ap_set_state() check kvm_s390_pv_is_protected(matrix_mdev->kvm)
(under kvm->lock) to reject migration when the attached KVM guest is in SE
mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D5
