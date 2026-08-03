Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B6489898;
	Mon,  3 Aug 2026 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761512; cv=none; b=X6Y7qhUKAvaFI7hS+LbFTyFO1i+UqXvhCvKTRmnLqZFIYBwxfSXVf9bI8dCUlXhbvBu0dTLZJpvKd1lTdxK0ek5mhQUecdDuocZ5TRjEOcXCnzYIkb59Qu61nhMmKsWilL0/HHuC2KyhaLwCL6s947vC2huemnm8arKx8bNHZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761512; c=relaxed/simple;
	bh=bS6QLB6su+PzaXnvo3V3RmRr5nOVs4Iq7ZHJJ5IIzcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=URgmDlbOlETEq+oL9laYuz2p/SWv5qhj6s2AEhJkaOJNrm54Ffixphx6B3qSxWJassm7kyQmEBuauQgoss69036G/z3hRL4G9hCsmaNzflodY58LEF173bd5gPbinGZ2tn4xX4/WKkjSDk2UC2xX2VGkAOy2EO1C0tZy1toIuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJzFYTkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJzFYTkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484A1F000E9;
	Mon,  3 Aug 2026 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761511;
	bh=bS6QLB6su+PzaXnvo3V3RmRr5nOVs4Iq7ZHJJ5IIzcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJzFYTknIfIdQoqNacQ9487Cu9urfYvcLNcnR1KuwLGmA+rmjUVw/5gud/PP+pC8S
	 htphMfnPZAUx9j+tXQ5pZsjjpI446/7shmRvCy+V3Ypt9UHhagrWDJAvGGcuA5dZ5L
	 vWN59W8JSohFKrdaagUkWmYrIC6fQPRDgTbJujY8hgWj1q8u3zC2lQUPwESWci1jiC
	 xdryFjEsj2SqKHZI/n6hhlO30XAJ9JXq/AYM6u5QzD8dGVZfB80pvxYdHaLVMGqbnz
	 bprjS+FjuYHnHr2EOoNQbn1Bg19J0+89xhH3hfQgzz15nOFRAkL3WDzRV7s62JA2pW
	 gV9w9X6+7AMtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/13] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803124040.126471-11-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:51:49 +0000
Message-Id: <20260803125150.7484A1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D10

