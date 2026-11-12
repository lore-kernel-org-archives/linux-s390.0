Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457896;
	b=iHzNYK9SzANklHxyipiPm+rmw3giH2AgTycPtIeZlmtiR1v8noh9bipfsX5X+nFFSeLf
	 MxKE3FhnwuBC8tUARzkERDa8L9BlAsWxbcmMXc4/LDrWJtP1Z3T/Nbg87iSm38fqkVkIm
	 jrfnwaJlKCsWnBtk23TAHMghfWDl90N/mu6hcOtCOFnIW90UjuMCVqxhob//4jjJ09eZi
	 l2AZrP7Rfd+d8BgRZIibe1aaJGVaw3fFSAfu0fLzROmgFEX8t62KrTTiuZ/4Z3Alomz9F
	 nrb0AN+7Gzm++wrypTjW41jG7ySFZ+amJewLbMTihdQYmRk9gx4IhIXRnQgU50aslKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rJ0DRoHZMJOuvGlMk+Y2bTwcNQi1BaQuGIwpYJdAZoQ=;
	b=lAD5i78N5udy6HnGsEFko8cx5DRXeqHSQ5RWqlfBPVk0/0zzVGmKdAO6DBJblUWyrErH
	 6A9WFNZnbmRmM8jFvSXNZFoYT/omkynewJI3gPoDc+o3Nm0ACPrDtKxqocs0sHgrIsJed
	 Eu/7v1PfCQpTzI1+ptvoAJ6S2rD28LHCNKAY89cr9SW+fCiege0ZZidjXYfGeuHAVqqvI
	 40klvc2BB9QVcujUz/FTq0cv1iXhrtJM9tqtopwwTRVSb5ezlVZuYdyoA7K+Py0AZRV2U
	 iak6pvSOhJy8NWJW19ZV1Ql2ZaLnW58ohpVO0QBERs9rFdlghJKpRocSKveBl4kq9Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efFTYmQx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00635606A327;
	Thu, 12 Nov 2026 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efFTYmQx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B51F00A05;
	Thu, 12 Nov 2026 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457895;
	bh=rJ0DRoHZMJOuvGlMk+Y2bTwcNQi1BaQuGIwpYJdAZoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efFTYmQx8YpH7Syy648VioUHsmWw4Mp/LSoaAGuRcvD5d5Pz0UJBU6ODZoBED5/5h
	 Z39kofHCf2sl9BhXC4RtrBpnsXciOA/ByYuyjfZQKoMxoAwnBwIAuMnE+5fOvggT1U
	 xithnlhBzPBzUo+aYgjGyINtVi8y45fyNkIwEdZI4CyMMndQ/+hTHAl39pX6y9catw
	 q0seut8aYkZisZRtsmbWnwAUxZ6N1EOEannmMSHug/wljhGnBsY5cUvdSiVrOthF/C
	 0ElsUkalrkyjjhbk10a0sc4G0MAU56BpQ2gg8pCqHbXKKyelUS1oUa7DhApfy8i9o5
	 xfcflNnyXkLEw==
Message-ID: <sashiko-outbox-210356@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] rxrpc: Move key types to their own module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-11-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin the kernel module implementing their key type, hosting rxrpc
> and rxrpc_s keys inside the same module prevents unloading the transport
> module while keys remain in keyrings or cached connections.
>=20
> Split the key types and their preparse logic into a separate rxrpc_keys.ko
> module that rxrpc.ko depends on, and flush key GC on rxrpc exit.
>=20
> By doing this, rxrpc.ko can be removed while the persistent keys pin only
> rxrpc_keys.ko.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D10

