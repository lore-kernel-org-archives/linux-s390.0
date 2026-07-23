Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84648CD79;
	Thu, 23 Jul 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832454; cv=none; b=tvj2SXfkUiKMbJiKXZKbx/PtMqtfgqdAPQ0FcWa7OIsLvoH8pETSLdJz8A8MCNoWZjqCi6K3ajBhj0lfmkR4Kqm5/EiwIriU1dLQFZE7sXRCfJV9LMXgfXlLIFAybusiJG6zrgTXmhEtFmHeY/VIfUlHWPW+KIXgpNj7b6U/Lo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832454; c=relaxed/simple;
	bh=kB6QQVUArqoaG0DAG23aHYQ9XPGP2nrRpYQvFxxgzR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QmHQ5Y+JNnJubP0zUDBKU3vNqhKPmPYE8EWtVALveP7imzz3Bjb/HJtCzI9xfqA1dTjF+XPcYdWry+ajVESy83lapew6XbO0nzgMIRghajLqQf3pJJZxncrfflf72vPd6kgT1WzlVBwAC1oN+9ykCcWFzaptXb6M8HFcGNKtp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIcMS27e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIcMS27e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F51F000E9;
	Thu, 23 Jul 2026 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832429;
	bh=kB6QQVUArqoaG0DAG23aHYQ9XPGP2nrRpYQvFxxgzR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIcMS27eBW72DOyhqNNGJtxoRDDGlc3vk1orkpw4dP0GmnZNkzHQuYWZaBYeToTN/
	 74M0r6TAMH/BpchWWG+tCtxW5SNFuH6l04pEjZl+64A0cLynpuyE9Sn0iXsG4rl0Tp
	 Nmrio2Q6+Rn1cJPgEFPde9+s8HuHsKBmpZCAWX9jjNHdwnHOwJrjriWatRrruXRSPB
	 wy0Np9sS8XRkSrKQRCd5KvQcygQSHis++QpygYXXwGPPkEB8VwFa8b0u7Kn4tvTNph
	 PrCupPCGUTZN8BbviZtCNFPnRCT209pP4VL5qo91YTroDoIi6wUYhBh7XUPNCwNT52
	 K2uQ8sGvdLPiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723183440.3271-5-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:47:07 +0000
Message-Id: <20260723184709.3C0F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The airq_iv_create() can return NULL on failure, but the return value was
> never checked. If it fails, zdev->aibv will be NULL and fail when
> dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
> previously allocated AISB bit and zdev->aisb on failure.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D4

