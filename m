Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C541A569;
	Fri, 24 Jul 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914113; cv=none; b=S3bcG+yAGnZyKlUaut+mAnGyhtE2wrYUbGxVK9CGEl4mRhYMZO8syrFOYRVFaXrWPL5RoXCg59AcCpFat0ieYzkfzFYWImm8vzw4uoZz9SsnHgcQFo+XS/lDEuhJlCtZnBVOETkez2UeT/0eXg0gdKQzN9trhLlEkv+ILNl8BaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914113; c=relaxed/simple;
	bh=LATGk1Mpopu7i+mX8N/0zdj3wbMrDrQ1cgcaTJT2WzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JkmJVbbjrg0SxQbDoiQ6AZvmcyMrTNKQPOKFfCHSbaUMzRSPXluA5ihbG0/7rxX1v5aEOXgxF5MotQOkJl6IILy86uSs+7Xd4m7WuV6HFS/tqQdUM3MHNbxo/ycUhn2MGGYrdpXBdrZtY+6u+DLUY7Oqm2h6nxiPUx4RroGS6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3dd6ZOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3dd6ZOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467581F000E9;
	Fri, 24 Jul 2026 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784914108;
	bh=ZUdeq4pw0b/ouxPAuL3nC9+/zktWW0SmAdpQcFnGbAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3dd6ZOp2nV7j52oOohEzBuEzRdm52rK/JGrNpJx0Bz+VEaZyrwGQK2q4niFR1nBu
	 HNX4CvkdWCHlGBbX5pcTI/X6c+J7Pi+TimDjzILCN5++aMeKCeqrFp3uIz3rKLJht4
	 VJc4bLWDEuMdoeLHMz1/CHiIH3CLt61FwzB25SJI863LDujjO2ojNQiRg2zo50ewaJ
	 6YB6ng9rucfP+EjMCqLHHpIGvvZsl9/zSo5BeTiqvxX1UsDZZmCoCf5dAm/BOAKZxu
	 Ok9q9Wc18cycrED4WO+amxAFMb6bVItgTWTmrXJXIknjmqG9+bCI2T2KBSmRlt85tl
	 2xcv5XapxioEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260724161351.1802644-3-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:28:27 +0000
Message-Id: <20260724172828.467581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect kernel-doc formatting and field name mismatches will caus=
e documentation build warnings.
--

--- Patch [2]: [PATCH v5 02/15] s390/vfio-ap: Data structures for facilitat=
ing vfio device migration ---
commit c31e0e68ee7918227073261c8d3c179cdb56d4da
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Data structures for facilitating vfio device migration

Creates the data structures used to facilitate state transitions during
vfio device migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..1b0856aacb697
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -0,0 +1,72 @@
[ ... ]
> +/**
> + * vfio_ap_migration_file
       ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is this missing the "struct " keyword and a short description for
struct vfio_ap_migration_file?

Building the documentation might trigger a kernel-doc warning here.

> + *
> + * This object is used for chunk processing of multiple reads and writes=
 of
> + * AP configuration information.
[ ... ]
> +struct vfio_ap_migration_file {
> +	struct file		*filp;
> +	struct vfio_ap_config	*ap_config;
> +	unsigned long		config_sz;
> +};
> +
> +/**
> + * vfio_ap_migration_data
       ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Could this kernel-doc block for struct vfio_ap_migration_data also be
missing the "struct " keyword?

> + *
> + * Manages the migration state for the VFIO device that maintains the AP
> + * configuration of the guest being migrated.
[ ... ]
> +struct vfio_ap_migration_data {
> +	enum vfio_device_mig_state	mig_state;
> +	struct vfio_ap_migration_file	resuming_mig_file;
> +	struct vfio_ap_migration_file	stop_copy_mig_file;
> +};
[ ... ]
> +/**
> + * vfio_ap_config - the guest's AP configuration
> + *
> + * @num_queues:	the number of queues passed through to the guest
> + * @reserved:	padding to ensure proper alignment of @cntl_domains
                                                              ^^^^^^^^^^^^^

[Severity: Low]
Does this documentation for @reserved incorrectly reference a nonexistent
cntl_domains field in struct vfio_ap_config?

The struct defines the field as adm, so this might result in a field name
mismatch warning during documentation build.

> + * @adm:	bitmap specifying the control domains in the AP configuration
> + * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
> + *		queue information for a queue passed through to the guest
> + */
> +struct vfio_ap_config {
> +	u32				num_queues;
> +	u8				reserved[4];
> +	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D2
