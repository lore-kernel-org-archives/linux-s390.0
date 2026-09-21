Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145D48D868
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008953; cv=none; b=WRbOyqW4I5/0zw1Y2CC0ZiRwkvjFsxC0WU/mHwJsh4g/mEkzx4TC6UZmzhzF2EmvtBX1uuVwZTGGN0MPuioKydvRf/mbvtU6Qai5/SnJiSl1bOIVIdlS3AOuMuWYxj6SKac3ali8zZK79yMnAQde4+ynoBhuyNuJ1qvu7/xCIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008953; c=relaxed/simple;
	bh=fd4MMC4SXqPqvUJEBSEGn6gCMs+HXqCabp5VEqkA55U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m9YckclrCJLA6lAiYJVjHiejVxn0QT9qbXnU5kp36wQE4BgRVcCDyw/5gIUJ8pAr5m0MH6zzmG77wKLZpmGyZEr7/T3A9BkkRVilJdUoHHYdWDN/0mlF4Axga1eeJBRze33nawNDDsYIxsKgCU70k9Nkakua5hcHSzF5N19/k/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfTNUIPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfTNUIPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD61F000FF;
	Mon, 21 Sep 2026 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008952;
	bh=fd4MMC4SXqPqvUJEBSEGn6gCMs+HXqCabp5VEqkA55U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfTNUIPOhiAY3Za9bXDtlEltgBT+M4PPGMwUeWeih39RKp1Ts37GTkUAGukFdCOtM
	 wtAzkRG392cuIKTvtFTZ4XerS0ibgzPEUZKiiIRCfX2ahuNLSunelAIoKpEOlHYDSc
	 WHgX56F5fJmow4Y5FmIHYGVrajtuX9LLy4Db4+adsdvV7ou1wBHpJdqg7zATVH8Hmy
	 ByyBfCeWpMpSXPMLdUX1An466eKQzoCcnFUlFriha09E6R6MQndiEuuUOodYa1CivW
	 wtKlUHDGotkHphjUENLXPARcyQ3rBRRuetaWu2sdhYwGwS5WtOtMcX1yPHK98koanh
	 66otWhORjxslQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/11] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-11-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:42:31 +0000
Message-Id: <20260921164232.0AFD61F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D10

