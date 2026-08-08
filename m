Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51C306B3D;
	Sat,  8 Aug 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210587; cv=none; b=YP05583wK5hAqy7D2OAWAIZcEnpQXozeXijgdzk260/1hv/ZW4UMCAFeQhfvDYVmLSBgcNr1MhpbvPR6VLK3ewRhFYTCe++VGGZmD7ZfVgiiO4t3WGwtcK0xI8Y/G8Elt7/8fQla3SgB1eaTph7xGyJLpTfjForzFhAwXawfz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210587; c=relaxed/simple;
	bh=PcZ2/AkqhwCIygVeLlzaJuwXahe+xVDNrZ0WgzLui8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gJU94abkjE8Nmsyfr87rZPBnVwy3LTOwxMT0wTpud/PF2IaqD+STnqK0P4bwLnyQQ9hJWhN/i/kKGX8IMJpuqpAXWNU2ONt/Kg3JVG/NoYZS0GKBHARdEIc31yjTSdvGvqqBVDXwvbf6pMsptpQIZCznm8+/dyzeT7gC9GNLIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haie61ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haie61ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D41F000E9;
	Sat,  8 Aug 2026 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210585;
	bh=vr0f+oqzjv79GbKng2FGenZjQTbqTHwoc+G6Gnxm0dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haie61nePro7GXUQVeOsbYrSvzYMVQea3BWd/O4aZSqVn+dq7ks1kUttuE3Ag1VoA
	 1fshxHJsmKiHVJx0XwDrEv+YjCX0PNZDdYUxLqDwxKxeIQZ6Y1XzdZKweziIfE7AZS
	 CMCvDk6Ws9ct3nRIO2zHc1eguk/YF8AGF7waaqaZMvhnGul+HdqXIP6JVqoGIqDwkN
	 Q4x2joumcuqkAm4RL9m1RmdtUa6erDlrOZRCXXp+LizF5GT+CAWScEWs1+mEazUGia
	 CcYfxGLanmzvrmKXOaWMVzZfmVcDx8vMZOCvAN0wmQ3AVWm1za8E/Fuyf0uZCalvWJ
	 l26dUXqZ7g8jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260808170712.839066-3-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:36:24 +0000
Message-Id: <20260808173625.599D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized Memory Usage in `vfio_ap_mdev_hot_plug_cfg` leads to=
 random hardware queue resets.
- [High] Use-After-Free in KVM's `pqap_hook` due to improper error rollback=
 in `vfio_ap_mdev_set_kvm`.
- [High] Unsafe concurrent modification and iteration of `matrix_dev->mdev_=
list` leading to Data Race / UAF.
--

--- Patch [2]: [PATCH 2/5] s390/vfio-ap: Fix dereference matrix_mdev->kvm w=
ithout checking for NULL ---
commit 9e16afa935b6610f6431f2a073e3d436ec0b7f7d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL

This commit resolves a potential NULL pointer dereference in the AP bus scan
callbacks by explicitly checking if matrix_mdev->kvm is set before acquiring
its lock. It also adjusts the lock acquisition order in these callbacks.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 845c86ba8bc30..e382e5a1cb996 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2821,9 +2828,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;
> =20
> -	mutex_lock(&matrix_mdev->kvm->lock);
> -	mutex_lock(&matrix_dev->mdevs_lock);
> -
>  	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
>  					    matrix_mdev->apm_add, AP_DEVICES);
>  	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,
> @@ -2841,9 +2845,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> =20
>  	reset_queues_for_apids(matrix_mdev, apm_filtered);

[Severity: High]
This is a pre-existing issue, but does this function pass an uninitialized
bitmap to reset_queues_for_apids()?

If the AP configuration only adds control domains, filter_cdoms is true, but
both filter_adapters and filter_domains are false. This skips the call to
vfio_ap_mdev_filter_matrix() which initializes apm_filtered:

    if (filter_adapters || filter_domains)
        do_hotplug =3D vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered=
);

If this initialization path is bypassed, is it possible for apm_filtered to
retain stack garbage when it is subsequently passed to
reset_queues_for_apids(), potentially causing unintended guest hardware
queues to be reset?

> -
> -	mutex_unlock(&matrix_dev->mdevs_lock);
> -	mutex_unlock(&matrix_mdev->kvm->lock);
>  }
> =20
>  void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> @@ -2854,15 +2855,29 @@ void vfio_ap_on_scan_complete(struct ap_config_in=
fo *new_config_info,
>  	mutex_lock(&matrix_dev->guests_lock);
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This is a pre-existing issue, but could this list iteration race with
concurrent list modifications?

It appears this list traversal in vfio_ap_on_scan_complete() occurs while
holding only matrix_dev->guests_lock at the list level. However, list
mutations such as the one in vfio_ap_mdev_probe():

vfio_ap_mdev_probe() {
    ...
    mutex_lock(&matrix_dev->mdevs_lock);
    list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
    mutex_unlock(&matrix_dev->mdevs_lock);
    ...
}

are protected only by matrix_dev->mdevs_lock. Since the internal iteration
step happens outside of matrix_dev->mdevs_lock, can this expose the reader =
to
torn or stale pointers, potentially leading to a use-after-free or infinite
loop if an administrator concurrently creates a new mdev?

> +		/*
> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
> +		 * ordering requirement and prevent a lockdep splat.
> +		 */

[ ... ]

While reviewing this file, I also noticed another potential issue outside t=
he
immediate diff in vfio_ap_mdev_set_kvm():

>       kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
>       ...
>       if (m !=3D matrix_mdev && m->kvm =3D=3D kvm) {
>               release_update_locks_for_kvm(kvm);
>               return -EPERM;
>       }

[Severity: High]
This is a pre-existing issue, but is it possible for KVM's pqap_hook to be
left pointing to freed memory upon an error?

The KVM hook is unconditionally updated to point to the incoming matrix_mde=
v.
However, if another mdev is already attached to this KVM instance, the
function bails out with -EPERM.

If the rejected mdev is subsequently freed by userspace, would KVM retain a
dangling pointer? Could this cause a use-after-free when a guest later
issues a PQAP instruction and handle_pqap() dereferences the hook?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808170712.8390=
66-1-akrowiak@linux.ibm.com?part=3D2
