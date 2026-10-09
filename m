Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988094457D0
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527610; cv=none; b=n5yMDsL+OYkewU8wOqMB97nawpHjrDfqRci9QFTrQcK9QmM/lqn44UoNqwaSGqiMwQMXDw7iTq9eLF3uO0udlpCxH1TLgfNXZUQfR+lbNttVENB3un+B1W0favOX7QgK0Rx1Vr1sg3ht8ZRhI/uR8E1Pt3oESk0w670EYqTkHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527610; c=relaxed/simple;
	bh=jinp212n0IphJzcKHZoLaKEQJR1NfXKwCh1LcEHNjMc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kODQy2d05QR6wppueyU0T+Y3FVUIaGtZnDxEUWw851qQ/ClCqeIQWuNlb7rA33L38o1X6+KaUD0XqczRjmh5Wm4buZawVpCwyTeUpkSaV4jLdU7A+MeTyt3aRbuaMNlZO4Luwn8QWj5HBiUK1PF26bz9gmyoyi61Zj5Gsl032Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozAuR6+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozAuR6+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1DF1F000FF;
	Fri,  9 Oct 2026 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527609;
	bh=jinp212n0IphJzcKHZoLaKEQJR1NfXKwCh1LcEHNjMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozAuR6+YvG/zonfNsasElRHKkM2NKJqK7yNjGF+KNluVZzk5oWp8Ief2dNCUI1uX8
	 0nB0H4oGelJnKKaQVSTCBa4bVuCF5QblUmY93cBlma8K0B7qWA+At9FBHW1x66rNwB
	 vfNMBXJIMtxkI/3dvfTRWpYisdFGzaur1sKQ78c4Bqo6eDWviV0+dGmxP+5w+vVa6A
	 50SuK6IH93WLfltwOWVhqXm/jfGiB3Hgjh++uAa+qLrmA+k58zbXaQDbg/2TgInLcq
	 8JLD9r9P5EWo6leddJc6bwkE6ByAx87e4EdXbfCuaC9XezMKSi7zI1pB4L3PdKzenG
	 Pin4w9z0Z4tjQ==
Message-ID: <sashiko-outbox-164949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] s390/pci: Fix MSI directed-mode teardown IRQ bit
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-3-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-3-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:33:28 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On s390 with directed interrupts enabled, zpci_msi_teardown_directed()
> frees the platform's maximum number of MSI bits (zdev->max_msi) instead
> of the actual allocated count (zdev->msi_nr_irqs). This corrupts the
> shared IRQ bitmap used by all PCI functions, causing lost interrupts and
> heap corruption. Fix zpci_msi_teardown_directed() to only free the
> actual allocated IRQ bit count.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
> Cc: stable@vger.kernel.org
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D3

