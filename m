Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3F322A2E
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938962; cv=none; b=JAx5RybGS1fhBR+Clg9FEX3sgcLk7DLD066jru71V74j97IFPRLfSnH4v5UuoYnZojtACLTNBk2PZpKgFdGvjt17lSB2yNxEK/R6pDUoEJqXGfKEtamoP7zZ2jwdQL4+YQZ5o0LNuLT+wsR8z2vtsSkpNovSm7jkvZuE55vlmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938962; c=relaxed/simple;
	bh=s9AfVcZHKBQgAEQ9vYrVcFwWj6AD5aCWCQMwaAp6gX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXwz0sRkafaBp4YF/l6uzukeDi0B9kYcBUiiDAYvKMTWGywtDU+xdevcb8r46pC0mtAql+8eFsNPLKrwaU3HNVgH7EWikcv8sER3OgTEbO2zVWtc0315T4DzvmoX2kCjtNdPNBtXvEV2wO6Ev48bSu/pvEqhO7BBQxBhUa/8knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O14llKSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O14llKSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086B1F000E9;
	Wed,  5 Aug 2026 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785938957;
	bh=RH4o5udiTZuwmMhcUiECujEGhJZHDF+Xpvug5f+SvB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O14llKSIu2Xh+sH9fDnkCxLg2OHYaB2UxSd3fwkc9dCi+zpumQPebPmmoJY7kmaFJ
	 RxzvyXtNusDMnoNserMygtsGjrrNir15qWHoLG0iUpeMydG1sNsFDv7hk5Ai2mnwna
	 +2APRjoc7wubuC4gMqFj6E5CtvCcUplDQDdetPUJTVv9OKt6OSS75wKmxQWp1oKEOH
	 hhyZxxVf6NRCcdtO1HVq7x1JnF/4zVGX1ZjXoz9gq4lgXirYsVyDLANUiT3sJM0IOq
	 3fy8Sxrv4gTqM2CGsS7m63zI8+wbxIwnvoMu1x+tJvSW3lTl6aW5hiDqmU7tj0t2lp
	 n2c2sc9xTmbHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] s390/pci: Rework __zpci_event_error() to remove
 conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805133627.1216607-2-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
 <20260805133627.1216607-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:09:16 +0000
Message-Id: <20260805140916.E086B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Clang's compiler based static context analysis does not work with
> locks that are conditionally taken like in __zpci_event_error():
>=20
> arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fi=
d).state_lock'
>  is not held on every path through here [-Wthread-safety-analysis]
>=20
> Given that code which takes locks conditionally can be considered
> suboptimal rework __zpci_event_error() to get rid of this.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133627.1216=
607-1-hca@linux.ibm.com?part=3D1

