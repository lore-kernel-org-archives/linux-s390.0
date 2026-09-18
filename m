Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B113D3327;
	Fri, 18 Sep 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744545; cv=none; b=JSHAAoh211y59QkPCrlnoGXdlSfOqhom2oxXDTM045ybDo7P/X0iLnFNpVv9cIPqQ1LAVv3SY/nu3dH5QfJqe/vZnnhLRA+wbLEqNFt/oZTHE3z5WUZyz5zYgz5lWX/+f+4S2QkbZYzFV1amg+Hff6vak0Rf/dxEOoLx+AcbQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744545; c=relaxed/simple;
	bh=KOuKxdOCrkCm+UwZ5a2UNF3hopOtjkYgdNAn9ZA0M4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVgpp403oop5Qd6plhfafuW8xxBr5zOrzgeqE/s09FNOBGb4rY/Mw+3lfqIlBpBq8vj2g4ZzLh+GDxjHEgHCthlz0R9U8ZfKygGcGxx7AsNeOOtXXDZdQjBs0yNQoc27wWEJsd5nUL2mMA6QHOdKLSXUKSw/s2RLQ9stRDKOvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORSqZQcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORSqZQcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6687D1F000FF;
	Fri, 18 Sep 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744541;
	bh=KOuKxdOCrkCm+UwZ5a2UNF3hopOtjkYgdNAn9ZA0M4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORSqZQcslBDY6AY6BNjRqqHC7STo1MAgXrNF0vaJyMIhIrP7D3h5aTZKwfdw3kVoU
	 ss3gHHhSY2WThXMR5GRYmuf6GqYAei9RyVcIEA6GIsV2Wj8iMh8/ojKFQq2OAy8JB/
	 o64TVlt00ygkWtfoPrcBBjkefepz5pUoflRC22nmnr3s66nF0OdEb3/wV7KIUjDUaJ
	 mgbPyVvx2JcG79rcm08WRtQMTtkFclHyruMaKHwYeOgHsnynTa9z7qi6R4hE478x/f
	 DaPni6kcCb/bv0JZP8euudg3/HZAKCDxQ7CBfERCGi/bt60kL3Mhh5lpogKKM+s1mq
	 Zk3/R6zzZ5j9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/29] KVM: Replace CONFIG_KVM_MMIO with KVM_NO_MMIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev
In-Reply-To: <20260918133107.1042730-10-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:15:41 +0000
Message-Id: <20260918151541.6687D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Defining KVM_MMIO is not flexible enough for multi-KVM systems where one
> KVM implements MMIO but others do not. Therefore, remove KVM_MMIO from
> the config space and use the macro KVM_NO_MMIO instead.
> Define KVM_NO_MMIO for KVM/s390 and for selected KVM/powerpc
> configurations.
>=20
> coalesced_mmio.c is now always compiled&linked. However, for
> architectures/configurations defining KVM_NO_MMIO this effectively
> collapses to an empty object with no mmio code.
>=20
> No functional changes.
>=20
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D9

