Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C2430312;
	Mon,  6 Jul 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330543; cv=none; b=gub9CbDKJrKS7PDmj2xQwPORYV8i0EJ13TDbzwhoqtvsxr4lzQqKUEEVobOQkfo4hdjVUyGLh5iW903858SUPKT+w+RAyVBMLYswf3bdsIUtTjPvvLZt/wxqFlsypeT5eKLcbluk9OnHRHB8f8tpssH85l/S7uirDqxS4GFQvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330543; c=relaxed/simple;
	bh=IhbG/1QV63gAFn8zPHNCerEvyNwKUHmhB8DFfJQJytE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MugDg8BD6aingOOWB8m+oup/6kB1F8NUatVp/j9LjFE5kkx+PbmbHNr4oLFw/HxGtOsAoYg/s29sv+VZrzk19Hc5zn04BVIf2oZkvzSQ44XnKiXbBZke3BDZm/AoMOkd2KBXb2c0axsNXnGHknWI08/Oa9OoSagXwfVoqHMfhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0+4Eqx+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0+4Eqx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0AF1F000E9;
	Mon,  6 Jul 2026 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330539;
	bh=tHiAZf2QB0WMW2DRWk7c4hSkp0NEHRow5vX9K/vO/js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0+4Eqx+pxy92SEvL6mF3g3H7y00p32rG1agX38W88kmogS2YpjnBFUeIRm8Kt71o
	 XJol6gFtTgJXO6VHoRqtVmue4WjLQoA6b/8pWntLH2EcXZL67EflUirVDai3UjTLRx
	 i/djtho+OGBqmxFR1Jug+BK5HqMMZyzKa2o0E8eEoRVgs6DgngVY6cpZdsSJVSfUcF
	 ClaPCk4EW09K8/yh5BdMA9K8UMGC44NB3JoERnYIWvhA67nNzqvBGYo+sACPv4zxWd
	 LlYQD5GlBAGKz5DkYxArVCAOSnK+5DxIXKl0l1eoMm8Lcu2xL/S5ino+HAjtEidI74
	 DoCDSLcV64u5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/27] KVM: s390: Move s390 kvm code into a
 subdirectory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-15-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:35:37 +0000
Message-Id: <20260706093538.1A0AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The files `pci.c` and `pci.h` were moved from `arch/s390/kvm/` to t=
he `s390/` subdirectory (`arch/s390/kvm/s390/`), but their specific entry i=
n the `MAINTAINERS` file was not updated to reflect this change.
--

commit c2f3b449a0f094fa44a079aff2968b331a351e17
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Move s390 kvm code into a subdirectory
   =20
Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to later
share gmap code between KVM implementations.
   =20
No functional change.

[ ... ]

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/s390/pci.c
> similarity index 100%
> rename from arch/s390/kvm/pci.c
> rename to arch/s390/kvm/s390/pci.c

[Severity: Low]
Since these files are moving to the new s390/ subdirectory, should the
MAINTAINERS file also be updated?

The current maintainers entry tracks this path:
F:      arch/s390/kvm/pci*

Because the path has changed, the get_maintainer script might fail to inclu=
de
the subsystem reviewers on future patches for these files. Is it worth
updating the pattern to arch/s390/kvm/s390/pci* in this commit?

> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/s390/pci.h
> similarity index 100%
> rename from arch/s390/kvm/pci.h
> rename to arch/s390/kvm/s390/pci.h

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D14
