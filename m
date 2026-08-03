Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E693426D0C;
	Mon,  3 Aug 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778834; cv=none; b=K5BvTQjVpaL3HE95D7weznu5/PWWy5KHmc1M7bBkeHiJXJ9fOI1yatDyoSrL4Sz8jz5EDBOnWDOEyCgX+VD6pELzDEEZOjySZGJpIqVQacN3FRf5I7tGv0wlDc7xTJ33I/0f5+zLkJ0rrhUOhqa0PIwOzqdG1EbWKRnueMyH+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778834; c=relaxed/simple;
	bh=bgsIxbEbcnxJXOiI3d52IKMx+kp1IA9lUHxjkZGNCeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDvA7FaMJZVSV8d0NwbQ/rDvoSRM3foAIEQWTdsl5BDx6MNlbu34xg5Fzpb86f69iFMATY1r5vC07koPLKfsqpWzPx+tNn3ON92Z7pQvZ+79riRYU5Z4Ao72cu+lhFKETmVz8xGEQHoA7R80zanfxCnqW763stJTJZ+SR9zE2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4DROpGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4DROpGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCD01F000E9;
	Mon,  3 Aug 2026 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778832;
	bh=bgsIxbEbcnxJXOiI3d52IKMx+kp1IA9lUHxjkZGNCeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4DROpGTd+11jbWl8CYeom/fH8/1axMtsIC8OsOQQVHLJYDKLlSqY4MmSq2MBPrXV
	 VsYkWmHpL8x6VAW0i8k9vkYIGXvNzhGxhwIRbRFoxaiGO2/6U2PrFSL8jatYsgzDIe
	 XxVLKjl52gyvmyL74VALjWWekeVtnkJLqdeRjlq13G6h9xV752udbl1YnT/KyIQdWc
	 EvHaEgtxRVNLmyztJlPdwqXZVy3Dg/8wWmEz/m/efEPseVOmi/ggY59AXQ6QFjK6aH
	 TzBNveHyrZGG51EXL2Nc/2Rt0Cek/2RX/CeG8TsSvEr/GlbjeOUEBq5e2Q59amF02e
	 synuUddfrpOqQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 21/23] KVM: s390: Return -EINTR if a signal is
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-22-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-22-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:40:31 +0000
Message-Id: <20260803174032.8CCD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a fatal signal is pending while trying to fault-in a page, return
> -EINTR instead of -EAGAIN.
>=20
> Also fix unpack_one() to handle -EINTR properly.
>=20
> Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D21

