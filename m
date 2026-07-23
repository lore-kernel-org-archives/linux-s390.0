Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002132B132
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797052; cv=none; b=ItM27/1sWtnSJup+/zp/zw1rqKH0cbtDljQMslLiFxzaO85vrUX9Dlpcxb9+PPGe4ntcLTmX03uJVNQWmta9v4pxYRb4FiBvir695POZwtO7mKwF82EvBzNkB8UVmpiFUcBn1L2VUZx1l8tZCa6mhPzeASAALMxHSWkH6rj/7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797052; c=relaxed/simple;
	bh=LS67GPSbf4AFbtMF4dnltxj3q3wbUqcxlR1iDWbwH7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m3EiIi62TM5ZgfwzY7RuKcXFZItlfzGn/Z0ZYjQdn/pMklgTofhq2+LxAnP1mRFtxXiPU2ohhdJ9NDe/1A3iGRymROaYuD6wHdtkIA7oA0Q/ZT4tn4Qgl77Iv+FT1rkeZU7hElDjmvGKIqeAp6mEPVjJyw5RO7budw4Ge9jj2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jztQtg7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jztQtg7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833CC1F000E9;
	Thu, 23 Jul 2026 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784797050;
	bh=LS67GPSbf4AFbtMF4dnltxj3q3wbUqcxlR1iDWbwH7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jztQtg7tK+vpPIq5A3ShkFa0odDUC4ules/FUob0fYNyObXQtgDki7LedTnHva4c1
	 6i4BHcYBV5aeSU3vYMoDe0U7qApo/K42Ig86o+GqySRmcbn5cNVNU9jN2goWrT/v/U
	 OVxA4/R8aIdre34HUHjvXXd7GfT9W9alY/7EmuovlxbnHBVBE8Di8vDb5C5pU7ZOE4
	 CDAAOKPM7QRfYtGgaNiHaC9iVZ/MS5+ldWbfjV3AqPKUv66Lb10rm7iy3f0eD7esli
	 OVEqZAPc7IoR1HDEOsZpd489k9nvOmQwwWFm/2Db67ZQZLdqoTPo+QQuZ7YlcehoJu
	 a3U4KqICVmBgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY
 COMMUNICATIONS (SMC) maintainer entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenjia Zhang" <wenjia@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260722085705.56755-1-wenjia@linux.ibm.com>
References: <20260722085705.56755-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:57:29 +0000
Message-Id: <20260723085730.833CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch accidentally adds extraneous files `Kernels.code-workspac=
e` and `file` to the repository root.
--

--- Patch [1]: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY COMMUNICA=
TIONS (SMC) maintainer entries ---
commit 8171ff1f0436e110b4e20aa711ab8004cc5cf6d0
Author: Wenjia Zhang <wenjia@linux.ibm.com>

MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries

This commit updates the MAINTAINERS file for the SHARED MEMORY COMMUNICATIO=
NS
subsystem. It removes Wenjia Zhang as a maintainer and promotes Mahanta Jam=
bigi
from reviewer to maintainer.

> diff --git a/Kernels.code-workspace b/Kernels.code-workspace
> new file mode 100644
> index 0000000000000..9e26dfeeb6e64
> --- /dev/null
> +++ b/Kernels.code-workspace
> @@ -0,0 +1 @@
> +{}

[Severity: Low]
Were these files accidentally included in the patch? It looks like a VS Code
workspace configuration file that slipped into the commit.

[ ... ]

> diff --git a/file b/file
> new file mode 100644
> index 0000000000000..e69de29bb2d1d

[Severity: Low]
Does this empty file serve a purpose, or was it also mistakenly staged and
committed alongside the workspace file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722085705.5675=
5-1-wenjia@linux.ibm.com?part=3D1
