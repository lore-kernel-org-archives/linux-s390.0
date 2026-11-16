Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827960;
	b=XwOG6gtG7Q0Ay//aMiIfQIkPE6DGNAUldu2YCwcqDYwl9zhMbNwAn3eDDynfMWGsBFBn
	 qRwWW2MDGMMIWwsbINbvddzW4wxuheho4CnhlNsRCzm5Onw5w8tVKm5puQZnUhz8saVjD
	 RJQLEaKGaBdGK6QPqIkTx4e+sYxZ24N+aaZ9AcxxvOrzNO5E+l43fWs4JaLljfs6tum4+
	 hFX9LqCyjFMp4VesOwh5khT9vZ4oqRnevX7kTKVA599MhjibkmCsmLSEXZ5EGUQSLwpyp
	 CW3E6SHwVdwLP4vF8KtHyC7jUK3DwtTTS59KlvxsoyLXRosSNcPea3wjwMbq+iS2dzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qdSo7TaH2MhsvrsZyPMcZGWa0uUR6qxpEywciS1hW6M=;
	b=EWnKbFPC7se5eSlKmN+bDnaaOxVxdUMngku/FCaNlYLgHy8LXxLfBLsBzMCV7FSfL3hP
	 O4prLMsg8PTsVJzXt7xXmh73UNXqgxrCpqLzINX7EJKNKr+bSsPF9t45vLr2cAvjJSmHW
	 WwTbiXieJ34HNjd7ECp/SbB5hHUAV7bCw4qcegZmxH0tNoq4xIucwGYzX/xbEyXD69CBg
	 rwPHQU2zeSLYBCmxajOOTtvct+lyLRJQwE3S2TI0ChpLin172YI+kZjOcL3T6mPNORiDQ
	 f3jFoFXnEYWwBa+rJFHcGi/uidpX2sbYke7kV+ykZha0XDOq1BFVbRa8oa8dVj9lcIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XPreYoJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DE606A883;
	Mon, 16 Nov 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPreYoJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C71F000C4;
	Mon, 16 Nov 2026 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827960;
	bh=qdSo7TaH2MhsvrsZyPMcZGWa0uUR6qxpEywciS1hW6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPreYoJ/ohLnrwlzgyJRDP7iHQkOpMrIe0hJRfOhmN+auwSC5jnTSSRyJQc84tsfb
	 b9k6Ms008HV3IoHWxBl6GO3XvtEjpiBayXmUg3neXKkpnXhTdUU0pE++/Z/kdvsovd
	 B+c37Kd9LUsQm6QpuJJuz7nsLWkdp6qzMN8yMHwZjtr/d1V1tbbNMwcXqoNcxCUijV
	 8JBa0BhoZJO2GTMfUGDCs2Nj7BsZ2spbzLZr/guly3Kxr0n7GVegcIscldzLrvD2fl
	 pWE6Godwq4LWKKM2fLVeha5ytMIs1AmKYqUvMOQ9recPLtlLoLz1XhsCH8eDtL1Uut
	 oeG5MPjSNRrNg==
Message-ID: <sashiko-outbox-216887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 22/44] sunrpc: use fc_init_pseudo() for
 rpc_pipefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-22-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-22-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:19:19 +0000
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
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D22

