Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AF435514;
	Wed, 12 Aug 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547636; cv=none; b=mpJCRWfdzRuqa33xKdm/3zshP8ASSw/Svc4WM8asLEW3wgOepB1lDSU9F/Z37k6Xq/opJ3T5O/Yhgiiebt9sUZ7FGRYiB/coCsIvt/0xtu0xZwhI3tyqPWKYXbKR78+qYB3mTYMWWwJftjUW14ERp0slMb1p5yrNWd32FnPifbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547636; c=relaxed/simple;
	bh=foQITieku7Nv8uZHRWQS5q8JurL6AWudmaMM+YKgGx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H5zJUbWphALekhbCSoONdUCQeGjMi36wlkXYFhrH6DFzALtrPZK6z/vv2Wz1t2tgCyXw+LGrMwJ8Al+uicXQin9QIlIJNgmatC52Ad2JzeVKR8CkzJXdJ+TUCvTt2QcUNoDi3WoIz8medDdrjLOabUGwQ17F4hYb53qbwHgXScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0kFkjTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0kFkjTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA561F000E9;
	Wed, 12 Aug 2026 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547634;
	bh=foQITieku7Nv8uZHRWQS5q8JurL6AWudmaMM+YKgGx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0kFkjTbh0Lh2AiR01ouqyKQynbd603pdllgy87FSHq0FaonBXKtM7+1RCFV6Tyoz
	 rAc0AbC1xNCdablNfkDFK32oaoCu3dyiUVSrTI+mAUJzmOORVCPHAtRd+Tn1YZGO88
	 Tk1tcXGSuFDBBn7M77UaV2v8ymo+9/VE1xTGMyV4SV40hUlA19DS/TuUeoxafzxiOK
	 cw3SwG66k9JB2eLSc/0es5UXBx+1OYwPqzBCQWg41D7Ca5ScGNKy8ecCjlDEiXW3ld
	 lwak3KbDy2H1/f6GMIRDDL215HU04eua1+gKOdO+Lkm8ETms47PHyXgrgG6oV3hKP4
	 cZ1pf/BLP87+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/20] KVM: s390: vsie: Move SCAO validation into a
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-2-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-2-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:13:53 +0000
Message-Id: <20260812151354.6CA561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Improve readability as well as allow re-use in coming patches.
>=20
> In particular add the logic to be able to check the validity of BSCA and
> ESCA origin addresses.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D2

