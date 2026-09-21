Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5914D17A4
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007825; cv=none; b=r+NRrFkv4EWBOZyYxm1sZyNiIPnxXKCrR9pyMk6R3Lfss1Z92o+w3Kt1MPvmvk8041+s+/MMkurRPcBSaoOsxt38LfoPLR20nkT0KsA82YmmF+FOZ2EA9bxb/Ro6EFvD23GbxApfCw0j/pStYgMUw9ZILye/q1kXUJbMFLft2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007825; c=relaxed/simple;
	bh=pOnEVS7HS6XOPiONiFHV17GHdlGaqOIAAQVJgVrBjx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqJHguncRbrDhgJP9TNHhNqLY4PYk586W0tEHQ1MV90uGq4Q81bDyJzdgehkL5oH2NHenNPDNUvORb0tUqgZzb4kOI5vCmorg566iGXcwydtnmN+tNye1ASk+kDg57atjM24NQgccN8qD3hi/gsw0chnj1Sqyomc6BkFcqFFlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oukyx8mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oukyx8mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A871F000FF;
	Mon, 21 Sep 2026 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007819;
	bh=pOnEVS7HS6XOPiONiFHV17GHdlGaqOIAAQVJgVrBjx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oukyx8mraL/BLqYKTRhzoEVhnDIdSKKw/0aIVYIk30vIuUqfh7jBiKURXpoSgaTI9
	 yqExHX3udScWPM4sbc+9ZKZoFEGbZLLndBh7hcO5IaD4CWsg9CWsl/vEHNxEuyPi0B
	 E7uQLkppa2mhTnmEPFsCmb+mSRqM+PlIlQibmJnmeWor+9FE2tFP6F4tmt1ZQNztrP
	 V5e5NpC+Ct4Sd6UlKUHaC0xKGI0I+HEF28wnxCnktlnjexmmTBLkwFqCHuMb6cxJaA
	 2bBygHEH+wD8zBnNxWzXGW3Uy7aoU4yUU8mWMuPZW3KsQyBvkwDpViLTqCHpcr6gol
	 O5xL7cBpKFnPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/11] s390/percpu: Use __PCPU_BEGIN() and
 __PCPU_END() for inline assemblies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921155806.2447506-8-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:23:38 +0000
Message-Id: <20260921162338.D8A871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the use of MVIY_PERCPU(), AG_ALT(), and MVIY_ALT() within all
> percpu inline assemblies with __PCPU_BEGIN() and __PCPU_END(), since
> the begin and end of each inline assembly is the same.
>=20
> Also use consistent names: e.g. __PCPU_MVIY() and __PCPU_AG() instead of
> the previous MVIY_PERCPU() and AG_ALT().
>=20
> Furthermore extract DEFINE_GR_NUM and UNDEF_GR_NUM which are used to
> convert register strings to register numbers.
>=20
> All of this should make the code more readable. No functional change.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D7

