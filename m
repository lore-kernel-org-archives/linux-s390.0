Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F33688A;
	Mon, 27 Jul 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177963; cv=none; b=ar+pWXVqID2K7WL/wEFUp3229wUe5MiKd1OTA2ivmlAfuEqxre5k2nC0p+Lw2Z1oFiyWA/b5rIDTv0vPISufEAN6OI3AyxIEUpFxNH3Eg7CgkQ90GHG67oZejUiM/69QOriJMxxzPee3rSPDm+b1ybUaH3hXZRTsXNFcUkQ94yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177963; c=relaxed/simple;
	bh=RYsECdzIg+Pq0Uaugm1zDZ77tCYTthSqhO68PYAPdvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEO6zd+ba7gZ85ejETnepFXc4DjDItMzgSBI8E4FnlpEIHTgPqGcECOhAoPgdZsFFeln3SGVg6G+V4JR89YtlM66Nw6i906hiam2PgP4NlIWFPljh0QABxSrVS0IRPyP2KhbIWXwOh6H5VLmtVp2jiHmbXzcimD0gYU45U8I3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsp+Vtis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsp+Vtis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845101F000E9;
	Mon, 27 Jul 2026 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177962;
	bh=G62ARkKmlTg0xKHtLRN+2pxVd016EyrDeymzgbmm1qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsp+VtisYoNYECBzfsGITNDhCnos5nQqBl1wvlauXD5G183Rmb/Gkv5SXHoCDPaMI
	 iLl5A48HDNAR5es8DgZcnJOqrJZMfhBXp+aJbpKswp6cp3wIzKUZhBK0RDbbllccZ2
	 AKdCRHm1PfEwixHZvSMl60PEfyn5EdFnbbCN0/tt/xC8Py/kUCcR/s+a51v6xFDi0o
	 fWL2A7qQJ/inyJCSyKxWyyBhvG4K2A95ukYeKzPemHX+gsgODyASo98KIAlYxotxbL
	 AYZ1edUJhw9AbYFfjKrgFJLNMNpXOXQBKO7MM/N604Qlah9IGOa6ja965aS6FkcwaS
	 YW++8OeDWqNLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-15-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:45:59 +0000
Message-Id: <20260727184600.845101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'migratable' feature is unconditionally advertised in sysfs,=
 even when migration is unsupported and explicitly disabled.
--

--- Patch [14]: [PATCH v6 14/15] s390/vfio-ap: Add 'migratable' feature to =
sysfs 'features' attribute ---
commit 4ed92108ce1d93cfce3f8740cc391bfad091179c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute

This commit adds the 'migratable' feature to the sysfs features attribute=20
to indicate that migration of vfio devices is supported.

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index 8e69ed286bb9c..4e973736522bc 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
>  struct ap_matrix_dev *matrix_dev;
>  debug_info_t *vfio_ap_dbf_info;
> =20
> +#define FEATURES "guest_matrix hotplug ap_config migratable"
> +
>  static ssize_t features_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
> +	return sysfs_emit(buf, "%s\n", FEATURES);

[Severity: Medium]
Will this unconditionally advertise the migratable feature even when the
environment does not support it?

If the system is running as a Secure Execution (SE) guest, migration is
typically disabled. By hardcoding "migratable" into the FEATURES string,
management tools like libvirt querying the features sysfs attribute might
incorrectly assume migration is supported.=20

This could lead orchestrators to make incorrect VM placement decisions,
followed by unexpected migration failures when QEMU rejects the migration
because the VFIO mdev lacks the capability.

Should features_show() check environmental constraints, such as
ap_is_se_guest(), before including the migratable flag in the output?

>  }
>  static DEVICE_ATTR_RO(features);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D14
