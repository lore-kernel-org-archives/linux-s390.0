Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24025EF87;
	Tue,  8 Sep 2026 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846619; cv=none; b=JY1iwsc20ZAe6VNRtNU7m2TULi5rMxF0kkn688Ew+Tx0ygQTrKw2QH92Tmmat7vaQ7eHMLovvsJIe4/zcg8Kfa/dWY1df79+70LAkvigXewrtLviR49fCmBMaMNECoPGgJLeHdeEN8v0V9gb4ObXR5GsIkyblfWphLmA8YZbQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846619; c=relaxed/simple;
	bh=GjiX5ZpZ7NZD4YDBwlWMBeINCHTLmJt67Qr7uMuDcM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAjETTvaVLPGUL7QG9ZC84nNVfrkvNcookAT1YvDXfleYwHa8zSLcK3MefPLMEhwIenxcroyknPG76cqx4XvxqCCalL2j+WLcQZfdGA8H4Tsdl2BsuCOYiiOX46XkcXdiyiME6HV42sprb0gLNWX1h0QHCnEvXkfvdFOo16RJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpzaG6mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpzaG6mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F841F00A3A;
	Tue,  8 Sep 2026 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846618;
	bh=+HdsQhUguVzCfg5c05nZeUPLgws28G3DkRXCxIkyvlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpzaG6mzuq9yrRVXSWOCHZOGnJhZyl+UPxg/iipVuYyC5NUot7DMSVXCsUAk7+9dU
	 bq1lPjxMDtlIFynqQFHHhigpsARmT7iUG+a5r8Z1nDKnMAEjuUTxE8sTW3CsO86Ow4
	 C0MOInK/DNTNTQYmyEd2Egz7ZT676P7kKSnVsp2RLej2bQYdn9y9VLl0xSUv7JLnn0
	 h8W+vunAA5tzUzaA5IYtUQpQ5hXzp/tSl+xQzpA/stpOjRxMlm82Nr50jZlo0jOK3n
	 JAI+QBID3bn/fylXxMFWEpJl03626j/4NcmQH+CJW06Giyng4wyk6zrlXQoSQDj9lD
	 zgVFJIkeCvmZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] um: virtio_uml: implement synchronize_cbs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908053817.26065-5-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-5-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:50:16 +0000
Message-Id: <20260908055017.70F841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature clearing of dynamically allocated IRQ bit in um_free_irq=
() causes unintended IRQ sharing and race conditions.
- [High] Resource leak and potential Use-After-Free on vhost_user_init() er=
ror path.
--

commit 88d671cc22ee3a67541ca7191122aa3e1f6d8c9f
Author: Karl Mehltretter <kmehltretter@gmail.com>

um: virtio_uml: implement synchronize_cbs()

This commit implements synchronize_cbs() for virtio_uml by using
synchronize_irq() instead of waiting for an RCU grace period. This
synchronizes with the IRQ handlers used by virtqueue callbacks.

> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 7425a8548141a..1f2e62e29a277 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c

[ ... ]

> @@ -869,6 +870,14 @@ static void vu_reset(struct virtio_device *vdev)
>  	vu_dev->status =3D 0;
>  }
> =20
> +static void vu_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_uml_device *vu_dev =3D to_virtio_uml_device(vdev);
> +
> +	if (vu_dev->irq !=3D UM_IRQ_ALLOC)
> +		synchronize_irq(vu_dev->irq);
> +}
> +
>  static void vu_del_vq(struct virtqueue *vq)
>  {
>  	struct virtio_uml_vq_info *info =3D vq->priv;

[Severity: High]
This isn't a bug introduced by this patch, but it is a pre-existing issue in
the codebase.=20

When a virtqueue is deleted during teardown, vu_del_vq() calls
um_free_irq(vu_dev->irq, vq) to remove the callback for that specific queue=
.=20

However, looking at um_free_irq() in arch/um/kernel/irq.c, it lacks referen=
ce
counting and unconditionally clears the dynamically allocated IRQ bit:

arch/um/kernel/irq.c:um_free_irq() {
	free_irq(irq, dev);
	clear_bit(irq, irqs_allocated);
}

Since virtio_uml shares a single dynamically allocated IRQ (vu_dev->irq)
across multiple virtqueues and the slave request channel using IRQF_SHARED,
could this premature clearing of the IRQ bit mark it as free for global
reallocation while still in use?=20

It seems concurrent requests for a new dynamic IRQ from other devices could=
 be
assigned this prematurely freed IRQ, resulting in unintended forced sharing=
 or
-EBUSY probe failures.

[ ... ]

[Severity: High]
This is also a pre-existing issue, but there appears to be a resource leak
and potential use-after-free in the probe error path of virtio_uml.

In virtio_uml_probe(), vhost_user_init() is called. If the slave request
channel is negotiated, vhost_user_init_slave_req() creates a pipe, assigns
req_fds[0] to vu_dev->req_fd, and requests an IRQ handler via
um_request_irq_tt():

arch/um/drivers/virtio_uml.c:vhost_user_init() {
	if (vu_dev->protocol_features &
			BIT_ULL(VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
		rc =3D vhost_user_init_slave_req(vu_dev);
		if (rc)
			return rc;
	}

	if (vu_dev->protocol_features &
			BIT_ULL(VHOST_USER_PROTOCOL_F_MQ)) {
		rc =3D vhost_user_get_queue_num(vu_dev, &vu_dev->max_vqs);
		if (rc)
			return rc;
}

If a subsequent step like vhost_user_get_queue_num() fails, it returns the
error code directly. Back in virtio_uml_probe(), the error path is taken:

arch/um/drivers/virtio_uml.c:virtio_uml_probe() {
error_init:
	os_close_file(vu_dev->sock);
error_free:
	kfree(vu_dev);
	return rc;
}

Does this error path free vu_dev without unregistering the active IRQ
handler or closing the vu_dev->req_fd file descriptor?=20

If an untrusted userspace backend forces the probe to fail, could the leaked
IRQ handler subsequently fire and access the freed vu_dev memory, causing a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D4
