Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B0381EB4;
	Wed,  7 Oct 2026 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382018; cv=none; b=Hb7xOyygeUOpD376CAWUux8EWi58NcxfzotjTnb2iXmc96SqMM62yWgyuI0EHczNajSrl/Xde6wkMErQpHuqA5bYWodH9ZO6eGvWHmaZ80qweMxCE+92MaDk96WCMH4nk598PY5VUCUozqhqW/zWsfqlfu+gQ6DjB24Fo7u0PLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382018; c=relaxed/simple;
	bh=+wSgnlX/eCvtxXODQeQhUeFBKYk7WPyQFeeuxyG2GV4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CE/N8PpXI+d+f9UxoNrM6B49NbEJzXJj2QODPUX0iIth4kVVU9hEM2miaSuw0mhc2jOPdFhPQPUnafOFeW/0hbi47veIi+qOIREULtPSeep5DdrJW0TamoQ/5mjAs7D6bYg/Kw4SDzXPjwiglx77HqcqByXMCOeRCqlo6+614DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et7H54Js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et7H54Js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909DB1F0089B;
	Wed,  7 Oct 2026 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382008;
	bh=+wSgnlX/eCvtxXODQeQhUeFBKYk7WPyQFeeuxyG2GV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=et7H54Js4n0IwLL8/P7kl2Q5JzoVF+eL6KIIpTqhfMbiNuZ6WH92zFEJieXlxLbVf
	 PUYUESCais/gRB+HcqCgI06bIsl6LAguoJxpF2I3A+xLq6fcTyce84JpoG1fYy/unr
	 bDsSN/hB1/5eckZ3IyFEaqpdAJ59HS5KpwTUF9VL0H/zncMZ0+jJowIRfM9uaKHDaf
	 P35m+FV5D4mf79QRrm84iuYnTVPfi4RcbmIQNwIPk5Zy2kTOduUfvpOgP0IGMbNeUu
	 6+nqfUW6tIW/XlxzDK/G0Tm1WqEZjS861tJEudlX288pSiguK/a3Z3vj0U3p8lVomX
	 ExS7uSmprk51Q==
Message-ID: <sashiko-outbox-163086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261007135926.82935-4-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:06:48 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007135926.8293=
5-1-oelghoul@linux.ibm.com?part=3D3

