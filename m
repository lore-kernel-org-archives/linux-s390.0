Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1448592C
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721759; cv=none; b=Ih8RysfocwM/DWc3bdiRjtx/Nnv63OrZCrt7uYMSzRw6Gz8gWfpqFiYk4q9VzlC/+5spz37bMIWMdI3P5okgyJ3/8aEmPch/wSDjmXsA0DWTSLTq3Loiub9LTjyThrLqBsp1nORBbmKDOtqP2jAeoKlOHUlPVhpUldaeIStvrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721759; c=relaxed/simple;
	bh=EDT+TN6DYWRn25W0aV4pGPYu0AsSZXtu1ERc+bfv3Ps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VE1i8Tx5p4sth6K1zCll1kMU7gVpGTtKIra/TzKVwlEqg/w7f/AvUneGhaABUoNCDfMgllIhY1A1MIGNH9iprODZjLSY3S4CSy5RbodNHvENwu8PSVuNJy3y/Dt7X5Q6bpjxBwmRP2gn/+1xTBdV7MSdPKmH+2vdWWzKY2Df6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlFwbwMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlFwbwMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64CB1F000FF;
	Fri, 18 Sep 2026 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721757;
	bh=EDT+TN6DYWRn25W0aV4pGPYu0AsSZXtu1ERc+bfv3Ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlFwbwMUrJXpTOsN4V8HTb/cKn08OIZiaD9LN5V4QGyh7LQr/XPFQFtILdZrKoSHU
	 7KA+5iLcThPg+hEC3CkT6AjQyUNe85K46f8KSMdheEP/+jqcMJv4ZRgObBSNoLGMhk
	 zjIF0MC6MBBz6KYxlmL2Q81PA1CNrZ1SgutOUy09V2l80s9fFKPZj+5Xr490Odrjqo
	 1K698Mm0UKOTiFnVQi1EwAkQ1RzlzSEslI5kk0eli6KZdXTWPscIA8HSsFUUUPjYkH
	 FmtLQfKdOUQp5SSCHciY8ABANLBBDsRRTKVFtEekY4RgUpovTZLzkLuTLJ77zpxlJd
	 rnF7OIJf24iOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-11-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:55:56 +0000
Message-Id: <20260918085556.E64CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are no compare
> and swap instructions for one and two bytes available. For one and
> two bytes use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D10

