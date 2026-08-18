Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117F25C804
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026589; cv=none; b=otP1xq/pUIbVV7CM48wPzxTvj34pV8J+V692zhFD+CRyz1Sw9vutXZinlJ8zQW52MDWzx/Rciu8ajE9J0sDAytNF38GNrprV7KUpHS/wsen7/syrOhpU1LAvNZp8zc0HlnBciTPGwF2QcbeB89WE3c58onCBcMQWmi6DcaS9RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026589; c=relaxed/simple;
	bh=ueI/qYO2pmM1EX9zUITEvHU6ZWhbKOHcFzqt8I8F7hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MRtQrBNlKWZkDwydUandl+AMzuELCMmdu5Yih5V7AuhlBtlU0rx5r8PC3ItI2Gi29EDLMdYTRnB6EplhANRhmAK4fEezBHHm8vtxF5FT8ndNQ3R/bFmB/gfzxwyUgEkK0w6A2lpGsoXVux30XEqh7I7vucbOwTdFPuoJfCsgZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoNWHh67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoNWHh67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E61F000E9;
	Tue, 18 Aug 2026 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026588;
	bh=ueI/qYO2pmM1EX9zUITEvHU6ZWhbKOHcFzqt8I8F7hA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoNWHh678piJzluKYdK80akgIwxYCXmQCEB0raqDRGRk8Zrm6Yq0QC/SDE1RGRxyC
	 bBdEK7G1T5jiLZLBDR/QVyKVwSB74GExtAj+bnKAj014CDOR4r3GF0qWywFoPyGqLB
	 WYr0wAlmeOLm9L9yc07z+8pERbfFvl2Ah0PoomGNqsTz3T/tzxEAg7ZpMcjRF/8ijn
	 wSPY444bVYDiFWMf04ezWyagTO+f69KXfweaqbRrQf9upCDXV5mhzAlOISGRKVyveh
	 zKIzi1QxDh3DpWhl9LPgQEnb/Si957BkRe9w9cPWFrk5WSjy7HMd3LCnjBncIWIIo4
	 388pHCaG5dHwQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 5/8] sh/mm: Stop using pte_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818040041.1891769-6-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:16:27 +0000
Message-Id: <20260818041627.E20E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps =
in
> eventually dropping pte_ERROR() macro across the tree. In this new printi=
ng
> __FILE__ and __LINE__ has been dropped because they are always the same a=
nd
> don't really add any value. Besides ptrval_to_str() has been able to hand=
le
> different PTE representation with and without CONFIG_X2TLB, which helped =
in
> unifying error message printing.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D5

