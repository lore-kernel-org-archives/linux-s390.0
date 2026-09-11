Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACC26CE2C
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096076; cv=none; b=rynI+PkIHKPTkarawdCOW/sRNC1AxNZiZxD29y2zmIfkbHcPXgyW7ERS/xn+49KSwEbB1v66nRv3RgAfiptWfxD29dKDO+en2lwWFs5ePJfnEc72CGq/Sge3pY1MV+m4Gf7bELGdW1sHpFOlqoB9p9nnKbWXV25EW1gDJeSHjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096076; c=relaxed/simple;
	bh=yGYH+Z8u0XWJ1D/eTP4DVLVRSGP7SCdsW9EDIXqMKhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFFxp9CKS/2ByoqjwlkdTk8DUGMoP0dtboFc22cS1WuSl8jd+xtQYrJvER/AJLcBPHJKlrD59diHdopoJAwQkNw2NUT0sMPIJrtM/Mx3qy8LacGrT0BtR0Lk0HA1n2TN2TsrL33JM8/hZi+GJXO/ENqfCztFknbBI9JleLUt3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mukU/IeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mukU/IeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0EB1F000FF;
	Fri, 11 Sep 2026 03:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789096075;
	bh=yGYH+Z8u0XWJ1D/eTP4DVLVRSGP7SCdsW9EDIXqMKhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mukU/IePcG4DwSehb8Y9Zht5FhGBVy9WhTg7VbMgkaaetWGtFD6b78/IwySiZ/Hvi
	 CiDLy0RgnztfUkYv1P2u103RbDZkkuLiCWmlKO8buciEBbjIIw4Vvm875B+oYC/kX3
	 ur0Yin0bBNuh6Maw5jw00yBPd4sPhkUq2NMxvamml7HMs9eXo98279s7I1ORpnh5lk
	 lGZ2u5jNKzwvuOOZ+uoK9EMujfxec60ufahyx/OGZodPzZ80PSaFguBz6JFeyztKzW
	 pIXa/AC7gY42uJqvbY5tDPw0+lNPrBjREopmB+fM9KZ60m1Y9OGPkw3fTzK51qqQiU
	 NLLMXvlx2hTZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongru Zhang" <zhanghongru06@gmail.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 03:07:54 +0000
Message-Id: <20260911030755.0C0EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Hongru Zhang <zhanghongru@xiaomi.com>
>=20
> The per-VMA lock fault path releases the per-VMA lock when the folio
> cannot be locked. It then waits for the folio to become lockable
> without holding the VMA lock and retries the page fault. However,
> the retry always takes the mmap_lock instead of the per-VMA lock.
> This can cause serious lock contention when a writer is holding the
> mmap_lock at the same time.
>=20
> Add a single retry under the per-VMA lock in the architecture fault
> handler. This does not touch any page fault code in mm. The retry is
> very likely to succeed because the first page fault has already waited
> for the folio to become lockable. For example, this usually means that
> any required I/O has completed. This allows faults that can make
> progress on an immediate retry to stay on the per-VMA lock path,
> [ ... ]
>=20
> [1] https://gist.github.com/zhr250/c36c2c54d9351df37e12fd072d4926ef
> [2] https://gist.github.com/zhr250/218ffe693f842346b56434483127422c
>=20
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911025613.1220=
845-1-zhanghongru@xiaomi.com?part=3D1

