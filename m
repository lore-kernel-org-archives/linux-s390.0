Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9E1F7916
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226637; cv=none; b=f2nhOV1SGRVjtGoq1D86fSuqps1ob9rjmwFxTZJEW9C27ttwQa73xLNIgAsgU0ouZRDZqokoOlPIBwc0L3nZ5G4WGjfW7X18l2GQu5Pg3UCJ1L3Apr8aLqufo9GJJlTHLXm2vooG5Mp0lA15H+15x15PVIkOHRbl/PP85WiKqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226637; c=relaxed/simple;
	bh=3Tm20ZOHfieRC9InliyjvuqO4coLqZqBKoz+PsiVIFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZ/BQCpnF3IlFi9WYg1W5ToRTajKr3s/RAkAreqqM64LLi40zEH9D+4DY7cdCIurbq0DsEhYtZmcThB8wdkN6tETrCu6QIQwrMowJmXXQCkdZYPtB6BZ6zI6gx3wr2HGiUUb6dHmJtLL52LexVxnozUeoI7SW1XVGgN8240hiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJCeRRXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJCeRRXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A01F000FF;
	Thu, 24 Sep 2026 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790226636;
	bh=3Tm20ZOHfieRC9InliyjvuqO4coLqZqBKoz+PsiVIFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJCeRRXgq6W8IfFgZQhmnzxHKCFUGMdQSgfBvUmH9SDF2JWfLMueqkM3gqGXa6uhI
	 ear7kfUd+F/9x3cnr7hdNMTn6sdhONBvCHGEvzIdafJ3LJMxsOoVivif7j6FBX9Lhu
	 gpU0g88kqPkZKSGvj0OmEyucoFOVcIUYHd4QgHAap5QG1GydcuvecQ2R712lLvh1at
	 Rrr3E6IkXjPpDqsdHaadosevzRXEfG9iE7SVWVwYkZ7J9OFMDjyeEeubJxGdNtNOkW
	 XhYWqxTv/Sb8aaGgCynD1CNCq8ftds9OQ39RhXJiSkyWuvGfnYHX7egjbbn7zm+lyY
	 ziTQNhVc8vL4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set
 only after firmware activates.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nihar Panda" <niharp@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260924050217.2583852-2-niharp@linux.ibm.com>
References: <20260924050217.2583852-1-niharp@linux.ibm.com>
 <20260924050217.2583852-2-niharp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:10:35 +0000
Message-Id: <20260924051035.D76A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Set QDIO_IRQ_STATE_ACTIVE only if both the subchannel-active bit and
> the QDIO-active bit are set in the Subchannel Status Word (SCSW).
>=20
> The channel subsystem sets the SCSW_ACTL_SCHACT bit in scsw.actl and
> scsw.qact =3D 1 in the SCHIB to indicate that the activate-QDIO-queues
> CCW program is running and the queues are ready.
>=20
> An interrupt-driven approach is not applicable here.
> Using CCW_FLAG_PCI on the activate CCW generates an intermediate interrupt
> too early, before the firmware sets qact=3D1.
> Therefore, polling the SCHIB via cio_update_schib() is the only way to
> reliably detect when the queues are ready.
>=20
> Signed-off-by: Nihar Panda <niharp@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924050217.2583=
852-2-niharp@linux.ibm.com?part=3D1

