Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AD50B433;
	Fri, 18 Sep 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746333; cv=none; b=sDR3xoribRlyuWcr8U79j8DnfJ8C8jByNHBrmfyi1WASmmw8ra9J6JIW0WPNVLQ6Ryc4xd9Vg3VtvjmYld7NuIwh3gPGL2HHo+HM/CFfx9ff3SPKMJuMVUhKvye32OxZHetyoRyMISJUzh/oTTpxjxSKcX1UVGoR8LmfjXs8jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746333; c=relaxed/simple;
	bh=rtmJUy4o5LspSiMWCwwO7xWs5PyHglZhGdIj0Zr50mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCScb9kNkSd94tfBRYLoOX/vu17S5weIJN3AOMQQW0l7RrrSPg/ILJJNqgAFCwCGf89/CBgyn7ebPm5OAOxI/XHwpoXZPxmdZMBeq2hl/bJccBB8RBpqjPhF+LyPPfFgz+eXN1kozdJ3Y93OvLTpuHigUB9hs1HkImI5UG16DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrUXTWSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrUXTWSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE3A1F00898;
	Fri, 18 Sep 2026 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746332;
	bh=1lffAiDdg8IlnjBIV8SP5ZlnmQzBPl/UjE0UvWVxMhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrUXTWSB9+Xq1HntX5OZX6C1QgGi8MpeFhwJs2By3gPR/8bda5CC5pncn3z7ItCOt
	 PCmwzJYYXAEmMTxWBQ30kr5e0C72D7kgXKCgomgtOKjRmkZr8DKkzhime+HCdogaem
	 h0+JGlP0MiFcvXUB5ojpKUSm+EGv+u1iGICt88ELL/sigufoxJy4ekVv221Js8wkA/
	 jIOzmdWAF6R65EA4MKbghCPwdMZ9P4ijIwTYrVUaV6GJ5aAE8VTqkq7Z5zH/rtnevx
	 f/rQd67WkFdfKcuSZnuyYd1fS9zNGIDLrMxAxu+J9Hg/WPyVhWTCB+Swk/OfF2DP7r
	 KhVjSGGN45HwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-18-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-18-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:45:31 +0000
Message-Id: <20260918154531.DDE3A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce two new module parameters allowing to keep more shadow
> structures
>=20
> * vsie_shadow_scb_max
>   Override the maximum number of VSIE control blocks / vsie_pages to
>   shadow in guest-1 that are not using the SSCA. KVM will either use
>   this value or the number of current VCPUs. Either way the number will
>   be capped to 256. This is the number of guest-3 control blocks / CPUs
>   to keep shadowed to minimize the repeated shadowing effort.
>=20
> * vsie_shadow_sca_max
>   Override the maximum number of VSIE system control areas / SSCAs to
>   shadow in guest-1. KVM will use a minimum of the current number of
>   vCPUs and a maximum of 256 or this value if it is lower.
>   This is the number of guest-3 system control areas / VMs to keep
>   shadowed to minimize repeated shadowing effort.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D18

