Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69653002C8;
	Wed, 12 Aug 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550374; cv=none; b=qgCf73NXcEs1kNLqmsklaTk88BYDnneTjWM6i9tmtHAf42ka9lpTK6sgO4Kb4OkgRX4vOKpOSoXcTXdAFg3nlfcFsqSufyGvfxhQBgjmsaFrjMrYCQQKCgas9ihC1xUgGbEHipYY+vEFaVcC/Iwg0ksGneqrf89DVT6/hK6fRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550374; c=relaxed/simple;
	bh=ylmYAr+gUd1wb8m66fKPL2AR0anXLkkOk4U52y9OoDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rOHnlGyToLuic2bPLqiwH+IC6curTbbz17a437AiWUnUizqTJ6T9tGpeDcQsMXZaF76u3ZyE8hIQjJgfPXm9azpIvcDq781JE5ECaWw+7yLdj/b0vHNptzDfueevsRIIckjZhp7/ApJMS1PEk2ZZ+0IB/HhdDxv5zVT9tnwYYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9Yj1Yv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9Yj1Yv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA471F000E9;
	Wed, 12 Aug 2026 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550373;
	bh=ylmYAr+gUd1wb8m66fKPL2AR0anXLkkOk4U52y9OoDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9Yj1Yv5S25wPk6Zi026xPOZ1JXb7xxSbMri7a0xKHFzxCC1YL5Pp3jqRoeXsLzCg
	 zuGUAqFw+zRIahduHYkOv5jeCKaoweClQhD3rZ4jR2Tji6ogaAIG3Mjxv9j2CVTOM6
	 M+tXZqfknZP4f1ohKo51d/RyZuXG3vtL4gs3FiZWJEjf/npRpBjavZUgosKIRGiUkS
	 FpX8NqraFzQRl9MbmYgslHqqk/soB9+h44mzCGJxbPpulDDLoIvFWCU3QVyCJbzc0E
	 svQFDtTrVJFN4gBXhGxJpJr9QIfO8WfhNnGRlH+IrNr5eqnvgO+c8d1CV7bo/ARlKj
	 ENjNF6ixFL/DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/33] KVM: arm64: Share arm64 code with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-12-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:59:32 +0000
Message-Id: <20260812155932.EFA471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Mark functions that s390 can use to implement arm on s390 as shared
> functions.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D11

