Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4C2C15A5;
	Fri, 18 Sep 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745515; cv=none; b=ejBEDf5/H74XJ+UC5NYFJizDKZRzyuDE/fckwURmnNinQe+jElXLeVqnAl/D+ZOZLe1r+17Bglg4SItNVzuNKUapTHGD3EQXUoIMftxGXDliY83EE7eSwwsa15snVuTTo3ec8ga7UzIZgyRc2iO7PT680xsHJICOwVGniB5S73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745515; c=relaxed/simple;
	bh=BTTxFT+qjxiGinniZAaCqgbzmSLm3GBK9djn2pgyTdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0TbO2SRRfeuODqbv+us9XPr/w4Kdy61Izn3L0KpLknGkVDXnURnF6sUUX4u9Mtpz35nA/GyOpvrL+kQ9OVrwGn9y04D/WS5Mft5aUa9RjF7/ajcQ+s7WRJZY057miBmtHSJz6R1xZe60iEQlo2AhRMeRMlA/bgup5+wNBAmk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxxhzhPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxxhzhPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20D11F000FF;
	Fri, 18 Sep 2026 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745514;
	bh=BTTxFT+qjxiGinniZAaCqgbzmSLm3GBK9djn2pgyTdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PxxhzhPamoL7jN538+xnqZ5xHhWjAzEbCzB2QjTalMqlqfQjkMTmiVbLF7Sql4hYZ
	 Ui3kT3mIH24aACyJ8bxDg0p6Vggt/CriVaVFWoCLTosPwkR1thqzvwODMN8FPemAKg
	 1SYCpls4IUgFEhGS+8aqs7BZx43zo6uUtNL2b/ftvaDyGcpG4nDvZmtMaF5Ogfkf2+
	 wJ0q5wi4kOe1pj+h7eZjGsxrWA4ZcttbXkTl1eTp5aP+gM10TVlzYLnHupYfDMGYcg
	 /jx49VGcD8DM+f5XvfehOpqbjF7pa6xNT62v3iPjr1wMLXIR8K2oVn6JA8Wcf8WpvS
	 MEB0kwLSr7lOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-14-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-14-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:31:53 +0000
Message-Id: <20260918153153.C20D11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To handle vSIE configurations with an ssca we need to pin and unpin
> multiple consecutive guest-2 pages in guest-1. As these might not be
> consecutive in guest-1 it is necessary to iterate over all pages and
> store guest and host addresses for later use.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D14

