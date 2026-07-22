Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58340F727
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726320; cv=none; b=UDeXUzoah/LCOcZkuAbvpVEVaNvEa8Cua7yNVxOlyiD8UiiyS7KmDoL6Y6XFcd0vqGhlW69IGJTwk9oRTXsifZ9vs7ms6RCZ64C9/XmdNpku7c+bwEiDCmvOkryX9oc8/KyYBWeBsLJL7PPUmL4tol480rWqhOwF8pzN72qyaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726320; c=relaxed/simple;
	bh=EXK6Wy2yeIBa9Jjc+OeYn1vTmNGDhiH2AcH9BL5dOoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hwACn/aD+EgwfdEb/RKtG4QpipJ+XOVxF8vybze0wWQEy5ve7CG+rSyO60C81loFMzJjiVs4oV8rj+wvJXi7i4uUAwq++gbMT6l+JbnmNehCCFdI0njybferI4b0abSusmtka7H9TNmTPCRiR4hKtaxujmzTr7TEO3xE9Fm/YXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPXBfMHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPXBfMHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2167E1F000E9;
	Wed, 22 Jul 2026 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726311;
	bh=EXK6Wy2yeIBa9Jjc+OeYn1vTmNGDhiH2AcH9BL5dOoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPXBfMHm0jvmTDR5u3L5rgKsTluQ+JPxXA+C6Z0bjqaH1UAZxWtheHTMXTEJHBRcj
	 JUfjUJ+eO6fHN37PB5SwUObLZPDyPmmIvAyddHLRL7GFi53hEClzGsNa8WewAMtSTr
	 VX9lLFCLfo0FYpbJtgHIz3leJtuYssPuop+fUFYLaWKyAsIV6XkUMoaCcL6gSiCnpi
	 KsnjoubinHe2TWmOb/Vm19+oQIEzFRTzcoSE2UoYaaLw0MiBBuQQ76NrIoib3CBVk5
	 6fQWnnuMLvcG0LosJ52LgPFu9metRAPZ5o9o86GAe7BbjwnzXjN8pPVSBRTZg/sPEd
	 B1M7f3Huilc+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return
 without MIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260722-b4-syscall_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com>
References: <20260722-b4-syscall_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 13:18:30 +0000
Message-Id: <20260722131831.2167E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On a machine without PCI memory-I/O (MIO) support or when running with
> pci=3Dnomio the s390 specific PCI MMIO write syscall checks if the MMIO
> cookie is above ZPCI_IOMAP_ADDR_BASE as a sanity check before even
> trying to perform the MMIO. If this check fails the return value was
> left unchanged and thus 0 from prior operations falsely indicating
> success. This could potentially confuse user-space into falsely
> believing the MMIO, on a mapping not valid for MMIO was successful.
>=20
> Fix this by setting the return value to -EFAULT prior to the check
> following the same pattern as elsewhere in the same function.
>=20
> Cc: stable@vger.kernel.org
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Fixes: a67a88b0b8de ("s390/pci: remove races against pte updates")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-b4-syscall=
_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com?part=3D1

