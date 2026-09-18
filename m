Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E24AF155
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721479; cv=none; b=qeK3LIjw791jVMXauzv+KMHvjkseWPUEwvQqCwPbBIhpLmK+414XR/ztA/QfB5uec4P+oSB+eyacLx+3hdrxVcBpyJDLT8170/backc1OqqQktbXAr1u83zMvhymsFAhtS5drq3CErp+wwLKeusPxYGDKaGhmorgGMkeKjHtgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721479; c=relaxed/simple;
	bh=nc6kdByqOJ2bDTHmGat6qKFW+B/B+K182M8OxV2a8ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vCdn4dSazPHErxPupd/1ecofBvjnqCClJ7fXuhF5AHsgJAmGoW9fXJfimz7uCkGdPaewJDdkTcZ5YAgxDAcFpFxq5PDm4b6q76rgFtPFHA/BH94VVEqtUCbqZKKzJHac0zCkJT9jDt6WO1V1Z7/NW4g0iFd50meY/lUZ8ilaOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqIXqpoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqIXqpoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D779A1F000FF;
	Fri, 18 Sep 2026 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721478;
	bh=nc6kdByqOJ2bDTHmGat6qKFW+B/B+K182M8OxV2a8ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqIXqpoGH8H55h03rxIOFE5xCQyS/n5Q8cZ3fomRxxFTvI/Iap8geWE7dI7M+iKjm
	 412bH+4lsxmpEzwNWJIHCVbkKBjwVPOzJS+goCGImfvh0TmiwKuJkKy9NLKdB4jKoz
	 xySOIcbV8BbbpgEnyufgsKDGL56ecD5186w6CDsy5g1o+pVv/BCdu3u1isiYYhySwc
	 //dNk86DmuCke+BkZ2Hl9YwO1CfNvbAqwM/jcqqrJ0iGvT+c9vnKvGEvHPjKfriiT0
	 09SmbbsLxHNR43M3PuFTGLlA5oE8K5nWEvgsd5h/fJ7ZmQpI59w4/GEgBU190B1WCo
	 L2dPuRGc5p9ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] s390/percpu: Fix comment typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-2-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:51:17 +0000
Message-Id: <20260918085117.D779A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is all preempt_disable() / preempt_enable() pairs and not
> preempt_disable() / preempt_disable() pairs.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D1

