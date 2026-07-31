Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0242642D;
	Fri, 31 Jul 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504987; cv=none; b=S912NfjDNOJMTLKWFyevajIC2+/4KojXL+24P9JtePEnE6TA153tRfo4AKlVlEldO+m38l7NqKCXpH6RhHM8Pq6MHgB2ObTJXOlqWWZG1P6vPd5/YvzlKKgF5gqOi7WrDu0P2f7/J2uSpcUE2GGc4BXiBokoKYLIznAFjZonR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504987; c=relaxed/simple;
	bh=cbtSIJG1JjgcIQESLasTDAmJBKI4VTJm4OZ6BJSOP7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDGAPZRq/dSM/8JoEdu6+T3k3GKEjO0Q0T+WKHLr88wiZuhHVWDARw0iSFB3qrPhKs/9NgoLfnQ/yBO1MDa/RUiEXmdXTyCQkUi76eU+od2RLzOTeETbYURCMsz2VxxS7paWrrYVKm6xYjxz5rphv6vxa70UG3omwSfGnTA3G7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpYVEJ8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpYVEJ8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2301F000E9;
	Fri, 31 Jul 2026 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504985;
	bh=cbtSIJG1JjgcIQESLasTDAmJBKI4VTJm4OZ6BJSOP7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpYVEJ8ZIG9K/dQ+4QbSqLP0OpAO+SgcJXk0UvyGxtVxRD9YVwuS/NpSM9Z/ac6Ah
	 6wYslstOZYA2Ea0Wo9DQth8xLuCDV0FhaUf8HMhRi/AgOkY9xroh2hTJe4wgePrww8
	 dgkzdreD5rFmuFa9PiO089gSnW7nA+IRTYk2N0nMIqgecUtaXpQjzFKWXjorjTqzYj
	 CaoGj45v/+IQZ4bxcyUQBq5K+0bfnVqBbT24bzyL+ffm2UNa8jEJKqHaiYgkFnFc5h
	 k7/YPzN/0O2n+IVpeH9OApJafgxGHjuo4buxO8OGBM0hv5OqGCKry4vUAbK5XWtPSE
	 6EBpOFUWbwRcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/14] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130138.173983-9-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:36:24 +0000
Message-Id: <20260731133625.2D2301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a memslot is removed, all ptes that mapped the slot are cleared or
> even deallocated. If this happens while the system is in migration
> mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
> not reflect reality.
>=20
> Fix by appropriately decrementing the cmma-dirty counter when removing
> a memslot.
>=20
> Opportunistically improve kvm_arch_commit_memory_region() to use
> __free() for the struct kvm_s390_mmu_cache.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D8

