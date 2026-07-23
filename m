Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3E339844
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796674; cv=none; b=jn4SXREdDLZwqf2uKQxyd3CBc0G3kuj9H9Hf12XCFQGA7NosehEzWR9+a9eECz9gy+YxWNtR30Mf/rKSRJiglmJ0izGP6jYUhtqegq9e79N0URhzvaQsIqxNb489o8nx9cqS/POq/29Lg2+yl0lwCWq2Q/UiFK8HgPtOQd14RXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796674; c=relaxed/simple;
	bh=WswRbsCq89D/PNNWa9g64mVyfMpa72EfqMPIDkG0kxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCy7enhdrbOOmzMQOLCdrxsC3R8ikt4o6GvIzmxoK0qmIKzyyUk10GjG2iTogiTlnChtCq66vLqcqOUo85/ntw/lwodnBtsjMqkUPemJQg+IPmsgj/rjueHAqgZsegtncGLFYRNKtGsOGS+mIBWhSrPzgAbO1iJ6Huo8ICAp/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1yU2N4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1yU2N4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5281F000E9;
	Thu, 23 Jul 2026 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784796672;
	bh=WswRbsCq89D/PNNWa9g64mVyfMpa72EfqMPIDkG0kxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1yU2N4xsl2WfyKkwRmyXRp6ZLkIlCdkrbzux3ViAwVqzLP9vfnfkf16GcmRd4jzW
	 jW2opb25YYSvjXbagh9eTDRvkT8wYkhfsoEDRWPIjapf6LbE6Pm2dDfVF37zBGFZ1D
	 fHziY/OJdEtNY1UzOYyprkWOudmcwixaPSil1W+KyhUyrDovtehGzv/qrYujrPKOSh
	 6C9zzQOP8AXsghFJxKLQI2LtvG7b05z38++juA72LLJm1fOVkcoc1OPAjmc75kq2Da
	 C2lwM0cqEBwUGA43mVC2LFXbUq3Vl8Ho2cBpZMvghF9A37eYXVoECBbkqTMO+l0srC
	 bMi6n9H5MxMeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/spinlock: Add contention tracepoints to lock
 slowpath
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciunas Bennett" <ciunas@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723084229.923353-1-ciunas@linux.ibm.com>
References: <20260723084229.923353-1-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:51:11 +0000
Message-Id: <20260723085112.5C5281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instrument arch_spin_lock_wait() with trace_contention_begin() and
> trace_contention_end().
>=20
> These tracepoints are used by lock contention analysis tools such as
> perf lock contention to identify contended locks and measure wait times.
> Both the generic implementation and powerpc emit the same events from
> their spinlock slow path.
>=20
> Place the tracepoints in arch_spin_lock_wait(), which is only entered
> when lock acquisition falls back to the contention path.
>=20
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723084229.9233=
53-1-ciunas@linux.ibm.com?part=3D1

