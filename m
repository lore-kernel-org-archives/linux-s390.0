Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D7459AC7
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302861; cv=none; b=PsCjsRIa9XZkQMHBYxC1WzpppG2HcNS58hWJnOOpZ9TGLoul0ZuCVdbOtabhp/5zlTqsmsDVPHgBTIMTLRCqLLkWOfZo8pP2RTtdsyZEI6Wggngi5GaOkWzBUfcAzJj9jUtSQg7h+NfCsTtKISu04QB/S0oTqMXbORox036/Nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302861; c=relaxed/simple;
	bh=dKNHnWT3apvFbXEhhGbue7/f7MVhTCYRIViEN2DkeMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eECIpjiXN3cEOVbK6Dvz9fy2VtqKOYxzXbRIqx/Pnj2btfAvT46at/1gYT29nKtKQWXLeeezpntnGs/BzA2Mj9gppQW9SAjiZ2fVlFOqWwdoNt2OojLxp6HyXhivFKPjp9dUzMG8RPGuZZx8cfHqCwEplrq+hzjoNr7WzlXpM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye0PErM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye0PErM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205331F00A3D;
	Fri, 21 Aug 2026 09:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302853;
	bh=dKNHnWT3apvFbXEhhGbue7/f7MVhTCYRIViEN2DkeMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ye0PErM8V3SAToMsSpsvaZcTurOmTKJnFdQ6ibg+o+STD5RJxUs/Z2kAV6rhH87qf
	 aNGPYHPb+K4l+bLj828BzMrCcxcD760BCqMabfWYh6UU1ZjxRFlMl2Lw9Vxjj0HYHl
	 apbBvniXBFAgQY0wy9+OTbgg8xlIyz7bZdZtux+FPMf9YjpuqCi02K/W7WbqSmXPWS
	 c681GpwywJWFFJuWSCIfh9p2TdrZFhs3wf3sfUIHaVpd9OmGWrEu5ijbuTJTBMVy7k
	 8gejSfmlv79Q6XWJFWcTCgPvX8/AzIX9LS65PRiAbe9XtFt2NleviJy40zAPp1o1iF
	 PqCbCqftJzOvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821084648.23222-7-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:00:52 +0000
Message-Id: <20260821090053.205331F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a request is transferred to the engine via
> crypto_transfer_hash_request_to_engine() there are two return codes
> signaling a successful transfer: EINPROGRESS and EBUSY. However the
> correct handling of EBUSY was missing and has been added as a return
> code indicating a successful transfer to the crypto engine.
>=20
> Fixes: cbbc675506cc ("crypto: s390 - New s390 specific protected key hash=
 phmac")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D6

