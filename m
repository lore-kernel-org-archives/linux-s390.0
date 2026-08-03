Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748041D207;
	Mon,  3 Aug 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777991; cv=none; b=EaJbDs6slrZPE/h4ZROWpusNn/68UD8vEqbr/EP6tgmzBaPggM4YSKgab19bQ6WeIkMmJsXPinbi8dH7dPbl9KnPtnRbGYKwQL2mUiLGnX9JQZDQyhZAa78LUiZrbMc8Bcv2Pa6Y65AHBnc7Envq3EgfqphTb0JHHnmp4aQvgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777991; c=relaxed/simple;
	bh=JLVNva4vfntjzpvo9kcxdnXMCdj7v11FkKAb1wIg2gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gMie1EyHg2Oi0GWWwAOoqiuBYgk8Nb+smR36ihbylhMJBHu7ctBozcqawMMmv80AhN/5iWkFd8enhdoUtEaKLRfCohPyUAIla9SdNr6jrRp5Rk+mKL2AcUcbsyjnGygRvcKPM7Sp52WVXbrqcmbIeFK0V9VQlvQ3t0Awxy/+2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSL2dEuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSL2dEuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268CE1F000E9;
	Mon,  3 Aug 2026 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777990;
	bh=JLVNva4vfntjzpvo9kcxdnXMCdj7v11FkKAb1wIg2gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSL2dEuExUYe13KJYTL5z5Zrs0zs3NQS+oyDAIuVVxcSbwen0hg394RNSkrGO5ugd
	 ExZ6GuqO13dbdM/EeKrUN/Q7vBty7zwDfnwCfdZ+nasAVbY+5JShCDbJIC1yV/Spsr
	 15Tha9N6eLGYAF6WgKwzd094cIffKeK24lGwWMKEKw8GYCoo+8LSw0xPWkEi0aN9Kv
	 mt6YbGksHpsG7kPsRw4FZXDYutvii6SyhIg3OQtMXLutkinSKvejNUhbg/9t+oEoF2
	 qamx6CSupeT5EVfOyqrhsPsrSBXuUQCkNcptBV2f1s6LPamkc//6DgZ7e36C7rafQk
	 UOqXHr0QhVUXA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 22/23] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260803160924.236807-23-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-23-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:26:29 +0000
Message-Id: <20260803172630.268CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D22

