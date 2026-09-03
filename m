Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317C4B66D0
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446272; cv=none; b=OteGu4UAypKOdnYS8LZiNACOYJlXEHI8GoTtLdy/a4V4tu+MvxaoFysEJ9g3Lf12jOhB5k/o7lmIMye8fuezxlbPmXoWF8mzsc+fLhTQHHcqi6MkBxDU7CFfNVYgdpuEHOR+GTe+ujvGfQzwn0saS4n2L48GBGSrB111lB3/QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446272; c=relaxed/simple;
	bh=Qicd1q1DSx3kxHyrgPqSCFDWg9ndOi4/4GYh6Xt8660=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W1EYDJksG1j1oDsKzHJ9um6FEp45NtPwuC4mCN3D9NC35yB6m7iWbybUjSgr/vtCudIwQmD2EFsDDQedS/29L4WW8kbMl8JOLQ24MF0AqQn7IRCCKuNjRwOKqv+If3Yi2ynCc82sZuMIBPVoq8sEQfTXYKBejcOTwYbwH/3GKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5t0Lnmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5t0Lnmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CC41F00A3A;
	Thu,  3 Sep 2026 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788446267;
	bh=km3le8X+VFG7W54KL0EebePQFuqXrWjeBVka4mM1z3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5t0LnmzPCRS7B7p6tT3QsZCmlhRkkYprJ7a8nPDITyLa2zIHp4MHvT7juhfQ+vXS
	 EIyIEuCIlu9YapoWko0xfKktzsifAU6jOJ3XZH0Qrz1MTBH+c2U1YLf4IrH8z9532u
	 gVn3reYNcog7e2NuYkb8tGXry3V4GS7v6fsuAaA1WysiHo6BhpQTFUAYc0lxIumACN
	 qbFQOJpa+Sqavm1GSseWNhZCJHcutPdgWb0E5gOSLt17jXiJ9BMd6JgA5MktERvB2n
	 bLVsfEr1tImH7RA1eT2QUhIWWKjh9Xg2EmQo7BPcRIDsgS6Lh9rpoJ6UqpUzuOirIA
	 Y7vV0tIZVX8lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/ism: folio_put() after error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260902143733.433574-1-wintera@linux.ibm.com>
References: <20260902143733.433574-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 14:37:46 +0000
Message-Id: <20260903143746.A5CC41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing __GFP_ZERO in folio_alloc() causes uninitialized kerne=
l memory to be exposed in the receive message buffer.
--

commit d942ada155dde57df3b8bd6857db438603cbd218
Author: Alexandra Winter <wintera@linux.ibm.com>

s390/ism: folio_put() after error

This commit uses folio_put() instead of kfree() in the error path of
ism_alloc_dmb() to prevent slab allocator corruption. It also sets
dmb->cpu_addr to NULL after freeing to prevent a potential use-after-free.

Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer allocat=
ion")

> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 242da20f27e0e..035b233abb4e9 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
[ ... ]
> @@ -274,7 +275,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
>  	return 0;
> =20
>  out_free:
> -	kfree(dmb->cpu_addr);
> +	folio_put(folio);

[Severity: Critical]
This isn't a bug introduced by this patch, but the previous replacement
of dma_alloc_coherent() with folio_alloc() removed the implicit
zero-initialization of the Direct Message Buffer (DMB).

Looking at the allocation earlier in ism_alloc_dmb():

drivers/s390/net/ism_drv.c:ism_alloc_dmb() {
        ...
        folio =3D folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
                            __GFP_NORETRY, get_order(dmb->dmb_len));
        ...
}

Does this missing __GFP_ZERO leak uninitialized host kernel memory to an
untrusted remote peer?

A remote, unprivileged peer partition can trigger an SMC connection
establishment via smcd_new_buf_create() -> smc_ism_register_dmb(). This
causes the local host to allocate and map the DMB memory without
zero-filling it locally before the peer partition gains access to it,
potentially exposing uninitialized memory across the virtual machine or
LPAR boundary.

> +	dmb->cpu_addr =3D NULL;
>  out_bit:
>  	clear_bit(dmb->idx, ism->sba_bitmap);
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902143733.4335=
74-1-wintera@linux.ibm.com?part=3D1
