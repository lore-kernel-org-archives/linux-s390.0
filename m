Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D44416D1A;
	Fri, 31 Jul 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503487; cv=none; b=GcBR1DxFp7V33VK1zEzcwm1qfA3L/rV2ITGG/Q7bBu+i1XrNKpQ/kNjZEZZ465+DyGXhBxxlaebmwGsLLyj7YuyGXsW4GHsdxep6UqeBh6LKsVkPB82nX5tv7AIEgInxsBZPTVRsAm61OGtWOHhVw7a+tJeAgcMo6qVm8m8QmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503487; c=relaxed/simple;
	bh=/51oDInaX3PBFbUQoyFL5uZ/wtfWI7zWDs30Z0eEIAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXQzgW2U2ZV7Iz+sAH07Fxjb6A8k1dTdBadKsOoXoUmsCpqFcTM/L3lNEtBSjGC4TwcV6mGkmOYsl3zZE8B3kORehU8NY4mM740NF7teI3sNrolvIYlUvUtfwwXRJCgJyFoU+PQkh/DUuqvFRvEWZ0gi5s1VmXUjLhmMwI6Mk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7h9Tp+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7h9Tp+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F5A1F000E9;
	Fri, 31 Jul 2026 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503485;
	bh=/51oDInaX3PBFbUQoyFL5uZ/wtfWI7zWDs30Z0eEIAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7h9Tp+j3c4RPJOpwvV2WmhAPm/1xauueHGfVi628sIrQfQ5xazYKM1sI302zgWEN
	 pDVaB934JUFn8yv9o+BH/Cg7ZMmi3oF+SpSz1eCe3mgGrpOFdboc52uvuSpbSSsXK6
	 OelIX/HAeudjUM27wktjFupRAU0HtnZiFAQhJki66K1NXjhJD8sKh268h1AYb5bWSb
	 r1mB6yxm0DZwrnKDIbLhyzS3azdi/o+cyMy6b7Kspyc6Hqt6H49TYAumZ5L6vX8I9D
	 ZAgua9gcuxsHNUthlAyxKCnP27HMFzSYlgXgbDNddEDbLk4UsYPYJpmMnj8nONwEmy
	 99lrgFLJ7Hktg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/14] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130138.173983-11-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:11:25 +0000
Message-Id: <20260731131125.A4F5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The mmu cache is the first thing that is allocated in
> kvm_arch_vcpu_create(), but in case of failure it was not freed.
>=20
> Fix by freeing the mmu cache in case of failure.
>=20
> Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
> gotos.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D10

