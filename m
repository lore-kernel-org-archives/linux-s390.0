Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68821440A21
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527184; cv=none; b=Dw08HS3i6L5Wecshj50QqHlTOS+FO21jtWzzTUBDt/ywirtvlon7Qxs4T+G1vzXBpRGG8UouKTqd7FnHRnKZFLlhh9BoUpGykMuFZmgpFsezc7wntDpzFKGLZ6CSXXMSGvnUOvsgPxXSdSJE8uRaxodFG49RvxaYJuu+EtnmLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527184; c=relaxed/simple;
	bh=N5gAvRdKzDwbY5ilevRXFfn3Ff1k22GiSnz/xqf0V4k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BOCFr/+cT4PZHFUPwatP7+XQyUhthUEY7a07mKlfhs+TfOnst1nc0NaU2ZXMd3eaT/gA7kqdAbjkYvrk0+YliyzsRWDNmJJeQ26pya66wWW+hp4UZ9tbOxwFbV+vUzQ5tS9MOsF0DTmMmDcvA1TOqmlDQnxR0eHtO4mKttmnHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omCbycF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omCbycF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B241F000FF;
	Fri,  9 Oct 2026 06:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527183;
	bh=mFSzvKZ7AlPgH1M++GAb3IwC/GFCH0MT6655zqxMXz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omCbycF9Obs6YIR3XQE8KJ2v282xf7XFizwravi/nkJFLxRRaACd7qS+pYERELh4h
	 i8XKs1di9FhZFppTbnamsez9f3JsJXRC2uYyBgdEr5fE8IpvOYbZOBhCiXRY5nPB1o
	 6FuFFdh1M+C4FMcvX98n3LODlWumIRgTCSZqqU/KmoeMRJeBGLKMXN72Fu+2MbWq8E
	 sZU2e1NyPrq4NXMQf+ioKQdoc4q76SthC4j7RwRdDnJAerJEy2RcR7+P0X0wCfNfMH
	 SghwSPdTYR3/wi7TCG3YAGb22pnfK+v7L4+1hye/XpvFnunND9I2ul0mymrgPNjFgO
	 IS4J/v2P9GBiQ==
Message-ID: <sashiko-outbox-164931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-6-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-6-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:26:22 +0000
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
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D6

