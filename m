Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB33FB07E
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851370; cv=none; b=RXBx1m6u7OrimK0IkupyJ9rVPX/Hha/hTlLIIOrpSm7Iqf/WvnFBj1MJDm0PXW0H0zObPHiPNkzjSaZEE5fALG6GJiDm/OFIITdUtMnpbUch0jc5tHoH12WDn1wDuX/B2/9S7zYgp6qVpo2+WfbZS89P6qnuTGJsTinWQtFOmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851370; c=relaxed/simple;
	bh=xZ2dMCy/0pnlxqwbsy8+J8ty4ycbrl/8Oi2hiaroSmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VjgRD5XH7CVcXk4S1p1W6RqrJ0xI0+7HhKMqaKsRmQQBHOwX4vhPZWxDKYuhsAufcKCyvRXGTBFxd+4akTWOFrwop6t4jyUjPPfyqi4snCIzyRly6SpIIfkRfAp5A08L8hWBQH4bVqFx+jFTIh93hBKUfiQHzwDUVm9v6ZMu09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOYec/iE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOYec/iE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B831F00898;
	Thu,  1 Oct 2026 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851365;
	bh=xZ2dMCy/0pnlxqwbsy8+J8ty4ycbrl/8Oi2hiaroSmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOYec/iEieVoxWUTkgwcCa7V7U3yXQqkCrqeiZ8bvqLX8Lt7NvC/AqPjOIavgo5IP
	 fEjX9qv4O0C30I6J3HWvBebStNiGq09in5o/NqFQDcRzDsCdyqgsRaNo/y4duLaLwD
	 7wPOcEqIq+SJOp9zYFyK/fz4O1sO2R7Spm7njhCHWmjaX8HX49sH1T7Vdri1UZmxTm
	 sKErJjMSIm2OiJ6RZGvDSQMxGsqpnGaJsQLIkW8Er4ONIzcygMB+8drXwcG04CJ0ez
	 i3FyGh7H0a6shWgdcG+pLQ7EwuIATqzMtyE2lw06QlgNx/DkiRqNXMOof2wwWO+f1+
	 ug5PiXsQ+IA7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/32] s390/early: Fix early warning handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-3-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:42:44 +0000
Message-Id: <20261001104244.D9B831F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding support for __WARN_printf() the early program check handler w=
as
> not taken into account. Add the missing support to the early program check
> handler. This avoids that the kernel crashes instead of printing a warnin=
g.
>=20
> Fixes: 04dabb4261c3 ("s390/bug: Implement __WARN_printf()")
> Fixes: 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D2

