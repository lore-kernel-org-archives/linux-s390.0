Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870B30568F;
	Thu, 24 Sep 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267743; cv=none; b=Mze0YAo7ouVrGX7hPlo10LAk2zv+ykhz8yGm6BiFsRU6ecbaUzh6suCOOJmI8NlkZDbXBU7aO6dzNwFAD+whZT5BPx9zJO8U8J+p+vPDRDrkXSWrNO7qduVkPC+h0LL1NBckE37gB7MglhmyqJyLkiBn/bvWLVopdnUsphwQtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267743; c=relaxed/simple;
	bh=ZocbSG0ys8khPCLcy7evQ1A6ZUGNquc9YZcxBEUBv1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJG47g70aDab/hcxgOi0oR7H7e1iEuszArQ6hQCuDjxEYJEfavptczHQ/bD+EKS96Gj5sn2QpPghEzeqG4s0nx2YHP/PbhkaNe0oDjLUoRAEFd+mXR0Mys60EA9Z9QDRdReP/MmpmIx6yJsjxy74M/JkLghRYRJE4yv2/jBDWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR1k39bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR1k39bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC151F000FF;
	Thu, 24 Sep 2026 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267741;
	bh=ZocbSG0ys8khPCLcy7evQ1A6ZUGNquc9YZcxBEUBv1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nR1k39bqTXHR6SDlPA9ZjF8bgICpNt+jJ756WzIyOSdSC4MF51bFLC7POhVkF22wS
	 DJDPcPK8yOo6W2FksbFSZ364tAxgBnUvMu4/0S4yRtllg3pLEhu8LxNUD49VHTGkOA
	 1+6/i8vyvsX15E2C4BIVl+e+7qN5BAebKFrtdiABEzNcRq5VlYmjku3i3GsqnMS3nj
	 BKe3T1jc3Y/ddG3SvdMYvjZ1R4hue+938QiIBN6JcrBndL+xhgTvSvEE5XMiNY95zu
	 4jgRZ4/cUJ6MtlTydIqWOAThf3SzzYJowDvsUAZSa48QmDUMJwRKHwzduqRdw3Ibkm
	 mA6dLtkec3NRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/5] PCI: Move declaration of pci_rescan_remove_lock
 into public pci.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Block" <bblock@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, intel-xe@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <d15370f96120f007db5717839a313f1a7bbfe010.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
 <d15370f96120f007db5717839a313f1a7bbfe010.1790267348.git.bblock@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:35:40 +0000
Message-Id: <20260924163541.4AC151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> So far it is possible to use and call the functions
> pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
> code, including modules and architecture code; but the lock variable
> `pci_rescan_remove_lock` itself is private to objects residing in
> `drivers/pci/` via the header `drivers/pci/pci.h`.
>=20
> This makes it possible to use the lock - lock it, unlock it - from
> anywhere, but it is not possible to use lockdep annotations such as
> lockdep_assert_held(), or sparse annotations such as __must_hold() in
> modules or architecture code for PCI to make the usage more safe.
>=20
> Since it is useful for `pci_rescan_remove_lock` to have such
> annotations, move the variable declaration into `include/linux/pci.h`.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790267348.gi=
t.bblock@linux.ibm.com?part=3D3

