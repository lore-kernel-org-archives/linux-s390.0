Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998D373C12;
	Fri,  4 Sep 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551904; cv=none; b=eG28HIF+7ImJj1RuMZEEaxgT8WVwUKTgGY9pgedbPXkWLIgdXvwIpZivsrBBghBwqAN8lojKixdHQDffwrSJkdRIecqYfV+zujmfkfiA0zzsq8kqvDj4yaSaOAJhsjwuQiwIh1w/fvp7IzSLiXEjhTCBw/qADzlkzPKfWuslAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551904; c=relaxed/simple;
	bh=XZcu0+1uHt3QaVATjA/t5+CbBemxQdzqDwiQ6gxgeYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4V9oE4xo45BRgiAs+bQtiBEW//ddGP0nB3PFnrWUbtphvXziYiEsXk8FMB/JlNbjI1g0qXCeuNRmOHDP0T9GQWQTmzbsGnq3bJSMLIGYT167pFnDIeYWgORHG0O60asvgRdwP2mDP1FqIMlzXP/3dtQOr18qCwymc6IqLDZFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIfh4bkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIfh4bkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5E1F00A3D;
	Fri,  4 Sep 2026 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551900;
	bh=XZcu0+1uHt3QaVATjA/t5+CbBemxQdzqDwiQ6gxgeYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lIfh4bkzVma6eJfboapXPDDLe1sO67YDYPauyTXQ8jvIgoEggfotO2mipsyDufcRM
	 nvm70TXTpC/eKuGPM07arwtG7d31603/HHRQ/qsGEM8ZENrSoDCwkwR8/M8Kj2NmBw
	 dC6uHQLuJ9iGy+svaZUC4r+gbDo2S1yAM5Rmqik0wsN0ihrLX/aY2l0MveqKA4Q5yZ
	 Kptb9PaKtoNY++cL4SA8bB4r1+wHVRYrCm15EjJs6s0nPqW/DGxA6QsMBAHcKFnUE0
	 7Za+0wXIRX1z7TaHHQjfDZEqEAI9DLp7clhxHwhN07y9U9eHyEKudCD5IHK3vzpERO
	 1pwJRU7su3yyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Fix timed may_goto stack pointer
 for private stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904195132.141068-2-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-2-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:58:19 +0000
Message-Id: <20260904195819.DBC5E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> timed may_goto passes a stack offset to the architecture trampoline,
> which reconstructs the counter pointer from its BPF frame pointer. This
> breaks when the JIT uses a private stack with a different frame pointer.
>=20
> Resolve the counter pointer in the fixup using BPF_REG_FP and pass the
> pointer through BPF_REG_AX. Account for the extra instruction in the
> internal branch offsets.
>=20
> Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D1

