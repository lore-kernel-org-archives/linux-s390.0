Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092923;
	b=1B9cXT49Xzjy1a8eFydjTNuZ/lkyw6JBG4PIj7PLnDo0+fX0U3FRVSzppAKQcYVQ2949
	 7Y3+kpJfuWVrWtNkoqVZGe0dF3ZZ3SEFKbhtUcPpKRZih3sdKJnM01VSIuBNK1ttqPPTd
	 x2W8aIR83Mu3XMDb6uwUHGvwBwq+nhrSZ1gzQzvG0hygOgH24+A7LFGfwhwBSPtVYwIu6
	 jtnCfkQeqmjtczu2/T8jKHawi5/BHZfRXWE/NFhnmf5KVsk4vUIOBLk+mzauAxrkjjSsQ
	 hEcYiShADCfq0MFYDJcirNim4mZVOucLhERO8AK/5gI8A529xSSXXrbxlr+MAgesoGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nYKkU96QcEegYDBZoex7LnmQcPsYVfYg4uNNfbI5yq8=;
	b=IIrJokWjsiZg48Mf4sKOW2EtiFIyiLKAUPJChigNgD/TYIdgP7oeo9zkHX5q1oq7paWB
	 GrBmKUluIEmmUgoeglPp/ocMzhVEKKQ0LYsRX8bJV46z3nzDCfP5cCClPgQReXN2WwL6Q
	 p5+olMgt+4EYbLCR7FHP6tjEcalVfWdHeVY6m3EhLULEcjsOGVPvrAB4lc7cPvMfmNLKe
	 Oo18X/ku8mIwthw0fjf0L6bfxIfR+0qWT9lsmQrQiV0RBl3dxzA4CbHp90w8ICphN0fZO
	 qgBM/hNBuLscw4qYVeK+EPsSCL0gRvwpeeEtDj0fA+bXERUz2IPp2LcjAbftKHv0yvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ2RBZne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342D606A332
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ2RBZne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D891F000C6;
	Thu, 19 Nov 2026 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795092923;
	bh=nYKkU96QcEegYDBZoex7LnmQcPsYVfYg4uNNfbI5yq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZ2RBZneRsNGW58BIZSGUGZO05C85D4R/Xc7rV5oQ1LjG2GQaHkbQTQ4egBNSK3xd
	 JIZTcm4Xtqi9B0o+asmNgG8KebOTETlL9WaJ+FN2jp9GxASK2KbwOGw57OU2nJEFwJ
	 xDSggAKh+n3f0JOX/tNKhwHqR87fKeb25jo63wUWmt6aInXJhGGhbExd4dnaCEY05k
	 gtWFC0lZAlQbzEf7NdjtD/nL/lL1ZkfNYP4kttkHDt1pM0SaYZrNwl8E+xDDZ+tHf1
	 iLddtOp58t/PyG4aan76FEYVU2+wxDboW734QDcp/AnfRz9BYsF3DDWsYTukl7qCwb
	 cqT+U0Ycql8Hg==
Message-ID: <sashiko-outbox-223126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] KVM: s390: vsie: Do not overwrite guest 3 state
 on early validity icpt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119124936.33396-2-ggala@linux.ibm.com>
References: <20261119124936.33396-1-ggala@linux.ibm.com>
 <20261119124936.33396-2-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:55:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> shadow_scb() calls prepare_cpuflags() first, which can reject the SCB
> provided by guest 2 with a validity interception. This happens before
> the guest state (gpsw, gg14, gg15, gcr, cputm, ckc, todpr, pp) and the
> control fields (gbea, fpf) are copied from the original SCB into the
> shadow SCB.
>=20
> The error path still calls unshadow_scb(), which copies that state from
> the shadow SCB back into the original one. The shadow SCB does not hold
> guest 3 state at this point:
>=20
>  - For a new or recycled vsie page, get_vsie_page() has cleared the
>    shadow SCB, so the guest 3 state in the guest 2 SCB is overwritten
>    with zeroes.
>  - For a cached vsie page that is looked up again by SCB address, the
>    shadow SCB still holds the state from the end of the previous run,
> [ ... ]
> so that no stale interception data is passed on to guest 2.
>=20
> Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtual=
ization")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119124936.3339=
6-1-ggala@linux.ibm.com?part=3D1

