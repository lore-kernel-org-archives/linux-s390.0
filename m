Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851712;
	b=Ah/2fkGwGOUsHTBfXR6Qcd+UL4prBlUTYGBRPTbdRyZrY2OYpNdHVmGCvF7MtQ7tjlCj
	 zjrsAgL/JBliUpwQYV0b1X+uPlElpsrNIBJhyHZ3WV8eBCA8gd/6S1s8fJQbpylEZrxsk
	 j1Dwoq00XR4pP02upKQ8RGZtAGKRyg+7LpbH3r+MtRhD5bBTyp8F9Tg838vPu8yUIsFHS
	 PjouX+D/5w8gHki+EEfwmYhpjqpmqHOymW/MeUJFzmXYCfOKSyl6NBCsBKPAlJEtBwI51
	 SnIfbaS6wpsgEiOxl/M+TptfFWTu42qJQsWMig+qKlQWEJFR0TWCKbBwWDgzQwV/RFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vNdcbKuMjVVGvz931yLOwj4cLnfKXnwnEotSv4ca/1M=;
	b=KiEm5liBm9/P/pNZQ2kpWl+ApLRZqsOEsjAto9ZSSub2uorGNDFHLo5ozXAYiVcUvGjO
	 UTXyPTUKU2/nHNiPXowbgsziFoOs66N7LmErZnOveG+eSci3hk41ay2YQmPESm3svCcRD
	 pqOIRJLCYNdX0cAaTOKUGiVAU2JZ4pykn1rDOKqz0a/YqTOq81xDJZ2gbMH270dzrxmsA
	 8iUl/Yt5Saf1/KGq/L0RjpseKrsrFpv1C3mR1x4T2cgZiAjBOymQt53MVKKEzZxX5sXP3
	 1rsDFfFSTecHh1JdfDAGPXLJGnRxt6AUYZX6bVfTDR7zUmDnqBYhZQK2SJIyo1ufNew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTfOTfx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1D606A32C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTfOTfx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F971F000C9;
	Mon, 16 Nov 2026 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851712;
	bh=vNdcbKuMjVVGvz931yLOwj4cLnfKXnwnEotSv4ca/1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTfOTfx3Tgy6xniX0DSFjFD8kwgVRgws5cf+VgUXI6CzzU9d8tTqRDhUAXJZrcLnr
	 NQParYYae739CodjjrXek6MX3MIRusB6Fsh79JPg3a9bID4hF3EYUPIwyyZ1gKIe0W
	 nJzBcd0cYZUR0sk6Oad+UW79GTQ1frA3WegJmCx4SF/DnVl2ri8KcS7Jkp+0nECCev
	 Tz/MUtOV+29fl9IJMXB408jR3yiCNN1BBbUFYJdD/4F6TnfQUBkGP8e7GvEMmQbE+L
	 3b5BhCKwTVzdBS7hgwBh/n0IdSkZ6aghL5ivph/Nwvehu4NB6AjOw3XatESdDi04o/
	 78U7UZNGjhcfQ==
Message-ID: <sashiko-outbox-217457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] s390/cert_store: Initialize ism array in
 query_diag320_subcodes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-16-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-16-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:55:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The Installed Subcode Block returned by DIAG 320 subcode 0 may be smaller
> than the ism array. Initialize it to avoid copying uninitialized data to
> the debug area.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D15

