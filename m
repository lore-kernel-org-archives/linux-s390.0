Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E173F7A9F
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980358; cv=none; b=LZC1u4VfWaZEzvVo7z0Yd0zyV4xjfjYEfASm4Hyv9blSL3LFGykxAeM/cpldidYDzaMsGY7cCQ6BrBwxwsz0aEKTQEoAg2xvKeJVZ6fO7aiCxAZ8zPBudf2HrKFPDf+H1k61dGdHWPQGG66vRgbyO4psfzoU7yzBK5KcCPu7adI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980358; c=relaxed/simple;
	bh=p6mwSX8qibiwrn+hxz73nwt6fOBgyLUBZS2iO2HP8RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJerJjwu58bpY+3lE04kdLBaFOhkY3NdAwQltpIJluaWPiFeGubQjcXg0IPdYymyXP0ziW1nHZNG5OwHzRz6E0G7GxnsLEEr+TbKUgy14raRUT4f/rpzFlnNU19wHRJKI+L/CGUaU5Y519obiu4HMLsdIHF6MIULeCnD5OWhzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEEMZjFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEEMZjFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502351F00898;
	Mon, 21 Sep 2026 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980356;
	bh=p6mwSX8qibiwrn+hxz73nwt6fOBgyLUBZS2iO2HP8RU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEEMZjFti+UxkoWYnuVbGBaXPAikEyjYERR/cMEQpKNPQdD0V4n3sg5SbfyUybzZY
	 +BK5Gqo3fgysTpod0k+NMSwkh0Mr1eoun769TAiuocrl+Dwzl/uOTRpEGXTmp8FQL8
	 ffN2H1KqUvC0ja8i8wrnbHmpLFv7nAB5EYOsT2EHHSZzBohEDvzDh58NkXkKLCjztN
	 dNo+cRnbEV/U2d9cjmOPZVUz+kG/RkxcrEd/Q/G74VI0mXqqWt0iKOsPLHx7Xs5scX
	 E/n0WlKEVzcUSqOC8k8qUEEOAR9SGe4RqazHj/oHJ15s7SE9bXFaKwnCphVRELRqqH
	 6yYFIylyc1TIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/11] s390/percpu: Use percpu code section for
 this_cpu_xchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-10-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:45:55 +0000
Message-Id: <20260921084556.502351F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_xchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are no compare and
> swap instructions for one and two bytes available. For one and two byte
> use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D9

