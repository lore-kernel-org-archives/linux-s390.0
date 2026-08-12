Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB793453A41;
	Wed, 12 Aug 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543393; cv=none; b=XeCzT7jD9UzbT525jLa8RNOr/blI+jTaPfofCjG1kOUs9x2Njn3lp35SU2BkVgRB+D6GN6Py5xrmO7R41R/Oq3taZbLpBgRlhc9MyIH6xzFXsUwFiKory+oFn55JLhRDO7EOmG/ZxUWZavP1gTx0O8p22FscStQE6DauHVdBaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543393; c=relaxed/simple;
	bh=Lj42kkXFCq0Ax/IQ3t85HqFrzen/l20/pe/wQ775UBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkIC5tdtvywvthk+J8cgRxrl05APlTwNnrD2FXc55GFaguEUJjJMigUPaTDoBCZ0wEAPjrt8tkC8WwODrTp4pPP14mYhlZc16CfREtNlK/k4k/H/m2xXHbQzVUsnehAmeMz4BoC0gJJQDcwmEaHYKZs9bSUEkBbJ70m0fsKK57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+bYK3PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+bYK3PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75E91F000E9;
	Wed, 12 Aug 2026 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543392;
	bh=Lj42kkXFCq0Ax/IQ3t85HqFrzen/l20/pe/wQ775UBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+bYK3PQ59Qosp0ddB88qEFtgPgEfVN1cN44QzTqIkZCiCFBq8He1000PBzWPY2PB
	 AgMLJXuGsyg3RNdCMjpxwW5yV06xdxmsQFXU22RQd+u8UEThsCdZpaHvEmyCgPh1bU
	 a9BnPFgrGeb9BzFeBYc9rq+fmNTomrkdATImORUf13Gov34HPV/bS6504BjsuB+6R3
	 Dc7rjqpOQ3gxe42WQo1dV5KsATDX/MOxwVn0AMORh//UmC6SnE8LOdQaETJvgckaDJ
	 5HUXaykqlYiA3cPdMmPvS8ZGuaNhrQCLk4onK/B1OYE0aCMtwdDlz/Lk9ociWnom6P
	 6I1iRnHorvoNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/20] KVM: s390: vsie: Replace radix_tree with
 xarray addr_to_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-9-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-9-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:03:11 +0000
Message-Id: <20260812140311.A75E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The underlying implementation of radix_tree is xarray since v4.20.
> Changing to the xarray API directly relaxes some of the locking
> obligations and provides more symmetry with the next vsie changes in
> the series.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D9

