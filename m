Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF3282F13;
	Mon, 27 Jul 2026 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146543; cv=none; b=gj39gp+JvqWR5+JScOROeBnzjjOOogOWOmHCm48G5k5V/Vc6U3sQKTRvJliKBzR7rX3qTgW5kgUg14N0jOcF/Xx8j8U/1rc+HIBadczCLuWZThyJzK8qkYtk1AeTP7xp8jU+ET9X6eBEV/bh0V+G+q5HfHMwa02Lp62WMWgtbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146543; c=relaxed/simple;
	bh=TdExs+AbftxUBxoIvihW7b4rMJpbmNhS6c2eNSwqvBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFs7Sjw9AMuB7GsmZkeKlGOiausiip7R0AMNYFi1spX4gkrVb/Y0WuV5wfs6R1h7FG0LZx/h1Cypdz2Mxjnxpoz5HfPwTFvUXFT82ZHBHPeIwT+MyhNQ1n7u5ONScNvL9/o5PcNL4u9PxsNvCfIBqEj7ulRFNwoJsVck4k7mt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnFdDgZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnFdDgZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7437F1F000E9;
	Mon, 27 Jul 2026 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146541;
	bh=TdExs+AbftxUBxoIvihW7b4rMJpbmNhS6c2eNSwqvBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnFdDgZ4UNJv+ERevZCABqcaEPSn10cRbJ7AIJUN2G3Kzyb/c46Efk6VsNciMzqvc
	 LWbyXV8imdk/0Zf62+PSm7+h5nXpMXfFK7vucku7FwS7nZQwq4oAPZc7L/mznCCOpd
	 T09rA2plGYJ4Af+6LprXJJwn2vPruxsv2kxKdYJzUwzzVZwxb0yXlzlfpzyIzm8W0L
	 q0CpbqYPuAcDycv7QbKUYeh5IXEAB5dtIGi5LxA4/i5CctEnFMDAavu0pUZapRgC9K
	 4CAeLkxe2MWI7KUrrdHIYSqRTvY0kNyctrDUyGdT8TJKP3oH6YqGibVkkv1QffXNZm
	 lRrQNXvtDFWQA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 3/5] KVM: s390: Fix dat_crste_walk_range() early
 return
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727095359.107671-4-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
 <20260727095359.107671-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:02:20 +0000
Message-Id: <20260727100221.7437F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> If a walk entry handler for a lower level returns a value,
> dat_crste_walk_range() will not return immediately, but instead loop
> again and move to the next entry.
>=20
> This means that some entries are potentially skipped, and early return
> is ignored. Skipped entries might lead to all kinds of issues, given
> that the caller expects them to not be skipped. Early return is often
> used to interrupt a walk when a rescheduling is needed; if it is
> ignored it can lead to stalls.
>=20
> Fix by breaking from the loop immediately if the walk to a lower level
> returned non-zero.
>=20
> Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: wal=
ks")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095359.1076=
71-4-borntraeger@de.ibm.com?part=3D1

