Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F72222AC;
	Fri, 31 Jul 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505629; cv=none; b=U4SNE2efTfJtfbS4ir0YPCCLIQldRLoUMn5wKYFEdEv5yOHKfb8VFmYRqgVDALDNry19h5hXhdITawO5jhxrx1mtvl4sUNQrkiMFUO4Yz2pROj/FWEnoGMq58rCUBhxnuvWG2qUpOobC5Yk6W6hmnjI23h36smNc8rzZBHo7JjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505629; c=relaxed/simple;
	bh=JZkzrjCW/Nv95fsbRGJ3dzd3As3Z0G9Bx7Tphfu59KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZZb6gHhfu50vsEJn+u5ViVClCO/ikDUtQ56RJwXJnrQfXhjjyLgskmSUgQh5NwrG1Ob3jhZszKun9rHZJEuKgw8epExl1mLD+SSx1PZ7GQLvSXu+sUZrftB0zJKEE0quKBhu32SKjS6eiCbzc/27dFjcB5tXkBQb19dpaSvQ3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbqVe0S7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbqVe0S7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8811F000E9;
	Fri, 31 Jul 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505628;
	bh=JZkzrjCW/Nv95fsbRGJ3dzd3As3Z0G9Bx7Tphfu59KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbqVe0S7wv7n52frNzYYY+Kohb+pyYCaAVyTUEQKVFV1kp/zzXpG1FssZl23FEEJg
	 aodlLh9BsWWh4ZPWv0a9620JbSyFWBtXHUGOCTXjAtvWinYwr5AKaldeXLX0djLPIg
	 0wLLu09/YHygl4jgq5uyDKI9kglGFnUJ24PFWuezLNLEo+7aZ1kV1n2uHjZ1X5kNwg
	 m/nxlvGzrCqZRi1ZYAr4uBgrqdP8fzgWFV0d/wYikslxHMmJfXJjNyPX4B/PPqHcQH
	 /hqhYJMTJPDkUYL+Kn/oi2dOkn5J8TUYAamlHq9AnYcVJjrxyfZinuiawRgbyq7Hlt
	 2Lml7YehofMQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/31] KVM: s390: Prepare gmap for a second KVM
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260731130902.654679-18-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:47:07 +0000
Message-Id: <20260731134708.1E8811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Refactor gmap code such that a second s390 (host) KVM implementation can
> use the gmap code as well. Move mmu code from s390 to gmap so the other
> KVM implementation can use it as well.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D17

