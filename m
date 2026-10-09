Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6ED4E0B7F
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552786; cv=none; b=PQDBCuawTZJ5iFez49FJ05hBrkATYbgrhe+whjVpQ1rpk1yb9xA8hYQLnTPWv0tQnCp1L8Nj5l0Ch9MuZKJ67b/LtgvqJdAu3ZKNx5E5dxvEIZZan60b42wiT8D8MbDa2UY8p36cXsNlYEIAQckmMwsRC+g1augztXk9WUoflDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552786; c=relaxed/simple;
	bh=gssnYBGi/Iwb0BOUaEgZLdw27TnXvcmUr4qMTlMeMeI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a9Y69Dk++/J27XKSeK4nWbUEBmWP3tmVtkMbpiZxQ6fyCkrbkMEriHS4vWKBPEORKDvcI8OcfoEEsZln1GafWOGTrDlnZd0rUTJyPldNJkJ4LLcgmSXyiO6imuau3eIZ7IXWk6WlFawvmTig7KWRR3i3psq2Leqi3ogfkMe86ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLU4eHLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLU4eHLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A571F00893;
	Fri,  9 Oct 2026 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552784;
	bh=gssnYBGi/Iwb0BOUaEgZLdw27TnXvcmUr4qMTlMeMeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLU4eHLzQ7XfBHDfQAUuPfl/qVjKKklZzIX0CenprjjrZVgnP7CdhXz+68HrSXJMB
	 dtmHueObX6s6z34vcxUawJWCg/N2X9FmKTqu7qdhbiw/22xxilSPkNfICE/m2Se3Bv
	 okvkSLCTfdWYPAGpSydF/6tpF74b1cDNaL3ogILnggeJBvwPWnZ5LMQ6uExTo8WG2s
	 llWrDLdfnOrVOnbvRsYrj2f8uE51srPbY6pvFeibeAo7ccRMZUfOZgXYv70TFVC7do
	 irrf7eXiel8Ij3tcaxrWtIHfHGjrfmtDtbBtdMhBLmD/sIT9a6RSUQniN8j93cb3Uu
	 yly0mHU/4cDlw==
Message-ID: <sashiko-outbox-165646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/uprobes: Fix off-by-one bug in emulated PER
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009132604.2434271-1-hca@linux.ibm.com>
References: <20261009132604.2434271-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:33:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The uprobes code emulates some instructions, and with that also
> PER storage-alteration handling, in case a debugger is attached.
>=20
> The PER storage-alteration handling contains an off-by-one bug, which
> may lead to PER traps which should not happen. Adjust the comparison
> in sim_stor_event() to fix that.
>=20
> Fixes: 8d1a2427d8fc ("s390/uprobes: fix user space PER events")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009132604.2434=
271-1-hca@linux.ibm.com?part=3D1

