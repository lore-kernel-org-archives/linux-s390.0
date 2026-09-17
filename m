Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7113DAADC
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673109; cv=none; b=HxBnOM34fjjDP3MCEtALsPQN8dqysVTWlelpPblts1WB0XgBxJCcW9a9kHaa7SdYO3FpvyOS17aoOL2W+4Pwb/mWNCc7UOX5QNZM31iTHhPsFCGcld/YXVWGUsqFrWW9QzNndniX7h7RdjOAnA4JGzLiVn8ydUJbkbsTD0lYmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673109; c=relaxed/simple;
	bh=9vnT8EoSaAcY4g5uC96WAie+97xbPGsXLjPp7P9ADfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ft4F1NlHjfd/Ey9nPmZ0BpGNR6ZsoX76uRRMaR7NfuKFJdixMAWwjtDW2qgZmPj1SEtMUqCPOnq+a8fSUjuVB817LBwuEAFazwJZEvnHJh3wFM/JMjIOjSJ/PL5a8R9svR2ty2PG0cPNmUg5iEwUItzZrd6AsoqblHGti8DdgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3azYXJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3azYXJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9501F000FF;
	Thu, 17 Sep 2026 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673108;
	bh=9vnT8EoSaAcY4g5uC96WAie+97xbPGsXLjPp7P9ADfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3azYXJ9UBCtgSw4pfhVknZhfmC3OYKWN7WucKMHgPjBFCgjy2+7oG5RITw+dnbE/
	 xLMp7FDkc7vvDFw7ifDQAwJweKxSO28qe32eo0sTBEJG7Q+EQWjaOEhBfgNSDKeDAI
	 4mC/Njxq1ugwzIUybgEzBuCpwNcKC9SuuJ/bb79ww40qPZyw9/SRRxqKG6UqwJlDKQ
	 vV7RqNJMjoEabdNXGVeFFvgqdx51WEsZ56/Dh4vmSfoOm1myLWL+Ab96BADd+gVWtt
	 UdLdP6abG7d2FSspN5a+ffUrohetpMvTOEx3PEvTJOmSSEjaXtVojXdemMIfmcOnby
	 btNz6iAIOll9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] s390/percpu: Rename inline assembly symbolic
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917192237.638324-7-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:25:07 +0000
Message-Id: <20260917192507.9A9501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename perpcu inline assembly symbolic names so they match (more) what is
> specified with input operands. A trivial change which is supposed to make
> the code a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D6

