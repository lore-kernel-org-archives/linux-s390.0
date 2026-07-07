Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286539479F;
	Tue,  7 Jul 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416279; cv=none; b=n8qe/fpKyfeIcJiwd1e/sTShKerTi17+0bSdcaEsHdiXyX3YmZqiLb2pii6QRUzwmed0dvFhdfnoQqOfWN23ulyqn/CgUxZlD/LVz0hFtLjAro60z1oevi53iVXuVrB7f/RTxt0W2ecnWnkOY4WHtpBlpYj7otVkMmJ1PriVAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416279; c=relaxed/simple;
	bh=0Nvuv2gxvMtuI7VLzLbBtmnQeLKkkvUNkqsax7pJcD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ns0axW2XmRl93nab+OzHILPxB64aaZ1uVJCNeIFduv7g6NcG8YMelPI7E5m51ttNgLe5YEkQ9AUO8M3IYDGtfd8U+NEFMtwOYE+YVkHolUlraBBvdfeS9LpPFCdzMcy64IuFslE6IVuFiA08w7LluEMox5MQ3dy6LdVTSOqqqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSC4h9Lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSC4h9Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBED1F00A3A;
	Tue,  7 Jul 2026 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416277;
	bh=UpEQEv+EatMCmHxitenbQSPz6w2c+GNUOhJxnvcK+m8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSC4h9Lw3oWcir2rHX4k4Ab0KZnVMeEC6CCpYZAZG/4SyT+sLeisBLiet9cA92jcF
	 2S5VtDkwBuPt7ZVP2y/C4muVI3ccaCl5oQnZgglyFYXCLD8SHzygtuA1CzToIuXdgw
	 /sgySwkC83lLHT41/K+ciXRHeJhKYCHisFQsjTtn2CYHDFlTDFos2ZC/Ctr/Av1jbS
	 P72/uRwVT1Ehceq0GouK3UYHfoVdQa5G3pG1Rstats7YvuMLiNK71Rvj25WTIKmFp1
	 B55Nwb5NiuP2/r7HxC1jBtnhn631Z/lK+tn80F9H5rjc4Y+spjz1lQ6gYAft97w0GJ
	 O/zAMQSPBuYMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260707090226.3206695-10-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:24:37 +0000
Message-Id: <20260707092437.5BBED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Unconditional NULL pointer dereference of `matrix_mdev` when g=
athering queues by APID and APQI.
- [Critical] Adding the same queue to two independent linked lists corrupts=
 the `reset_qnode` list pointers.
- [Critical] `vfio_ap_mdev_unlink_fr_queues` links queues instead of unlink=
ing them, leading to a UAF on mdev removal.
- [Critical] Unlinking queues from the old configuration and aggressively l=
inking them to the new configuration before validating exclusivity leads to=
 queue hijacking.
- [High] Kernel stack data leak and logic error due to uninitialized `apids=
_removed` bitmap.
- [High] AP hardware queues associated with removed AP domains are never re=
set, leaking cryptographic state to other guests.
- [High] Attempting to reset removed queues by passing a NULL `matrix_mdev`=
 forces a global queue lookup, destructively resetting queues assigned to o=
ther guests.
- [Low] Iterating over `AP_DOMAINS` sized bitmap using `AP_DEVICES` size ma=
cro.
--

--- Patch [9]: [PATCH v4 09/15] s390/vfio-ap: Add method to set a new guest=
 AP configuration ---
commit ac6b1dacfdb4c478ea23f906be7720936567f0d9
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add method to set a new guest AP configuration

Adds a new vfio_ap_set_new_config function to set a guest's AP configuratio=
n.
This is needed to set the state of the mdev when it is migrated from a
remote host system during the RESUMING phase.

> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -875,7 +896,40 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_=
matrix_mdev *matrix_mdev)
>  			q =3D vfio_ap_mdev_get_queue(matrix_mdev,
>  						   AP_MKQID(apid, apqi));
>  			if (q)
> -				q->matrix_mdev =3D NULL;
> +				vfio_ap_mdev_link_queue(matrix_mdev, q);

[Severity: Critical]
Does this introduce a use-after-free risk when the mdev is removed?

By replacing the unlinking statement with vfio_ap_mdev_link_queue(),
the queues retain pointers to the matrix_mdev struct. When an mdev is later
destroyed, subsequent hardware interrupts or queue accesses could trigger
memory corruption.

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

