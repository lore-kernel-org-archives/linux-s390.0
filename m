Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1193EB0E8
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851333; cv=none; b=ut1useGMYQtvP/9haxSCkDTc9wAWvhdNOkcrXtrjUrAf1D966H63hxxZY975CezkAChDHHiOhPlsdYF1mSW6SIQYhagxFVkLD58mqv7uNj/K26AIsP+Iub8z7LvosyJTDGrkwDqtvF3qOK91g6dxLBKckq1nudPN2VG7t6DYWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851333; c=relaxed/simple;
	bh=+Gd8JlGLmgqli/Uv3HyAF5eTIJt2kuA782Fo9ZdTCDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOyTRduF/h6KXOQWwlz5I7UywDY8fJrHbgX2xyt+Xn3hb5CP/pCGcUM/fJ7N2OTL3+HRe28pTvYj6P6EWzPnDOFnafdg2Runs0EmwK8q47Baj4sdCquzYwRw8auQeXHav8C3gsRspg5Nr+bLUhtyc2xQxi1GOUKHvG+F6efJPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS1doOif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS1doOif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8181F00899;
	Thu,  1 Oct 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851326;
	bh=+Gd8JlGLmgqli/Uv3HyAF5eTIJt2kuA782Fo9ZdTCDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SS1doOifF7sUeMopCZ+4X+wjXl5Zn+MW3SPvB0dQdKsiWMekQu1uksS8dsb9eeHVw
	 Vw6HiTuvpvwJZfuORiBmO7UFRSfgALadHYNhNRQin+70MVEaYrHvVoLZiP++0lA5bJ
	 nn5ObO8gfmiMtKNVaXjEqMU6GVt9wE+b6+jfwz+k6rAGLVuaWwQK41237wrOy4Pgrf
	 r5tY8+zOuuilSGOv4W4sIQIt9bHp1a6Wvr2Hm+FAARYfV17Dbe7IyLWVIyjWTnHRPG
	 XGNE1dhnep5yThqkGhFPFUXegoTu5g5CWduUPSac9L6UlvFYnPW4CHdFhseStd+VoV
	 261gAuqkWzgcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/32] s390/kvm: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-25-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-25-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:42:05 +0000
Message-Id: <20261001104205.EA8181F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the gaccess mvcos exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D24

