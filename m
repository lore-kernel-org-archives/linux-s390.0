Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF554B486F
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596403; cv=none; b=hCukn0TVZjFKNW099kAxogOGhAS6a9YzKvA2ehYlfDKKjsYorpbAIKmk3KPFH7N5jNIZFQknp/kHw5dxDsA2t7ziSVwQBXRosEKBEIvolJOo8g6JF6uIun6DSlL60Bry+gXl7AOXUvQCEgzc/GcV0RqI3yOSpYWUgOE0gEfIjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596403; c=relaxed/simple;
	bh=6le2qXwVJmZxFOEVvq71j+C3kMrvOnmtqemgrLQwVYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MG5yLiZt3sQbflFgWs8rrt/oDZ1AyAiSsc6N4tsJdRoLVV5a1MunD7OxWsIKW1BHwJO1/I5ewr/bjRlM+I/HlF0sWL1whq4VTZW4Xz9E4adyi9qRoIZ2UsGyl46ooktx8D2h9nQd5SScmhouVrc2xIHEcbfoojprV/xsMKYzpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0TynG5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0TynG5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12041F00893;
	Mon, 28 Sep 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596402;
	bh=6le2qXwVJmZxFOEVvq71j+C3kMrvOnmtqemgrLQwVYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0TynG5Zb+qBmxHk4Ve8GE1P2XCyN0Fm6pC6DglM70SivzXMt1GyHXVPz1G36hHAs
	 6EGO+TkxjURV56LVdaYgc+RBV+QOt0QYIL7hDFQwuq8ZaaCeHwQyXjvF4vk4Y0w2rf
	 mhmV+4lMJAqLcMeLd3RrVYykFJe7a4BEfjZhBUgtBOXwFafhwucdKR6y7rT1khEb2Q
	 ghWOrxqe1xhc57fXwDjL5snmF65B2QRH3D0yZtx9uFkkjyrb76/cix3oblPKfAitHg
	 BL6WlVwLd98TFWGQTvoBRrSxRUp5XEgZyVIWMZsFG43H8cECuuyHYoGJTB5Mpa2T73
	 qqiuVBt7dxlCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/ism: Zerorize dmb at allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260928114741.4135978-1-wintera@linux.ibm.com>
References: <20260928114741.4135978-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:53:21 +0000
Message-Id: <20260928115321.F12041F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
> uninitialized kernel memory to be exposed in the receive message buffer'.
> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
> general the smc kernel module (dibs client) will only push newly received
> data to userspace. We still should not have uninitialized data in a recei=
ve
> buffer.
>=20
> Since
> commit 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
> dma_alloc_coherent no longer required the __GFP_ZERO flag, but when
> commit 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
> switched to folio_alloc(), it should have added back the __GFP_ZERO flag.
>=20
> Add __GFP_ZERO flag and state in dibs.h that register_dbm() provides
> a zerorized buffer (dibs_lo already does).
>=20
> Link: https://lore.kernel.org/linux-s390/20260903143746.A5CC41F00A3A@smtp=
.kernel.org/ [1]
> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928114741.4135=
978-1-wintera@linux.ibm.com?part=3D1

