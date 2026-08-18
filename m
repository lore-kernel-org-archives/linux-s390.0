Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3736A03A
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026447; cv=none; b=DqrEw9CkKo3O4Ek9Fdy0hSd/VAaAYs1OnggCRpBA3hDqFy3Ttl2pPbGTkLn1qOrQyJUNknQsdDiHM6U7dh5dP2YpKQr4BlNzdCnkMMGit8HMwk2JYyF79X0EEtErcNURfHv33T8S15JUaLiJDbxzAsPkyBEdM8Gh2GnjcOY+pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026447; c=relaxed/simple;
	bh=5ViuJEiXwNofHM+r68NbyX6YM1T0jZtbbpl25+l9X1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ap72RyVf7zmg+JOjnVyeLPx6CMHG3AR6kexuV1qW0bajcZvjbXi8KmYI6ICMkbGrs5A6rU+nBZkF8xzfvUp6RY0be+VBsk8FhD8mBdfvAiz8cLjh8+AxMSDkKr5Ry5BLXB6AIzFjr/M268/Cwnb8gr/UupFgt82k7Y+dLN4+MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+7pRCsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+7pRCsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084001F00A3A;
	Tue, 18 Aug 2026 04:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026446;
	bh=5ViuJEiXwNofHM+r68NbyX6YM1T0jZtbbpl25+l9X1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+7pRCsz27H9UUsiSQpePv69QnHo1AcXbI2Q1T/pfUzpzJEtJ0CseXPvjUO2bD8mO
	 A1hwmYzlluLFCUE6vin0ckR1bKSlK/HSm5IsalSsWPCEyQNSPvcXizlzTkkoTrJ7A8
	 9MwUT7jyfNcVIqt9aAAogqizC/RgIBeh+59QTuYgLuNugEubPPLLpm0ASxp8QP7Jca
	 sScZm/d8bO8UeeBieo5Ax3IQ/yVo0wGqAJ4bWUqTJmSon4+tJkECbev4e/NiLBqffk
	 T6huBpOLSr6rsVEPPv9tDHsFVHPPSmj3Vzq0MNZDzfCBgPi9GTJiGjnnel8x6DpWVk
	 qqlS56C+mOqdg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 2/8] mm: Stop using pxd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818040041.1891769-3-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:14:05 +0000
Message-Id: <20260818041406.084001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>=20
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printi=
ng
> page table entries thus completely dropping dependency on platform provid=
ed
> pxd_ERROR() macros which can then be dropped off later on.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D2