[Severity: Critical]
Can this cause a NULL pointer dereference?

If matrix_mdev is passed as NULL (which happens when called from
reset_removed_queues_by_apid()), the loop header will unconditionally
dereference matrix_mdev->shadow_apcb.aqm before the NULL check occurs
inside the loop.

> +		q =3D matrix_mdev ?
> +				vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
> +				vfio_ap_find_queue(AP_MKQID(apid, apqi));

[Severity: High]
When matrix_mdev is NULL, could falling back to vfio_ap_find_queue()
destructively reset queues assigned to other guests?

Since APIDs can be shared across multiple guests using disjoint domains,
a global search might discover and indiscriminately reset hardware queues
actively serving other guests.

> +		if (q)
> +			list_add_tail(&q->reset_qnode, qlist);
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

[Severity: Critical]
Is there a similar NULL pointer dereference risk here?

Similar to collect_queues_by_apid(), if matrix_mdev is NULL, the loop
header evaluates matrix_mdev->shadow_apcb.apm before the ternary check.

[ ... ]

> +static void reset_removed_queues_by_apid(unsigned long *apm_removed,
> +					 unsigned long *apm_filtered,
> +					 struct list_head *qlist)
> +{
> +	DECLARE_BITMAP(apids_removed, AP_DEVICES);
> +	unsigned long apid;
> +
> +	for_each_set_bit_inv(apid, apm_filtered, AP_DEVICES)
> +		set_bit_inv(apid, apids_removed);

[Severity: High]
Can this lead to unintended hardware queues being reset?

DECLARE_BITMAP allocates array storage on the kernel stack but does not
zero-initialize it. The set_bit_inv() calls flip specific bits, but the
unmodified bits retain their previous stack garbage, which is later iterated
over as removed APIDs.

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
Is AP_DEVICES the correct limit here?

It looks like this is iterating over m_removed->aqm, so using AP_DOMAINS
would be the correct limit macro.

> +		set_bit_inv(apqi, apqis);
> +		collect_queues_by_apqi(NULL, apqi, &qlist_by_apqi);
> +	}

[Severity: Critical]
Could this corrupt the reset_qnode list pointers?

If an AP configuration update removes both an APID and an APQI matching a
single queue, the same queue object is fetched first by
reset_removed_queues_by_apid() and then by collect_queues_by_apqi().

Adding the same queue's reset_qnode to two independent list heads=20
(qlist_by_apid and qlist_by_apqi) will blindly overwrite its internal next
and prev pointers.

> +
> +	if (list_empty(&qlist_by_apqi))
> +		return;
> +
> +	remove_queues_already_reset(&qlist_by_apid, &qlist_by_apqi);
> +
> +	if (!list_empty(&qlist_by_apqi))
> +		vfio_ap_mdev_reset_qlist(&qlist_by_apid);

[Severity: High]
Should this pass &qlist_by_apqi instead of &qlist_by_apid?

If the domains list is not empty, passing &qlist_by_apid fails to reset the
removed domains.

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
> +	if (rc) {
> +		restore_mdev_state(matrix_mdev, &m_old, &m_old_shadow);
> +		return rc;
> +	}

[Severity: Critical]
Could linking queues to the new configuration before validating exclusivity
lead to queue hijacking?

By executing vfio_ap_link_queues() before validate_ap_matrix() enforces
assignment conflicts, the code forcefully overwrites q->matrix_mdev on
queues that might be assigned to other active guests.

If validate_ap_matrix() fails, the rollback in restore_mdev_state() unlinks
the queue and leaves the original owner disconnected from their active
resource.

[ ... ]

> +	get_removed_matrixes(&m_removed, &m_old, m_new);
> +	if (!bitmap_empty(m_removed.apm, AP_DEVICES) ||
> +	    !bitmap_empty(apm_filtered, AP_DEVICES))
> +		reset_removed_queues(&m_removed, apm_filtered);

[Severity: High]
Does this conditional miss checking m_removed.aqm?

If an AP configuration update purely removes domains (aqm), this check
skips reset_removed_queues() entirely. This leaves the hardware queues
associated with removed domains un-reset, potentially leaking cryptographic
state to subsequent guests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D9
