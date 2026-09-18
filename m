Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69372502546;
	Fri, 18 Sep 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744591; cv=none; b=dm19nd5i/OUOldHLP6WFP/7cGslhtU3oKr3TWIOot1KlLkglZPTHWqSITkMs5XyN40vm3kF/m7vL4qyM35gvQgA32SXbW5x8W60ENmLTW3+vL4Uglcyv9RL36yOsrDQz+AetfN2Nxz6QcTChhPJSvd1875svYNGjocYZQutdOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744591; c=relaxed/simple;
	bh=Yz07jNdqc3NPVSjw/+GveW14FMVDGh0jmfIMaMntQMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=amxwadJ4TJY5l/kQIMpjD8T0lGSFj09kdeHrAWZO9sJ1cA6DfBoaaY9xZqS3Y6AOyGgkyX/JoJ3HY9A4oOOQIqyG/0SEhT4l2YcaTMvBRaaoLjci9LgP1NUzB0zmdJeyFVIyC6DfjhCuXsXRNXV0tN14n99ItVrxTDDariljWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrGCxR23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrGCxR23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1D71F000FF;
	Fri, 18 Sep 2026 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744590;
	bh=Yz07jNdqc3NPVSjw/+GveW14FMVDGh0jmfIMaMntQMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HrGCxR230oL56V5zsPGTOPsuuLbQ2+lpHq6S3hTzy0DcfIeWehA7gaWLmCgiNcC89
	 LiFeMQsTT6y+R3DnNPMCcx9/M6LtHCBFPjkHxNN1qEIRduW+4YSyWC7R5FmEFcmOZe
	 t2fdzHbRXVWZsTO+fTcMEjY+gdbtfvZSKoXQFMJXDgZ6GalpVdWzxHLbA+Yi10Yb1i
	 GVkaJgc3aP447ysKULnvdrClrdBIQWC60tdfK7b6RnTRggrXAxY/0EyhwDmtprwWza
	 bOFrTkzAZxb3REx2AG9Rgr21HQJY9jxUnCziiSDp9oBQ1mgQRuYmneIKUKRFjV8LJt
	 K7zKRWXqMgujQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/21] KVM: s390: vsie: Move release/acquire gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-7-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-7-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:16:29 +0000
Message-Id: <20260918151629.8E1D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D7

