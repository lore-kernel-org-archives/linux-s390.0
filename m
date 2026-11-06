Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980630;
	b=daZzSxW8sRUvDQRutkfYwI+6rYIFz8+eM9VrMgAa+9dJZTOmi9Rg1UIQnwUsRhMUbidV
	 EInMUZuzVnykr54+Tei5TyvUQ/RmiR3cOfOsr9xTLaHDdxZ4NqbHA+zWtdpOln7I98pmk
	 APffKdLQjmA4F+mpWDMujP0UOSt4Vxu5UGZW3aI6nDsFQ3x0RacPJxnTg7jnAmJYTHbv/
	 XSJ0nHs3L3Q0IV0Y3GBLDCowGhPVd6Wv8dhknp31Oq0l1cj5tOka7JWgdmi/ROF+lrjpF
	 t8h//u2gyzWNOeNkBQqmsqxAPOkMSz/ERHJDhZQZEoMIQxXUMD3AqBdzDElFi9UJWeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x6A2Cc+4WNlGeQ2nD+LihqrbdV97WFTVzdFUbAobuu8=;
	b=Wc2AnS72uf5lbCz76NGHONZpvmsFSkO9D88fS5wLl2z5Jrd9QQapIhNZX/Y+6CjvPYm1
	 AUtv/Xz+wRcw06Z1gYv74a3wsFQxhUVkVXiixft1GgNwNceu1LDLQ7pcR8oz9gBsnAVqX
	 vwiEvChxUPFImglDeu29abxBycRH2iRim5C77KFkrdIlvp+FxgJ/bx/lT0edgLf5R3UN9
	 yThKv3Er69RHyuJvxySCByFk11XZo7cFdw96gE5DIe7zFbWVhitfpYtHUPmpTfCKshvpG
	 ghISF/uP6kg6lvF8I/kE31zxQqB0NFcsuaU8/p/FXyJRxuEW6OQgcNq9gNrvLTSeviQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4YNRVQa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B955606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4YNRVQa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94F51F0089F;
	Fri,  6 Nov 2026 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980630;
	bh=x6A2Cc+4WNlGeQ2nD+LihqrbdV97WFTVzdFUbAobuu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4YNRVQaN34XoOeIw4o+AFqVTrK38opx7NGIaB5PEaF2+FT/KiZxCACvrOZiIlxFs
	 Ozi4DJJuviIyZxJfjXkROpCdMZ6X9qdvhKITOnVYUNTyUuCHCymGenBI2Edu2oj935
	 klKUtSA64ChSXGboMpSL9x/6gOFgo5wCNrSgdgR1e4HdPZqFpHoRwwyLfybZp3M4Oq
	 9+9xpsRIe8u62i4iaY94JkZPq0EOt+6yD7TqIQR3XAEbdRrhURyLPF4miCuzlMkdFp
	 0J8eh7LVji3wyt9s4axYisRslEPfrfW7rYwf5gg6QuTLLqhwX4u0B1SsV9dy4QPVNh
	 eR61azlag48mg==
Message-ID: <sashiko-outbox-201748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 14/14] s390/vfio-ap: Add live guest migration
 chapter to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-15-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:57:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D14

