Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB49463;
	Fri, 14 Aug 2026 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665773; cv=none; b=cnECdsz9pp06OCWLxVYXTLOOvgjZqa1S6jbsk96HCPvI2eXdICjkqncyWOsWbuR01LD0qCI73xnczr9y91iu/yeHfQubycBcfH1adSTqjQsc1sZPZbbr0ydMO4+xrL7cnYSex/lFEb8vnUaV/18AZRbHqDH003XvUmrPvbHeMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665773; c=relaxed/simple;
	bh=T7j+gMrnhsvWWS88n1o2vNAd0UiMfcbIoMfLmJAs8Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KuMi2TR8WJs740Xr0eY/ccpRTrdZUhjQggm2ZEX1RcTgTrrMSEBjOpJfIHabfrYgS4boP+kJgHZpg/0iIqWvPI0K9vEi5xhKyeZbJmmBIaozDXgNf6lJ47mBWsCsu5sz9klbugfiNLngIdCznTe+X9gDsIa4u8yglhBNO7z3Ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onRiPBGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onRiPBGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD42D1F000E9;
	Fri, 14 Aug 2026 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665771;
	bh=T7j+gMrnhsvWWS88n1o2vNAd0UiMfcbIoMfLmJAs8Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onRiPBGYB7cLq+9GfatncSpyYvlEcTUSj5pOfVw0PliUBX5/pVMKITlECaYtj6cLW
	 CDPWh+edNqdCXUglDP0Hkrdreh7dVfgN9YEoprwuGD86RUe8LGc85bQNBvUqWWEexy
	 zAUN6/g+jmnqHKhxvB9RaP0CMJGhXUTl96LRbZZa1efspQb5pKGG+1Z7cV3JfUUng9
	 60T2Qv2gtwm0mZHBTTDR22hPt3fnSnnVD4MA0C+rlH6z8nSTbajRUIuxo39PU5KbDN
	 V/l9iJaqBKIoNghLoKJ8PwIdtNhkI9ou0qtpWPbokWKbq6RkIqGZPrkD+4tj3X517s
	 Vrtc0PulL6xTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/16] mm/gup: drop local variable in
 gup_fast_folio_allowed
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2FseWF6aW4sIE5pa2l0YQ==?= <kalyazin@amazon.co.uk>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvmarm@lists.linux.dev, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260410151746.61150-6-kalyazin@amazon.com>
References: <20260410151746.61150-6-kalyazin@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:02:47 +0000
Message-Id: <20260814000247.AD42D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
>=20
> Move the check for pinning closer to where the result is used.
> No functional changes.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410151746.6115=
0-1-kalyazin@amazon.com?part=3D5

