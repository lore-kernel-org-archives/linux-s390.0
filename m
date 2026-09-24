Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA119AD90
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254328; cv=none; b=U2vhplSwhot2upTOW7RMxBdA+dNcNMTZUZYtqrmv6ttm+MyOw0FO6sYR4CGTrQOOQ3t6yj76MynoW7LqGLMnLv9BUj4q+uGsz2vA2RMEhhovm71rER6Mec+GSurTXNiFIhyk/F74sO18pQJxBKrqyP88cfns/UohzhjEM111VS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254328; c=relaxed/simple;
	bh=ADqZ9pfSxrBUOUWJuiD2nGawKG5UnqegxBWFAmea2Yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L6kovNq2xGkFI4md3qi30+KCsjmBJCe/ddKwumUvj9iLpTNqeXyaQVV3JY/ZDiXgXXPTgVpmgQ8s0xmijbgHsCojkrgw/DB2cFvbnc2hoKbmRkyssui3qBy54bTBI/YccVxipqs/cDKVryw2blqmmHK7b2PUbNr+vinwYVJFgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGrH5K9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGrH5K9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D9A1F000FF;
	Thu, 24 Sep 2026 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254326;
	bh=ATftYKzA0CZDA3AOgkGPUu60qm2/nF5Ck9j3clJFEIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGrH5K9VxXnAFthFWix63h7Bdb2uxVdn3f7ocfT29SIQqskCA/EaR516dXqbtYz/a
	 UtxxT9WiLNanPfqLvSgkjPW1UchwVvmY8k3lKWo+lAziqfgPj0E8nKXmkA8cOFid9M
	 rFnlrJlqglDecWtamWAm6sJsaoujK239XpG69bDsjZ8QeFR6NEqGxvSpsv4WEl3amX
	 D3TK1OU3JA8oYFxioR8WfTYNSgAFgERB2jfKVFb3C0zMphzUS3jEqNJ+5qk1+ys1ph
	 ebo44hAzshpzDg/kzGNpvaE5NBVgY/eD47I4Z/fdtDG+YbeBFbD8JItpL9EaMx40Ug
	 Qk/L6Hfc+v9pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] um: ORC unwinder support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260924144039.52fff8ac4e16.Ie3f2b9610f0bc9cf45ca82c17f3b9e0f90354ea4@changeid>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
 <20260924144039.52fff8ac4e16.Ie3f2b9610f0bc9cf45ca82c17f3b9e0f90354ea4@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:52:06 +0000
Message-Id: <20260924125206.80D9A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Add support for the ORC unwinder on 64-bit UML. Since that's just
> normal x86_64 code, the objtool etc. is the same and the unwinder
> itself is mostly copied from x86, except
>  - register accesses, obviously;
>  - no need for (entry) assembly support
>  - interrupts are host signals, so we can unwind across them
>    by detecting the signal restorer and using the ucontext
>=20
> Note that due to the indirect calls with -mcmodel=3Dlarge objtool
> gets confused in some places resulting in some warnings, but I
> couldn't find a way to suppress that and it seemed harmless.
>=20
> Assisted-by: LLM
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924124039.1621=
965-6-johannes@sipsolutions.net?part=3D4

