Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE503FADFA
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677392; cv=none; b=cLSqT04csV1Ve6tpP3A5huPZITkCiAN3HF0Gfc3oXaalJECyco4MEOVAy7QcfKcB+w6DIbdBFZMvx/qhjGewle65fVpEdnUk8M7v0DNjaXMA7f+75QcFPx/yIFJWnDNyD4T+bvrk1AKXc3w/i1K8mRjzO4P/RuMaerB6Q7X2Uv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677392; c=relaxed/simple;
	bh=7uZfMvSXyfBv598qBSJJmsEpRyvNrlFRgzliWKwxOZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BYfQ82QLuZVIbqh5BOCkidJ0NAuEZAtccTHb1yoSOShsfICDNnhrY/VafNAbDtEX7iMTDRGEA6b43S7ynHARZ19zZsorpSKxMs/ipvbk+3h6jqFXrkZ37S+xe/k4kQqIBcYEr9zwvUxwTJ5N6eHWiQE4eT0WoCv2MzpT8DNxlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8cX2e8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8cX2e8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F851F00A3D;
	Fri, 10 Jul 2026 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677391;
	bh=PYRhlcgikvLTGi/xuNYZxxk4KNE06L3V2lrY15PPRL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8cX2e8tu8hYJEGMqA2OwcSnCz3nxW7X/MN4/Wc4u/KgMh9eIMjZ+ryCfz7y0gZBD
	 8rElQM6/KK1dsmr9jYxQWNMnzif4aJ9G03q9lR+HqCwr7G6EsKDeKILidZh+XXUy6t
	 cHVVOozIZnAMX8hXP7GuvliZymXH2G3+/3CA5BM3lE0WEnDr0+ghKn3a0JLULsl9Y3
	 zCCcmVAqqeCbQZLawNFSpSUv331m4uAzL53QRmItnLq4cpHHOpNsSU93RicQ3dyFf1
	 m46c2S3M4kU2aHAAWoXGkLpjUNJ7MlN5uphRWfCv2ZQHn2jiRi17fWGRcsuYs222oz
	 K2KvEbjgsFMvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 12/13] RDMA/rxe: Implement
 disassociate_ucontext callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, tj@kernel.org, linux-s390@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20260709095532.855647-13-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-13-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:30 +0000
Message-Id: <20260710095630.C5F851F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Implementing an empty `disassociate_ucontext` callback bypasse=
s the core's VMA zapping because RXE uses legacy, untracked VMAs. This lead=
s to a Use-After-Free of `ib_ucontext` and `rxe_dev` when the VMA is eventu=
ally closed, and potential kernel panics upon module unload.
--

--- Patch [12]: [PATCH rdma-next 12/13] RDMA/rxe: Implement disassociate_uc=
ontext callback ---
commit 8946fc9f2a378bad6f910a408699c6a70e97a6f6
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/rxe: Implement disassociate_ucontext callback

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index 1ec130fee8ea7..6eb10d2f0653b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext =
*ibuc)
>  		rxe_err_uc(uc, "cleanup failed, err =3D %d\n", err);
>  }
> =20
> +static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
> +{
> +}
> +

[Severity: Critical]
By adding this callback, does this opt the driver into asynchronous teardown
which can lead to a use-after-free and kernel panic?

Because RXE uses legacy, untracked VMAs (bypassing the core's
rdma_user_mmap_entry mechanism), these VMAs are invisible to the core and a=
re
not zapped during teardown.

If a user process maps an RXE resource and the device is then removed or
migrated to another network namespace, the asynchronous teardown will free
the ib_ucontext and allow module unload while the process still holds the V=
MA.

When the process later unmaps the memory or exits, the untracked VMA's close
callback (rxe_vma_close) will trigger rxe_mmap_release(), accessing the
already-freed ib_ucontext and rxe_dev:

drivers/infiniband/sw/rxe/rxe_mmap.c:rxe_mmap_release() {
	struct rxe_mmap_info *ip =3D container_of(ref,
					struct rxe_mmap_info, ref);
	struct rxe_dev *rxe =3D to_rdev(ip->context->device);

	spin_lock_bh(&rxe->pending_lock);
    ...
}

If the module was unloaded in the interim, jumping to the VMA's close callb=
ack
could also trigger an immediate kernel panic.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D12
