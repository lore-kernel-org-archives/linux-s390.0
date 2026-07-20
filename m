Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBD3FC5C5;
	Mon, 20 Jul 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576320; cv=none; b=beD4D/d9n6nIs0Y0Pn8ZYkua1vQ9DRfpHxnHz9gbM3F/TZ19KLOS/bDj6eR2E5KCWPT4MKD7AnsyBODGa7GCdZUsoecMlp4VREHwqzjal4JmX0nxMXQ5sFumES4jxFz2AvSRIF6IFbW7fM0s/Payrm8xJcdtfsICUG0Jr1MxVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576320; c=relaxed/simple;
	bh=fJocJo28f0w2w1n0Q7hNTn0vFSVbNrPrgHkccaRLAFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YKw6oM2IlZob8hXpZaq5lvmrRFTU01rmMzjAr0KmJ1Ch+1j9vfIeCdS1fvCLcRSoaYkJOCmSehiNogSTTZ0FZD1Q/8n/9qGuGBYHVAyO8GhMfuW1KpRQuiT1ogbXx7+RbA40qvHvYLQzHTyNgfR7wbuVpNaRwgrCsvp9MQKXxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOBIwZ/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOBIwZ/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E831F000E9;
	Mon, 20 Jul 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576318;
	bh=fJocJo28f0w2w1n0Q7hNTn0vFSVbNrPrgHkccaRLAFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOBIwZ/ZqKiGjFjC24NN1pFBJZnLzS6Y1xVC5pLumCni7idGe7pyvUmcPR8o7zZGT
	 EOVxrHE0PBT9qy6UTazwoVHF0agCoHgK/N508a5dKmv/JAvpNM07r9O3rjtn3tkNA3
	 rXuBHMv5gZVDjXlLhbFkXCoVOdgkuDbrn/WGiPxGVj+Zd9/GlM+pIF8Fb6xQSFWGrS
	 C3nNDVqIEeQNE7mAILe79SHPoEQwsIBxa1mGOBEoshVeur/H9KoPUaP1GPcO/AOeSX
	 QLgg1Zkhw2jn7NCBQpEUcNheRmOkvj5XxlWddYHucumryoJgIrJfjoeGEdFZO2qUr8
	 mjkgjkLrPYhMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 3/4] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720192505.2957-4-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
 <20260720192505.2957-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 19:38:37 +0000
Message-Id: <20260720193838.33E831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720192505.2957=
-1-alifm@linux.ibm.com?part=3D3

