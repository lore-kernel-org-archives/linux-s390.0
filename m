Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52C4D8D93;
	Thu, 17 Sep 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646599; cv=none; b=ndIL94rWx4AWeIDJThJDe2QEguHUC12ccTTTg01GZkEta3oC9/kdu7bvbaohILCtMzFPSCxQz93QoJ+F9i1uiIZ1vD4i0BONm/Od4AJNzerqQG8lCEOGoStCL5Iu4B04fuOsMPgu2ean4QgwuF9PdFRwAtinNDsX8Wmw9Uexj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646599; c=relaxed/simple;
	bh=LapwlMG2g2Dl414Qj3dCYAlDmJxtugxGPPOYnMVAWT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Da/Yv3rd/4/0GkObtt/XDhcmGIgGIajicCay1N+noUiCw2YYClCx73RhMg7ve6RCGYEu4Uq6i9zkRPBr5lHz7HMJTpjnKtzggTo5KdMgmPnwNeXgb42t89SIQkUTKLEammI0TjRqT9njtsDwGBm7dEAie+mx5MEtbtkV0FIswmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9jANGYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9jANGYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF141F000FF;
	Thu, 17 Sep 2026 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646574;
	bh=LapwlMG2g2Dl414Qj3dCYAlDmJxtugxGPPOYnMVAWT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9jANGYNNWY+tkY29g1X4JHWmDvpZYp4Qjkf0Ys8IoINvINpjRtKc8CJh/j1BnJil
	 OmU0Xm7FkcW8ivHoWWxihjkPwkHlswe29aez5t7YPSyzmJoNOHSbyMrCzhj5CgONob
	 EvjDNefK/tNLJuFvZ09Ej0BPElseGIRBoiC8TPVy7dq7DClQZP/JyxYiQHhTVdR7iw
	 6e1KbwWtavH1+CKFB5m5082e8D8+HNi+hil+4iEfQh2nYCUPjy1e/hQ0TUq5BHVAM8
	 tRZhrwJw26HKDOPIIhGvvdtPEXOMv3wkCVaB5mseDavA9k3fivsriSE7zWrVHFy0RN
	 DNBMr8aHaSt8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] KVM: s390: Fix UCONTROL inconsistencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917115340.126628-1-imbrenda@linux.ibm.com>
References: <20260917115340.126628-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:02:53 +0000
Message-Id: <20260917120253.AAF141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
> the tl field was set to 1. This collides with the present bit, which
> means that other parts of gmap would mistake the entry for a present
> one.
>=20
> Refactor the code to use a different combination of flags to indicate a
> mapped but unallocated segment.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917115340.1266=
28-1-imbrenda@linux.ibm.com?part=3D1

