Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD041DE0C
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231351; cv=none; b=l2g+E43tu5gQEDU1uRKWkpPZlUgfez+nNKd0Je5FD9c+12bagaT/KDV1wwQ2qzpSa0KjUQu14aQJpPdFXdtnuSNnk7mzvn48ges0Nsew7bxcxfiMQsRkTinFnKzazl+vR+6KSOfXi/9VV/ZpngFf4ngMZgzraDaMD0e0lVdzpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231351; c=relaxed/simple;
	bh=EkjWYVPqzxZY+lZakYqk+cfF/qnujB0PkPR1x1Hb4T0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxIOIgGvsEhPxIPGl4tfxKzdQzD4byA8PoHSu10pI5z4scx5Ey9Kl+EUXrprMnLZ5M0wTPHEX1TlFRkqHCvVCyLGRcZjm92Ro5Dcr931/fTTSqB/fbExKvM681JzXK99BMjKH19JIt9N9JAhQHsEzpnFqYDMKGvbRhgl82N769w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hthd94uZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hthd94uZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA41F01561;
	Tue, 28 Jul 2026 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231348;
	bh=fXDmk4N6IHw5r6tJrevupm0XCWWlS71ixaK7aw7STnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hthd94uZORQBfNuGMS2icBZI/fvt+SM39gEvMJRc4RZ1Qwodj9HwqDIGyGwo8KIzq
	 YBlN5yBQonKfvbfwA84q9fB+Pg5AWl3bc26BS5oHHcD/pK76XmiDFOnioEwyfqY5bP
	 uscAdjCBbuRnKyQYGmB3wHVzeep2UYWGtjh8zVrnt1qFQjHCi9onSIk7Gf/X7TdHVU
	 mwKSFkvIedl8ezmaH3bZOR1312W4af7OmrHRcw0nY98TBMeU6o5mLjLbuOYzpmszvr
	 Dh6Cbvr/uxTnNPrkcXocBSVhWbwigNdbMdWcqtz/mGYDZAXY4YtM/0odiVBflTADgm
	 pToi529A09Z6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] dibs: fix use-after-free of dmb_node in loopback
 attach/detach/unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727093530.968834-1-hidayath@linux.ibm.com>
References: <20260727093530.968834-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:35:46 +0000
Message-Id: <20260728093547.8AEA41F01561@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dibs_lo_detach_dmb() fails to clear dibs->dmb_clientid_arr when dr=
opping the final reference, leading to permanent client resource leaks.
- [High] Double free of dibs->dmb_clientid_arr in dibs_lo_dev_probe() error=
 path.
- [High] Race condition in dibs_lo_move_data() routes spurious interrupts t=
o wrong clients.
--

--- Patch [1]: [PATCH net] dibs: fix use-after-free of dmb_node in loopback=
 attach/detach/unregister ---
commit 90d8ce044f1442abf2a546d5baabbf36276d4b45
Author: Hidayath Khan <hidayath@linux.ibm.com>

dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister

This commit fixes a use-after-free race condition in the DMB loopback
operations. It closes the race by making the hash table membership and refc=
ount
transitions atomic with respect to each other under the write lock. Freeing=
 the
node is now handled safely after the lock is dropped.

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index 0f2e093111526..fd5caf1e19a8f 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c
[ ... ]
> @@ -209,11 +205,12 @@ static int dibs_lo_detach_dmb(struct dibs_dev *dibs=
, u64 token)
>  {
[ ... ]
> +	last =3D refcount_dec_and_test(&dmb_node->refcnt);
> +	if (last)
> +		hash_del(&dmb_node->list);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	if (last)
> +		dibs_lo_free_dmb(ldev, dmb_node);

[Severity: High]
This isn't a bug introduced by this patch, but does this code fail to clear
the client ID array when dropping the final reference?

When an owner unregisters a DMB that still has active attachers (refcount >=
 1),
dibs_lo_unregister_dmb() does not clear the array because last =3D=3D false.

When the final attacher detaches, dibs_lo_detach_dmb() drops the refcount t=
o 0,
frees the node and the sba_idx, but structurally fails to clear
dibs->dmb_clientid_arr[sba_idx].

Could this leave a stale client ID in dmb_clientid_arr indefinitely, causing
future unregistration to fail with -EBUSY and permanently leaking the client
resource?

> =20
> -	if (refcount_dec_and_test(&dmb_node->refcnt))
> -		__dibs_lo_unregister_dmb(ldev, dmb_node);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but is there a double free of
dibs->dmb_clientid_arr in the dibs_lo_dev_probe() error path?

If dibs_dev_add() fails internally, it frees the array without nullifying i=
t:

drivers/dibs/dibs_main.c:dibs_dev_add() {
    ...
free_client_arr:
	kfree(dibs->dmb_clientid_arr);
	return ret;
}

The caller receives the error and unconditionally frees the already-freed a=
rray
again:

drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
    ...
err_reg:
	kfree(dibs->dmb_clientid_arr);
    ...
}

Could this double-free cause slab allocator corruption?

[Severity: High]
This is a pre-existing issue, but is there a race condition in
dibs_lo_move_data() that routes spurious interrupts to wrong clients?

The target sba_idx is cached and the protection lock is dropped:

drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
    ...
	sba_idx =3D rmb_node->sba_idx;
	read_unlock_bh(&ldev->dmb_ht_lock);
    ...
}

Before it acquires the lock to trigger the IRQ, another CPU could drop the
final reference to the DMB, free the node, and clear its sba_idx.

If a completely different client then immediately registers a new DMB and
reallocates the same sba_idx, will the IRQ be routed to the wrong client wh=
en
the code continues?

drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
    ...
	spin_lock(&dibs->lock);
	client_id =3D dibs->dmb_clientid_arr[sba_idx];
	s_mask =3D ror16(0x1000, idx);
	if (likely(client_id !=3D NO_DIBS_CLIENT && dibs->subs[client_id]))
		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727093530.9688=
34-1-hidayath@linux.ibm.com?part=3D1
