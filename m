Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751862D3A93
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202534; cv=none; b=Ewy4uChUUWz5XqtED/u08M1IxXjOsFG5xwmd8XOQNLUoEbuIJ4/uxDemAxCFz39X1vgwrr9OMacigVAn4Lag8hNbcm2cry5qUE3tZ1xHfaFbCqsb28qR6l9ymytlEuYRORAc02+G/i+BYfo7Wj8P3YGteKbZvA1EFpLXb0yKraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202534; c=relaxed/simple;
	bh=MIkokVhBIPffUAY0yBSCqOJk3cMzmbEafwp8Xx9dP+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH+7MiIh9Rp3st7DQLSBTlb77AExKRW6kDa4+f6HWT+7rNMkE/aKvx1fkcbNaDKUjI+thDl8sViukjLyCcR0SOXrgu8w3mPOKmt/oCDGiOWShtptl4DsUOFWx3QGWq2rblT7xvIMysqK7ZFDjfhGdRAQpy+Ii96yeH8J4nEhfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrwVT4yU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrwVT4yU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E581F000FF;
	Mon,  5 Oct 2026 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202533;
	bh=MIkokVhBIPffUAY0yBSCqOJk3cMzmbEafwp8Xx9dP+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WrwVT4yUT50tF3+c5hBN8lDkks8pcRPpRrwdocO4y/I2e4Gs3iidrfOZSWOUlhYQK
	 2IzN2s79CwhRKuUBdbT3ckRJBuX6u8V+X2yfJYwVCO+vtULcx7E+l4FJLcHuu3pj+Q
	 Siyl7SeedOcL0E4wAW7Tntng2ER0+JrVDBFrILZI+wxRUFdkHSPqn3DH6uiQ3kzqJ8
	 ZXN4gs+jyxqHEMPXqKFOuX+nNDVVh0zzBgXAlOl+GwvK8j+bMfWV66gPUh14Ppa72x
	 oWBFsHAyfngaY8FORyQXx28mk8mmlWaL0U3lDO+WYvK6/fDw/MO1c5yVaPpQ/6LVLS
	 w7ZeeMrukVt7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] s390/pci: Fix MSI directed-mode teardown IRQ bit
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-3-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-3-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:15:32 +0000
Message-Id: <20261005121532.D3E581F000FF@smtp.kernel.org>
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
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D3

