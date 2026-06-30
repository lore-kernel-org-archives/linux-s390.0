Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CF3FF1A3;
	Tue, 30 Jun 2026 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819247; cv=none; b=RJeXxRHhGv9MtrYz+euca144lK2jGO/KbcFO6mfX3SpkULDfC5274Yi8Qfwtu1bCFbPBPKxgftILNLCFaxox2bpmNWHvmbf/qMP97S4hgWfA6/ZQHBtGawwfKAAdARWyoTsmCNJj08VlUfypTtTrB2ziHFhejQ0KDg0VIJ9sb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819247; c=relaxed/simple;
	bh=sdh9E/2hjfXzblIuxnHSy6GjbN2ta8pS20MqPxp3lG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hm7SLxsc+lk0g5efQShar78M63fdhhijVyLWIM/hhMHnBP0tUrLup0C2iSypp0uXm7pNqBErZiEQZwBS5jPMU5YJzWczPDfCnmAgSBdO8fUTcJ69V6FVU/1uGGTWoJwxtjZyYt0SL+ERnQvvndnrY1C9xznEk+b9XTbbFeTDQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa/yeNhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa/yeNhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184111F000E9;
	Tue, 30 Jun 2026 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819246;
	bh=B1NliwZBh7rqR7GVo5tTOxQW4zi1/nBH+BWSvKDlNZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aa/yeNhl/M3yIB/sbmZ4UVvSAPNb9t9nWCWP/MAd4drWEH7IxMlAybbkrIuX7OgTN
	 2yDBvyGkAeAwjbV41x7FKRJvQh/UgJ92c0X2lsVra4pSGGsRpCPTKARk2dSMHT6PvP
	 FGSqECYqX37/v8bBhlL10K8eseF2yrffEqR0xP1Z5fxNMaV62kgzLiPBzqzIrUjsEu
	 CF7HNRnfFGFXPg0FB3b57lm8eI0jgbFxhAgsfBVilYeAqVXYxSaMQyUwFWam8kQ9Nh
	 vXSObc60QqMJVNTxPO+5LOEbMJQWrFuD9jtfEZgfer8yfmVftDiXqQhdGgQ1f8g1du
	 0g8D3DlyOGIKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260630104132.1598851-10-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:34:05 +0000
Message-Id: <20260630113406.184111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Refactoring error replaces unlinking with linking, causing a C=
ritical Use-After-Free on mdev removal.
- [High] Unconditional NULL pointer dereference in queue collection causes =
kernel panic.
- [High] Uninitialized stack-allocated bitmap `apids_removed` causes uninte=
nded hardware resets.
- [High] Typo in `reset_removed_queues` skips hardware resets for removed d=
omains, leaking cryptographic state.
- [High] List corruption due to double addition of queues to local reset li=
sts.
- [High] Premature queue linking before matrix validation permanently corru=
pts hash tables of concurrently running mdevs.
- [High] Domain-only removals completely bypass the hardware reset sequence=
, leaking cryptographic state.
- [Low] Loop over domain mask uses incorrect limit constant `AP_DEVICES` in=
stead of `AP_DOMAINS`.
--

commit 1cdca5acb48932a1408594014bf5e0f8fa51e334
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration

Add a new vfio_ap_set_new_config function to set a guest's AP
configuration. This is needed in order to set the state of the mdev when
it is migrated from a remote host system during the RESUMING phase.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -875,7 +896,40 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_=
matrix_mdev *matrix_mdev)
>  			q =3D vfio_ap_mdev_get_queue(matrix_mdev,
>  						   AP_MKQID(apid, apqi));
>  			if (q)
> -				q->matrix_mdev =3D NULL;
> +				vfio_ap_mdev_link_queue(matrix_mdev, q);
>  		}
>  	}
>  }

[Severity: Critical]
Does replacing the unlink assignment with vfio_ap_mdev_link_queue() leave
dangling pointers after device teardown?

