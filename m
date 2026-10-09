Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D4440A21
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527301; cv=none; b=UNihwgvVeD01cvk3PzmbTGh6JqHapWwHs04qLrpRHSTavSg968CG3sX8BESLE4oN3YQVtRlIvt1E+0KkUO6PftR34A42u91upuIopyK7iG39dYwH7PBhNoSP/iJJEXGwBZPyEX6MVvl3q9BZsQ6fheSb9MSSQkXJMgYll9bsL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527301; c=relaxed/simple;
	bh=f+EuNia4PWdizQVA38KVnzReyJvdz1i/3CEEBJrH3xM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jZvjjQQTpoSOyDO85pS+bE++OrQCDbQyijTEPA0G8huFO1OyXYH12lB7gaN9cRnt0+eBwdZ8FO/aE+jvphZ6m/ptK3kW7UTeMbV/rPINcR8B5ilTYABkeWtqISslxuGZI0eR1VNYa1wyip4IPG05ov+EODjgRD81cXnVi7QvYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8XEc05r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8XEc05r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748661F00893;
	Fri,  9 Oct 2026 06:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527299;
	bh=f+EuNia4PWdizQVA38KVnzReyJvdz1i/3CEEBJrH3xM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8XEc05rJFmSAliIKr4w81wIpAY12TCje50i2jzHBkPHGUYWgicV/6YcvoQwCPtwX
	 2iugeeFClsuJQCmywGMjFltePyFGZgXx6O/j3y5HdQwSnqhV9HPliD1mdIjGGVMhmb
	 4ZppJsHHdDrMYhNbrddf1FZeXi4PRUVlc7RapVtRGiT48ZT6h0keVWDHTDz8lvqwqp
	 dWNI6GyIDKCuQzjUtHB2jE/nHVE9s0OuW59F902/MjKQBcgqwmOiNxBgDeq6vndoll
	 rYHwe42XtslG1om5FKby7haqvRNdsM9xqnl5+k9XiGYO8BxTlAv5muOyb2I3PTpRJR
	 jZZSKbXm5JclQ==
Message-ID: <sashiko-outbox-164937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] s390/pci: Fix resource leak in zpci MSI setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-2-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-2-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:28:19 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
> by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
> ZPCI_NR_DEVICES summary bits, reducing system capacity with each failed
> device hotplug. In systems with repeated device insertion failures or
> under memory pressure, all summary bits can be exhausted, preventing new
> PCI devices from being added until reboot.
>=20
> Add proper error handling to free the zpci_sbv bit and reset zdev->aisb
> if the AIBV creation fails.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
> Cc: stable@vger.kernel.org
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D2

