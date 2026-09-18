Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDF4E50B6;
	Fri, 18 Sep 2026 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744057; cv=none; b=hlof5MjxzbxbiEpyFty6mW7GTwo5ngNdWp027Bc11zpJmTKAghmxFsrGE/XUMzhDIGCeqKotq6s8Lyq4aLCi4gI2hD3yyOkrD+o+fOBgqMyVm3aix9vErvpyzORIxBJXvZZjn0AZz0nIxI9Mpwwb9txn9AJDFxLJR8pxQ16N5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744057; c=relaxed/simple;
	bh=lMLG2gJ31BEBJ/Ad0p3AI5oG5oKsdUvV4z4DPWrAz6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFaPy8pcJF+1GIQlynlDqJNwIp2MsY8tsoI3ha9cw/rQNlPZWnyX25hV3YI3DjUKUIx/uouxZBF0KmxiIClPkJjJSEafL4mXTFRJm9mF3tY+vY6lggzFz2JMcrvyKdNczyfSfft0HU+OsvMbxXh4LxZ8RveUbK+u8VhYiT55o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCwVvqH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCwVvqH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415CF1F00898;
	Fri, 18 Sep 2026 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744055;
	bh=96Sf3ePwD7C5+Tsxwx0kN+h73AW1l18RlQBhRiue1p0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCwVvqH77082DM7wIzkD2hbGVvge8GJfgUROcsIRvq1d9Yfq4GLd9cyxMeXUv1Cx5
	 M8fxcanp5heiihNXooURO8Z+Ix2krz+qooqrxSO1rF20RvYPc7WczsQAR8ZWcQc+CW
	 YlKcYK6a6ghFc9gODWHBs0oC8ZYHCulV5XI5N4J811u1PL1lwi92yWRzE3GNA80jAv
	 sQQd4d489Mlp54Tx1tjkF9QAwPG5UKHq3IL/gf/sTOWJLS6eordP/h4nCwL0nub+qA
	 U40CE1hNjfIED5bvGxy6vPLr1fWeoXzKhprha8Jdmp0APmn2iD6gEhY39blggBOvHL
	 tY9TblrRP56Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/29] KVM: Move architecture capability Kconfigs to
 header defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-9-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:07:34 +0000
Message-Id: <20260918150735.415CF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kconfig: syntax error in virt/kvm/Kconfig due to 'booCONFIG_ltt' ty=
po
--

commit ee51b43b92593e9aef02197487e12632baf77f58
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Move architecture capability Kconfigs to header defines

Historically, KVM feature opt-ins and callbacks (e.g. read-only memory,
MSI routing, generic pre-fault memory, lockless aging, halt-polling
controls, and vcpu run PID changes) were configured globally via Kconfig
symbols (CONFIG_HAVE_KVM_* and CONFIG_KVM_*).

With s390 hosting multiple independent KVM implementations within the
same kernel build (native s390 KVM and arm64 on s390), global Kconfig
selections force both implementations to inherit options that only apply
to one of them.

> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index c3c0ee253fc77..008b110ebdb7a 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -9,7 +9,7 @@ config KVM_COMMON
>         select PREEMPT_NOTIFIERS
> =20
>  config HAVE_KVM_PFNCACHE
> -       bool
> +       booCONFIG_ltt

[Severity: Low]
Is booCONFIG_ltt a typo for bool under config HAVE_KVM_PFNCACHE in
virt/kvm/Kconfig?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D8
