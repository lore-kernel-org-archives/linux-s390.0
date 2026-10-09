Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF154D0CC1;
	Fri,  9 Oct 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546819; cv=none; b=pVQ8IKae2cYLXbIjJFXo8E/KoFWGvsWcvW3qVQCDbIibqxsVkr9kJmLEFLlj5Auol9bWE2lBRhcIa65yxNzkRwgHBvsUDl4tgGY60FY7RzKtoUsLZJ9WcYCWd6RuW0PpsVgmR7LDOL/g5WbagFXSG7IkWZI/32+A00QDbzNAAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546819; c=relaxed/simple;
	bh=rfTVmHPNHAii56G5QwnwOEAiCxz5PhUYG8i3+ULkr8U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OvfME3C+c1wgx+nPnGk/FI3S/D2WqRpBz79AL1wzKv71/Z7SS0l3p2GqpxnBSjbqkTzRjHKqq1WSXsqRJUm+ec/hgeM8ShPRyA4ibsLa4inWStZ2/5ogSCbcCnycqy7r6PbYdjQmpLq7A7waOGGxZ7zMjd8PwkDh8J6SLZADzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJPuVARk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJPuVARk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A15A1F000FF;
	Fri,  9 Oct 2026 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546806;
	bh=zxqJ1dGOmHRaC/UehFaQHY9Jh4AaVgaTrcpjSFIKHqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJPuVARkJM2+AfNBOv8HpiDqeJv7toDmyWQd1LDpl/1giAi4RrCW2QNrodELP4cns
	 iqUiTLsXpjgbIZw/5u3fSyIItUd5UufkfpUZ5COkH8ObwC+fXfpbz1vw0td9vsg7P7
	 Wyu4jkflmSWpx3xV9JUEpZPUgLeT5pkmBtYTS/7PxINB9P2sOlo71wqNBu3l87+C0N
	 i8c2xTV+fFQDftFhOH1jEoPh3p2dM2nnAiwSYSKiiC45eQUxIctfRLXrvB99mz8CML
	 iUYmV2KJKVBGY3DVaX/E69VS3arUjmcZqNPcNVMvSR1dkPWiI7d6uvHz3iJ27e6wVK
	 VlcoCeIO49NRg==
Message-ID: <sashiko-outbox-165442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-16-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:53:24 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: vfio-ap: incorrect host reference in destination host configur=
ation section
--

commit b9b160f01756abd52de1ef4f9e6032ef6704eaea
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s39=
0/vfio-ap.rst
> index ac0c07f76ddd7..02d7cbe5e4791 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
[ ... ]
> +  * Display the AP configuration of the destination host with the follow=
ing
> +    two commands:
> +
> +    .. code-block:: bash
> +
> +       lszcrypt -V
> +       cat /sys/bus/ap/ap_control_domain_mask
> +
> +    .. note::
> +       The ``lszcrypt -V`` command lists the AP cards (adapters) and que=
ue
> +       devices on the host system; for example:
> +
> +       .. code-block:: bash
> +
> +          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +          CARD.DOMAIN TYPE  MODE         DRIVER
> +          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +          00          CEX5C CCA-Coproc   cex4card
> +          00.0033     CEX5C CCA-Coproc   vfio_ap
> +          00.003a     CEX5C CCA-Coproc   vfio_ap
> +          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +       Each bit in the ap_control_domain_mask corresponds to
> +       domain numbers 0-255. If a bit is set to one, then
> +       the control domain is available on the source host. For
> +       example:

[Severity: Low]
Does this mistakenly refer to the "source host" instead of the "destination
host"?

This section appears to be explaining the ap_control_domain_mask of the
destination host based on the commands above it, which display the
configuration for the destination host.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D15
