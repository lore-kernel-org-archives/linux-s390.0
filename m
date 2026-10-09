Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB744D7D51;
	Fri,  9 Oct 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546794; cv=none; b=ZBydd18CvzLpWQZqDuc4XbDg5/wRBJM/NbnA6Rzyws4U+ypEfZCHbgF2BJ1j8dJrToJvBLWIVT0M2HupovivIjdbEWU7kAcbWrVRuYK8jSFWwMWhhgzfIlXy2wEQeJWabCBiNgbU5YM0e9gRznWYQznnEjhTr16omSjqJlK5NtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546794; c=relaxed/simple;
	bh=btwDbiunY6oLlEmqGvAFyOqHDL+6CvKnTLLF7Nr/yrA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZgZ8fkap+q26bAOZCtnxeEdLSWXDBsQ/5aj5+b8TFUjrPMioF17X8kX8vk/LMKOv2p/afiJTo8zUnKftOMyNUGX++Xragl4Ei6w7/z/tfPW5G6yOt1BStIsQHcOX7+bFyl4Ch4gF4HLNlfwlANLwNgVaJVi/xTuvdXw31ZfFSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0GmwLz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0GmwLz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296A1F000FF;
	Fri,  9 Oct 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546784;
	bh=s/euihaLGeB/PMopmMwZSFJxKGlA2n/ww357OC9k8mE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0GmwLz3QHx9hzi0J9t6NL+j2tEHUJiw13O9WezuOscL6IPMfIafWGr7+gQ4OOrRS
	 MsrGqBXwityklZgpiSjx1lzGMCV3SsSgIrXbZzHBGqX05InbhnwR67NClWPfZ0blLP
	 /DWu95fNjSh2pWbKqLotw9MY/iKfmoEbb/q2wCriaExxz50vg2snHEWuFqKrt7N/ZA
	 M6SESEffkuz3dOnfkLd/P4zOXf5I9P6IM5Aau/9Vqlw+8BL82frkx5V8nmwV8hRx/b
	 Liqn0Yh/LOUU1dmIwFFqLlaIZ/JKXjBUTTBpRXprNCWXL43Z3XNWMODnnwBxhQHa3x
	 xlvM4z0PsNm3g==
Message-ID: <sashiko-outbox-165440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-11-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:53:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] vfio_ap: duplicate prototype for vfio_ap_matrix_init()
--

commit e05cec73b2479bdf6aa3c63debaa31756d289ed2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration

This patch adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. It refactors code from the ap_config_store function into a
new, non-static function which is callable from both the sysfs attribute
handler and the live guest migration code.

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/=
vfio_ap_private.h
> index 9044ef4408c87..3910b5c023c91 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -172,6 +172,8 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *ne=
w_config_info,
>  void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>  			      struct ap_config_info *old_config_info);
> =20
> +void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *=
matrix);

[Severity: Low]
This isn't a bug, but does this patch add a duplicate prototype for
vfio_ap_matrix_init()? Looking further down in this header, the exact same
declaration already exists just above the newly added
vfio_ap_set_new_guest_config() prototype.

> +
>  void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_m=
dev);

[ ... ]

> @@ -235,4 +237,7 @@ assert_has_update_locks_for_mdev(struct ap_matrix_mde=
v *matrix_mdev)
> =20
>  void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *=
matrix);
> =20
> +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
> +				 struct ap_matrix *m_new);
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D10
