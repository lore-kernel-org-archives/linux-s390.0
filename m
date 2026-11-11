Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418373;
	b=yWlBj8m1h+0cvyAsvSDDpt1Zg+jY1U+rr5IU315qAOsRGkurb45UFiuAA3+c9m5A2BEm
	 38wHpgQdfK+tOevehIDh7+rBNn6xcOTWYKIr5hkKHt/IcS4FKnUCxcewopspnlP0DsCPw
	 Jx2wjboEMLlfVA6XTDxeQQpkwbQ+8I59+UAU0/edXrMhTe4sbe0+glXzu3fcbcoLwYsCf
	 n3zlaN7VnCoYDnqIc47zLFUQj2IJWk5Q9MwWAfdrxTu1GEtDVR/hhnFm78gyG9/H+8t3A
	 OFbczq3SmysOqXJOv0aerxES+pJ3iVr8qz5R1Z4ogb5cD1ZzNs44+otk8oLTK206L8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ms6SCAGUYNb4PBEPFKWhZPqpF1vwhHysE0jtoPMTVt4=;
	b=IQk2lErYqq0GXj6JQXhqX2EzcY2C4tXZnf5LyPoL4cBMQRBT5TOkM+tjS+Hp+MvHlikx
	 jY+RJOfwnhxMAcdk4o5Yfbq1aoMun8jI5iR0V7DmGiARPf9dIT5LPY78HofiGbyvAYcsZ
	 qGSCNN4J5vGYeDVvmm2f0e9nG2fEr7PiXFHcemPDnhrrYUA/WRMApeBQ0qFmUXvfpWRdT
	 OTNbwGzSJGR0RatpoP69dTIR7VyQgcxc8eZdJGJhy+Bjbc+kaMGYz5Cj09LXTD1QhzX5X
	 yWd7OEO7YG31rkdRZpPLKo6Qdc/ZqAG269Q9gk/dk24uwZxRWNsl4uKMON76Bi+gLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9TLdfJI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A487606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9TLdfJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E251F00A06;
	Wed, 11 Nov 2026 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418373;
	bh=Ms6SCAGUYNb4PBEPFKWhZPqpF1vwhHysE0jtoPMTVt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9TLdfJINn/Nr4WF6ZMCCALy0N9Dt8bnk+ecD6viYyJ8iCN4wZKMDKo4O3Jh4NRuJ
	 oDW/J6afGde7qrevQnVVuY48cd/FviZjiVUhrUDQwIjFskrNzzx+PL1UIbhdQ7GnPo
	 yBsJtx7YF4uSANcPZ5hQA0AGp+cygWS8/KFAjbU2E8uTHPRiKLiJB0f3IOkl6WfH+R
	 OoYdWlxa5+2JTIBYbFBaMI5phTDqiQGvvPuEIFHK85I+Eqp5pQkrX31ZdRCd0oH/Se
	 PMtwWKSIZCMPZKFTpNDtWXuW1/qNxh31AsCsxUNB3SVBExxbX5yzW71hhfdEbBrP3A
	 8FR2qy7f8wWyA==
Message-ID: <sashiko-outbox-209415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/5] s390/pci: Improve FMB memory management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111162758.9792-4-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
 <20261111162758.9792-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:32:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Refactor the FMB memory management code to use kzalloc() instead of a
> dedicated kmem_cache. kzalloc() already guarantees adequate alignment
> for power-of-two sizes, rendering the kmem_cache approach unnecessary.
> This simplifies both the initialization and cleanup procedures.
>=20
> Allocate the FMB once upon first enable and keep it for the lifetime of
> the zdev instead of freeing it on every disable. Defer freeing the
> buffer until device teardown in zpci_release_device(). Add the field
> fmb_enabled to struct zpci_dev as the new FMB liveness bool, since a
> non-null FMB pointer no longer implies FMB enablement in firmware.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111162758.9792=
-1-oelghoul@linux.ibm.com?part=3D3

