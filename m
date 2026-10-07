Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64C3B776A
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374049; cv=none; b=IpzVHQntmV4Ul1/CP0AkfI/VTqsoPhEGU+7yn5qf9HbggbgSVfaq2sINt9IxahKbysYoU+M2eZuvhOebQW9CuCETVNBwMU8ZvdzOpho9Tod0GCd1LTAjH2BygtYBaYAdB5fJ23sX1efyl0yg5FPYIjaAISFnTaFEUzqWGbmfIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374049; c=relaxed/simple;
	bh=ftCKWcVQ7vAkV2BmfAkpr5NrX/dCeaHWMu/XDURFV6M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a+dknw/sdUOlv8J7tjK4x9lBWRj7sOOjpjjL6L7YGiPuKsDLZ02Ohmj0rLbr6rx9/bR72vT8APC851Cse/leUnDMs3gf1Lbj7E83rqVk2QjnbSMA4/Q35eGaM9rG6lrsiYg1th59K/BaONdOl36/CXzqnGUcKNsf+bx3NibLHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgqlkOno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgqlkOno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C61F0089F;
	Wed,  7 Oct 2026 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374038;
	bh=ftCKWcVQ7vAkV2BmfAkpr5NrX/dCeaHWMu/XDURFV6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgqlkOnonYxk882uWW3N/Plc5E19h6ygrs9ib6BGOkodmGmmsJTMGXCH2I6s+rWnw
	 dwEJjVePkcX7jBFx179ia9GnxiDfzKTLXieaa1sToAqMK/5/aOGBwfrEy1QEHNvNF9
	 SXO6bX/6mso8TIM0wngS+UqmcKMXGm9H0p0yKxfce77Je/wWLTPOYcFOLStWTw36uF
	 IEJkNuasP/9qE7Y+9pm8cc1bNY2iFnNwH0zCyH5mEeW7SSe2pieytIY4O2xVL0+wo3
	 z5YqXAmeJqbyoGkFmzMuTObvh9Eb9lLOfMGI+ur3iuRDaXK5xzSthreqKrinh3cKKK
	 bHw0J52uUPzjw==
Message-ID: <sashiko-outbox-162949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] s390/mm: Lazy MMU mode sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <1890ee88ced60e0d03d88e681b7e6dde6a6158fa.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <1890ee88ced60e0d03d88e681b7e6dde6a6158fa.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:53:57 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Detect PTE entries access in lazy MMU mode by means other
> than set_pte() and ptep_get() primitives, which would be
> a read hazard.
>=20
> The access to kasan shadow memory from ptep_get_lockless()
> mistakenly hits invalid access in case a concurrent lazy
> MMU access to the same PTE is happening. To avoid that
> disable instrumentation for ptep_get_lockless() altogether.
>=20
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D15

