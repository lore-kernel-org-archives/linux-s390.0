Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F9422558;
	Tue,  7 Jul 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439019; cv=none; b=S2KMuNWmXAhD/M5bXnmN8Ab+DIo4nYlwFEipM+mQE/4V3/smwpXi/ZVcRxTLsXWbZzMTbS4vVUwVy2OIIl5pLvGJy+Tuvb6rLBbOm+g9ZkSt8mER+hzplXnNl1QY/OwKMCCFLnvrRBqi+mQvkLtp4yB4sUqSAZ73xdEFMa1YkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439019; c=relaxed/simple;
	bh=+GVbdGSoJTePcS2gPtQnWIffV0SWeJP60naWeIcP7fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCVA/owMQNM3rTmvTIgzHuI/JY1BQN6xIhpJtbzhTmeUAMS/V2fNjuIFLY/wvvR+XLKfI0acAODxiZe6xiaNKf9xvlEJl+9yXXwpWLX6FDPsVaQS8zgzoPO6L2ycxk8SYvul+uf5HjDMrTes5BfuWj/bBX5YBGUHRrU9tQhlpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc3Thh8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc3Thh8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2901F000E9;
	Tue,  7 Jul 2026 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783439018;
	bh=+GVbdGSoJTePcS2gPtQnWIffV0SWeJP60naWeIcP7fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc3Thh8CwJK9OwgRdVho2rvosqwBgXCKICT4ajwLwjIo0cub+fWQMgBWMoYIlmlib
	 WY8OxBuN3hwSTFoEHhoA/2dtKWNJkbicplIAe0Wssz7cJ8LqVviYRLt2X72bAqNw7A
	 8fGcGp3lrJOex2WNXvAab/qoNtP5avhHtZppfPQEMBKOjXBj3GaryDVxiFf0aEXlM5
	 FP1hwVnHqQoEEtVYeCprryUJiYP+bzB79yvtemKrd+VuL7KaiTiZhJCaDiah5yY2+n
	 S4+8Vo0MebmixVA6SkWQS7WReNUFgpPs28gWW8lSPFanz7nAgK2uUE/C2rDIy//ECR
	 XJYgAoL6E5csA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj()
 and kfree()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-modules@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260707153819.4172541-4-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
 <20260707153819.4172541-4-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:43:37 +0000
Message-Id: <20260707154337.CE2901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly claims that the file uses `kzalloc_o=
bj()` instead of `kzalloc()`.
--

--- Patch [3]: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_ob=
j() and kfree() ---
commit a56e4cf89267d12126bd70f7981a05c846959016
Author: Petr Pavlu <petr.pavlu@suse.com>

tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()

This commit adds the missing linux/slab.h inclusion to tpm_crb_ffa.c.
It removes the reliance on indirect inclusion through linux/module.h.
This prepares for the eventual removal of linux/elf.h from linux/module.h.

> tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()

[Severity: Low]
This isn't a bug, but there appears to be a typo in the commit subject.
Did you mean kzalloc() instead of kzalloc_obj()? Looking at
tpm_crb_ffa_probe() in the driver, it correctly calls kzalloc().

> The drivers/char/tpm/tpm_crb_ffa.c file uses kzalloc_obj() and kfree(),

[Severity: Low]
This isn't a bug, but the same typo is also present here in the commit
description.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707153819.4172=
541-1-petr.pavlu@suse.com?part=3D3
