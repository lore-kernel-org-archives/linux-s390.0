Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EB47CC78
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253834; cv=none; b=dCU6shKjeqoyUPuQJ9C3NcnESVpDhEUN1DUulYEp+qhX2SUmIl9kTd7Yknh8CIDTMmw0oTXjeWcrmvaIqBaTkLaMj6MfQcCHdIZz3FI4QJt58YvafgpykKL7crwiS5091fVA13Zhw/kuzLkNPyImfF824AbilM4Eb694ZlYLmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253834; c=relaxed/simple;
	bh=T/DP9gF6VMFraJqWzJdariUs4/scuzad+0SNh0h/dBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AkmaiwmKGvXVBXa2wAwgdR0vRU8FtrINOfLOlWVwNq1czX0Q+TULPPqg/u4eGySMfC1azLl5eYLrSTsANLTNjJ3ObKfg2Prz3pPn4LfYeTaONEp+byg9+1QCYSWQZ604CQWKV3aVe+vPqprfXXviAg5Sp5x604Wlx7eqjNwRW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFNvjxos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFNvjxos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD61F000FF;
	Thu, 24 Sep 2026 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253829;
	bh=T/DP9gF6VMFraJqWzJdariUs4/scuzad+0SNh0h/dBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFNvjxosLQn3edghSIq7v3uSIDW3mwvGc7mkuGd3WkYctAoctPPwDC1ABFG94ddgz
	 MpOHpZ2l+OmGn9xWVZnCCf7m0fxiiNsCgUSsB/h45rGwlMcnuaGZqbhuxR1X+wxs85
	 hDSgXtm6gwtwRl1mpmp/fnmQrsXezHybgr5vl0MPzYTzqd6j/rZ09oEAcZ1fOgoIvT
	 zt64JHdL/ARbQFdWUIKoMNKl1jMbJqmZqCZiIUCgQ16zBGiuR9LxTJYWgXajU4nljO
	 eJak9ap+wjPlHEIxifv7p2Hk/Wkbp71KIo4KjBGLHxpqkOiYtR8oeZ1PL4bQZK+Db5
	 Pbq902QOU7ggw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390: remove unwind_module_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
 <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:43:49 +0000
Message-Id: <20260924124349.8FDD61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This is dead code, but will likely conflict with
> the ORC unwinder unification.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924124039.1621=
965-6-johannes@sipsolutions.net?part=3D1

