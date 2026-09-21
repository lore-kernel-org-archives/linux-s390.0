Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6A4908D8
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993281; cv=none; b=TwyiQjvMZ4hx0Tz6jj+5w53562ylXhue9oqauF9WN0CX5Q04HgqIcvoEfVq4eBAWxzfRJoEpqhi6yVBVYaeGQPqOvm5qY4fpqaS359eouggikOzNvrXtXUN2A7xcdXn0QMfBUOuW2ZBvJVWQlba5rdeeTj3HtQdIZzPXpGaXawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993281; c=relaxed/simple;
	bh=PkYoYuF+WTDmOqY2uFfO5UL91sn56uPlftE5WJ6ytfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gFifzaI0Zgm1DSMxwPS3GSX8NFf9R7Q3se+eMA2WuwLgAaYTPZdiG0ssK2sUIx3xgBR8aBg6f3G5bSvEua8NaTOycK1r5Nq3VkBt6ppAXFCHu6oZ7Mnx0lvchIbS4CqrAra9pMC3t4gGonlgce4i4JhHeGQ0P3SDohOtoDuZN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVFfcXnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVFfcXnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74EB1F000FF;
	Mon, 21 Sep 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993280;
	bh=PkYoYuF+WTDmOqY2uFfO5UL91sn56uPlftE5WJ6ytfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVFfcXnLe1wi9vFMPSn/5vXZAxdkJAQ/lvg6BQIwmBXRwWCSI9B2SQuZPJBWc0Ltl
	 acFiXETkaJu7VhXBb22IwNHU+Rn20f9iFPB0FNRgmSDorRN9EvuKPZnJ5mM0giRIeK
	 SQqK2HPkPh9n5CFQpmOx1YMs4rix8iwKbWRvV16xhdqWDZ2M9xKlYj/r3cVcuVZPOr
	 g476N3kbkg3GJYXO8M85/rc77LK+VvT8c2uMzTDxMe1XP99zuOnR1p59f9gORgWhFZ
	 LYAOyCHTRmvWcPhKkjE+zN8z0l1guQM+xvcTrs2OCt9HbND8LQZtewZlghZVAP0EqR
	 5YGzLYFvxjDJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/sclp: Introduce dedicated sclp-vt220 event
 buffer type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921121619.1354611-2-maxbr@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
 <20260921121619.1354611-2-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:21:19 +0000
Message-Id: <20260921122119.E74EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce sclp-vt220 event buffer type to replace the
> byte-manipulation behavior in the receiver function with well defined
> primitives.
>=20
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921121619.1354=
611-1-maxbr@linux.ibm.com?part=3D1

