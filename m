Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F293502571;
	Fri, 18 Sep 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745056; cv=none; b=qdq29mtnrxzRpBZzoCcQo4Mtbq3EbCBUOtXwcJuXkshQV68aemMHccjwpuWYwjWKWSnQ2Hu0eR3ajkzoPkiChT8RyKOKKuMrAmFPi0maOyljvJDpaVUQF6CgXkGoD+t8YMItnV0FZEhpc2EFFhOidb+rBSlyvnc0mU6vQbiZac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745056; c=relaxed/simple;
	bh=/p9iO8x1eL2Psxw4ft6JjRp6oALN/CCyUBy0JJL7jJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=alT2Gn2E1G3S2mxbtyEsYJK0cEFmy+Bd2q9fxqspklLDrY6tLN0dR8mOs5trlMyLl2keQ68GDvKe8mrCuXNmM0nN6jcczIUfVGHXHS2/fFV7pzcjrvVFhNVD6sZPkJs6XomrHkAtf9LY8123WuEXpMkdx2KzMEAXxLAdP3lJEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkFJBpSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkFJBpSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871D1F000FF;
	Fri, 18 Sep 2026 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745054;
	bh=/p9iO8x1eL2Psxw4ft6JjRp6oALN/CCyUBy0JJL7jJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkFJBpSdKDRWhywOVGh+4B2CuoMnvqQUgfEUKEfawbBUXTsckkoIhA5ybvlOlR3uP
	 bvbHReVotzWbOCMz/Rq8nMZzF7X25rQrNtzjAZgkKGCqkrnGYbYq7OQwAAma5ORSCb
	 rcVQHLKVC1bbdQSu5PYXNVoMY347dJGAciKErzuuK1Ey3zV8xpk3t8MdFFEHPpmIbO
	 S7Ls8gwB6da7DiMluDrIUl5srzW33Ru65/o894MuMzFavVwj9XnnZnDqI46jRgI3uC
	 AnPGQq8pcml0sk+m8mZVHeQat2+Bo4bSlIC3TvwXLyuf0qOrk5qW4P4P2+tKIFSfuK
	 Qva3LOB08K/rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/29] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-13-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:24:13 +0000
Message-Id: <20260918152414.5871D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> DDIO616 2026-06. No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D12

