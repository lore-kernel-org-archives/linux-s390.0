Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483050;
	b=NDxvnoNXTf9na3aZ+WgeD2BNJJIAoJ6vKrDaX4icjMnhwOBzKaI44TE6On2EGjeSgijq
	 O+RUW7flTX8noEhGyeGP1O7As7VD3IXSmnQL4XDgg/1SH7ZZaiCOnEBLoxUGwTOPAWGRv
	 ltuAwL/WSqqIga5atHe5zl+KECevxuE6WlxjGKKUc6VqSWbDJB1PUfG0B1U3r7KMkJ3EQ
	 vZqz6iDf4HhcY6AKHiGEWHJEE3YukvxZp+gv12CIssRwb3OysqObpv92zOGuaAOBsOIkv
	 aGi0CxMXPAGuhfq9OJWsed8/cMu6X0zvMr71tIqVVp+GwfDfTma1WSKeJwvlLX7AEYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HcSyYyL1aI9yVXJRMG+8rB80N8c/m6fAmhL+0qfSOuA=;
	b=2kU0DAa85Yn/8USchM0aQdTKC8AcGnJmXKKDl7JtiDBdJTlyeitzb3aHnxa0B6QcmlCc
	 gKimuml/6STzei/HtomZGWt2sNYTYKHqXhN08+NoL/e2DJV1kunvpPW6YQFZUfGDKwvFg
	 yhtUq/YqG6cbAWQBwa49mBf+rWRszkx6ejFFYdOjhqjh+xx/xv2iv7YLpx1F8ikwZo1u2
	 2+azyKHTWMr/zHUMFcL8DH1xVBluztlTFMxhVRv4z/yoO0a3o63Uwzsyz/BEZ5xTC5Q1H
	 I3vaVkSqeW00PHP9ZMNrH8QA/zgZ+ZDXyRiGvmmGcQLyvLRjRiQvfDKIRz++V1h/Qeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QknDstmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6E606B58C
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QknDstmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2626C1F00A06;
	Thu, 12 Nov 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483049;
	bh=HcSyYyL1aI9yVXJRMG+8rB80N8c/m6fAmhL+0qfSOuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QknDstmTjHUe2g2R+kyYKGlBriyS2a4Uaeq26iu0MVr7nAqXkBqRJm95OllgWyogK
	 2pshuhOVzvX7a0eVzPcPG+abvrFTlZnOh3J8M1tUTUpLDBIa/8/Ydoeiw+PXTeeAHl
	 R/lkZV0xGNBwFy1qGt9egZrBHDMlPxGgncLhKcdRUWAMflnChj5Qow6i9c9D4CEiIo
	 2Xwo0g7g93CRBm7A0cT5OS1V1C67/MdvyEVBFLMosVN8HJTnYmDGlrOoXL+NtbVzO/
	 2XYQQyIvvzR678w2Fm1bNPVA5piWw4nFE+DulCO95qryAHbmWL5uz5jac1F321YcEy
	 kDCMN/TNt3yNw==
Message-ID: <sashiko-outbox-211019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] s390/kdump: Exclude crashkernel CMA memory from
 vmcore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-6-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-6-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The kdump kernel will be using the crashkernel CMA memory of the
> crashed kernel, so it must not be a part of the dump.
>=20
> Keep the CMA ranges handed over by the crashed kernel in oldmem_data.
> Add them to oldmem_type next to the crashkernel memory, so that no
> PT_LOAD headers are created for them.
>=20
> Merge adjacent regions, such as CMA areas placed back to back or next
> to the crashkernel memory. Otherwise for_each_physmem_range() returns an
> empty range between them, which ends up as an empty PT_LOAD header.
>=20
> Use the original ranges even if mem=3D limits usable memory in the kdump
> kernel. Build the list without depending on CONFIG_CMA in that kernel.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D5

