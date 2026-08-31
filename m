Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C467357A25
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156947; cv=none; b=QzwxKitji8sfCUgW+I2Gdh1gsqq2DxxuILOgLvfxblUeKRDRzJT7VbDf0AISr+japduqHNm4dZDUSWDlltzi/ueSy0Jl2bLhn3+hVhCpppxUKdgLBbapPw9qxs9U2EwuG0Laq3B/U3n41UoH1cENaUeGw+CeMh0SZnfUEgO1JHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156947; c=relaxed/simple;
	bh=g8AN70ODZ6WRGkDmupqfu81UBOCwMODRXTec+wU19g0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VLNp8J8zPpeOA5uia1IsiLXHztExYMfC/NE76DGn/0EF4et3ihsQ5QHRbgtKnBakbHVQ/eh4naUk6XRIpnTlYQDJsLSkIFHnMNcBthTcxDofekWY9Pqjn2GpnEm7nJgQDvSsCF1hZeE7xEhoxvIQhHU3OserIyzIk3NNuMu6yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSu6i3wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSu6i3wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE561F000E9;
	Mon, 31 Aug 2026 06:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788156945;
	bh=g8AN70ODZ6WRGkDmupqfu81UBOCwMODRXTec+wU19g0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSu6i3wpBSPNojFH0zEsz4QwIT5AKdRJZcrPYHOkN02lzG6iRIK6dMKQWdIxQCYGQ
	 XfvZrexrh+pR+g6LR3JcEjdMNEGDoAIWfyKBaUDfPBse4EnqBKfflguv23O+oJuQN7
	 wOvvzR74PYQwgVbhsnYYxjFQ6mfyV52BVCNweLl/3el55oNoZ+8a2GBHa9qWu4W449
	 4v+srFewknLpPOV3OvhrTgO/XDo/1ePAPEX3ZNpeBWWKf9rjxJ4iGkpX9mLBYgyccl
	 /JZQhqp/cMK9PLKGQVWzPevBFvftEUcOOtt0/7HvC0+Hcva5YZcfOm17jSzFfXDr7t
	 cvlEKIv5xRjFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] parisc/mm: Directly use generic
 [pmd|pgd]_clear_bad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831054331.625505-5-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:15:45 +0000
Message-Id: <20260831061545.7BE561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Drop [pmd|pgd]_ERROR() followed by [pmd|pgd]_clear() instances. But inste=
ad
> directly use semantically equivalent generic helpers [pmd|pgd]_clear_bad()
> in unmap_uncached_[pte|pmd]() which helps in dropping their corresponding
> [pmd|pgd]_ERROR() macros across the tree.
>=20
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D4

