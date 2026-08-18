Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED71262FC1
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026671; cv=none; b=KRIzvcS1RWQNuZsT7lfZ1YS2MLzBafSjdYgokJpyCLPpxoUsUZvc3jPO39lOdw8zzP/23PneH8Pdpi9sst3wnStnLHer8ZUrBekL28QIy8pTKwkFbQBIEc3FDBSYJs2ZhmvJBD1eJp8coYCDMgyURuptqgWfQCgeuwKonywXSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026671; c=relaxed/simple;
	bh=+y3AHEYX/aW+1XPiFmBiKxaBYtmrUA9ZCarwGys1gIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFyr5aMuMQOzXg1FPsZe5UQntWlBm/foySxqnyhG4MyfkJ8H+UF9DSa6S4DCF6J8n+Y+U4pajIaCX7hiPFac9Df5djUS6ccnPNuV6QmhxZE8I4k/6tDTzGFxQnmzCxbcXuqymCebKabEfIuX7jz5r9VjKlm9ScdChzW/Y+MVK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6GDQvcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6GDQvcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB171F000E9;
	Tue, 18 Aug 2026 04:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026669;
	bh=+y3AHEYX/aW+1XPiFmBiKxaBYtmrUA9ZCarwGys1gIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6GDQvcG4CCuLobLE4S97Bnrj0Xn4VBuoyePGF1o9ulGXMEHwGZMUtwHt/dQsTUWI
	 mJgwxDtOUI6osnQYUiDA9QHTwfR5EH4TJAQiGTrbpKCqpD0AkYOBkcDtYdWDWf9Apj
	 /raHXr0HPQayXnM2my6lDsAxvF4e7gbwGx1lW4Nw5McaK/GS0XSs2wrZNuNsNDWkHj
	 NKoGn/oXps49O7rW6+HeMIGW9Qe5gX6oNUYvlXZK+IqMUDFjTkMTezWo03s9D9o2aF
	 eaZ2+cmH5jl/8J0aHwQSB87Ba3uloo2MW4iIWfYNouFYnNxGvqbzBwSyIt3xM3Uokf
	 F+F/ekPKkZyCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 7/8] sh/mm: Stop using pgd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818040041.1891769-8-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-8-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:17:48 +0000
Message-Id: <20260818041748.CEB171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Stop using pgd_ERROR() in __get_pte_phys() when page table entry is alrea=
dy
> known to be empty.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D7

