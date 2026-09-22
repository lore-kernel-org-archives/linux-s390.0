Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46B4A8429;
	Tue, 22 Sep 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107254; cv=none; b=HPmYa4WFGPHm0smNp57hzagQaeO7LVXpC5wWFKjQzWfcipcFfV2+a3XQkETGKdfNuZDYkYdmN2MBg/xb+oxTUHrhnYkVtCz1AgyGsbgLqoMsKt6ajU9nOgXR2y96Uwesy5gGB6AHBfPNfp6jcryfbU4hCbfdGkjDrxexFUfUgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107254; c=relaxed/simple;
	bh=FDfbzx1jfPOhuwBUcmhFqhsRVSeMapV6Nuj1pc7kMg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5Jt44yxZ5PTEakl4plnrw+CfJ+QBw77T5d3ztrW9uy7UDO7LqRt0cyGbw/jyE82LRQR589x/ttia+tBqjBjXR7lxRPEND+s5LHBruE5qir/LLqGhpwXToHoL/CDC3dgq3MAbh8K8mi3VS+s3JBPVSWMtK/tPQUQO6e9asiKWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgojSSXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgojSSXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375FD1F000FF;
	Tue, 22 Sep 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107244;
	bh=FDfbzx1jfPOhuwBUcmhFqhsRVSeMapV6Nuj1pc7kMg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TgojSSXLRJUtZv3t6iHEG3ThJ6n0HIKO6IB+nImY1f0l8hfR2NGCmnEN9edlvxmeH
	 WH8vmDcxox9P0kKx0HaFU/LQJSf02o7XCShsJykbGwHEBGZyRKxezz+6JIG5VLyB5L
	 UjR0GyNjuttp8WJBunbCYTmsLQV9/UeZN36pVR90LiTsLn7gcWHB0LeenHTRKbbb5p
	 yROWAkJa0mmS1exdOIrqrP+M/bcXfO8+DZNQljJkJPHlGMnDdfW254Yc1cJzK/Ccu/
	 HVZxn5j/fNlzFDmZD1zixJWMf+BWIxZNoljuOjKyEJ5evplv8/dWFoYi/3fiVffR78
	 VrES5h6njg14A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922195141.94548-2-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:00:43 +0000
Message-Id: <20260922200044.375FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
>=20
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922195141.9454=
8-1-oelghoul@linux.ibm.com?part=3D1

