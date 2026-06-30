Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE13AA1B5;
	Tue, 30 Jun 2026 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840438; cv=none; b=iBN7vjuaxvrGxebDpDOBResQixp4wHdMbCnfXcJQSXI4ThY5R14UmiZRShwHRJmd3gsg+xqXOCGMrGD+8ROElh3HLvaHHDw9Gt91pjVpFGm7HjKCxKGMWof6AQg+mfOSo0MZJ+2xn6qe8Ec+kyQHG+C4ByNaNukgOSiXnmjgNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840438; c=relaxed/simple;
	bh=ss2fGP3mjT1OY+/VMSawSf8lqidO9w0vy7lhQdI3bMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAuo4Pe9PoQsG0qJHJ5AMWRj9t74G9eSAMNsyymM3mWPIccVEgrWF891B9Wk61u7KkotBjMhor+W89mrTeda9hEb1AInrRpY5KAikImuw5E6oTxoaYsdrS6yz4qZRTw0B6QVMl5FkI2ph6uFT69hKS46biUqwdj8w4asxARZfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQY3qv43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQY3qv43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C2B1F000E9;
	Tue, 30 Jun 2026 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782840436;
	bh=ss2fGP3mjT1OY+/VMSawSf8lqidO9w0vy7lhQdI3bMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQY3qv4378O0uHaGupWP3DTvLJS+0eQgmrR4EuoIXIWInxqiKznJnKY31qa15AUHc
	 pJ+Ine66RssE5WFv/xgNN50H9PcwCHQPgpJ8ztYPyN3/G0pZliW87oKJ1O0KibjF4r
	 es6AuoEv8PbvMqSV6eNLo/n64WLArGGTMgQAfTjm2hWzK56No1pOyzUQlJxXEUpa5l
	 ze9BW3Ai0M00qV2fcRCvWA+DX62V8Pk2RrlY+XtNJJF6AObcf46MpObZcgtX+dzM3p
	 +OF9WgTuiepVzCnzo/qXCE1ZnYjb0fm0iVydJOXgLwqWu30buPZXN+X8yVAl1BrcL6
	 74zUisvJiNGoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/3] vfio/pci: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260630165553.725-4-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:27:15 +0000
Message-Id: <20260630172715.E6C2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The error signaling is configured for the vast majority of devices and it=
's
> extremely rare that it fires anyway. Removing the pcie check will allow
> userspace to be notified on errors for legacy PCI devices. The Internal
> Shared Memory (ISM) device on s390 is one such device. For PCI devices on
> IBM s390 error recovery involves platform firmware and notification to
> operating system is done by architecture specific way. So the ISM device
> can still be recovered when notified of an error.
>=20
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D3

