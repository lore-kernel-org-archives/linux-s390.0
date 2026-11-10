Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310604;
	b=A5nJ90AXDgCVfZtW9PsRdO2vwg3kFUz51QDC572CAatoog+anzc9FT6cuG98qtPG9lIN
	 Nb2CZ+0DmWmJycNI3p51q3H99puIuz/Rc7U21CBolu5w1lmIO7clDWHi+vFoycyXBT+AR
	 8nYoRf27HTMkO69h0LSbGPLfAh+bK3lXghZvvKkHic4CEAgbxcYKpkQZAZmHrU8wGM+zW
	 H5IV7heBnirJOrVObm1IfJhQfDnrtfjFxBeoTrjTQhMfi27P79K+kwYo7FUb53oBywU3O
	 FxmNZaENHrLsiA7gtrnTbd/8prOGbRCtA6SMfg3S8/a2sOO8pfBIDu12feQYKsSo7TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7nASW1RBFKvB0aM/H+PcFhbaBCYzaMThLkozMavcZVE=;
	b=pR8I7f2Mqk05uczwn70q1i2j1RMRp2P5vJI9BzZRNuvQLdPBcBvV/7nqEYPqqaq90iYW
	 xA60JLkH+XjdmhWcT9bPpBeeN6XNJ9ZI0IK5dsPZpT7PeLgctDbP7yJSQO8Now5QwXxbq
	 t+i7C2NmKz0cDqyYDBDPN119wP19efrWWFIoPCPy7f6EZLysHo6s3AYlrvx5wjm10DITA
	 gzHBKEzDJHGmWalGVBkTA50oUkdIL2yzIM1yBCWgRKaafZ2FkoC2VtS8Npx+ePqUmOkVZ
	 TLr1nkImcBJuTcYXdTJzvF/x9ucpE9YKb5rsfwbvZRqSPqZfwQuJE1iK/mrv0ZKoFAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VG+A+tn/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B4606A338
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG+A+tn/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBDC1F008A3;
	Tue, 10 Nov 2026 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310603;
	bh=7nASW1RBFKvB0aM/H+PcFhbaBCYzaMThLkozMavcZVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VG+A+tn/AIuSqEG0805ik1OmbqRCtIsFPOzi7dvXlHYGYHY2ZxiIPMN5HBrqg/N8s
	 SAmcV1Eunt/kVFnYd7S8hTD1N7BCjGiclAwLe6lxm+5gLZY/mpGIpRt7MXq/vRoUmh
	 wd/097jRULv26x6jmOywWRln8DEbHAeP3XHC/cD3ldn0BqrhPIGuYv5LQsvyaXlPK7
	 gvn2xmtcOAcdQa8z0oEUtQKmt/ga1NiH+zFWlE7XhEm0aBrPbo6aaIN1j4BtWQnndV
	 B97sn6h8JgDz52FMfvOSwHTTn8KQy3h4mr/u4IfgTZGYJwR/D1r8OJm2QkG5o2aLwk
	 tUhWIozaS0zhA==
Message-ID: <sashiko-outbox-206943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] s390/sclp_ocf: Fix computation of length of GDS
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110113047.238367-5-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
 <20261110113047.238367-5-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:36:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Fix length calculation for HMC-network and CPC names in OCF event data
> by excluding the GDS subvector header size. This prevents a potential
> invalid read access beyond the available GDS name data.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110113047.2383=
67-1-egorenar@linux.ibm.com?part=3D4

