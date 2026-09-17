Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC583D954E
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673197; cv=none; b=irU00+ZSiotnSURSdj+Ol7mvzIy7uW9UYh41FLx5NRX1YAz8mXgtTqbAjBlWkVKP5ULw0ppEe1e0A24OfDug/AJjyRACSkwjoESOol+ha3Spnzq2JanufmrRKxtLLsyu5r6OSRLW/WIuqUhrx+/WIPGCzpQvLl7TdwjVwqbKbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673197; c=relaxed/simple;
	bh=UxeGH3DfQDsryg3geqYXWHU8gJTau967gHGXqDA3A+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sc3lGwvvNUIudzYSLPQcPciGh2PmUmfvJl0CBykLlsOGiEGR+hRd6Q4PV5XXq0frGDCHp53o4qGTFMsTSiVp7ZvCjnJJMMpsZDRVEDDs+xvByxZZ+MlJWpYz5JAhYSoEAaOna8atafeLFSiPpp+1eNVpM3QEx/KxrwdkUHyJSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Bkb72y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Bkb72y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9AF1F000FF;
	Thu, 17 Sep 2026 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673196;
	bh=UxeGH3DfQDsryg3geqYXWHU8gJTau967gHGXqDA3A+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+Bkb72yM4+Sl/X/JbR6ZQ3/XwXRxZF6dbBAKMkwo49GUnU9g1WkGIqqERuLzeLPc
	 5bwxGphVJlUQ8HSaMyiiZ3R/Gxr5P8PWlfLxV6vhgqJvozuPOMgejVLiYHoCpt9GVI
	 g++99OlBSHWQUNlvorYGcGSJNXmhUj2cuevloQpGg4YrR0YbkQg0wQ6UiViFdDNF/M
	 S1jiJ5jBSgOtJ/0dA9cgKJFoJNPVNf6GGATgHy5JS5WRyRKaHiiHRzr/0rgqiWJNOT
	 9wce2/uhxY1sfDWN6rq/7REui39aGuSHwTXiReeceh9NRsxlQqBx3hdkKZXJDEszwO
	 jaGlB+DaOEcvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] s390/percpu: Use __PCPU_BEGIN() and __PCPU_END()
 for inline assemblies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917192237.638324-8-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:26:35 +0000
Message-Id: <20260917192636.0A9AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the use of MVIY_PERCPU(), AG_ALT(), and MVIY_ALT() within all
> percpu inline assemblies with __PCPU_BEGIN() and __PCPU_END(), since
> the begin and end of each inline assembly is the same.
>=20
> Also use consistent names: e.g. __PCPU_MVIY() and __PCPU_AG() instead of
> the previous MVIY_PERCPU() and AG_ALT().
>=20
> Furthermore extract DEFINE_GR_NUM and UNDEF_GR_NUM which are used to
> convert register strings to register numbers.
>=20
> All of this should make the code more readable. No functional change.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D7

