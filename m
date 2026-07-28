Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCF33262A;
	Tue, 28 Jul 2026 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258987; cv=none; b=Gb8QqNiEafNOypmT3+6tJoY9vKk6kwbvOXOdjA89wKo22UEfsdSi7o+VgUiKuyQJ27maQnECDVzdMRKr8t5L6qYNzR66Yj9NCXbsBZmcy4ARy633KKXBOgKqOXjq8k+H9Q0JwItaUj4ZpQPt6M7I9YeUirEt3KO7/IQLH51NnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258987; c=relaxed/simple;
	bh=Y5bx7KBdH/vLBYa6XwAg9/kFLOY/a4Fi8PIyhY5Hj0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVkM/Ifwj+ymfwSsx00iH4WAHJ7K3EPZOj6BvlrLtfmIidhybBdXxEJiwTkcBrdQ1slCeM955iSc5MPvEqd9hSRgbjRE7Rl/tWsVrn1QqmP4S3la8HKNrlr0xbqyEKuoaEroLAAkRWkz9Shkp1PcaTNQidKVTyk3QXI424GiZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4D+t4yT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4D+t4yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF41F000E9;
	Tue, 28 Jul 2026 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258986;
	bh=Y5bx7KBdH/vLBYa6XwAg9/kFLOY/a4Fi8PIyhY5Hj0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4D+t4yTSphdPRkHMhmcKJGj8ZNNsO7xrdefGFexwsEx5ck9NQI31Oruf1Uy/yuje
	 fd5ORUgfyWHwCdqb70oOXLAvmx7rbmajeLjE3gy952YBqVvsvtuK/2gk6FxnK2DUVf
	 h+hzKtm5Yzx7EsfUbzY45JeTPHURBkjpmQ5r2mEz5kOn1Ys1whh5GdiTLrITJipuMP
	 2mVj+9Wj6w+D0l8sgB8PFDu8CoxbJ4z3eBOg70Ku8tNbgJbUZy7GoLXijJsOwNG0qa
	 WTDBRfqRWT008ALBAdxyAIlo1pJd+gWKspFFjFygJIIxKo/LrxRbJQPn5I24oh7ESG
	 f5NCltiXz1Fnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728170708.294400-3-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:16:25 +0000
Message-Id: <20260728171625.A2FF41F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D2

