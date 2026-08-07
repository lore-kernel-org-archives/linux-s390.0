Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16C468C1A
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104041; cv=none; b=qbaJc5OCKcTDajHgHUviYknRng7g6AquxORDt2pcHBaATYr9X6LwjcFy+3y1SdkiIkEj39qiifzgfyetN4NY67vENuIx/LPSm0WmQKyzuWTOydbGpgJtNTI9E43Q64etCw0yG213vj2haZ+q5uqS7tc74b35EAET+gL5H4j5iD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104041; c=relaxed/simple;
	bh=SrnfegWShWGs2ZPjJHYwxqC368y2DhQVX46nbSkojvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzLdDA5ZsTkUkWP0MWqKotUQcKdebC8Fz58+5Am1yNeZ0SbVQOCqN3nM0bcNcRRUNHg85/wf7bknOysRA01Z3Idh50Gstc+lhjpC/nPmay7JXXCAB+TrXkh7LvTiKRrkIT1G6UzGMfYsKSxXvI4MX0OknhZpaxsJsslG0MRG7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWDyvngE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWDyvngE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0631F000E9;
	Fri,  7 Aug 2026 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786104028;
	bh=FGSaoAscmDMGqFF2OixX/qvWyIgD0IWJSPADbwCO4dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWDyvngELdAd/tsueKmU85YpBDSqSJzJEB2wIx6JvH88QZJ+uZL+pR+mHCAcfuw1t
	 lb41KlCvReDUr5qCtWds4KN0HYlm2l2P+4SaZQDbyB7Cujznd4WVmAQuGFxP1YYdGm
	 JkKew/YEt4pwiv5eG03WwFYxOBy2TGjlN0QmU+YEDJoz0aMEqytryG7gRuAPPeOwQZ
	 UItNh6JioGm0RZnjCGeE8OjzkQcPTL6Sfh4HXI/aHyhohM/5sWvgtr3OL8b7uQ5dPP
	 ecfhO1U7wc9u0vQGgKnzTMBBLFjNkqqPtYr3vsIwRkjEJTgN7HhXh0taHgvi0BOMMh
	 etnSlBHPhKlQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] dibs: fix double free of dmb_clientid_arr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260806120002.596137-1-hidayath@linux.ibm.com>
References: <20260730075624.114778-1-hidayath@linux.ibm.com>
 <20260806120002.596137-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:00:27 +0000
Message-Id: <20260807120028.5D0631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Hardware interrupt is registered before required data structur=
es and locks are initialized.
- [Critical] Asymmetric teardown order creates a Use-After-Free window in `=
ism_remove()` and probe error paths.
- [High] Missing `class_unregister(&dibs_class)` on the error path in `dibs=
_init()`.
- [High] Incomplete rollback in `dibs_unregister_client()` leaves client in=
 a partially unregistered state.
--

--- Patch [1]: [PATCH net v2] dibs: fix double free of dmb_clientid_arr ---
commit 1001308ced15383d91624271c00a3bbcf60208a4
Author: Hidayath Khan <hidayath@linux.ibm.com>

dibs: fix double free of dmb_clientid_arr

This commit fixes a double free of dibs->dmb_clientid_arr by dropping
the kfree() in the err_reg path of dibs_lo_dev_probe(). The pointer is
already freed by dibs_dev_add() on failure paths.

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index fd5caf1e19a8f..649e4e375be33 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c
> @@ -335,7 +335,6 @@ static int dibs_lo_dev_probe(void)
>  	return 0;
> =20
>  err_reg:
> -	kfree(dibs->dmb_clientid_arr);
>  	/* pairs with dibs_dev_alloc() */
>  	put_device(&dibs->dev);
>  	kfree(ldev);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a missing
class_unregister() on the error path in dibs_init().=20

If dibs_loopback_init() fails, it returns an error without cleaning up the
registered class:

drivers/dibs/dibs_main.c:dibs_init() {
    ...
	rc =3D dibs_loopback_init();
	if (rc)
		pr_err("%s fails with %d\n", __func__, rc);

	return rc;
}

Can this lead to a use-after-free? Any subsequent interaction with
/sys/class/dibs or reloading the module might dereference the freed class
struct.

[Severity: High]
This is a pre-existing issue, but incomplete rollback in
dibs_unregister_client() seems to leave the client in a partially
unregistered state:

drivers/dibs/dibs_main.c:dibs_unregister_client() {
    ...
				rc =3D -EBUSY;
				goto err_reg_dmb;
			}
		}
    ...
}

If it encounters a device with active DMBs, it returns -EBUSY immediately
without restoring the state of previously unregistered devices. Does this
permanently corrupt the client state where it misses events for those
earlier devices while believing it is still fully registered?

[Severity: Critical]
This isn't a bug introduced by this patch, but the hardware interrupt
appears to be registered before the required data structures and locks are
initialized:

drivers/s390/net/ism_drv.c:ism_probe() {
    ...
	ret =3D ism_dev_init(ism);
	if (ret)
		goto err_dibs;
    ...
}

ism_dev_init() registers the hardware IRQ before dibs_dev_add() initializes
dibs->lock and dibs->dmb_clientid_arr. If a spurious or pending interrupt
fires during this small window:

drivers/s390/net/ism_drv.c:ism_handle_irq() {
    ...
	spin_lock(&dibs->lock);
...
		client_id =3D dibs->dmb_clientid_arr[bit];
    ...
}

Will this cause a panic due to attempting to acquire an uninitialized
spinlock and dereferencing the NULL dmb_clientid_arr pointer?

[Severity: Critical]
This is a pre-existing issue, but there seems to be an asymmetric teardown
order creating a use-after-free window in ism_remove():

drivers/s390/net/ism_drv.c:ism_remove() {
    ...
	dibs_dev_del(dibs);
	ism_dev_exit(ism);
    ...
}

dibs_dev_del() frees dibs->dmb_clientid_arr:

drivers/dibs/dibs_main.c:dibs_dev_del() {
    ...
	kfree(dibs->dmb_clientid_arr);
    ...
}

However, the interrupt is only disabled later in ism_dev_exit().=20

If an interrupt fires in this window, ism_handle_irq() will read from the
freed array. Could garbage data interpreted as client_id cause an
out-of-bounds access when indexing dibs->subs[client_id]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806120002.5961=
37-1-hidayath@linux.ibm.com?part=3D1
