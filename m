Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CD3264C8
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851392; cv=none; b=Zwj+PHppaV/DvbKAkq4fthTsUGRuhBXx5egcCI4OAEfoYV1Gr4Z+k928x8MpITSCgBD1Y05hRLQxp4WgeU1RNxsAcmx/tQqhKGBYC2pGfOs4FEcZmtq/205WYN6lJ3YUqlpYNMV8CCv++xX8ubzVS3EhoD690PdPqChcZXuclxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851392; c=relaxed/simple;
	bh=QIlPl6TEhUumRifzLtKpLQoKev5dnLGUkhsE09s0GqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGS9gZELxQMcS3rw5WKx9Nm6HfHB1UJvJ6WqGURrPyz6qy6G9XF1jfDwkOGWdv4kuG9BwU89v5hGybHDXH0IlfYzq8MmJA7NiILhLr9t7CzbCJRtWZJsNgMlUAyQTL8YjAg7UIZKJbHjaLgs4YjlbREewEbXWHkhc/hVmAU+zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF70hnrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF70hnrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD641F000FF;
	Thu,  1 Oct 2026 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851391;
	bh=TadF25Q8kBduzgbKw064cxI0DRlxkNDWh/66/iBAPPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FF70hnrmbm59iK9IdXgpcs5MEFAeACyySHkEf8Pv1aClNRj5DmInNOxSfN4GeMk3w
	 qq4djcnolI1iRKl62BnlXMJcYorQ4sQU9nr/jFUFAs+JMocTqHPY0LroptEbza8aER
	 k7VRFJJj4ws9alGaNx+u0I+sguxlzskUoC9T1dyfiElcmBMZj8XCnzQBKyQicIghG+
	 QF2qWQAtObcYUWOviY0fTV3hJDU+y1kSV80qpI3lT+dTAKdB882NUkm4QuxXJ69NMK
	 Htq+PSn/2a7ZhRToVKAGAu2cPwkP2kX+g4WIidYXfspRnY7PC+8YciqHVYoeNpje0f
	 dTTv3YEfegD5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/32] s390/bug: Indicate modified PSW in disassembly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-5-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:43:10 +0000
Message-Id: <20261001104311.2DD641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With [1] the PSW address is set to the return address of the calling
> __WARN_trap() function in order to provide a more useful disassembly of
> the caller rather than the helper itself.
>=20
> However, since regs->psw.addr is modified, regs->int_code has nothing to
> do with the exception. In order to make that more obvious change the
> disassembler output.
>=20
> Introduce a new PIF_WARN_TRAP_SKIPPED pt_regs flag and set it whenever
> __WARN_trap() is skipped. In the disassembler output print a "WARN RET"
> prefix to make it obvious that the PSW points to the return address of
> the warning trap function.
>=20
> Also do not print the interruption code and instruction length code for
> this case, since they have nothing to do with the modified PSW.
> [ ... ]
>            000003ffe185bc46: a7690004     lghi    %r6,4
>=20
> [1] 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D4

