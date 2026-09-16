Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D830216D
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571907; cv=none; b=ooaY7KoZh4xv2rYVujru5ZAbL63Lw/RvbPqdX9nQhfoF30trVwePXW/SKdNOM6LzvDhwZpELBk7PFUwssgPVsWsFatKzlN5wPEOPuWxGCO1/tfEAXOwllhUW1EE9Tn1bjGyQlmi1DPtAta9OIpVHEFk88EALuqvq+N5LbUaZfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571907; c=relaxed/simple;
	bh=DvIMBNuRDZJaRrxVd8pFFfpuH8PA5qebfE7p3DI5AtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ubntZ2Ywsw59qZpud+F92d3t5/ohjbmbogzX/3jOSSASNQOCY1qs14gsLge7/ukYR+yVCFNW+ayfLTeBAfQWGH7lU9OIxojmV2evKzynHJNpNp0RCYiecDHnLUIvsKoXqUUZyA8QGGNRfyrWUTF2o1qYRVvdl8y570zyqbezWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8U4AQ2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8U4AQ2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA11F00893;
	Wed, 16 Sep 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789571906;
	bh=DvIMBNuRDZJaRrxVd8pFFfpuH8PA5qebfE7p3DI5AtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8U4AQ2TnL/iaK4YED99ISxBvvidx1y+BOW67mMDIub+NK1aFSOOPVp4U7ojFYwvk
	 jGAP2LT+XH3vm2N6Fr/xVzcKqtua5+SjkrB8LrAlfVeXdwMtU179wKdtzPHaRuHmfF
	 ZR+9lXiCNSKa39SRiXs+feORsKLFZHwFlIY8KM1yLD+EheuQIfjdhDvHRGnFRIreqy
	 pHbLyM62vwENfWFRdPKai9iKHRsTBNmjHqm1BKyUMVcEYR4UJnxz3MeuEt/5juYQFn
	 wN7nvOt7XwHGOwIZyxmgXwKQ/+6WQUl2HUkCEtkmP4qN0wHMSumvyBd2GV0slHsX2Q
	 g2HnamKlhfDqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] s390/pci: Don't report recovery success on
 skipped recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:18:25 +0000
Message-Id: <20260916151825.ABBA11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a PCI device is already in the permanent failure state, recovery is
> skipped, but the SCLP recovery report still shows success. Fix this by
> changing the status string to explicitly state that recovery was skipped
> due to permanent failure.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCL=
P")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-fix_zpci_r=
eport_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com?part=3D4

