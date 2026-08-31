Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A939769B;
	Mon, 31 Aug 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199740; cv=none; b=Ud9JbGMPczqHSrstXbsAuJCVZlOStMvgx1xy84aNfB2/5vxyMOzjE47DFLGepdUduPw1xYOp6UeTVCTJk0JwkMYQX5ifjG2jDThGYRxhJsdSo0Qk9UCC6DJgrYgzaOK1QpfKGJV7w03R4qmIvsSAHT7ZUZccfsnC256imutMYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199740; c=relaxed/simple;
	bh=KAukziXOsRtlvYtST+efO6bHwSFRTn9+IpXZRcCcp14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iU+NA/CWZPx1Z4+hlgztIucOI72hvopkVuIqtrtJOEJk0VgKxMm3xpFBWchBp9JC7xvsADU9Mj0Sr8Yrghct+PSfOb0aQBqYubXT/4UomkAnZoFUbSwcRI4QMKELs3AOasViNdNL/KknqAh+9LTKJXaJJMXrzc9E+2yt4Lc9+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFqWBDh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFqWBDh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A88A1F000E9;
	Mon, 31 Aug 2026 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199738;
	bh=KAukziXOsRtlvYtST+efO6bHwSFRTn9+IpXZRcCcp14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFqWBDh0mHkvxYFQXvCQcGzWS/a5qfJ56U4beyDB2wWO/u1de0moaLLnbRSYOJJYi
	 z4dUURkIaFcw/oNDPLfGreyuVpC9DMXKHbs6G0qnC/ohDD0tZM/rxm3VYZjqm8GX/L
	 iVU1bPFcKbYlRRoFLHJ0OcFlklaQ487F4hGdLoC0eFf+GWUlQn0tLZhO0zaa+BY38h
	 glHp/EEGUeVo0b2KoWm/nTrW3+K2iQ1kNtr+XiC8SKFpRLLM2gix95EKBnyBXwoP25
	 xZMsNr+1/cXovq6UTy8KNFH9n+pdwIh4sb7uqg/Ja0nVJwGRRiz7lA4fIit/WYql8F
	 EkN66j6O3BlSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/20] KVM: arm64: Extract number of sys_reg_desc
 into a constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831145536.913567-3-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:08:57 +0000
Message-Id: <20260831180858.4A88A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define the constant `num_sys_reg_descs` which stores the number of
> elements in the sys_reg_descs array. Replace all occurrences of
> ARRAY_SIZE(sys_reg_descs) with the new constant.
>=20
> This refactoring eases the integration of handling system registers for
> arm on s390.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D2

