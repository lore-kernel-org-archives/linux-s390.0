Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10972475D0
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171284; cv=none; b=Gob9wdHIh2OrN4fKIvcqZFgv/c8PYXYLi11LhPbNNyXbpxe2HCtFvqMoLhuOIKZSrOLpEyfSJzpNQUJ9xdcr30dkGB/cpJLJqMFcbo8y1+FfP36BKDJ8+gOy/pTTuFlJlsdlSiWM/omXEs4IBtib3IPevr8ZVuceplr/xRILi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171284; c=relaxed/simple;
	bh=aPQii3u7oRASDQ5j3/QfGpi++qeqmBLrTTV0wjoTMAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYUHmtVG5Vn0FmLTn4AMSz8lU8IJOPtUC6XQo7nSoOY8ymYW9IIcSfKEIFtS/vw0kv0rL2yeSrWGJJUtTm0+PVzHnVxQAlhDzSx6/eWOxweowwa1L4kGS/3tJDH5R46f/t3zi+Pkg6NwhnnFzJthCjBjlmH8HUQz1du4hnr45ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2KNLIzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2KNLIzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBAE1F000E9;
	Mon, 31 Aug 2026 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171282;
	bh=aPQii3u7oRASDQ5j3/QfGpi++qeqmBLrTTV0wjoTMAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2KNLIzNMUGHgCVg91H5V4El+X1Rc8nXbzRtU8cN/r5h5U2b8OEeqIfEdeRjvGfer
	 eZE+HhkvAKY7erNKHT2O+rkX8n4fJH7mOufz+jfr9iYlzg1jPZhLIeStyn3x8KmbgH
	 uGa8ATT82i/W/346Rl29726e0y3JuIqAO1Q96PxKY+ravx4F9kncAvTv+qN6LUHdWQ
	 vStsEfWb+RgWcZ6vSTV5xpR9ht3y9WicddF9H57YTXXMjHrUpXKd4w3vQ+7Bifhioj
	 qqo0K75+iePb3xwryVFK1Zkjdmkaa+c1UG9hwH2PwqGCcoPyBvpqnB4//4wXbfgDz8
	 Gh51rK28jbSqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] s390: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831-arch_do_panic-v6-2-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
 <20260831-arch_do_panic-v6-2-a1e170a9e7fd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:14:41 +0000
Message-Id: <20260831101442.0FBAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement s390 specific arch_do_panic() instead of using s390 specific
> ifdef sections in vpanic() code. disabled_wait() is now called after
> "end Kernel panic" marker.
> No functional changes.
>=20
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-arch_do_pa=
nic-v6-0-a1e170a9e7fd@linux.ibm.com?part=3D2

