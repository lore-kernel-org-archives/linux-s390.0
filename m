Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE7470EB6
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721770; cv=none; b=iz4OTwFHmzgSWZd6xQDQNJ/K8qq2r5ME16i+yi2ykTdBltceEB8tCyG1+jdDExUNLfLqRkXZ1ReLbOVU698ZiYWZ2g93E5f2uJmNEiM2KCmjRkbhI/nNjdjrD1ey6HfOUlYFDTPS9CeKJVlYy7x0rdp1EaO6fIzlDXoCy0Boz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721770; c=relaxed/simple;
	bh=R7OWc+rLubdTU/vFhGdcx8lPtCxdS96MA5p/SxFCxcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=osrKt20rQPpAtmdhxRc+G5v9iWv2o5PigFZpT7wt9uCpAyHaI9XcuSo8quGSKaZ+9MBvurMw5CZW/PE0bclVqoWxKl4TRW2H3Ws1hZtTdhm01dlYixWxEXzD0LdzVX0agGs39It0LK1E5LgQZdnpNKnsj0eoJrZBaXO0x3LgY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkGVugZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkGVugZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF011F000FF;
	Fri, 18 Sep 2026 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721768;
	bh=R7OWc+rLubdTU/vFhGdcx8lPtCxdS96MA5p/SxFCxcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkGVugZiXQheETNvGdAEJo0OM2W8WufOnXYTSWufJyorOLXS3cNPguVXFTTr3S7Yd
	 20xy9nbjT0bjamkdKAz3soHfIfcZQ1tE8LRMIgBhHByTtmXAiGDsz60fhJ05Ygyt+w
	 GcqF7RwNhYODrmjw8mQB+iGP3sHKit4VIlms1ATJqWiOKeoDkkO3W1lWC0Wvc6kHhp
	 Y+m/OyErophMQoDCwVz8eS/0v/rz935C+ookP/DIyD3EDvYsRAkaQXmAkgz6VaKxlw
	 MhODN5umwt6E+4IpQ/EP8ikhd+rhGgOQhTI1LWOV3bhoqVGo7j63zPwH6kvJPm8yDy
	 pHDaOE9hPed8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] s390/percpu: Use percpu code section for
 this_cpu_xchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-10-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:56:07 +0000
Message-Id: <20260918085607.DFF011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_xchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are compare and
> swap instructions for one and two bytes available. For one and two
> byte use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D9

