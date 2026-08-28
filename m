Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C07343CE79;
	Fri, 28 Aug 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918939; cv=none; b=CV06vdD1kWGw4RAl/Srs7oWupIQ0I2B4qZyGixPQ3VTobr2+ZHcvlq6+oNoCnpI0R38PD9b7612wbU0+3JQfDtgPc7qp+KHtGLTCyEWOdLcfp2EKu2coiPka4Rx6IrWI8+nwJxjc3r2h+oXidTksci2hAh2R6VXOc1OP6d3inxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918939; c=relaxed/simple;
	bh=jZHtkj2Jv5fik+PSKW6iTS8E+B6JStEsGCxBB1da8xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndvZbaO2/0nHKRKeGwLLRqx5KOW4ugm5BF4crRjJA9V4KLruBccjM3eyORB9d3wkhHXs5BJaBYAFOt/+6LlxN9cRgRZJDEhE/ZFyx+bNkmUs334N0k6ViwuIuezN6JjtDitQJF09NybfbgxvpaUI0l6b+axxp6sWgo8TQoX7mUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuHVnC4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuHVnC4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2501F00A3D;
	Fri, 28 Aug 2026 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918924;
	bh=jZHtkj2Jv5fik+PSKW6iTS8E+B6JStEsGCxBB1da8xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuHVnC4BeY7iX8DyVXy41c2Pca4qZ7evjys42Ih3Ij3VjG91Q0ILucN6xxJEgZuk8
	 nCcDWRn6XcxMvsETH4xs0bA7Not+Ka8OJdSXSTuq3LzEOhTjqFbIqaK0Kp+vM7B/34
	 Z2Rn7lU8q07mRTz3Q3HtUmSPg2AkpIwmNBpkazP8Oy/yD7JYkQ0mYKc0jvTmVhq4nC
	 kHpGAykaKopOhKbxCrZLNVIV4gYPyBh/Z1DxQnUj5wkrd7tQ1s2ht7+bZlBz4ous3R
	 hop7bthYEwNYgvhvWo82kujuTE8wVlAb4Yb44kC1MiFZ8FkuLxboK7whMCEI3NIYqh
	 RoN2WLEkWqYvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] KVM: s390: Fix potential races in dat skey
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828115439.145885-8-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:08:44 +0000
Message-Id: <20260828120844.5D2501F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When dat_cond_set_storage_key() finds a large page, it will
> conditionally set the storage key in absolute memory using
> large_crste_to_phys() to get the absolute address.
>=20
> There is a race window between dat_entry_walk() and
> large_crste_to_phys(): the large page could have been split
> concurrently, and large_crste_to_phys() might be called with a crste
> that does not designate a large page, leading to crashes.
>=20
> Similar issues were also present in dat_set_storage_key().
>=20
> dat_get_storage_key() and dat_reset_reference_bit() did instead check
> for a potential concurrent splitting of the large page, but then
> handled it incorrectly.
>=20
> Fix by performing a READ_ONCE on the crste pointer, checking and using
> the result, instead of dereferencing the pointer again. In case a race
> is detacted, try dat_entry_walk() again.
>=20
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: sto=
rage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D7

