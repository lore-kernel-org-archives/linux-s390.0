Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB24248DC;
	Fri,  4 Sep 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551914; cv=none; b=KSOGz4rpzpYquZxPXxXGVhX5eWLrSOALdcmp1gLvcI1fxBYFo1/gxsZfX0JGOcBIFS94iVWdbp/izWBK1pBHn00PdVLpBVfAu9gjVuiZux6/C6dUNyvKyCYCZXnrxeeUSfYArdToYzeI8lem/H+/bgy0AqW/dqAMAE62D8WbRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551914; c=relaxed/simple;
	bh=1Vv9CaZbNEfXkEziZ9a9QrXWt+xf9re3CXJ8beITLbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyLRu0YiriLaQEsv+Wg6g8F2PNpHUiEjC1i5euWlRGzC2tv+ZggPoIfQp17eRoA/iQ+XTCyIdh01gUyvNW6w2nIGuZkIawyaN9uZ0EkjIuCi3xC+KPyBzUsvmEhLqF9jen0KJc5uW9u5hMsevaBkupB+aRRCPs4tut+EZkZ1B5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWsx/Cq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWsx/Cq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8861F00A3D;
	Fri,  4 Sep 2026 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551911;
	bh=1Vv9CaZbNEfXkEziZ9a9QrXWt+xf9re3CXJ8beITLbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWsx/Cq5sQr3nbq2NCmkTjkRNkucc1sRqnO/MDVAhoO4Qq1CfV/jP8k0EkefLCTKF
	 EKUtTepLooFMpsVgw7G8ZN9UrtYV7vmhllKbgaYLL/Df6FDBWtm/qpEWEVAl1V25/A
	 0rKeqaHl/4cjQO4MtmUxueDG7ZXkGQT4KxYDpNnrp0nW0NrpEvW9oucYCH2s7/sypP
	 223enUZCwnoJCjXFDcml8EzoOn4ewsp1NyYmsRzHw49fCuzmCJfaJl8GF/dhfeBDaL
	 DnmNK467tnRoIKC2OxK3KZgr6ygDJzV1K/Rxb/IH+52CAz+XHhQoTOjXkUKToZ0s/l
	 lzjNEbgjina2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Test timed may_goto with
 private stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904195132.141068-8-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-8-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:58:30 +0000
Message-Id: <20260904195830.DC8861F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add private_stack_timed_may_goto() with enough stack usage to select a
> private stack. Check that the JIT uses the private-stack frame pointer
> when constructing the pointer passed to the architecture trampoline.
>=20
> Update the translated instruction expectations in may_goto_batch_2(),
> may_goto_interaction_x86_64(), and may_goto_interaction() for the
> additional pointer construction instruction and adjusted branch offsets.
>=20
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D7

