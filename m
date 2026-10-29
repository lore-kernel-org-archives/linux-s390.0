Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304993;
	b=QA9o/Lrw7GEPm5AujwUbvrXWC5K6UR8xBCAwglUkA9i0gWeo6/kMGZjQs5UME+f5MEp4
	 dOCh268JAX/AJG/JvvwaLM32MgmbmuTIyYb3mXyRPgyu8Isjp6CTEFW7bmiMW0ju5OkuX
	 kdLmFqfaEJA3Ep/kPaQkkNZXnNjNx4G1fDYgya88AseKKb/p3H48Hx9uHMgDezIDvYcP8
	 /C4hkwRHpylRZtgNe355HGBjEOefHTBR/71Fy8xWFlMxG9XSlKFu9kTRJK2+zeZovqBvz
	 bKTcGxj824kRSRMS/MJ4CJriDn4adujBtE34C3yCqI2tNSXeNtUKDgShrgPSLijxGkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HHMpYqTaAPvWPm+dlJZq8agJ21LSuX2jQElZAbYSQpU=;
	b=jZWrG4gaGEngRX/rvpjZ2pExe+0TeLLIjKFABJQ4MGA3DG1D37NcAkLu77KbvVcMMKwP
	 sm9PdHhrHInbzl+AAhD4aahniTpdqrofxL6HzhCA1zAJ3tKmsDUuZayNqGG0+9KBwsCEl
	 vwPH5iMLlI0ohO36c/vwS3MxdrdvKOHPuU0/LrDeDZB+tcmVg3Ch5ifcGH0YNmbGBvuFs
	 snbLhdY4TBdfd8ScjeNER946tnvR2/yy0y85RukR8lTJVfIP/+J87ZsfOy0evVmqO7Ebv
	 TCh2rWSIPqR5kDZwxUDNZpGKn3c2bmD0wdgK1HmdXCBItcuxPC630cMwf+bPWlNMYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m41gBlQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA8606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m41gBlQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B511F01824;
	Thu, 29 Oct 2026 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304993;
	bh=HHMpYqTaAPvWPm+dlJZq8agJ21LSuX2jQElZAbYSQpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m41gBlQbxTCryRhAhhPV8g8V4ni8Xgp3CY4+NJVKNIIzwy3DdYOf9MHgfnrRjRlOO
	 HhjHiyBfafGj61tP8YWmeCAg4kR/rN5hoCpZ1LjGs+8yJzRX1o3Ts8pwhnr8RoEvu+
	 Wg68k/vAjW+6K0XEdho0yBD2a7GvpYQ6QBrKzJAvsSZOoZZW11ZSNgH2BvVbFQj2Pr
	 7j8MiV6OIwCP/6sPkXvW4Vf9Jwpga8buA10YoCqEogmcQ1TNTsmUAKI+vveVz9W0C8
	 AXzNforLtqLet1Gp89VMYTE4OzIPuQufOP/gW4bRCkOJLH+hKjIq+68L5Y00Vkbc0B
	 gLBR2+9AtNO0w==
Message-ID: <sashiko-outbox-189908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] mm/hugetlb: serialize page-cache allocations with
 truncation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-8-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-8-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Truncation can remove an inode reservation while a fault is still
> allocating its folio. UFFDIO_COPY and memfd pinning can also consume
> reservations beyond the new i_size. This can underflow resv_huge_pages
> and leave folios beyond EOF.
>=20
> The main issue is that truncation takes the fault mutex for folios in
> the page-cache, but it has no clue about faults that are still being
> processed concurrently.
>=20
> Matthew Wilcox raised mapping->invalidate_lock in a different upstream
> hugetlb locking discussion:
>=20
>   "although I wonder if we still need the fault mutex array, given that we
>    now have mapping->invalidate_lock?"
>=20
> [ ... ]
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Link: https://lore.kernel.org/all/ajMfdQf-Fspwmstr@casper.infradead.org/
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D8

