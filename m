Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBD4BE432
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006413; cv=none; b=l1Nu5zsRY4d/HX7CddDhn3o1Gd44F4/irpfIOfu+udNlM/TY+t1nnQWqlBc7OPO3mg78e50aTeskvrk3vvzJky+N6vG6OWyJcMVOuD0o4KWQpcjfNyRKO/aNUjcggQKJ0BHfa9J55UD+tnFTVcxxg6CGhcMe9Qp6vGZlyM8peDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006413; c=relaxed/simple;
	bh=FGL797UTWpo4KUJIY3tzwguPH7fF5wfKVzM8tP5I5BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgdNsA5mA7/73FcKE7wUYppFAiUOOhsC2TdhMTv4o8jYbrZK1fEXJ+Qic4BydrWA9GDe4Co8et+o7tyPdw85lQYMJmmc/IC4fB8LB37c+2wNAHrqb3STS9tdWF7jiMX09V978MJxRHK6pWp/D6O0l4hrdHI2UahcSrPhNNcy3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR/KEH6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR/KEH6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5051A1F000FF;
	Mon, 21 Sep 2026 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006411;
	bh=FGL797UTWpo4KUJIY3tzwguPH7fF5wfKVzM8tP5I5BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HR/KEH6+S9iZ46Eq7mmNxAN070X+xk0TTVsDoazkl1olTl1VOjDtK1EgKIUMZt6op
	 y8sveErkl/JmzJMoPl5NQqWenWj0Gzi20/7VUOejjh79cZigbmTE5S5k2IVao04Ez2
	 gtgEu1jqwAFGEk7Arcv6zkcvfR5QdravQisQl/DcSF97PI1pc0nDlx/6jSMLkzMKZ9
	 ZMg/Nf2kLO91/H5BHdIiFSTfFkRG7eJd7FS5g5yuTLsjH0Vs6zjduSpuqEYlC4hbm3
	 R2dBlUGihIwAGITCUZtCfGnPdRINnXsRHYZsPz6reLehXeb+IA8t5X4UBicUuaJRQD
	 +KAQOfMBJl/1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/11] s390/percpu: Fix comment typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921155806.2447506-2-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:00:10 +0000
Message-Id: <20260921160011.5051A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is all preempt_disable() / preempt_enable() pairs and not
> preempt_disable() / preempt_disable() pairs.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D1

