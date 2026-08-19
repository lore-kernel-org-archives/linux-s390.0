Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6245A2B9
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134767; cv=none; b=AzAk9Sjcc3us56n9uYyZXgkYExBidLiIaGr8OkH7MvH90iqWSdaPuIpcuhCng9d4Chgtx1hljMJBnyiCHSKN6isv9Sqk5lg/oY/wN4kltkGmrXJCOwTxEsSrLCinVYpElfrJBuIfgQqK6dkEmS1E3b/M0nPvVq+yZ7tGk4y6IA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134767; c=relaxed/simple;
	bh=eZi6pCWEc+LtujSqI70WO7MlcieFg+1T9hT9APDUhak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBHa769svSl/HYHGxTRz1TkD+DD/EXHG6XbUpglMoFHCVxl2jv9ZIY6fcMJOLeVz+OVuV6MGLJP7F0g4uEmFwvkjJ67aApkQ6vv+cLkC9J499dNp+H+QsbfqiYb6f9Ukc06fAXnEe98gefdh4yaAuEXQOxaaWzDGkFAgbNfscCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi27Qrq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi27Qrq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388241F000E9;
	Wed, 19 Aug 2026 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134765;
	bh=eZi6pCWEc+LtujSqI70WO7MlcieFg+1T9hT9APDUhak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gi27Qrq4N23minPjtWrFpNUEw3he8c95WVuoPUrxoCOmQYx+fqsg/kNBkEO3aloPG
	 nvIAfJWeKoW4+cM24WT3nTWUkvfHZJ46sNvysYveqS1QF+V2ymlBwzGo+JwnJ6nFJj
	 EwkxSALxILPqr/2fGD9vimXyD5+7X6evgbdf2EWOf+eBB6iFHHOpEPjohMF8AOmDAx
	 FO9vUWfcARgJl152aAjBfPmwHQ8z1sqYZg4KOr95V8QFP0XVIcZV8SKTNysA1DkAT3
	 QWGBEX2icMEIaHdhhVRphBiESGmpQhuisDD5vxOGtVnastWr1YEZA2h2BDUMDTYAqL
	 HMaszQeG50Aww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:19:24 +0000
Message-Id: <20260819101925.388241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> As zpci_report_status() accesses the device's driver the device lock
> needs to be held. Extend the critical section to cover the
> zpci_report_status() call.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCL=
P")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-fix_zpci_r=
eport_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com?part=3D2

