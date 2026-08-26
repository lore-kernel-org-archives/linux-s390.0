Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110033F58FF;
	Wed, 26 Aug 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757018; cv=none; b=huPAt5S1OYqUyLPAmssDJY0JsrDIgVjNSGWOS6lgFOJtewNep8weOMH87RKYArw4htGX1eSLtlgEJ6zBauvNiX/gv0+1fZnCRsq8DzTdE8LuPeiRyASzh96kDzg5V6Yq8f+LrrxVhdPPeDegLaJp/weJdmxVb0KYIbr1MKCvaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757018; c=relaxed/simple;
	bh=UjfWfC/7eLoEldHdr6vx7pFusxJw9Fw/rnmqrOvFQ68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Suj0aN9GBSekSKPQhX3SUHMkkRxHxbGas9euXbwxhGTD/dV1fTW+f+F/Pm+Qyo5U47ucqigsqunSA/QAKQi59m7u+ygwNPN4Ua8F4V8VFZ/vYLJkPpbauMG2n3Ow5sBusGNmmxgQdKMX9CIt+SrOQdaLretwYmCN45H+Q0uTIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu/X+3ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu/X+3ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD01F000E9;
	Wed, 26 Aug 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757016;
	bh=UjfWfC/7eLoEldHdr6vx7pFusxJw9Fw/rnmqrOvFQ68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hu/X+3ac2h9uNfgfNxhWiE3LeJ5mYDfoN1Yj+zT69M3b58IgU4iGFu5zY6Trh6Wao
	 RjJoKAwNg+vKYJrYuKm4V6FBIhAdT4KLc+vfQVBRKGjJobAD1PrbbpqPYnpIqZsxm8
	 7CTo45sxZkUYHZ0GRYOuKZ9PABPfV1BR/qxnaOua3xCufFsqj9KTsbmB+yReqniJCe
	 M2Brv2yPaO26DwkZMcqdnggfLbJXO8vuWjiLWqBu0Q5v9Se+LcxeqjNsO7eriIzEx4
	 LFIX6PtTIk9JDJCCQ9T0ExCCXVWP0/xloPLNr1QFkvi7mknL1HyWwdHHxoUmK+dzgP
	 I/Wzi1hdfjTDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/21] KVM: s390: vsie: Move pin/unpin_scb methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-6-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-6-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:10:16 +0000
Message-Id: <20260826151016.72FD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_scb() up in preparation for the next patches.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D6

