Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0214FDE48
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572180; cv=none; b=ATu0JaMxVAhx4nElTY/F8r6YzxrP4eamz19Wow6YmAzhWs579ug9ubX4O9Inx1W4rnsd7a+iY4xy+bNNntZrnAuBp8Wj0qPasGJLJ7Re94KK2quMuBm0Z4QQL20LOvoYzXm4gulWnWNfGspmKkH1Co/n/aJHtNVnZKnNet7YBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572180; c=relaxed/simple;
	bh=Y5vcu9wPQWdUwHrXqsIbGMB7R9qsAUjphTLj4uvMC+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6h8u5P+EcijsUgoXMWl24Y7lfwIpnIQKSP5QQK6nNB/1pNzLCGrREoxhx3+PaOOFZy1r8onMF8zdH98qKWMQrro1cJOVwoOV5YFqCjYWhEAw5y18LWSJ5QrXd8on8JZemyER0++Ctp+irT4ulExzCaRsVbEkrsjtqKFmoS82A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAmq6Xd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAmq6Xd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B08F1F000FF;
	Wed, 16 Sep 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572175;
	bh=Y5vcu9wPQWdUwHrXqsIbGMB7R9qsAUjphTLj4uvMC+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAmq6Xd1VbW2AwBPSV/Y2mhnyd9W6jINPd68kQWixdvNckla1BOSSkNf75W2EqE88
	 +TpSfvuKovU65rdNvONN7pyr2jTDeJjq6w2bZcMts80LXjgG0aFP6mt6KlQyCodDaz
	 Va3MwMXZycTqE6/Ls5CoKBUMAsVaJgxohtcpNtqpxal+M0TIN3HW/0tU6HwNIGf9uz
	 clHt2ibesSEJEPG8iCvaqyhI9Ub/1Kdb2uvueijtXMP6oVEEnBgA+RLc3Oi/6vD3bE
	 /UYwGwqdV1qTA9vg60p1zLSxWRtXZERLjyIK5y4FyrDZcBzVXxpuWP1KcmR7Ni5Et4
	 mKdY+6JWM4p3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference
 in zpci_report_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:22:55 +0000
Message-Id: <20260916152255.7B08F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In zpci_report_status(), a reference to the pdev associated with the
> zdev being reported about is acquired using pci_get_slot(). This
> reference needs to be dropped with pci_dev_put(), but this call is
> missing, thus leaking the reference. On subsequent hot unplug, this will
> cause the struct pci_dev to not be released, leaking memory and
> preventing reattach.
>=20
> At the same time, the only existing caller already holds a pdev
> reference. So instead of reacquiring and then dropping another reference,
> simply pass the existing pdev pointer to zpci_report_status(). This gets
> rid of the need for pci_get_slot() as well as the zdev->zbus check.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCL=
P")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-fix_zpci_r=
eport_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com?part=3D1

