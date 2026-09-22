Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E29554094
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092171; cv=none; b=jbpl9MAJw5AB0CpNj3kOEvuWwuFilhNxxIa8yFey//Di45PxHFnMjIi6V9Myejuk7cT15WFH/3jE4TPNUK7gZaHL1w1AnKeNq1LZ1fKO63ZtCk4J7DUDFqN/pRhNyemWgFBJCi5gcbS0t0RhX1aD8Lj5t2jRcZe9Sn7z7qiqxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092171; c=relaxed/simple;
	bh=RgpBR3Rf//w7tXDJ6bm4I4QVn2SuvX5MtMAPyUn/kzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KuhRm1uU9OMJ3+Z75T6ZY4jhoIIBvwRayRhI6qO9hSiENPdba8UzVr1Ug8yTQiaAcqDclg+LxgYg3Y+tjvmOI3Y28zJ1lKF4/RB4bxtkNw8HtKM/A5zPf+Aq+egZpRjSd/ME0YYhORGzNRPTmx083Cqs00sIS/aUf8Fw1BtuMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSUqQOGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSUqQOGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975711F00898;
	Tue, 22 Sep 2026 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092169;
	bh=RgpBR3Rf//w7tXDJ6bm4I4QVn2SuvX5MtMAPyUn/kzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jSUqQOGfZTU2uVZ6eEZ82P5W9EqQNZIT7pcnQb8sqny+tPK+adudQEvw6OYYCJlpI
	 +7CSP56kDrapCyTKlYdAj5eR4L2HNr++x9UMQfIugxk9egbQ2a6uQlGQQJlleJgN+D
	 LXCG0zCU6yN1hyFx2FDczdtDLyjEwnrP19JLgtgH5xW5eu4RYnsIvecF0QQEcJFgwM
	 NDpDkK42A00KOGRfwwuAypHlQcRDmQJPFc4leFKokctQ3+46kjkfjmta/Dk2XIcNKC
	 Yk9moA8y2NQ6MgVyty6E1RDcKMrxq2+dU1v228gT0XaLjUFzkAPIbQw67Igs+qyys7
	 vGRvlWIyhR+ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:49:29 +0000
Message-Id: <20260922154929.975711F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
> RCU page table freeing.
>=20
> sh-X2 is problematic because it utilises slab-allocated PMD page tables,
> and thus tlb_remove_ptdesc() cannot be used in these cases.
>=20
> All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
> convert some architectures to use tlb_remove_ptdesc()") already converted
> page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
> grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
> for sh-X2, so the arch can provide its own __tlb_remove_table()
> implementation (called after the RCU grace period).
>=20
> [ ... ]
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D8

