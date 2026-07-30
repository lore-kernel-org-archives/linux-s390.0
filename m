Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EC32E73E;
	Thu, 30 Jul 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429639; cv=none; b=R7Ll+jBxvl6AnVFWYeSI8T7+nMxQk6KJdXjn2O0rp/ShXsMI3AuJlYQ2k4WhBvuiZIU7NVu67eqeUtxWvwkUrUR/LrnElW+88YGWpUr3lw4OpCU/Nicr2jy5ooF3JWPRMvmj1+cjMixkTrH5TNr2ZXCIQzVkHdL+Y1FENbgMw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429639; c=relaxed/simple;
	bh=Wwe1ymxRpllN3ZysBll1yLhgjmNOFeEo5c1xqXGtkYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u7iCFTcI4MaUKddcEwF701H+1JbaMJnSdUm2dnTCTpxdGXyGLCvVh7BHp+GJP8FdxvBb0QZMnpgaUj386Es2RcpxNm3TQ7zrDzy8GjLVJBeXOYKtv10WJJP0r/6x+Swi/Y6B7kHtNTpIXJRXd015UvUhpZdglDZdBtI1DxCCw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoUi+chH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoUi+chH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9971F000E9;
	Thu, 30 Jul 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785429638;
	bh=Wwe1ymxRpllN3ZysBll1yLhgjmNOFeEo5c1xqXGtkYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VoUi+chHZeFh2MxwLXiojHqr8WEuY4rsWN2ECugRPwS1lMCByel+Fb/e0971G/a6M
	 JEPiVCmHxvXD8Fv4vPTHGuvaFlIhIr+HXFBgeki3F2GPnusGv9dsj6iHDuqpPrkzXv
	 ZplC0NKqsOrw51QCIx5Jdunu8dHJCaHSORir0KOLG1gZQ8tPoLTuvKXoYkEqD/ajQp
	 +MLLdcbAP974vfO7oouz6BW6ICbaRL/sxbdqJuzroHA4ZpN1aIoxSiPFKfI0NQQ+Fi
	 2a65Ldmw6DUXSCxiL1eYxsCiPgAV5QpRejxYrdYBjW8EhdIQHTP7bwW0PrxCFQuuS0
	 iwX9Yc9axTsKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/14] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730162714.133327-6-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:40:37 +0000
Message-Id: <20260730164038.3A9971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
> memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
> value.
>=20
> Same issue with kvm_s390_{g,s}et_skeys(), kvm_s390_keyop(), and
> dat_reset_reference_bit().
>=20
> Fix by returning -EFAULT whenever the return value would be > 0, which
> is consistent with the behaviour before the gmap rewrite.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D5

