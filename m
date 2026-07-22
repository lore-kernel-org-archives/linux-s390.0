Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAA345EA9;
	Wed, 22 Jul 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740753; cv=none; b=Ii3wC6vKYPqfgFUKaFLe6dSn0VoKkUpgrNXleP7mb2qQUMybmf1SZAT+vs7YY4hcIrq9/IVlgkH12Gn0l7fXE04CmrFz7CctY/Axj044HAkepIGfLSJRNPm3L+7OJi+9WTWXhCXPvog4EiIRwEDYvVVzdryddsRkfc/O9BhERps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740753; c=relaxed/simple;
	bh=HXrVcKuHe7ErJ4IuVlPEy7SdhF1SNTtZsZk0OYE3H4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SgbbsUeVuE3Ka8xBYKWEPNEj44X0qnDi50JWAcrghgIpG6Bb1+Do5PByCaunsUj93GOaAaySnul6a3BAYgs4TOLEtNtw78utz/VvBcX7UyhNImhocoH4IWs9CAIwsohL3ZkuhIc6WKP/zwae2koDaMbCpTF/tjROIYIMSMOVSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ZgC158; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ZgC158"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8BC1F000E9;
	Wed, 22 Jul 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740752;
	bh=HXrVcKuHe7ErJ4IuVlPEy7SdhF1SNTtZsZk0OYE3H4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0ZgC158JIajx6jgPiBNw6W0Wn5vECNLGARU0IGOo0BCQIKAXmdVMo7YeJLo6Ca0d
	 OaiEMoAdoIR+XK0PGyslakNVy08mP+NSKKmDuAHAXne0P2G65sjwWc/zqkHMT5T7eZ
	 WJvvj6ZbkkVjq30iJJXoXQGxxOShmwPXyVai/T/88X9PcDAq66xvVg2BpMt0sXX58q
	 UodoXL8OPLCdhDTPHiXl0lGn1ohZJ74Uv3pHmLI/y9D/bRB9wS9h0W/dCXmka40+2b
	 DLXOIdtV8Zt2L7jtQu0ac/f5vXWy/vkBXvWVYmw29iV1IG6DBxWvOJJHvwe52lHdd1
	 /ArZEszgZupwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260722170621.1686-5-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:19:11 +0000
Message-Id: <20260722171912.5F8BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The airq_iv_create() can return NULL on failure, but the return value was
> never checked. If it fails, zdev->aibv will be NULL and fail when
> derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previous=
ly
> allocated AISB bit and zdev->aisb on failure.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D4

