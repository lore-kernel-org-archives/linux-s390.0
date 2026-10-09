Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B202BA45;
	Fri,  9 Oct 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556635; cv=none; b=Iwo6sA7EwEbdNm6hQscJMbt9Eg46CBDUhaYnN8AeNifVRRj77qegE6NY8/5Eph+XjwqqRNKebWvLmaYeCzwNNfGA2HqzC7FAGp/hDnAt0lYiGJSMnmhKGW0+D6dGGyuj9ZOtcTT+IDXJk7U34LB51VyGTaGI7vNsBMA09IYutqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556635; c=relaxed/simple;
	bh=8sroR5xQlN2EjogU4OR6bySN3oxs/bEcS2apZDTmX0I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EywuFXKHBR6JWKO7PVGQwwkLwFEs1ZU4eWm7CI/+nDuRMNlvcLCJRfpVjxq7oizLoUtP9/7sSfIVbAeKxqZSdg5+8/asZkAj+ZQhQO17cLEivPBJfJlsfA8rWbZQlcLonpLB1hWlCNE0px8pFzgh1Z/sRGwbyux609X8odQNw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9SsjLMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9SsjLMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B31F00893;
	Fri,  9 Oct 2026 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791556634;
	bh=8sroR5xQlN2EjogU4OR6bySN3oxs/bEcS2apZDTmX0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9SsjLMMnNYSDka/M0taN2uJFIDOo8yfHedPXayl7JH05/Ico5kmJURxjJvhZCcG7
	 YkTA8zLq0KOzBNM2xQM+zA29MdR30UjYkw+jxRm1gFLjCZJ0GICncM2Fyc3Q9dpa7+
	 LR8IsoxxfXot/1vw4hxYL9P0pl9ISwVR//gN17JM2vF6O70nfn2h16AR/Y06BgYk4k
	 5w1VN84Jc0r2eqrelPCq8TdFMolS8NmR68UACrX8jrdB2lFgG8cReDRw8WXa/S9/sj
	 Wi+yRF9cy5/M95bGDZUlCvtHUAEyUEKgmozCvCKp7DaMCtRQ/MPLI5uj20YmHyuS5g
	 EJ5ch2nGtWqjg==
Message-ID: <sashiko-outbox-165723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 1/6] KVM: Introduce file_to_kvm_<arch>()
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009142749.186650-2-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:37:13 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Add a macro mechanism that generates an opt-in and arch-namespaced
> file_to_kvm_<arch>() to convert a file reference to a kvm object if the
> file handle represents a kvm handle.
>=20
> Activate for x86 and for s390 (native KVM only).
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009142749.1866=
50-2-borntraeger@linux.ibm.com?part=3D1

