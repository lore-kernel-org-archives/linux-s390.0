Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098863D8909
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033271; cv=none; b=fMYbmVy6a7L1qcCTtwWDjVeLW5EEpti88AV2IsKXhjgRsPv4wxtQikr2AoySWkN2Nmpd7VY5zdKnTA9w91qPzKW1bHOrG8l5MQ3MRPstSzwGdwYQ+p0dOVERsuAv1m58QOUeFXYB1KO+HUEA25fi+6AZbEk2SCOXxR/IzRast2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033271; c=relaxed/simple;
	bh=Ll666bnPUk4exAELmQS9ox26Yzukrj+5pxyRF/hNlm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gp06oPwxeflP9owAfRWn1LgIKIYrNd1ggCLLBoFXyJJsVJK7LQ+22qtbbg7IRUtH1yvk+kOVBQUYLptSuh4p486TBPefSMizTtiqlQpTbpsWMrfpc47xcSG4xJcPv26y0d89S6VbMhNIG26/3u/nmAFEbyAZjpQGSPRh3K38LrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIjBux3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIjBux3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1EF1F00893;
	Thu, 10 Sep 2026 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033269;
	bh=Ll666bnPUk4exAELmQS9ox26Yzukrj+5pxyRF/hNlm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UIjBux3smXXQ+jA+OD54fbNnOFM43TfG6+ixgbcYm2pAr3u+ydcSm+sdabXJ/ywmb
	 Hn+nFHcpN8BU6JfjPlNphX5TrYvMBGJYr10TjJPaWc57/sf3YU5/BZE0rdWsSZBJuK
	 OqmEoBz1Ciae5nOcOtbLn5XlgowMiXWMtcrGlDHuejqPClLN5eYt8gCDmNyr8icVs5
	 mvi6hkt4bhjvz0ihMjpSRva652t8bUk5NUR3WHCZ5nqmNbjJbnEWFPlqIfYvGhQRdP
	 uXpJWyYWSgj3xDXm+9wZx5OA++F20A5HyA6Zr+4ao01ktxhg1CCkWnqm3q0fs6dWbM
	 jJKqPkQXKvztQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/cio: Fix cio_update_schib() to not cache
 invalid schib
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineeth Vijayan" <vneethv@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260910093205.3357827-2-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
 <20260910093205.3357827-2-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:41:08 +0000
Message-Id: <20260910094109.3E1EF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When pmcw.dnv is 0, the contents of all SCHIB fields are unpredictable.
> Zero sch->schib in that case to prevent subsequent code from making
> decisions based on unpredictable data.
>=20
> Reported-by: William Bezenah <wbezenah@linux.ibm.com>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910093205.3357=
827-1-vneethv@linux.ibm.com?part=3D1

