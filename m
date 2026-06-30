Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58A426693;
	Tue, 30 Jun 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816950; cv=none; b=QOZwI9sTvel9NU3U3MlEA4uOZFZgf2d3G93C3UV9BAGpc27gasCx3z1IP9pTnKmfhNhagg4p5gZnXJ3aj8MR8fbxeViTXAhMgsrlUFfVp6/D0zvELfT6HlAST4/H3X3UAIHEwn842aj2hPXVlm2RKRCwQsQMm7Kkz/TxVyjhiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816950; c=relaxed/simple;
	bh=MVRiXQlQNp+hpHc60JFHtz2KyRo6MC6T9xNC4U55VIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYHUw77+4EdHQ4lyUahgTyPYRKkJLZJdyAXjb50SFVQUsQUPRRPirkoIhHk09ZgRCFEoYpXMCVaVqowD0HgPaalUZX+Iz7FbcCM6378Uzy4JXKZinFyyCWlCVJPAcXIffAZcW1vDBvkvc7JDe0ZClw+Xl3+iZhYnCO+WsrRo5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B//pSUZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B//pSUZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08B1F00A3A;
	Tue, 30 Jun 2026 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816943;
	bh=r4M6In1JQ8Z6U2OcHZTfWcB+V1K7l4VIpB1HiCw//yE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B//pSUZ5OXyzcNwvNi71Jm8usrvqDD/ojRr+nhrQY0Dlct8MlX3OiuMOqwgV1pNzh
	 kSspsXweGXDFkTpDrd2kWCQ5QByHxXzQJXnCw4CoFsOvVbrbmsn7dvZkqmfLBFAbzb
	 s0xMcmlQvwyCEjoJYxQojWoFKCh4U+9EyLxZ0l1JAzW4A2HhwVy2p1n/fB1RQdGRYC
	 hi8XIOcdIG+787k0Beerm/ySZiFA/xoWpDnNITVftpZNbLkiutUz3kP9uXPIMih8f+
	 hRXEyfXriz2P8StiP+pBX1q5KS3Ab2RsRCTnIGtAnKvEEkQ9BaOCQNIiBA+xQIHC1M
	 OWTgnIBQ2Tu/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-3-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:55:42 +0000
Message-Id: <20260630105543.1C08B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Out-of-bounds read in `do_post_copy_validation` due to redunda=
nt and unsynchronized size fields (`num_queues` and `config_sz`) during fra=
gmented migration stream writes.
- [Low] Use of the architecture-dependent type `size_t` in a binary structu=
re intended for serialization.
- [Low] Severe mismatch between kernel-doc comments and actual structure fi=
elds in `vfio_ap_migration_data` and `vfio_ap_config`.
--

commit b64c84539884d50cda90f18a69a0a94397d84158
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Data structures for facilitating vfio device migration

This commit introduces the foundational data structures needed to facilitate
state transitions during vfio device migration for the s390 vfio-ap driver.
It adds structures for migration data, queue information, and AP configurat=
ion.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..239168c4b7fff
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -0,0 +1,56 @@

[ ... ]

> +/**
> + * vfio_ap_migration_data - the data needed to migrate a guest with pass=
-through
> + *			    access to AP devices
> + *
> + * @mig_state:		the current migration state
> + * @resuming_migf:	the object used to resume the target guest
> + * @saving_migf:	the object used to save the state of the source guest
> + */
> +struct vfio_ap_migration_data {
> +	enum vfio_device_mig_state	mig_state;
> +
> +	struct {
> +		struct file *filp;
> +		struct vfio_ap_config	*ap_config;
> +		size_t			config_sz;
> +	} resuming_mig_state;
> +
> +	struct file			*stop_copy_mig_file;
> +};

[Severity: Low]
Are the kernel-doc fields for vfio_ap_migration_data out of sync with the
implementation? The comments document resuming_migf and saving_migf, but the
actual fields are resuming_mig_state and stop_copy_mig_file.

[ ... ]

> +/**
> + * vfio_ap_config - the guest's AP configuration
> + *
> + * @num_queues:	the number of queues passed through to the guest
> + * @reserved: padding to ensure proper alignment of qinfo array
> + * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
> + *		queue information for a queue passed through to the guest
> + */
> +struct vfio_ap_config {
> +	u32				num_queues;
> +	u8				reserved[4];
> +	size_t				config_sz;

[Severity: Low]
Does the kernel-doc block for vfio_ap_config need an update to include the
config_sz field?

[Severity: Low]
Could the use of size_t here cause consistency issues? Since size_t has
variable width depending on the architecture, using it in a binary structure
intended for serialization over file descriptors or the network is generally
avoided in favor of fixed-width types.

[Severity: Critical]
Could having both num_queues and config_sz in this struct lead to an
out-of-bounds read later during migration?

If a fragmented migration stream write manipulates config_sz to be a smaller
value than expected, the validation checks in reallocate_ap_config() could =
be
bypassed:

reallocate_ap_config() {
    cur_cfg_sz =3D ap_config->config_sz;
    num_queues =3D ap_config->num_queues;
    if (cur_cfg_sz >=3D sizeof(struct vfio_ap_config)) {
        ...
    } else {
        new_cfg_sz =3D cur_cfg_sz + len;
    }
}

This could cause an out-of-bounds read in do_post_copy_validation() when
looping num_queues times over the qinfo array:

queues_available_on_target_system() {
    for (int i =3D 0; i < source_config->num_queues; i++) {
        apqn =3D source_config->qinfo[i].apqn;
...
}

Is it possible to synchronize these fields or derive the size directly from
num_queues to prevent a mismatch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D2
