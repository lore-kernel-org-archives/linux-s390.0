Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9E4156C9;
	Mon, 27 Jul 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174017; cv=none; b=HuQoBlE+Y0bOpNmkm5LTdqZBuWUp25rflokdLKzjviLUHJImvE6gdaazXB5btDex3ujbL0H8ENecOdspvwIzTfBrvCPzfYPPSooIp++aOs8HEOBHTCioS+DxbvrRYq3cWS6ci1+17yjtwH7ZcBtQeBUp21l2MmTtuGCiim0Edbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174017; c=relaxed/simple;
	bh=IkfQWHm4VUtBsPwAYvM+2Y7mA+aJH/ZInajrtX4oEUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HjREOOHkKRCzA7sWI79ggSgfgB/AHdEmIZf0+dMNlaMQU5RIaysJSUIccKHeh9PNHVy4TqRcqgRBk9SHb9wnGYvQ9hcWCL3GD/e2AIobUbnbYmzAMtL2dAWiveWauWZF0VjUKmJtighqaSprZ5mMa/P5G9Ayup2LhQMNOLCHuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWP3vAMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWP3vAMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83231F000E9;
	Mon, 27 Jul 2026 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785174015;
	bh=3UzAapwmJtiTCaQlXrgTPFFwa/NHUjvOGkQjNjRyrug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWP3vAMqkow7ElzK2S8gZ62I0bu96fVRX01TmEsbGQKAjB/ngT5ULGQbeetS5SLii
	 qNp/cflQ/I5cm0i31fUb4Mqb0cVa/Vo5b4dTNA+ERmAAFDTGEBxKdoSnBUXy/TUMci
	 PFMc8CWseHXKffr+sFDgGHvsdVOCpCfiB61UUsji8vv/K1AQXcOX9H2Xuop3c5rbZH
	 /03xV4vYOacxgfEVJ4696Lo+L25UC+SVxjVeV1ccLk5elN7iMWjvfA/NSiXiBDpL0U
	 A9/8SKixHn/eHxcqgiQlhx9+0oR0azyhi8IkYTJUD20IGGZqvFLC/CaUTHmg4/aMc2
	 a1vQ0Yq0Y3Mmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-3-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:40:14 +0000
Message-Id: <20260727174014.E83231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The VFIO migration data structure lacks a magic identifier and v=
ersion number, and relies on an architectural macro for array sizing, posin=
g a risk to ABI stability.
- [Low] Typo and grammatical error in the docstring for `resuming_mig_file`.
--

--- Patch [2]: [PATCH v6 02/15] s390/vfio-ap: Data structures for facilitat=
ing vfio device migration ---
commit 1aa240c81b915a9ce3e59c82c532c41c1cab4d99
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Data structures for facilitating vfio device migration

This commit creates the data structures used to facilitate state transitions
during vfio device migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> +/**
> + * struct vfio_ap_migration_data
> + *
> + * Manages the migration state for the VFIO device that maintains the AP
> + * configuration of the guest being migrated.
> + *
> + * @mig_state:		the current migration state
> + * @resuming_mig_file:	the object used to restore the state of the vfio-=
ap
> + *			device the destination host:

[Severity: Low]
This isn't a bug, but there appears to be a missing word here. Should this
say "device on the destination host." instead of ending with a colon?

> + * @stop_copy_mig_file: the object used to store the AP configuration of=
 the
> + *			source guest for transfer to the destination host.
> + */
> +struct vfio_ap_migration_data {
[ ... ]
> +/**
> + * struct vfio_ap_config - the guest's AP configuration
> + *
> + * @num_queues:	the number of queues passed through to the guest
> + * @reserved:	padding to ensure proper alignment of @adm
> + * @adm:	bitmap specifying the control domains in the AP configuration
> + * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
> + *		queue information for a queue passed through to the guest
> + */
> +struct vfio_ap_config {
> +	u32				num_queues;
> +	u8				reserved[4];
> +	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];

[Severity: Medium]
Does this data structure need a version number or magic identifier to safely
handle ABI stability across host migrations?

Since this structure defines the binary layout of the migration data stream,
could changing the architectural macro AP_DOMAINS or the structure layout i=
n=20
future kernel versions silently break live migration compatibility between=
=20
hosts running different kernel versions?

> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D2
