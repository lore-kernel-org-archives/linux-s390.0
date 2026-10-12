Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D21A6835
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794766; cv=none; b=L/AEBYZYdjd6q91zHvWC9Zdhw9Yw9qVyd5uCYDi6ePAZi0ldUWdQ65NJ8xWNgaP28qo222NlwRngtAEzhNyb5UW/RLaT5yR0gNoQT7XZpfkqr7AByaDa7o5xGZKfTrtaYru9BzEpUgFcF7JBHak1AgSIWLGswZO/9zpuTI8d2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794766; c=relaxed/simple;
	bh=Gh7s016EdjNVNaYGqkJtIOEu/1PHK/bR9+1KKkuPXeo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K1bx5BZQTRd3VEGxnLFzPzet29+1nvL48xCnSI5bL1lsQn3HZJvLn5l4RoWfhDRcl64F/BTeieVy24l0qrzx3gc6FwTqvJKGTMCvSykcGlzqL4hLwgiW76rSy5DvvrxaUqVrJuGcrHJtgk9GacE/15fm9B3fSnsBUvLPXhdO3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVHUNsY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVHUNsY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67F11F0089B;
	Mon, 12 Oct 2026 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794764;
	bh=Gh7s016EdjNVNaYGqkJtIOEu/1PHK/bR9+1KKkuPXeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVHUNsY0C2E4F593aGIyXZvL5z97QjBvE/ACKSswQXTlEAM3/4JuL+84gn1L0sOlS
	 xKapCuZc4bbskJKBDEVOuP8XZ0TiZ6fs/M1PeKyz78eRxZR/44h3SnrRqEkrUCpZZx
	 Bx4gcqkg2CcmRyfFWjR5cQsByWJhJFwMJFjode3vW7eGTCFkgI+QEnEQTQuMmOImtn
	 Cn/8nJznIRU2kGsNmUj9QS1TrHiacKxQciz866i9Y4OPswr66BQ+YsqDjKbAJEpBdK
	 3PFHZXok6uZqx9b2ryuRrYrXS/JN+0dkgWk6eJGbmpy5Y7JJSEvbR0650++0zEPHsf
	 cl7LUKhHNZsGQ==
Message-ID: <sashiko-outbox-167861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/probes: Add missing fixup for bctgr and bic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261012083629.2109206-3-hca@linux.ibm.com>
References: <20261012083629.2109206-1-hca@linux.ibm.com>
 <20261012083629.2109206-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 08:46:04 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> For the bctgr and bic instructions the probes fixup is missing.
> For both instructions the instruction address must only be fixed up
> if the branch is not taken. If the branch is taken the instruction
> address is already correct.
>=20
> Return FIXUP_BRANCH_NOT_TAKEN instead of the default FIXUP_PSW_NORMAL
> to reflect that.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012083629.2109=
206-1-hca@linux.ibm.com?part=3D2

