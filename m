Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579955;
	b=ZYK7vYyNcX8CCtM7s/c6vBi/LbdnC3j+L2fqlQFK9wMqLFtcLbJIfFQAkszVTbJA0Mi2
	 8OAf6lwJi9pT9y03IfKhVsiboBEmpxbvicE4nY8e4nBg73JoVkdWc8q3k7NQqjw1lOfBc
	 6Z7WJdJBM18LdaROMn49cMPkBnLRhNbMtCaCxqujhyDqcC4uH4wdWka+s2NDrGthusATe
	 fVhmseYUNDm+fEk0EixFmCTEFTOJdBJn9+qbkff22HwuDcJTm+/HGhm3toT1RKkLSdzRD
	 DSKzpkRGaBnIwMaUvVpI5oel/wjSOAeNPDLZ5zkg3dkPzxI7nrZDqELr3zUDUT6x1dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JKx96xT0irEgZmynXxaruuwq99BKK/Y5MEwjwUN2jM4=;
	b=g6W4Tn2z9Who0ZkTTwNW7yJhclxSY7OojV1rHUdmw/0xGz6kYbO59pPLwBe72aG3E51p
	 nhORo899QFxn58K25tOjUL3Wp0zr3KQLibRiChzYVzndOdeDrZXSn1hvQL496tto86Xpq
	 iNbBML0KRLPIKnE2kUN/XL1cq2vySKO3eFa4TfPH36c+DiKOIgsnXfGv9QuCevVDq5d8C
	 npV4Qi0tgrboB4I/wO+pCwUar9TRNZbvpQem/LLPRMSKResc4Eo8vmmCT8lsnBYURi5RM
	 X6eNoPZlabbKLHM6I+kQUEq+rs2GyYv4sjW0dXS6affNHGgnd4bHWjUzOvo0zY1feuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2j7Yy2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFF606A323
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2j7Yy2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3501F000C4;
	Fri, 13 Nov 2026 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579955;
	bh=JKx96xT0irEgZmynXxaruuwq99BKK/Y5MEwjwUN2jM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2j7Yy2iKLnP4Q0LhLtm5RIdpLoEtUQJqEFF0r99jDJYIjaGubzDRw8a85h5v7P3B
	 wyjU7RsX0oiCWSqNE+fo5JNl3JpUjuGPbvilHm7ExUqBD/Nb49tbwLV8NqTz0CckFQ
	 LZ54RELaNMiIjxGscCNkyT5nPU6qugoPyl2OLQNh2scybr3lkxf6lK5rEfLLNiY9pd
	 t4rBErC9WzkIF8uDXwvyLXjb0LiyvEDSPERZbmhNc5FVdLTqURH0XVCR0KkuMLpOkG
	 o6GonksQ1clDEDionU8mbBOUAx6EHeZ4G1Rpw9z/4ukBetC81LL/aB192z4Icrk6p+
	 SUOOohaFNfdOg==
Message-ID: <sashiko-outbox-212978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE
 in change_huge_pud()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-5-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-5-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> change_protection() applies vma->vm_page_prot, which lacks the write bit
> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
> entries writable again if a write fault would only set the write bit.
>=20
> However, change_huge_pud() ignores the flag. For example, device DAX
> mappings are write-notified once soft-dirty tracking is armed through
> /proc/pid/clear_refs, and a protection change then leaves dirty PUDs
> read-only, so the next write to each of them faults.
>=20
> Fix this by adding can_change_pud_writable(), based on
> can_change_pmd_writable(). It omits the NUMA and uffd-wp checks, as
> change_huge_pud() bails out on those changes.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D3

