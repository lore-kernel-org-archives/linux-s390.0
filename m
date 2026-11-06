Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997213;
	b=gxc8vTrAiizY2c9ZvsAI0JLIRoIJai2LRH2hn/oRt+mqdKf/vad7qmG5Zj2UNwyKKpX/
	 NgWvYNjhLv4dI7khWoVM/gQGkCqzhw7H1QF0Xs/TMr4UrjakPEpzDJtMBC1pnCmPPp2ky
	 ahZBlGGdmBxTiu5DzhH1B/VGfn+IESUfu6kLhg5PmRIgcxruh3pJfQIZJku74QKWve+2T
	 H9E+R4Y9fBhtY5NHfeFurVpFlkUYjWzBUueu0aS7E7jHvTOpigmUvx3z5SbzNFLL4n1iw
	 HTSiTQhAsu2/ylPE68FzZgPWmXX8bpu30hWOmk8vDNVNxe6bag3F6EmSQKfyHBagOnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3QHL4KXjhjBupvr2Drp8n2TIqznfIntTJAuFNq+qyu4=;
	b=ojejDSV58WmxPJGP7/Wgh57Pi1K5Q5ggFP0FPa7HEUR3NZPwWHVMjm7aQrUFOm9jYu6D
	 ngTdOV4enuDG2UDEo81PVoRw7xbqMvK35Czvg1vq7+MmSxqSwlghncCqsLI7avEj9vIDt
	 Pm/BmZOU03r+WGweRINWZHeMpOPIDkS8tKVtL6/dieDx7EhyEV1qxM74rdgRH85j8Aqlj
	 QFJIz389P5D09TYdUMj/0ZLWWTAq1+A2r0rJm6wP3Jw7OeN+nJh+PsaJ6L/GhtpHHUJ9/
	 cS8Qn9nqR8RElewZSsYsPI4TW6CYemKOu/PFXjAC3LpmZ6veWk723HkAZtBlkfxryQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtBjodbb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABC606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtBjodbb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380181F0089F;
	Fri,  6 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997213;
	bh=3QHL4KXjhjBupvr2Drp8n2TIqznfIntTJAuFNq+qyu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtBjodbbaeyqghZB51BQ3JzEXcascPQrxbNXD2vxJY4GxPMQXsMp3ncxqrumdw444
	 sZpQIyWNOjb2BviztWf0lhJFfspMzDMBLLs3KqEZfyGHxrh4AxGd8NWmCBl52tZ6VG
	 5jqu0u1ZU3n+5UCk1sn+TGlV+Vc0JlOLWc1TlfPM5POsnqCleSQfQsZWHmsjiBW4QG
	 mKbwNTikntryeiy9N9zNyufqFEoDaeYj3NtL2hbVQs1ptpWS6OHPQrvOYonHPc10jG
	 CBCAAuoX+uUu3TdEHjnYSQJn2IiKdsNmkjWwMOueOAzQeJ14zpQA3PJyILOIelbCKt
	 +qVQMSdjXcEZg==
Message-ID: <sashiko-outbox-202214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/15] syscalls: Make --abis parsing more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-1-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-1-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Some archs Makefile have something like this as the rule for making the
> syscall files:
>=20
>   cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
>=20
> The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
> where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes the
> rule for the file won't have a %, resulting in a trailing comma e.g.
> `--abis common,`.
>=20
> Currently this input is transformed into (common|). This is problematic
> because grep will then match any ABI because of the trailing `|`. Make the
> syscalls scripts more robust by removing any trailing comma.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D1

