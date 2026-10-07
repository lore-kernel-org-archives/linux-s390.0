Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CE483BEA
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374163; cv=none; b=Bs2atCSt93fJKL+MgCSv24t8LYDTcITN7CtCULjsFYO8ny1H4qYPnRpgjoTFs9bBF8i6V94i1mpRH7K/G6NacrVoPDlHaEj7QmYkhcGQgAwEgcShe4aaAaPrkBQVEPM2AIMbudRe4Yba+zQZqxeyeTWMjJjvihD+dfUAi/kOs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374163; c=relaxed/simple;
	bh=k9/TGNEMSC5KHHKNxw0jEX5cVMFaJykAsonllaOSVww=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=agmslAHS5f8LzrZhgqbNRORjTXfBtdllGIqKKxgUqt3hvquryd7GtSWwruRXo59ad5uhsU8ta6uqbnha7comS4GEHpL4FSZKbx16Yaze2cQbmc2fQ+zyoSsagT0p3fnWI4lYBFHo4K6X5zuAq5iFvxvP+tWCw+g6kLlctlpTeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCB2liW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCB2liW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0A51F0089C;
	Wed,  7 Oct 2026 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374151;
	bh=k9/TGNEMSC5KHHKNxw0jEX5cVMFaJykAsonllaOSVww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCB2liW1LckWKcBWsy+JBO7knFJyVT7IQX5+6QSrAvAIjdzON/MoZtcfinYw9H+iE
	 S1qU9iqXjedD5oYBgI2ZJ97XXtxrka1dJpJp4wYoqemRD/AL13XhYGX8MPnZ4V4ns+
	 y19SsfR0HvlsuGs3+gpQFtqowPUXlgfePdYuXkYpwF7BPd6vvy9J0vX6OHBw6NnUOq
	 9VxcnvTOUNnf9CYhKvBKmsIiS3Ex5ifIWFK6Lc2vbDS7NZ5yb8bzaWRAALnTzChfON
	 fz7oAvrdeHIuQ4EtEW5XIPXx74BTPgZyQT2IUU/AAp5f/s0E/sYnX+S5fcj0LaY1VI
	 RQJXRto9GgRKg==
Message-ID: <sashiko-outbox-162953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/15] mm: convert PTE table entries in ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <edaee657070484a21e96f315c374ccc4d8922936.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <edaee657070484a21e96f315c374ccc4d8922936.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:55:50 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
> return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
> definitions. Read the hw_pte_t table element atomically before converting
> it to pte_t.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D4

