Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBA415F15;
	Thu, 24 Sep 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267680; cv=none; b=iMKGqQRZ+4Ki62MV4wzbDroMh+eVn83Njvcde9v40SKemjrktP4PvvowolvUQqR6td3EhSIpSBdKJHD3K4T+rqW9r+esMug+ce3Cj1p+SEL5Z6DqogfnLCbgzVZGMWTrIoujHC+c8X7rHIUuxHv8r43DCRgitJWoOYOOXU9Yz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267680; c=relaxed/simple;
	bh=JWWjajoKKaZ8Si6/0f128se04N0OYCtGSb9K4RUbsKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oUhlruX60qRNbxnPncXvWsIjUvsOa1nFLTLeZ46AEBEJKGWb/fUccCVpU8+bivBoyew2LMHJ679zeMmcJptIY3psOJJ9X4jfMG73kgtPs1xOaKAatFR4fgQdmihi3ceToIZ4DIM6ZaD/DbMVydIhZXxhxrQyIAcpLnXcs0vKDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWa4tg2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWa4tg2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1721F000FF;
	Thu, 24 Sep 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267679;
	bh=JWWjajoKKaZ8Si6/0f128se04N0OYCtGSb9K4RUbsKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWa4tg2HopJFZ57W3h3ATvxcTw1J3dnru1bEMZh5zc3G3pIGO3LHW6slUGljdDpJs
	 jGZPBsXnJNwNCIU1qy1d3Te5Fc5O+m8bhwlWGj5yL+N7bLoBKdEK9QvhmKCIbcw06W
	 5DtWwHNxVaryQYbQ+Y2+sjs2poZwpPgy0FZOMfT8dNcCor/siPzOpupkXgnNY2tdpR
	 Ov7I8Q1WJtyhyW+FLbs9Qzj9I2eeUoOhp9fL5uXHmTLXtj/tgN8MBbKs9TqEqiHdZV
	 k9Ar/jI43pU0p7PDsuGE20/VvcrTI/QkimL4piimfpalStmyU7bdSyV/4rMY1GQGSp
	 z4YE0xQnwW/HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 4/5] PCI: Provide lock guard for
 pci_rescan_remove_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Block" <bblock@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, intel-xe@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <33e55a5db13f7ed16234774803e8f0ec03ae8c5b.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
 <33e55a5db13f7ed16234774803e8f0ec03ae8c5b.1790267348.git.bblock@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:34:38 +0000
Message-Id: <20260924163438.9A1721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Make it possible to use guard() or scoped_guard() to lock, and
> automatically unlock `pci_rescan_remove_lock`.
>=20
> Since the actual mutex `pci_rescan_remove_lock` is always supposed to be
> taken and released using the functions pci_lock_rescan_remove() and
> pci_unlock_rescan_remove() it is not possible to simply use the already
> existing guards for `struct mutex`. Instead define a new guard
> `pci_rescan_remove` that will also call the functions in question, but
> is usable via guard() or scoped_guard().
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790267348.gi=
t.bblock@linux.ibm.com?part=3D4

