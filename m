Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A38201025;
	Thu, 20 Aug 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230110; cv=none; b=a5LrJreIVNiz4OxRVD+3RAG2LNqGDViP0xRdiXqKDT2OmIsFkCYns8jJ9bcn3sfnEyg2MDVr16b8VLmDm+rA4ald6H95THemFuMJRk0bIgNzTFevmNgM0tCSTyPmbUARUh4qQWtHb3f0+xW6U4aBckcRZIVvZoiuYaJLm9qqo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230110; c=relaxed/simple;
	bh=QwW4C4O0heaMlMi3xjHodC+NHXBx33+phpCRDs7nFIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S5fH6IO3L0g1avV1xwB3Bt0w9ZA7W6R88fhhILiB0ykPkaBAyzlrxlTWArfGafxEzQdUL89ANUuc4cZrLOWh0gjrL2NPUx1Bj7+OIQPXyvJAX1IlZBDDLmPjrV35Tb21OkQ+anbBDsH1ZTwFlSQ/8WKx1wpp+cLIhTPF5Y3C8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okZN+P//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okZN+P//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCF51F00A3A;
	Thu, 20 Aug 2026 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230108;
	bh=QwW4C4O0heaMlMi3xjHodC+NHXBx33+phpCRDs7nFIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=okZN+P//407PfXJHwbVGKNF0W/hPdh+wXyz72kHK0H0osZb1ozAAZMgaMNj2s2Mxs
	 HMtVk+98AqgwuHKzALSjdVL5so0gsrTlFBy3FrOxvOu331xVkwIWXBDp9VFHAWLhHw
	 qdXb23VITUzTeBcynBKJxJsHrYZIw6S/ZDbqkHLs1TMS1KSuuL3pGEt9G+CdVgJ/w0
	 MRK5kL59C4TAxXiBDtKE1A8jP+RfFYJEWX4KVwoIl+8zpjR8GQ6tGwYQ7+xyA7/dgj
	 ZSjAoIyQOABsRwugEjcVhRFdyzS3yUeyAix075W0Oi+WrvOp66KXz9Dtz9HjFvfVib
	 MHrPnHmKZttDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: selftests: Add IRQ injection selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260820123728.26284-2-frankja@linux.ibm.com>
References: <20260820123728.26284-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:48:28 +0000
Message-Id: <20260820124828.7FCF51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Gabriella Seifert <gseifert@linux.ibm.com>
>=20
> The IRQ injection selftests haven't been added to the selftests yet so
> let's do that now. We start off with a couple simple error checks for
> invalid data.
>=20
> Signed-off-by: Gabriella Seifert <gseifert@linux.ibm.com>
> [frankja@linux.ibm.com: Improved formatting and wording]
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820123728.2628=
4-2-frankja@linux.ibm.com?part=3D1

