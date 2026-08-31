Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E732DFA4A
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155950; cv=none; b=Lb4d2TCEfOJArn1M4lyzM4j+n1JIuxfD8Mwbx5cA/Kd114Msl3Xmo7xY7tOiqTGfoUXxGhqWkMNBjw9desr2PiP9HSzOZPah1hJvUNQGghXhOtQ0rjrDqA1ucAvSOwKloqVfFJLmcZEIW6WZsi5hDPHNF0a39xRM1BrWgSrwUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155950; c=relaxed/simple;
	bh=2oCrg4F2ULw6JsAugzjjw1uO7sjBHarf9GXaLKlHqDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CaoIRWI0qI/uTr8WDFjQ3IcTNo+ZgE8ErGRcii9mQqBsr1sakLAeuuteDtkzPARQE02MrIpkGoNYgHPYTaHvKhyrcfacJ5wmQcE9xLH4CLmA9nJM7Ub+bw51CuFJNvfWy42p0taCW6bXrI1acL/LCXIQjAVs8eNwPdOp8FVXTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbT0XEu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbT0XEu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B4B1F000E9;
	Mon, 31 Aug 2026 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788155949;
	bh=2oCrg4F2ULw6JsAugzjjw1uO7sjBHarf9GXaLKlHqDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbT0XEu0rop1Hio2AbIpj1CX4SBfdbf/kXIr59RXTrI+w11kxnD6MmOX+CSXN0vYZ
	 13BMDfUFs+KG3U8PdLB14Hw9SX4yB5ydVLo8U776BvZtVfzL/Gl3pPgvu+Z4eFdhMx
	 cz96Pj32YQEMZEi2mRzlLy0q92pngZpZL+VQRWHB+7PfwIKOvfjngMfIHuNFzHWEv2
	 iBLBX1MXKAsX1t/vORg3zGlpjSfVcPfpJxEkqptlzvpOXOkuH4biOAnPWZTZpnQo2f
	 LY/1daxuF6HJb0LKpb5i3sNDMTyEQEkpXVp5dn3SDKH5IyHQs49Q/go1bEjhyWkdNd
	 g5wn6TYqzhXMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm: Stop using pxd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831054331.625505-3-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 05:59:08 +0000
Message-Id: <20260831055909.57B4B1F000E9@smtp.kernel.org>
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
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D2

