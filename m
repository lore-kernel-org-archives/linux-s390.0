Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADA27D77D;
	Wed,  3 Sep 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942955; cv=none; b=CYbHcIszdOyqf2NWN5Hv2HL68zqcgz1LkSGKfO6nuVaiTlGwNLgQV5FQfzh5J2/kFpgINxqIoR8mwNHajwiCrHKerVNdn9dcrAagzkKgBY7O1bDiHDwbry0INFFO7EXWMIpHR59E4woArz7b7Yb8H9N9mYCFUMO7o7L9ccFyg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942955; c=relaxed/simple;
	bh=ZiCj1LxsUdW9sFioa3DqemGUROr5HygFF06vYzpADwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3WKUzIQDL0FDl5pIXGu9ian3c83t0JKpnp15OKE24HG6WUIIQqQ/cY1r8h8Vi0/11QjYCgcC7lrVf7WMrkr6CKrLAcgLLC8Lr9WVAu53K9d1ufAnxQkySGz3MyVqMcNlfC9ZODDO83yrOYr0B1SmLcamRlbvX+M8mXLLLz3H0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPwqwa2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPwqwa2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E194DC4CEE7;
	Wed,  3 Sep 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942954;
	bh=ZiCj1LxsUdW9sFioa3DqemGUROr5HygFF06vYzpADwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPwqwa2on0K+P1lj1A6ptOtG86Sl1Tz/4/yhQBB8D0YGV/+RRVdyx/z/ZIV0ypuXX
	 4mSC1MMndmGyjiAuYVcc5s2UzYXu+EQmsQjIlNjkDd4LD9zKMeOercxpuBIjj2NBR+
	 5fcTW8C+J/ovydM8nE/fHNW8ASD+deCUYg839A3rSAgEnGG6IA50LgYoQ9/QFVbm90
	 gZx/zYCuII6abr9Ibv1EFHD1DC+OCLfD8zwvapy0zhHsmAmmAgZyq/xXW9DLJly+Bf
	 xl1L8RK+mTF/4uYuctIELBhpos9ypmaRnm9hgIPJPaR2//qHDwDQKEUWfpa2rqYkYf
	 ydP362fg6RDAA==
Date: Wed, 3 Sep 2025 16:42:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Aswin Karuvally <aswin@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Mahanta
 Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] s390/ism: Log module load/unload
Message-ID: <20250903164233.7b2750e8@kernel.org>
In-Reply-To: <20250901145842.1718373-2-wintera@linux.ibm.com>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
	<20250901145842.1718373-2-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 16:58:41 +0200 Alexandra Winter wrote:
> Add log messages to visualize timeline of module loads and unloads.

How deeply do you care about this patch ? I understand the benefit when
debugging "interface doesn't exist" issues with just logs at hand.
OTOH seeing a litany of "hello" messages on every boot from built-in
drivers, is rather annoying. Perhaps this being an s390 driver makes
it a bit of a special case..
