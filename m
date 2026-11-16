Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851761;
	b=OQ6WGm4MZ+0UWqww1VcCRjR7D7+bKbdXbvQi5tVAtg/dXfhqdoBKYEFx7Bl4YD2jfGXg
	 lE09wzB0Du2TdZa8L4w+KNl1jZH13vGHqI4WQmzQo64RDt2LLt8FUUzR/wxrfEE+B0qX/
	 JVavgByuXDyCFpNoraSLM2Z8fZaJiFBOBo9J4JV6jAI8BTPcPG9kaDMgIlEmhxKaRv4xE
	 n5cM4H5UOXxWyDLKd6lPxJHWgGSRz/dE+tiDbkwmf5buthpmfgO3I8rqrMaeSfeuEYmwN
	 KUbmbePcOnXpyNnP4iJxpmL4JwIQchNcqStd823inVpd2EgJlZ8ujHQLOkveOLxC+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+DtAdwiUEzDGQ9yttMyiX2TLpqxhYAZiOTaRHt9ndrc=;
	b=CI2kt6ripLn5itOSSk9D7fpBIY5VPlQYLAk2L7TOn6r6l3Cn64eUIILHT7sILqmiYr60
	 9Fw052k/1p5YRLIaFJzZRIM6hruB7LzlXPb7qaujgLC7mCRAB3iqj18RXmxs39MjxoZA7
	 8ehMERRGknzOspuI+EzwR6X4eK7tuyGxCfxanlex0+ht349G5EnzHjv7PLCNy7gp4a5kW
	 YPWdhCn5n05vLzCQwpZS652nes4gNHtsRDyJJApo5K9XEJUm5G8TCfeQAlesPMvriDfOO
	 jzM7JcYD72kxm48c5tHwY13mwe0zS8iAV3VKG5ULW2sm3PQQOko45CQHvMc41jJYbDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nttDuZAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C3606A891
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nttDuZAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88351F000C4;
	Mon, 16 Nov 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851761;
	bh=+DtAdwiUEzDGQ9yttMyiX2TLpqxhYAZiOTaRHt9ndrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nttDuZAb+ZTmKPhkOY1LFdNx/vfuq9WGo3hk5IUPmMYfd9fapM0iBbLEW3UdiLLhZ
	 iFUy8dqqTl7zR7mYgKg7oHK+Z7if3gy2ehI+P5RMWj0THStK7Hd6IUYKUWuJ5p4tCU
	 byx/XvOb9YWgrtZl6Y0uVnPFRm9WFBO2vMPCDXGnwgjzeHmHjq1hos0FsGIZE/xY30
	 4y2M3NINv4xc9FqSMRLFg9WZj4QrAn4Tv9Jpb2R1yslaJyjOgcdQ+XYfDxKT5s7U4N
	 fwz4IFtHN1jJT0t1acJoo47QvraAk4mbCGsYt1JRfu3YAphxwOEwADw0zEAn3afGdO
	 pwauUHhSiJGaQ==
Message-ID: <sashiko-outbox-217463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] s390/cert_store: Fix out-of-bounds read in
 pr_dbf_vce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-15-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-15-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:56:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> pr_dbf_vce() dumps the last 128 bytes of the certificate data of a
> Verification Certificate Entry (VCE) into a debug area.
> However the address calculation is wrong: vce_length is the length of
> the whole entry including the header, while cert_data_buf starts
> behind the header. Therefore the dump starts at the end of the entry
> and starts reading behind it.
>=20
> Dump the last 128 bytes of the entry like intended. Limit dumps to the
> data length.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D14

