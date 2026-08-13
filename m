Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFF392837
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658502; cv=none; b=oLMaAzaVoy2yQEz+d6dQRZyNnrZxQoHM5ImOLwEDBczkgyr2fO/xjJQ/gdbBatOyLOHl+P2eUcAJmvmGeX7RVTpgNZIL2Dzug5LYpSQnPjv3Q9rXctAAMrgFZddZRDRTTDva1V+c0khgFWlS7FHp9Z+MesYhFInomo40jp3nhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658502; c=relaxed/simple;
	bh=22uxZhX85myJkpMGDbxyZAjdXSdWoqiel1rEnCcNlqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfMAE01xG3hvMqmaxaiQbbAQIz5pWskW3stL/lKXPIh/Nbbe34B1d8nkAdyqJrxTVXhJdIDbXbBCA40P1dvQb7Hr7Cosm7/NA+R03j+UclGIHrq6XiHDLhlv1x4gFFD2SLLLosvrygTs4llHaNODzJRWS6wARz2T/isw7omkDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4XFC6m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4XFC6m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12091F000E9;
	Thu, 13 Aug 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786658501;
	bh=22uxZhX85myJkpMGDbxyZAjdXSdWoqiel1rEnCcNlqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4XFC6m4DoXD4qaRyK4KUf2ExUeWKyZs8ZoLUN6ivPwjybFh1RF4CAsRa5TPF044/
	 XzlVYKbM2Aq2cnF4BDcTl5QGhDpVcCP0qcaaeIvFRtTxPGB06gXRwHuMXwUvmlrueO
	 5d9lr7AHLacV33p6HIrWLTSU5z2Kyz/qGm9OGwxio6ZXO3Bu2ceWK9daWq0CE+vhdK
	 4gYvi7bfirzsVlRk2KXHbGxxQ/n284E/wLTK7QPWZlCVNFToUC8pkD9XAI8W1hi1Xh
	 BnWtUPWH+qVUB+DXGb15heVQf/AcfAT/kCLpTeNl64fExCEJSTgOeQhRYwErS47H+f
	 ALc1YgAuEWyTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] s390/percpu: Remove one and two byte this_cpu
 operation implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260317195436.2276810-10-hca@linux.ibm.com>
References: <20260317195436.2276810-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:01:40 +0000
Message-Id: <20260813220140.A12091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There are no one and two byte this_cpu operations within the kernel
> (defconfig). However even if there would be the s390 implementation, which
> uses a cmpxchg loop, generates a very large code sequence due to the lack
> of native one and two byte cmpxchg instructions.
>=20
> Remove the s390 implementation and use the generic implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260317195436.2276=
810-1-hca@linux.ibm.com?part=3D9

