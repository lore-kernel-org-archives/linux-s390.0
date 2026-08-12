Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CD3E8695;
	Wed, 12 Aug 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536741; cv=none; b=k84mKJIRdMmSMzY3TLCbJ66U0jqFLLlx4h2lKCYoCsMCsBW/OQbyOJEKD7YLWoR+ZLgcnSdjQY8JlHzckGURret4Hv914eRk64dY27fzKCU/yhMcwroXtz8mGKtrFnUcf50GlKN78irO2zQFTFDX3rAu0Aqmee5ONO8h6oV2yfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536741; c=relaxed/simple;
	bh=rlXFVdp++pMhm2oKfUqRU39BZCFItgdSZHIJsXSrTjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E10B6JM2tsRXiJNQ0bRMNhNbkpnDfP8f6yiQ0PUtOYN4VzatVHJQwxMfKe2C9E6gBWBmOPsy2jU/wqK294QOEiNMnEiTItjQnrNM+bfA3FtCwnv4J4pNB+D0IRI6Yaa2LBj8dXR/mslwVtz9BG2xnBF7pHECRLzZkRP0FgLRw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qoqp5eJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qoqp5eJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0161F000E9;
	Wed, 12 Aug 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536739;
	bh=cf9J7TH7XqEZHGiMlMsDNw9IHfO4YoT29P/bOZUuqvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qoqp5eJFzyFlA0GYWfj4BADgkwPrk8iJL5xVQS5+0TJ5mnpdPDn64pad/7gPn+eOH
	 hC7kdkkjF7+/QY3izjLaC/pXZZJKET2Hp7mqVSby67Ve8qhDMLHswiJ6r/U6R3qQCR
	 Y4s4A6g8w+mlhep6ZH+OywM6MMra9hj5F+BNWQmrwK17Fz3jonl8hhDr6Z2/lYask6
	 KArlx9VDMOqBXkYQuOyB/URa8IKxwZF/i5iEzFBNg8/t0cmuZfGYSLXqZh6AR/RIrl
	 9wPgI/ivYWJ7l280gvwRTHhJfuQp6TD6mI1mj9D6tA63B3UdL91sWVu3vH46eIT9z5
	 AAIS5yXtI6N3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812115139.576303-3-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:12:18 +0000
Message-Id: <20260812121219.0E0161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack-allocated bitmap (`apm_filtered`) is passed to=
 `reset_queues_for_apids`.
- [High] Missing matrix_dev->mdevs_lock acquisition in vfio_ap_mdev_cfg_add=
() causing data race on matrix_mdev fields.
- [High] Unsafe iteration over matrix_dev->mdev_list without holding mdevs_=
lock.
--

--- Patch [2]: [PATCH v3 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kv=
m without checking for NULL ---
commit adee11494c3d56eaa0ce36b3c479c7382d103cad
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL

This commit adds NULL checks for matrix_mdev->kvm before attempting to
acquire the matrix_mdev->kvm->lock mutex in the configuration change and
scan complete callbacks. This prevents a potential NULL pointer dereference
if the kvm pointer has not been initialized.

> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2606,7 +2606,13 @@ static void vfio_ap_mdev_cfg_remove(unsigned long =
*ap_remove,
>  	int do_remove;
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate over
mdev_list holding only matrix_dev->guests_lock here?

Looking at vfio_ap_mdev_probe(), it appears new entries are added to
this list holding only matrix_dev->mdevs_lock (without taking guests_lock).

Could concurrent probing during an AP bus scan modify the list while we are
traversing it locklessly here, leading to list corruption?

> -		mutex_lock(&matrix_mdev->kvm->lock);
> +		/*
> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
> +		 * ordering requirement and prevent a lockdep splat.
> +		 */
> +		if (matrix_mdev->kvm)
> +			mutex_lock(&matrix_mdev->kvm->lock);
>  		mutex_lock(&matrix_dev->mdevs_lock);

[Severity: High]
This is a pre-existing issue, but does vfio_ap_mdev_cfg_add() also need
matrix_dev->mdevs_lock protection like this?

vfio_ap_mdev_cfg_add() is called right after vfio_ap_mdev_cfg_remove() from
vfio_ap_on_cfg_changed(), which only holds matrix_dev->guests_lock. It
modifies matrix_mdev->apm_add, aqm_add, and adm_add, and reads
matrix_mdev->matrix.

Could concurrent modifications race without mdevs_lock being held and
corrupt the guest AP configuration bitmaps in vfio_ap_mdev_cfg_add()?

[ ... ]
> @@ -2821,9 +2828,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;

[Severity: High]
This is a pre-existing issue, but does apm_filtered need to be zeroed or
initialized before use?

If vfio_ap_on_scan_complete() is called with non-empty adm_add but empty
apm_add and aqm_add, filter_adapters and filter_domains are set to false.
This bypasses vfio_ap_mdev_filter_matrix(), which normally initializes
apm_filtered.

Then the uninitialized stack variable is passed down:

    reset_queues_for_apids(matrix_mdev, apm_filtered);

Could this cause reset_queues_for_apids() to iterate over random stack
garbage bits and inadvertently reset arbitrary AP queues?

[ ... ]
>  void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> @@ -2854,15 +2855,29 @@ void vfio_ap_on_scan_complete(struct ap_config_in=
fo *new_config_info,
>  	mutex_lock(&matrix_dev->guests_lock);
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This isn't a bug introduced by this patch, but similar to the loop in
vfio_ap_mdev_cfg_remove() above, does this iteration also need
matrix_dev->mdevs_lock to prevent list corruption against concurrent calls
to vfio_ap_mdev_probe()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D2
