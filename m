Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C93D5C0C;
	Fri, 28 Aug 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918924; cv=none; b=I4dENxeEGIbFpl9N7DA0dX/6KhnfnQmmv0u7MjL+i5g+RpWtcSK25kwV5ifhdJYOs4iX+o9GiCUribmPsj2o/7vL3qkh4dzEfKMDEsYMC0n2zDJX6clY43hPBTQUTWFWyOnc4gFNRJaE9UFzs5ag2WbIHD8mfcVEaIcYodOpS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918924; c=relaxed/simple;
	bh=YvjScUDLuGELTLeXe7hM/Ch8d0osbR9VZOK+tgCFquo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ltq7ABCYqEjby0VfZmeDAfnvK6KBCnvju+DMUHDr8X8n8sm62dsWTqBgIyugGNA77q9ohlHgrg693H6dvZFmYsUrdtx9PB98/uZgxImFJBDNT9aB3PkDZl8zQv8nOduqzI42jg6zc/Dt6QQB3AgA2kh+ZzPAqzimX6d0hSJ1NNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie6FPtPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie6FPtPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9CD1F000E9;
	Fri, 28 Aug 2026 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918919;
	bh=YvjScUDLuGELTLeXe7hM/Ch8d0osbR9VZOK+tgCFquo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ie6FPtPupOdKxYslItOYnYR366NDW2EwnneUYEM5yiTgfOwqvVQVfnRcj54Ctw9gU
	 tFonZFTgyYWxd1qGwHjK0BDme0v2WnmYxMcukfZ2lnyZ62oasjSHucZVGLNWZ/SSEB
	 c62Y7fDy7gSB/nLjwDg9id5ibKzVxF5/dbM1A+CKBtNk4bN/pI7zCWVKrt7B+A6BTr
	 Cb9Kw/k3cpL4AWVACTJoWpvXxil6lQT33NVHN9//MzDiNszbH3SKZS+YakOPqvrTFV
	 EVnwORBiuDY4Ck42BNF8ctZb2n4SztxNHTOtlroa7qzWmXGgBSWY/w4j16RpIiddIY
	 P1CME9D4fQ5UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260828115439.145885-2-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:08:38 +0000
Message-Id: <20260828120838.AF9CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
>=20
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
>=20
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D1

