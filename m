Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C46211A09
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760856; cv=none; b=cki7Ec95VUuJfrLjS3h8go5zoSO04VxpnPR+7oOb0NaF3xqlUXH5vWZ1uyEY8BPhMKPDC5kWBezK0gaw14uCNQ8JRGf0GxD9t8u2UHlPrpeGN2n/Eo7RinB1orlmpnY/obNWjAs34Rg35leoTHE9++fYnvk5UxhtDYmDJhcszoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760856; c=relaxed/simple;
	bh=FShc1XAv4fj5r7gFmaVf+tSZ/nP1p1QqaZKm5HcKnqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pklrf9Syy8Tdks5PWU6FdSHaUmRWGmRiILcDtJx+FzuV0YEcyOndj0XodEhL1sVAGIyFRDoQgCjvCxH+jYy+nMrShFxQheVxFI+uTDVzs3rZzsKX+EExVGKk4OdTOGEHmbizYeJZL8zIwPUR8C/xcjnXWuKbVZjbAQlAm0XG2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsqyrz+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsqyrz+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CB71F00A3A;
	Mon,  7 Sep 2026 06:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760854;
	bh=FShc1XAv4fj5r7gFmaVf+tSZ/nP1p1QqaZKm5HcKnqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vsqyrz+LnmHDL4HHckdNAThj82K8tVvrI+CQqR1hyWs3sjtqg1P+cLQowEnTpVGkU
	 QXOGIs8o1NtHW7BNo9IIo5Ts/C6Duk+VC4c6Ga5P1vGGWRSrLlVd+MeNkVlrMWHEj8
	 qBeKxyeeFE7MpzabLHiONAeloI0BH+UfThmHU9Tnb7rYTkrydmPC1joYJQVloXBYlo
	 Oc+gZY/3xz5kKfjKJoxlDgREbFiuM7OZrh9obO1yEwW0gcwYR/P51mbJDV2B9NnVsd
	 7EfOYz64naCH//z1JY8BL9Jdd9m7psTnUzNJFQUC2aGj8mbyFoypjjTBaXBxM0AAgN
	 SgKlfDokiiZWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] docs: s390: pci: Fix the sriov_numvfs attribute name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260907055847.27992-1-kmehltretter@gmail.com>
References: <20260907055847.27992-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:00:53 +0000
Message-Id: <20260907060054.38CB71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The attribute is sriov_numvfs (drivers/pci/iov.c); the document names it
> sriov_numvf, which does not exist.
>=20
> Use sriov_numvfs.
>=20
> Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907055847.2799=
2-1-kmehltretter@gmail.com?part=3D1

