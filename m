Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5E39CD0E
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155643; cv=none; b=DrH9YXZYSfMUwlPsnxBNpWnT2n5a0IEtSEOVXKDIfYV1wnjMsWdfIQ2HhpLpYh1mFX62nQ1X/kIhqNXmp3c/WbqgshX+0Und2nFfzzmi8ZRBkq5HP7AEATeKJnbS97pnYlwkItJl50zuHrLkRRx3T3aMK0bBLrmqSEhwoIFhym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155643; c=relaxed/simple;
	bh=tGc7kokGcdm39lO6q4a7h/vz17T9Yvtz2y+9oiupEGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CIZiHiVWJ9QzSYvwHLdWl3dacmAerTrNudZwrHImqYuMU5KBb4ABaj1Lwym6ssK/9kPxPG4eSI2Jb3emAt7LdYyNsLDhgv3MUaHf0KgqSNovhe0Y3J8wdWapwPrXUnUPsYIReCJ7BUTn1Fz9a6DZ8nXKlzQJ6hJiczq9TrLcBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSVXw0l1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSVXw0l1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F361F000E9;
	Mon, 31 Aug 2026 05:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788155641;
	bh=tGc7kokGcdm39lO6q4a7h/vz17T9Yvtz2y+9oiupEGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aSVXw0l16rTJL7eIoObE/i4J3Dldo6UF/91Jyy/RvLvEZT70Q0gTIll2s1kw2Zfzs
	 A7OpQyuVizldDtlX4nUBV5rFx9MTdJDORy/ACzbaiQ5MkRtsO9K7N7IR7r7LDh//s8
	 i/7CWsXUnR1/dmA1xJ2RBx/QMIBGjzHD7izAxCqOIoLAWuoOnYTZHWkzzd8tcEf/aG
	 RVEvBrwBrKgEWP2FPLgpHMyaPj5v1R5o1FyQlv9zA6EZdtA8JwK4lAZMRGphJVcDQ5
	 CibF1AqDGfF3X9AOtz1PrDyGaTDeaTUMFE5NT4ME4/JGT8Ngw31JNRyY3YJdwhqu8W
	 4A7WIfdKeIdxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm: Make ptval_to_str() generally available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831054331.625505-2-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 05:54:00 +0000
Message-Id: <20260831055401.53F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move ptval_to_str() inside a header thus making the helper more generally
> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D1

