Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C8476CFE;
	Wed,  5 Aug 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949643; cv=none; b=PcoIxyAqqMv+nX0NpNocV/UFLsMVkm+yd3u87v9BZmXkFeJbukr7aH65rqIaNz0jDldqf3BB99gMhaxfGlTVnZXhE1BsFEDJzgFMHfZJBiqgWY7tXH3Ph5ru5PDbGo+Xsw8kvBLSpgL44og0tSzde/8BSS7G37JWS9DVlPermo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949643; c=relaxed/simple;
	bh=Wfa8QM2Z72uO1Y+CjUFyiu9FIEURzt6NqKY9qYb3BPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ocDFXZ7Is1wnD7s3XtHadU1qwMYt5MLDRnOLJA1XdeITSgXZOOq0Jhb+UXdnm9LPK4+qL4FB4//Pr17MhvinDNTs/6EyUtZfGFGo94B8l1K5XLnQI/NlB4YPo7hXuFEN2n44Yk/rFR3CDNURAlAanNnZKTYb1cm3iwGHlXlqM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GysQv5wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GysQv5wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EC01F000E9;
	Wed,  5 Aug 2026 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949642;
	bh=Wfa8QM2Z72uO1Y+CjUFyiu9FIEURzt6NqKY9qYb3BPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GysQv5wthmQ2nUANj1Xpu8jUDHSHmqV2tRj94SzHjM4PTZWpCSAaaGXX2wAiHObaZ
	 Qk+Jqro6eKD4Dfz4riTcTX3oOhHV+UhoRMIc84YvuJvK+uYFWtCUUSxasMiA2RKkZv
	 pb8PueOzPwbc+J/LP/qgL6si7yKw5wyPXNMDE4ytkqlAKfQJJETiBDAEIaw6kXjESX
	 APtEjBLa6TEoOZY8N4yyOo0xTetVu/sP21d4ocxIKPqOE6ULDSPWyX3/utrREz+QK5
	 dUTX/4tUPFEd/ED6yEHgbdq7BOXb9ryxt3k8kMXi1852LHIn+QujK4fDc4nrLLTCUV
	 M9056rYxypcYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 1/5] PCI: Introduce PCI_SLOT_PLACEHOLDER constant
 for slot_nr placeholder value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805165518.794-2-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
 <20260805165518.794-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:07:21 +0000
Message-Id: <20260805170721.D0EC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a constant for placeholder value and update the kerneldoc for
> pci_create_slot() to reference PCI_SLOT_PLACEHOLDER instead of -1
> throughout. No functional change.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805165518.794-=
1-alifm@linux.ibm.com?part=3D1

