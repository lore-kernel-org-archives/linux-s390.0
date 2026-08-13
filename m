Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F773330301;
	Thu, 13 Aug 2026 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662485; cv=none; b=iu5suQcAvrEK7D09Td0GyxpGae0kHa3Lj4W1NifjGdTRzdpKLi5NKykNv1sBRBL/bAskwmRzN+VvcA6Ap0NsIYMaw9uRtgju9W0NHS9dKwmaEHAoKfxMTuXROBzKGu6pnTVXzC7KtRYrVTp9U52IX+vaM5B7e0RG7mUhBrLlKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662485; c=relaxed/simple;
	bh=/WDdnGUJXBqqZqovujSnoIXubkHCv+sfY0h4Mw7+dtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qw1xUyPmyKM7aWTGT4Wrbl5haOb9+dlYA9qELQU+ek/I9kX0W0jFwAv3j4XE5G9aXviMLHQEU68lEkCLSPzEnv1gdtDw7D6yi8mqy9AY/4WIW3YJ7y9uU5iyiH9OBTNeLkKF7AAyBGrUeI+jY+u0Sy8Y0ZIOoH6hMbTEiv1JRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly8NUml/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly8NUml/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD31F000E9;
	Thu, 13 Aug 2026 23:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662483;
	bh=/WDdnGUJXBqqZqovujSnoIXubkHCv+sfY0h4Mw7+dtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ly8NUml/qxbwzwPGb4I5ii/dBr4Xn1Qr+3DmYx/5Oq7vtBF95nk0j49JmTssUT2yP
	 5Fyyr7E5g+R9q5oG+aCPiJ2u6d5CAegEbkFWb7yPqfIw8GhgBwmuvlhTfTiWZzZVDH
	 HBHuOpNM3yheAmFbCVIcfud5ovhZHCuSyXG9/oSrfAUrMQxJxkD56B7vgc3E2a0lEr
	 c3ZdzGSN5glir+UYkTsuHMoP2IQgxd00h2jvc3/TZKqW8nkhFPVMWzRt0VrpkLw2yG
	 PE0ZYh0Wmod1T/xwhbjqCDeSb/fmblCBhqZLoIZhn1iRuUPy4jpzA6qyW/tPGgYysQ
	 78BhjLMT8jHIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260324174301.232921-10-imbrenda@linux.ibm.com>
References: <20260324174301.232921-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:08:02 +0000
Message-Id: <20260813230803.68AD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
> ioctl. The current (wrong) implementation will trigger a guest
> addressing exception if the requested address lies outside of a
> memslot, unless the VM is UCONTROL.
>=20
> Restore the previous behaviour by open coding the fault-in logic.
>=20
> Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324174301.2329=
21-1-imbrenda@linux.ibm.com?part=3D9

