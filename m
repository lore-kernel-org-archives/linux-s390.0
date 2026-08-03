Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23B1FFC59;
	Mon,  3 Aug 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777232; cv=none; b=m57DZ13FXHs7se5YGLZ4AUraXGjVXW8/Ks8j/K2IsbHL0Q9jm2P40Y2ma1hR1wXEhIqHLBVPA5UhirocCZQ5r9mKRhs8rBtMvE1RtQGSoS55b4jbni6llG2I5734jmgRiO+FVeviNj3vbG2U/CWChpL22kCivc1DiL3fwS6gXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777232; c=relaxed/simple;
	bh=cfbCAiBB0Zher1hAR3K/4lh0flf4ZYHny0DqjOY/IoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BE7rYAC2/hOOHvlDoPxci4MVpLV/R6ZUJuw0kVP577JbE+Qea+lLmbIJYhOB/SRG8jhs1cglR9Z1nzdCz5eD8nTNLNPxw3AixXYtJezpoYrYq8+609jaG1xJ6/db6had3chZNUxsCA3kVm/M68R01pbeadGzGfqiLyXZJIqorHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwcxE/4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwcxE/4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E543F1F000E9;
	Mon,  3 Aug 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777230;
	bh=cfbCAiBB0Zher1hAR3K/4lh0flf4ZYHny0DqjOY/IoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwcxE/4eJKcvumRPbC6zlGCIP+iHdRkNAPpb/Ju4bCKbUerkvGripZJM3zirLZFpf
	 7+O/AuaYDvrR83KLK3a29/n9O5zngE02uSLqnQud7uG8wsQZ6mcXZU+Y4uHpAfPZVw
	 NrVEMXex7ZIvhMdHq2poHfclh4D8RIOK+AjQii7G7H690PgJMndAwV0KqKI3CLlw5e
	 iDacCaMBy0lG/a8ZHnj4u09Dtv1oKr72Z7Gn/Rqm8SRnFIGU/Zpu9SZM1jCGju08iD
	 794MUEdD95fXK/hXT8xwNXtuZrPoj1yAkLDR7Zzut5gfcphuprfBIF6Ed6nfHhg2bQ
	 uM6LkvmfGTEAA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 20/23] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803160924.236807-21-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-21-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:13:49 +0000
Message-Id: <20260803171349.E543F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The mmu cache is the first thing that is allocated in
> kvm_arch_vcpu_create(), but in case of failure it was not freed.
>=20
> Fix by freeing the mmu cache in case of failure.
>=20
> Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
> gotos.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D20

