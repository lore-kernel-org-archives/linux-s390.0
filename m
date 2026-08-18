Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216132772D
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026828; cv=none; b=rZuQbL9SF1RNfQSDWf37DnAwbn8htIm60qOhJfZWU3wXedjy64MNa+q7POXGHiOXPQZuSs9NOZ2Vv9K4JIp8WRIiLSR3xqioxiwK3CWrh7nWyPCN2UyyAQDH1cCeUDr/MeeHcYMaRlFc7NLeFy2Ktf+fdjTnUU80NAN7BVAn+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026828; c=relaxed/simple;
	bh=N20ZG65i4OU+Eyb8TlA+9x1YoxyfgnlF/YYE+at91U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfnGby9JmNjMZGp1O9ThLAh7Q6HyMriGiyp0O6LpxcK8/tvEh2URNP9zFnN2A8lAJiMgsCTJqikOZ89LV7Ji59t0Wfe3GwJ6Hy+xAYTB58LtkUeo566kOAfyasgOtVHD/aagKCDwI+Yz6Kc73PKcFetOnPG1zRfa6OVICAcWlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOa8KMH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOa8KMH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CA61F000E9;
	Tue, 18 Aug 2026 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026827;
	bh=N20ZG65i4OU+Eyb8TlA+9x1YoxyfgnlF/YYE+at91U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOa8KMH4tL/Fc/pKVTcI5ixKZLjXWAagZ8wEJn5QdPDhr0qjIUrL7ho0mClGNCI2o
	 blP9tnDEvxQg7dfbGPhIBzWbOX3ToNx8Fk99/V+EDdnwmt/avF4U1kXulrFWtsj9pU
	 CIR8zMSOneKlCMAXAwX/+FCEBojI4GzVXI1POr8xmlbifmXi3CBvou3k6dJL2Bb47N
	 aMfr+r8KK0G3/9ZRHf9P7E4Untygfsp2KCt1rOcusLNo65X0JZRsP8ia0flJQ8KTG0
	 o+Sc0SdkvPfPBmpCdIuIJb/HkRq3wtnE3tqeBTYZZqbrAN6mZaBMS8IkRwX2Xp8HVM
	 g6WxlDQ2JdxUQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 4/8] parisc/mm: Directly use generic
 [pmd|pgd]_clear_bad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818040041.1891769-5-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:20:26 +0000
Message-Id: <20260818042026.A0CA61F000E9@smtp.kernel.org>
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
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D4

