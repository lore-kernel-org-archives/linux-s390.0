Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9F4A64CD;
	Tue, 15 Sep 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484117; cv=none; b=IlR2zyeJMa9EAB8GmxM/v4OTPVjaAUZsGsCP7Nn/mdjvnIEhGxzcu3/JHfkiRx45qYxHtyhAAjcaUy9R+BhxytifKU9wu4+J3HlqdCBs40k/L78Ey/gHA51egdhP4ZLhwI35B3nAIAR30FcSaSIWWnhH3Y8AmExuBv5BV47uqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484117; c=relaxed/simple;
	bh=ocvrlDniUILB2Qn+xpcxcG1bxect9rksUAFthAjrYUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dfYZyEnCygVKBrCwGpNXgroGsazVOnAHYbuchiW7VYB62yCBmsc4j+i7t8lNrcU3Xk+FbIX7yMNlqP5gIMf7XYPsubkvb6OMkI6GyM0awt18nsbuK77iXfBdcQPdDY62YdiggTEsObLUcW52amehLXwl2yAs+PlXf2DtNSUBV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqz0Aaof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqz0Aaof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0E61F000FF;
	Tue, 15 Sep 2026 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484104;
	bh=D1Mmk5fSxyhosignrfJbyzO5uMwrwmLvAMFCvEMPdKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqz0AaofVPDlRQvBjaVSYXT95+pstzVvSszXgFIdf4Pm4StLb2F1nYMx4pC7iiS6p
	 bjJfNAMyvtEKLxgOE1nAIDRXoIAE80Eq/i/9W2lxZHjkvKDTgDdUFpS8wUNr3fAg2E
	 qGNp7gFuHQuCjVdAefDtX4zJKhGgifcXcUJmykC2K2dyAsaV4Jx/FAwlxpZY9BrVK+
	 VErhNpBmpaQWZGs5PHLJ+jxtx2djxPoelcCIqaZ5pWudVOVs5IpYxGthIp9lmoi7rF
	 kr++FjT5v+HrurSRGW554x71x8B+Egx8fHlBC1YF8ugODc7enPpQxjFZ6pS3sgVtBd
	 ey1UtLNdGLWuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/uv: Rework page allocation for guest variable
 storage area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260915144307.2367089-1-hca@linux.ibm.com>
References: <20260915144307.2367089-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:55:03 +0000
Message-Id: <20260915145504.2D0E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Alexander Gordeev reported that the allocation of pages of the
> guest variable storage area via the uv_alloc_range_cb() callback
> of apply_to_page_range() will cause problems as soon as s390 fully
> supports lazy mmu mode.
>=20
> Problem is that uv_alloc_range_cb() allocates pages with GFP_KERNEL while
> preemption would be disabled. This would result in reports like this:
>=20
>  BUG: sleeping function called from invalid context at ./include/linux/sc=
hed/mm.h:322
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6092, name: qemu-=
kvm
>  preempt_count: 1, expected: 0
> ...
>  Call Trace:
>   dump_stack_lvl+0xae/0x108
>   __might_resched+0x1de/0x2f0
> [ ... ]
> potential future bug.
>=20
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Closes: https://lore.kernel.org/all/e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-=
agordeev@linux.ibm.com
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915144307.2367=
089-1-hca@linux.ibm.com?part=3D1

