Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975F39D6CA
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171034; cv=none; b=Prc92X1MfoqmybzyMSAr/PAqQyXE2KRdOM9ApdiU+yAJa7KSQxVuh4AakfF66HzoCDdgNJj1njVrQcS7TNiJ2TyQHUKoSslIOXPFAu0RssqZzqz1QSVJG+2ozafxkUB2OWtcPPTumDyVNMmu2/JatZ6G59QhsysIFRNktVH627I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171034; c=relaxed/simple;
	bh=5QU9t1Ps2ffUxa8X6k0nzBF3xo2Ml86zUTqIoVDHxiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uDSnNdeZvDTDM+ArpdSqij8zuhK4g9h6EQtEhjdepV4JBjhWwxYsrfEcz9xScDUyvJurEjtmnQJHsDF9KBVNgkgHuR/Q09twlUUmT/PDRynZt+mlbNMTjMJ4B0K3uvWZu9iWFFM1Bo82LhYPw2X2HLidRtFYG9zcdRm7cRu5tdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kir4aL0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kir4aL0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311401F000E9;
	Mon, 31 Aug 2026 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171033;
	bh=5QU9t1Ps2ffUxa8X6k0nzBF3xo2Ml86zUTqIoVDHxiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kir4aL0UfvpaDK9Gb3JxceTlHxK7D9+/O+TjzI2U9m+Bq1c0f75hJl7pt/C9NNlJp
	 LyRMLA5o9DAgS5TWvazo87rQSSk+skJKvElC8y50aSW4UQkKsAQaKJXhg0oCbfs8Ng
	 XMLWik0mfdWQGA0lUrkPE1/X3/8UAFUXsGxtI7o7DKRTKwA6ZyDnprvYCNRIF/U4ua
	 68YTvmb5WhcXpMvxSGHvG4cW68sUxlGtOowcIgJpGzO2+1yiym4dsDKcw3uOOTQa3R
	 h5OF5f8TimpM2qphnjtK9db2pkpn3ZCsqQBx+w+YU3zD8e9dTqc+dgPEzSg2H8rgyr
	 rNZH9iHxXwUGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] s390/crypto: Map EBUSY to EIO when key
 conversion fails repeatedly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831083838.3703-9-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:10:32 +0000
Message-Id: <20260831101033.311401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When hardware persistently returns -EBUSY after exhausting retries,
> the error propagates to crypto_finalize_*_request(). The crypto API's
> completion wrapper treats -EBUSY as a queueing status and swallows it,
> preventing the completion callback from firing. This causes callers
> using crypto_wait_req() to block indefinitely.
>=20
> Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
> proper error propagation and callback invocation.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D8

