Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D042E62AC;
	Mon, 31 Aug 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203667; cv=none; b=CCBkZWwh1ZVhlZu9C0P5KaYeG6rzWZ2WTttO2a0BkQW7m2iTxH3CeNdQ7XhdDEYubHO/oAhmFlFW0Bk4sjzeEoSxfYvob8aQnTprgJwtN8hQtP5EvfMmMwRQPbxBCtkJEy0Uctv+d2JK7JQLuuzmVnuEfGPq8kbSgFOyDUVH430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203667; c=relaxed/simple;
	bh=W1Aw3ECEcO8GuONxpl+KKSSZuxmY2bL8kHKYG7ixF50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/XMnWKaa0oqOKFRPQusLCqgiI/9gzgq8fEhJ48JrtX8r1KuowQ90xqu61R97MkQAI0MaVg/qa0NSGOHWwz2UY4ZrY/CheYO/b8U2ipOSHIHDXvk/U+YPzeqgEnQxxjRpQT0JnwG/g/i44ZKRh2AzVYdVcFb2zWZy6Me/dbODHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl1hTl0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl1hTl0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7BA1F000E9;
	Mon, 31 Aug 2026 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203665;
	bh=W1Aw3ECEcO8GuONxpl+KKSSZuxmY2bL8kHKYG7ixF50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cl1hTl0IsiUOnDYkZjZzG5Uhiw7uR4Kqb0P1paGNWNsmlEP7lx8LqD5O4CEkKShDa
	 hsUj8lW746Ih98aH/lLCfffm88yZW5R5rRowW/bpI5MTOzmMGCt1BwPgoaSvzaIulv
	 8D0Aq44hdzf1x09WNp+tJu9exQfC5YpAiA70oHdndiKHLh3d0mWtS0TYRfBLzkLe18
	 IpjiwyftKmD6dHIfTuJ/rVJESN1qA7RSWqIr8hG3eYgqoNpxSqtwtKn7+lcKogCqj0
	 jpZzubuXYst0bmWDERoS+L8amujKM0gF8VdbAyADA5MhbaBpaijsRXBFh57YXPVlNK
	 c/4XNi/vePpfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/23] KVM: arm64: Share arm64 code with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831144802.834315-12-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:14:24 +0000
Message-Id: <20260831191424.CB7BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Mark functions that s390 can use to implement arm on s390 as shared
> functions.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D11

