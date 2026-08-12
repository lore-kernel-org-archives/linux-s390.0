Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC0442FD4;
	Wed, 12 Aug 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543914; cv=none; b=UXCgk21mojk707TWEYNIL0AE8bUAbJ1Ck4Gw3jfEElJnXe8NZW7Unq9EAskvMMmADIhNDqXx79WTGJKgp9G542Rbd91Kd8kmju34WSYASGlmjtXtp1UUstJepDjOwvxBKX78CNoyXkDpBMmc+hGpKP+l2zW9PSytZNf0brR3gxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543914; c=relaxed/simple;
	bh=avM4quD2Da77POpUj5o4sK6N3/yO1qcg+TX94/GjeRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtP021s6AJ1jnhrhsQReCJB4qecUuqpJR8NHEAhJMHp0WfG6IM1bMAlpx9Nq2RJ/yVjv0b9GFi6sbPH2ajsIJJEDR+ynV8TQg1o7tFha9s7KxplP+vIyTwxICICpBe8o39iyWYao1Q9Mh4ijP4hYnHSz3/P+UL+Ip4pv9S1Rc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOZbUXVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOZbUXVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098311F000E9;
	Wed, 12 Aug 2026 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543912;
	bh=avM4quD2Da77POpUj5o4sK6N3/yO1qcg+TX94/GjeRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOZbUXVGJ7keF7vDIoW9zmrvdmj8580F8FPm7YyHOZkSLsjUC4UNNzqBrOahCmOod
	 dua/NLX2n5VEBh2WnIPYDDn5dTkLVRlmWlHwPzZfeF9m6m2a9G4/e3S7YV9JFIFAbQ
	 y8GnSxCCBYYK63vLIhQJRZ/AnWYpeMSeeCQu2mpFVOzcDeUmWMII+Z7qh93hQ44evL
	 9VprUoQ2FC+w/tCi9esjW3MHyOfYGDQoSAMAQKvLliI8T0BqnzKyAG0jb9yc6vOf2m
	 ijP5UbTUHspWiQSSD3BFxDrRNPc/i8zxq5o4BPUsBJ+Ky31WauGZIQHMdR/D8j0KiH
	 6GiCUMKxC3FcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/20] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-12-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-12-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:11:51 +0000
Message-Id: <20260812141152.098311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To handle vSIE configurations with an ssca we need to pin and unpin
> multiple consecutive guest-2 pages in guest-1. As these might not be
> consecutive in guest-1 it is necessary to iterate over all pages and
> store guest and host addresses for later use.
>=20
> Since the new methods use the existing {,un}pin_guest_page() helpers,
> they are moved up unchanged in the file to avoid having to resort to
> forward declarations later on.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D12

