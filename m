Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5134104E;
	Mon, 22 Jun 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149409; cv=none; b=Ldn21rMne4lszFtW0IVI+YPd2BZIQzI8nBkWVRVKOgqyqV5cM0/9X05ubboF/fJm4Z3JF+kXBJMW7joLkVhPlEIyf7cI8lnSH6a1PDffMSS90V3gBe1cP+JklENOXNvsg1qT2ruxnREF4d7ZAdddzKKO67V/M3KilKwKEAUE0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149409; c=relaxed/simple;
	bh=5UiDazcE9ddbEUPtI+M8jlJ3AqxN/bl0tWC+HdRplfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V3oeoS6iYoEzUt5kYtMjry8M2twRKWQ5snQreXLFtObSj+moLuy+gzy0hDoE3/w0b+EKBeOGTCrb198fNq7T1uBLU1wFdCPFxofanGGCiyRaS0esSXHmsLhyFa5ls+oiuYhmz8IswkcYGYhSP67OCvgLgM1Oh1QbQt+La/jpy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6ihyyY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6ihyyY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FC01F000E9;
	Mon, 22 Jun 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149408;
	bh=5UiDazcE9ddbEUPtI+M8jlJ3AqxN/bl0tWC+HdRplfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6ihyyY9heQYNxHLLydZ7kH+PWouoLv+f/3+D6Z+n2IgAzndWUblx6KgBJdZ9q2vp
	 k09piucq3dmH+qpPDyZLSsLMq5lJyzedEbdiB5xKjKqgMvQbIyh2tHQ2KX7PXwk+KE
	 Hx/72CyxgzyKAaW6BbwKBqy3fUIfrJJkxBjQjBjbVsj56JVIe8dGrFCOaJD0MGtt9G
	 mSe1s+QpEQXmQtO5u0Cn/xQyJ/mjF+M5swxk7ivvX+Vr5X69rRgKLKnFUA3PwarLe9
	 7EMi2fzYD1dF2a0blj1sZDKYpKu7GjQcq2qAwMh0WOgr0RW19/Bvi9/kn4thYWTV/8
	 CglogzN1PFicg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260622171840.1618-5-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:30:07 +0000
Message-Id: <20260622173008.25FC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The current MSI-X restoration path assumes the Command register Memory bit
> is enabled when writing MSI-X messages. But its possible the last saved a=
nd
> restored state of device may not have the Memory bit enabled, even if a
> device driver later enables Memory bit and MSI-X. Attempting to access
> Memory space without Memory bit enabled can lead to Unsupported Request
> (UR) from the device. Fix this by enabling Memory bit and restore
> it afterwards.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622171840.1618=
-1-alifm@linux.ibm.com?part=3D4

