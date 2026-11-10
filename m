Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310219;
	b=s4DUd5ySifeiv/k8Mcz++7zYZ+KDan4gXkM5u6BLiwDF4KGtlLCEGz2R3MGAoM71Xm+E
	 eZC+kDb8NThNNuufuMN78suu6dA+rmKW56B8AKY6pMqZGk2EPQjlj7K5VEqqFBk73dl6O
	 TLTGltXD5yskCddfVX6t3Lk1n+coTqQZ4W3qUC+wRyHWt4yq7drXAO/1d5NP/9Tc0+cpn
	 8POZknRIHH1RbvXBaR9N98Xbyi9N17U2CaLTeqgaZROOOzpgIc+2gEt64DqQ+P3e+XjO5
	 PRjjtRT3pTsX9i0wTWxrhq+LC/v5DGHBU3dWRmRNJbeWccdrNxboIUpjvuHdnwRYWrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rxC0axNWa33J2AJPymAsm+bGGhTbcPCfPr12OK3XGOg=;
	b=5Rdc0tr/peJj+HhQlJFgkY+RyG+xYJDlL6WoA3gNPRvk22LULUFwPTbC18JB6Bhb6IP7
	 lwLC1YALV/qqv5UMf6t7FinH73697hYN9jg+4whl9zvwRzIcRYCgJQPKP68M3Eq40f0uL
	 rJxyhKuP0nIcJ7/gr38A0Pe+04473cYua4Mw9Zg4Tfr1llfF3GikJGy+73d5SNRNknSmY
	 Llo7ecYCjIuvu3PnEtd4hS8fuwWRPLco5/FxJUtkyaFBYdq3CJHPVlRSvVriYHUF55ek6
	 goEIQFI4XfChgEU3sohZtJgveBPDZkT0OEap/c0KJaWwfqOIzqatkpiSBIqG9+kxOmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHNfh+xG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508D606A339
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHNfh+xG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3216F1F008A4;
	Tue, 10 Nov 2026 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310218;
	bh=rxC0axNWa33J2AJPymAsm+bGGhTbcPCfPr12OK3XGOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHNfh+xGXxunTzpJypD6KTECXFM+Fhjf2t9KCfvhMu3fu6Yy+pwJx01zBMgYrKRvT
	 1eA3RvmcNliMsmp4AzHO8aOqWNEOiSuOwdxHeoLG2hzQaRQUHMAh0LyoH1CO3scnFl
	 +ip9XZURafyNNqGGIex6ISWwWHCsMMhhmT7M/0DseCE6woAECeXbDeAbdZEV/YNofw
	 uJeT8DEXCr8xt3pZzLc2FZMizis97b9jbOOtn9213/tEr7annelwU2zvXuZSxy5K0K
	 9lewDeuTXDPf3SM2SRmBjLfFOaOomtN38JN1VRnkdxVFBVqYDLih5WgUFwL3ev9s40
	 ndZEwSdFA3lPA==
Message-ID: <sashiko-outbox-206939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] KVM: s390: selftests: Add kvm_exit test for
 instruction intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-2-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-2-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:30:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a selftest for the exits KVM reports to userspace on s390x, mainly
> KVM_EXIT_S390_SIEIC. This patch adds the harness and the instruction
> intercept tests:
>=20
> - DIAG 0x500: inject an external call, check it is pending, resume, and
>   compare the registers with those synced in kvm_run.
> - DIAG 0x501: check the opcode and diagnose code in ipa and ipb.
> - DIAG 0x501 with registers set beforehand: check they are intact.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D1

