Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E5360745
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302106; cv=none; b=SodgKWDz5uNnd4dEDY4S8IkIKFPMkTHL1xnsK3MA2SRnwCRtEXjKnO2X9nPFk5UHolZ4XuFMbcSqOFKN71tUIwVc3tQ/BYm4CuI5arm+6q8zkM/bSkwbQfUiBGKQZH9/ndmhAFMcYtJ2KewMj6LIqF9kiCIE6LqXhoZAXeroJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302106; c=relaxed/simple;
	bh=S6i8QAavZiPQCf0DRDgmExRedGE3G3MEWqLN/xsgyqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oGaL9BNwDuyKea5+XcCDt1zBQxiCab8iWfA1H5N+6CzDcLyXp40Jw05RVUoLupJ9o2RfbSz/e8Qf7GqNyOOCRBR1yCJ9zyoPnJRjIFU2hls9nKFlH/WovN087qrhjVACJoV2frVdh8QrN3GVlCtjnVrQ5wvz5L1C6IIF04gmLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baFWq5Of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baFWq5Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CFF1F0089C;
	Tue,  6 Oct 2026 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302105;
	bh=S6i8QAavZiPQCf0DRDgmExRedGE3G3MEWqLN/xsgyqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baFWq5OfP+SrN4zG169y7BnMMYPksnbY8JN4HlGujj8yqhKX+w/fOPUqv7tb7UcAR
	 7mf1XVNpEKFbOfmwAQeds1K+hDYnqrSqy5yEgwsY9Ctg2HsiqlWF76gclgSQcebqmY
	 jM9LF4qHvx/Ucb0GNizVTYbutQ5eE+TV/yIBTe/h9OJ28CVkF9av8nK9glx6Bqmn69
	 bcfQCBTIqXxc8pCUoiJjCVF+MyNCZ8ovQdn2sm5ccoxOQZgUj+EttMzzP8qz44J6TX
	 xa1dvbG17MdADffuyrqlJYvBNpYq+0ZxzLAetdrfoHN1yKSSufzvocyETUWLKf5UG2
	 1XvQClrGanbSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/zcrypt: Guard domain index uses against
 speculative bypass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261006154603.9699-2-freude@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
 <20261006154603.9699-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:55:04 +0000
Message-Id: <20261006155505.34CFF1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The previous array_index_nospec() placement only covered the admin
> permission check, leaving ap_test_config_usage_domain() and
> ap_test_config_ctrl_domain() in the CCA path exposed to speculative
> execution.
>=20
> Move the sanitization to before all permission and config checks in
> both the CCA and EP11 paths. Hold the sanitized domain value in
> another variable so that the later use can choose to use either the
> original value (subject to speculative execution) or the sanitized
> value (which may in case of AUTOSEL_DOM reflect the wrong
> value). Before that, check the domain value to be either AUTOSEL_DOM
> or in range 0...AP_DOMAIN-1 and return with -EINVAL in case this check
> does not pass.
>=20
> Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility=
")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006154603.9699=
-1-freude@linux.ibm.com?part=3D1

