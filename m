Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302761;
	b=BP+2+B1KNa08N0AQRDaTZAtgEBPXHTVk1lPbN2FXjNYZHwpz7aQJ3fwwH368D/lCDurh
	 AUZhTVOAzY6oNimjZ5h/G2l1AaNUg4scHlsdxtAU8M/3iL6kivMC91C5+CJ5mZL6b9s3H
	 cyB4gmEFQi1rDS26v5sLTPTELDtN8kzA4dqNxfqOyrkR/gWC6suRoSePTDTSGf5MfWQLF
	 X7NKgfwIDcNtRrsblnRohKGu7uFmRfbMWwtiSzWrWRNoeOjWon/79bh/3lf50WlsLHz1H
	 MxPALiIL8LQftZjppNBYIHIjexmgZuNGO8A9jVT2icMPOGBVaLxTSBy7+5OA0K7aLEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z4I5lGKfPPdPtzV+5DSo7bwm6NSc60XbHGA8+q551Zs=;
	b=0RNytI520w3pPagBO5IgH3HW1uteZg7Rd45sJ4C0ID3pJt/nj+SVplJUo1mPKPlI82Ze
	 69gtZzMjAEPMb/CJ8O3jwXgcubFvZ+xCZVuDv0bqkBUdWi3bD5k8DGhvr5vNCXA/ARGja
	 sCZcqj7rGbYwWYllY6mU2haMkutUOY2H+V69uzTARlt7serlH4Fjn66uva2CzMbZuC/yp
	 lKdDyHbMoJ1iVhM3mA+M1KOeLz4fYu0tz+XjA/Y9XSb/GxaIUF8Rj6Y5J1e57dkMescYO
	 YAaWR3T+dPJDpwn7zG5CWJvBh0+gTQJYsGydtrfzDbaD2BEwQppvL2zwDhoap704cPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIPHCLhk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0C606B15E;
	Tue, 10 Nov 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIPHCLhk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8B51F008A1;
	Tue, 10 Nov 2026 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302761;
	bh=Z4I5lGKfPPdPtzV+5DSo7bwm6NSc60XbHGA8+q551Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIPHCLhkJ9RYW5tI7KAw193Ci4N57Q5HLW2pohTiIIhL9ex5Rxp/yb/Y44SzWSViZ
	 9mXStRJ3HJjaGkWNmJ9gMpW7CIVEnPhubQliCHrIUvHiFGNg4ikKUqxgVl+5/Q7kx4
	 HO3qfVLR5n1RZuO61anzZpc4JYHcHhYXUmwPqP/6bc02l6YuqwKjGQQrhxkMQnPQox
	 b8G6d56AI4eUI2LcPW2He/OwPPdgW25DStBXzEv0xOj8pUMNWc4CPPI6CVzg0WMd3I
	 nyQhD2jJVKX3Hw/kLNmNKzjEJ9Ot7fpTixbtlsfRQTxQ95qnt2nz+5q17HKJlJzK64
	 QqBIr2QXsP/Vw==
Message-ID: <sashiko-outbox-206742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D22