This function is supposed to unlink the queue from the mdev by setting
q->matrix_mdev =3D NULL. Actively linking it instead means the queues are n=
ever
unlinked, which could cause a use-after-free when the matrix_mdev is
subsequently freed during removal.

[ ... ]

> -static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
> -				    unsigned long apid,
> -				    struct list_head *qlist)
> +static void collect_queues_by_apid(struct ap_matrix_mdev *matrix_mdev,
> +				   unsigned long apid,
> +				   struct list_head *qlist)
>  {
>  	struct vfio_ap_queue *q;
>  	unsigned long  apqi;
> =20
>  	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {

[Severity: High]
Does this unconditionally dereference matrix_mdev?

The loop condition accesses matrix_mdev->shadow_apcb.aqm without checking if
it is valid. Later code passes a NULL pointer to this function, which will
cause an immediate kernel panic here.

> -		q =3D vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
> +		q =3D matrix_mdev ?
> +				vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
> +				vfio_ap_find_queue(AP_MKQID(apid, apqi));
> +		if (q)
>  			list_add_tail(&q->reset_qnode, qlist);

[Severity: High]
Does appending queues directly to local lists here corrupt the list structu=
re?

If a queue matches both a removed adapter and a removed domain, it is colle=
cted
by both collect_queues_by_apid() and collect_queues_by_apqi(). Calling
list_add_tail() unconditionally overwrites the list links of the node,
corrupting the structure of the first list if it wasn't unlinked first.

> +	}
> +}
> +
> +static void collect_queues_by_apqi(struct ap_matrix_mdev *matrix_mdev,
> +				   unsigned long apqi,
> +				   struct list_head *qlist)
> +{
> +	struct vfio_ap_queue *q;
> +	unsigned long  apid;
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm, AP_DEVICES) {

[Severity: High]
Does this also unconditionally dereference matrix_mdev?

Similar to collect_queues_by_apid(), accessing matrix_mdev->shadow_apcb.apm
here will panic if matrix_mdev is NULL.

[ ... ]

> +static void reset_removed_queues_by_apid(unsigned long *apm_removed,
> +					 unsigned long *apm_filtered,
> +					 struct list_head *qlist)
> +{
> +	DECLARE_BITMAP(apids_removed, AP_DEVICES);

[Severity: High]
Can this uninitialized stack-allocated bitmap cause unintended hardware res=
ets?

DECLARE_BITMAP() allocates the bitmap on the stack without zero-initializing
it. Setting specific bits in it without ever clearing it first means it
retains garbage stack data, which could lead to resetting arbitrary AP
queues across the host.

> +	unsigned long apid;
> +
> +	for_each_set_bit_inv(apid, apm_filtered, AP_DEVICES)
> +		set_bit_inv(apid, apids_removed);
> +
> +	for_each_set_bit_inv(apid, apm_removed, AP_DEVICES) {
> +		if (!test_bit_inv(apid, apids_removed))
> +			set_bit_inv(apid, apids_removed);
> +	}
> +
> +	if (!bitmap_empty(apids_removed, AP_DEVICES)) {
> +		for_each_set_bit_inv(apid, apids_removed, AP_DEVICES)
> +			collect_queues_by_apid(NULL, apid, qlist);

[Severity: High]
Is it intentional to pass NULL as the matrix_mdev here?

As mentioned earlier, collect_queues_by_apid() unconditionally dereferences
this pointer in its loop header, so this call will result in a NULL pointer
dereference.

[ ... ]

> +static void reset_removed_queues(struct ap_matrix *m_removed,
> +				 unsigned long *apm_filtered)
> +{
> +	struct list_head qlist_by_apid, qlist_by_apqi;
> +	DECLARE_BITMAP(apqis, AP_DOMAINS);
> +	unsigned long apqi;
> +
> +	INIT_LIST_HEAD(&qlist_by_apid);
> +	INIT_LIST_HEAD(&qlist_by_apqi);
> +	bitmap_clear(apqis, 0, AP_DOMAINS);
> +
> +	reset_removed_queues_by_apid(m_removed->apm, apm_filtered, &qlist_by_ap=
id);
> +
> +	for_each_set_bit_inv(apqi, m_removed->aqm, AP_DEVICES) {

[Severity: Low]
Should this loop use AP_DOMAINS instead of AP_DEVICES for the limit?

While both constants might currently be defined identically, iterating over=
 the
domain mask (aqm) with the device limit constant could lead to out-of-bounds
accesses if the architecture limits diverge in the future.

> +		set_bit_inv(apqi, apqis);
> +		collect_queues_by_apqi(NULL, apqi, &qlist_by_apqi);
>  	}
> =20
> +	if (list_empty(&qlist_by_apqi))
> +		return;
> =20
> +	remove_queues_already_reset(&qlist_by_apid, &qlist_by_apqi);
> =20
> +	if (!list_empty(&qlist_by_apqi))
> +		vfio_ap_mdev_reset_qlist(&qlist_by_apid);

[Severity: High]
Is there a typo here where qlist_by_apid is being reset instead of
qlist_by_apqi?

The code checks if the apqi list is empty, but then explicitly calls the
reset function on the apid list. This seems to bypass the reset of removed
domain queues entirely, leaving their cryptographic state active.

[ ... ]

> +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
> +				 struct ap_matrix *m_new,
> +				 bool filtering_allowable)
> +{
> +	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
> +	struct ap_matrix m_old, m_old_shadow, m_removed;
> +	bool do_update;
> +	int rc;
> =20
> +	lockdep_assert_held(&ap_attr_mutex);
> +	assert_has_update_locks_for_mdev(matrix_mdev);
> +
> +	/* Save old state */
> +	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
> +	ap_matrix_copy(&m_old_shadow, &matrix_mdev->shadow_apcb);
> +
> +	/* Reset mdev state */
> +	vfio_ap_unlink_queues(matrix_mdev);
> +	ap_matrix_copy(&matrix_mdev->matrix, m_new);
> +	vfio_ap_link_queues(matrix_mdev);
> +
> +	rc =3D validate_ap_matrix(matrix_mdev);

[Severity: High]
Does linking the queues before validating the matrix corrupt the hash tables
of concurrently running mdevs?

Queues are forcibly linked to the new matrix_mdev's hash table here before
verifying if they are already owned by another mdev in validate_ap_matrix().
If a queue is currently owned by another mdev, hash_add could blindly
overwrite its mdev_qnode pointers, destroying the victim mdev's hash bucket
chain.

> +	if (rc) {
> +		restore_mdev_state(matrix_mdev, &m_old, &m_old_shadow);
> +		return rc;
> +	}
> +
> +	/*
> +	 * If APIDs need to be filtered from the guest AP config and filtering
> +	 * is not allowable according to the caller, then terminate the operati=
on.
> +	 */
>  	do_update =3D vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
> +	if (!bitmap_empty(apm_filtered, AP_DEVICES) && !filtering_allowable) {
> +		restore_mdev_state(matrix_mdev, &m_old, &m_old_shadow);
> +		return -ECANCELED;
> +	}
> +
>  	do_update |=3D vfio_ap_mdev_filter_cdoms(matrix_mdev);
> =20
> +	if (do_update)
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +
> +	get_removed_matrixes(&m_removed, &m_old, m_new);
> +	if (!bitmap_empty(m_removed.apm, AP_DEVICES) ||
> +	    !bitmap_empty(apm_filtered, AP_DEVICES))
> +		reset_removed_queues(&m_removed, apm_filtered);

[Severity: High]
Does this condition bypass the hardware reset sequence for domain-only remo=
vals?

If the configuration update only removes AP domains, meaning m_removed.aqm =
is
populated but m_removed.apm is empty, the entire reset sequence appears to =
be
skipped. This could leak sensitive cryptographic state to potential subsequ=
ent
users.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D9
