Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB5466B77
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254090; cv=none; b=bDMgv8U5s8c2UAncPMX6LUljEhkT4WUaxxfB23O+0VRdl7PPmQ7CrNi0keSSjkwr4zytCS+Xr9doG1b7T3XSkN8eIrXmI87SzhLySQTkrWWdaEBwStLdXnYpTUZMiN83AIiBaScSbaovJaf5gV0qAsmFf484lTnluk5kltf+jG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254090; c=relaxed/simple;
	bh=WtNyWb0JGxHB2x44JpNPtSL0N/W8/EZr69LHeBQLsto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvxlGo/3tYCvdhYaaZU4UFWT0H250LTgaLVJQ4pW66YEk2i5hbkJuyi97LSNil5VlJbbkkaCn/rI1x4R8ZErfoV/3f7JRXMyxIxAkla4AgFP7WWjCWzhcTCefZqT6u38NuyKyrbp4IiCqSqhfv99mmLZeagk1ImOkLTZqcrl8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnoozVXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnoozVXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CFA1F000FF;
	Thu, 24 Sep 2026 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254088;
	bh=WtNyWb0JGxHB2x44JpNPtSL0N/W8/EZr69LHeBQLsto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JnoozVXBU0UXzHeAEGOGUzXaOohqg8cWX/Wp2PDn+lx2WTpNIt8uwqNU3pnlEROA4
	 XAjDY4/o2lqcIv3Nfb3AGPMPEuxbtbPudgYxPjjuFtn3Oe/8bZmNSl5507SD6WYtlV
	 iUjP5VioXSgpyTr1Jybng3obVdtb3NqmqRy6CptjuzGshCJmtr2YaafGQqyz+gDLVl
	 2vUDcMzz3CkLN1Zwu6iKUz/EfwI724sMbJAaQrGnRcOi4KOGC5d7ArijVsEDm6SEHz
	 txgPT4+rX7tCQDnKu+Dlnwr3t5xg4rYmazaqbU8BvQlscB7nsiSGy7R1utxdWw26T4
	 Nm7mcoTlrnluA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] ORC: unify orc_hash.h generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924144039.7f1bd78fad93.Ibd2ade12789c15c5fa6c45b4661d471fbb4e177b@changeid>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
 <20260924144039.7f1bd78fad93.Ibd2ade12789c15c5fa6c45b4661d471fbb4e177b@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:48:07 +0000
Message-Id: <20260924124808.55CFA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> There's no real reason this needs to be duplicated,
> and while not a lot of code, I'm adding it yet again
> for UML. Move it out to the common Makefile.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924124039.1621=
965-6-johannes@sipsolutions.net?part=3D3

