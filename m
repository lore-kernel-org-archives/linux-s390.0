Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343B38645E;
	Thu,  6 Aug 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025930; cv=none; b=mmRmZ6Mihnr41UoXDIAYV5b1pIoQTuq/x4EFsL/RpaL7iiOfkNqb4M0Y97uOa/L846iqvZMp5YQOP3ywUZCpGRQ2IbXKj5drT4HmS8JlqlkisjuQ515//Bz0ifkPOhM1wTC+OxuQCtjCcvtN1UTfRNsKxvlE5W+dDa7dUSyDP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025930; c=relaxed/simple;
	bh=h5yHWdDqNI5aOwu+vrR29LkTg1urANHqBsQT663FUds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k8sT5/nYHEFlLb6xVb/iR0o7xej2Qd0bXGWjzuC3yUDqW0aQHwosvGbBaTJa9JD1ZxRpnLqp+fHDgNpOk6lKl6vrYtErbcifYxuIHDD1GeBSaaqgnUlmYYBeFQv9ksY8/Qjsn6jiZp9TZi1/aKVC4dFfQBDqvIRKa3xpShAzshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoIAeILo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoIAeILo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3061F000E9;
	Thu,  6 Aug 2026 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025928;
	bh=CH/EnklCL6IQjIsP/5j2KL+15PxFmj9dxqt06r+taJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoIAeILoB2UB3vYfvo3+bfmbxbFJbZ40tdOI9CkXg2MUfLgAes9yMLeUDBnKX2eKw
	 WXJoNOWWuqtyfOTZyCjti2QM257U+8YlxPZhfc1KlDXhTksmcfD2cZPzDYmmwW2Amp
	 W5PmscXaRQXgIG3K/S6Hk9uvDwMtawklWruxYOYNsTP1vsqL+1vNicvr8d426MjILu
	 ySK/XmQgmCKWauY3LC6DQR/Y/2cGEZ6VS2S8Z1aIj2JeAhJXzawdh5Sk5rqCf7oxLp
	 i1S0GgocMtnrFjxYCqv3A8k1ygnbrHQ8kRPIeT20OnePPRtcAX/Aoqmy+AK+Tz69r4
	 ZHpSFLa5UddiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error
 in vfio_ap_mdev_set_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260806140342.611294-1-akrowiak@linux.ibm.com>
References: <20260806140342.611294-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:18:47 +0000
Message-Id: <20260806141848.4F3061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Host AP configuration changes trigger a NULL pointer dereference w=
hen accessing unassigned matrix mediated devices.
--

--- Patch [1]: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on erro=
r in vfio_ap_mdev_set_kvm() ---
commit aef5cc63216cb49a3fd8ebd1da1a8d39b4fabb7b
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

    s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_=
kvm()

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
&matrix_mdev->pqap_hook before the update locks are acquired and the
mdev list is checked for a conflicting assignment. If another mdev is
already attached to the same KVM instance, the function returns -EPERM
without restoring the hook pointer. This patch rearranges lock acquisition
to prevent this stale pointer issue and potential deadlocks.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..99a0efd999ef9 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matr=
ix_mdev *matrix_mdev)
>  	struct kvm *kvm =3D matrix_mdev->kvm;
> =20
>  	if (kvm && kvm->arch.crypto.crycbd) {
> -		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> -		kvm->arch.crypto.pqap_hook =3D NULL;
> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> -
>  		get_update_locks_for_kvm(kvm);
> +		kvm->arch.crypto.pqap_hook =3D NULL;
> =20
>  		kvm_arch_crypto_clear_masks(kvm);
>  		vfio_ap_mdev_reset_queues(matrix_mdev);
> -		kvm_put_kvm(kvm);
>  		matrix_mdev->kvm =3D NULL;
> =20
>  		release_update_locks_for_kvm(kvm);
> +		kvm_put_kvm(kvm);
>  	}
>  }

While reviewing this file, I noticed a couple of related issues.

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
	...
	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
		mutex_lock(&matrix_mdev->kvm->lock);
		mutex_lock(&matrix_dev->mdevs_lock);
	...
}

[Severity: High]
This is a pre-existing issue, but if a mediated device is unassigned
(matrix_mdev->kvm is NULL) when the host AP configuration is modified,
will this unconditional lock of matrix_mdev->kvm->lock trigger a NULL point=
er
dereference?


drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_plug_cfg() {
	...
	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D false;

	mutex_lock(&matrix_mdev->kvm->lock);
	mutex_lock(&matrix_dev->mdevs_lock);
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but similar to the above, does t=
his
function also dereference matrix_mdev->kvm without checking if it's NULL,
potentially leading to a crash when unassigned matrix mediated devices are
accessed during host AP configuration changes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806140342.6112=
94-1-akrowiak@linux.ibm.com?part=3D1
