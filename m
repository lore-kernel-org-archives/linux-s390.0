Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDE46D558
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202126; cv=none; b=VWdYCoTaaaSPIMmDMjLAFHxn41P2R+iMZSfRG7BwsXLiUZYAgJbiHKRrEorYCTTH07QdIxkiBhsgd+NwzxoXsePklJ7ouL02WvboLRcYKh6eWvnMI5uZkvY6XTF/DMMFP1JBl3noSpOt34Sf3Zv2uKAtVANMyHuNjGp6se2vvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202126; c=relaxed/simple;
	bh=ZrLk4xRj5C458a4QV32SAi6WRUJfb8u+GdQqkUtOPXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VeQMyLvwaSkZGagwbrrCYBUw6YblhF0gW/I6hOYc5HL5rLkdbNkjauV0TOI9yN9uJHTbCD5JxWya+nX/e7dfDn5z9JgbmnWbmLh3Elk784lVPnGDRlIUB9hD4IGpTCba/BX80V23n+cX+8CGR1Q5ol3hwYxkZKRyAL1Fvi4rmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltwxFqo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltwxFqo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC871F000FF;
	Mon,  5 Oct 2026 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202125;
	bh=BgtVgL4StLMv8cKhI86zCDTEcztk7A5vJhq4Hv1SLNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltwxFqo/24YplKxgZ8n4lyVa4Sn7q94xCabOf+JlgAzcqXUlJqoGbQnEhJaKh7X4f
	 beYpUqi+xqV9Xkp0+R2t4jMg2iN1CZitcRSg2kLV8qwtSMIEKsZdgdZSyqAq9nL8yR
	 3BW85tJXOvI5kwZIXUsDEoF9XQkBKHe5IHBxIUZyDpKD56qr6coXRh/V9m04n3exOH
	 dE+xdFwM75Pxvg8CNvIHlpV7Fm6jg4pQ0pzFd6LWdVq5fzrUmC0Ri3UVMBITjjAgDS
	 RwZgWB/hezNXV1XyHavlfKfCu4eXjgk4RqWatrnrwVeISO7L1gprjMQ0DsxxF5KuNE
	 h043UBM00MSPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-6-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-6-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:08:44 +0000
Message-Id: <20261005120844.CDC871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> MSI_FLAG_NO_AFFINITY is added to zpci_msi_parent_ops.required_flags from
> zpci_create_parent_msi_domain(), which runs for every new PCI bus,
> including buses created at runtime from a hotplug availability event.
>=20
> That is a non-atomic read-modify-write on a field which
> msi_lib_init_dev_msi_info() reads without a common lock while setting up
> MSI for a device on an already existing bus:
>=20
>       required_flags =3D pops->required_flags;
>=20
> The stored value is always the same, so no caller observes a change, but
> the race need not exist: irq_delivery is decided once in zpci_irq_init()
> and never changes afterwards.
>=20
> Set the flag there instead, before any parent domain exists.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D6

