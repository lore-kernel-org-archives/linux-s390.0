Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733EF331ED1;
	Fri, 18 Sep 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741809; cv=none; b=u8ra3/MJVNg651XnVChbBrpkQyIm9T2m5sZS+9HEp/dzFii6IyFU4QFSt5q6UZkDU7bbngLenufv+/HOQ2QsSHPqBuOXH/jEwWchP+CpbAED3qtlRbbWuDV/vIBzflzoVU6Sc6V88Mm3cMpm66727/ognXKpg2ga6Zv/avqMv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741809; c=relaxed/simple;
	bh=glnBKS+8Klr9GPlED1qWfh93fg1YCv6De7YCppmJWnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBSsKg2jOAwxJWVXWu+miuKQ/3Vo1Yrn3K2dhMTJnnQmvCj2IeFYvWzMBy84r9Nsc7sHhCl2wK32yxC71KySFvDV339D0GlGeC+92v1wGaZigDmngF0rwsDulAZDz34uE5W7HYt7JcxJtmMJHeMsNJk0iLdI4viazHFdsjz9JGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7fMykW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7fMykW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74BF1F00898;
	Fri, 18 Sep 2026 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741808;
	bh=glnBKS+8Klr9GPlED1qWfh93fg1YCv6De7YCppmJWnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7fMykW0g/9/Dzk5DCRYICpWyUvHueSKC4s+loCFdJqEMsvvaLXOwzIkiiAH6+ShD
	 GAaujPkQml7FA/18uK2E2U8UEEsidtps3ldwsnUkPW3nPw6SdU4ub7wsjqCRePv41i
	 4yTbBHvn9BzVXXoPrnXrC1yC/USh7Xq7xswvcKKsMCfaAQfKoD/LpOQ88lvy/yINob
	 TKnmmyF+a2+fWIdgr809i0nLE7wMB2vdNN4L+SDUyjmNCXKWH+h7IBchwYYLWAe3uf
	 ll4VLD7AMlQojdQPvoNQ/MMU4QYwzF9sxI0+QmElKDQlVa6LGCzfMKENPJfmGTMM6m
	 JTas40YLk4wXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/29] KVM: Restrict kvm_get_kvm/kvm_put_kvm export
 to internal KVM modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260918133107.1042730-6-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:30:07 +0000
Message-Id: <20260918143007.C74BF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
> EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
> now only used within KVM itself. No external module needs them now that
> VFIO uses file-based reference counting. Remove the corresponding
> exemptions from the x86 KVM Makefile exports check.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D5

