Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421680;
	b=gtRs6fpSJl+DoHZBD9CTofVHEGxOhxIJQucR9JgZe3E3vRiaPGNbXBEqQ/Jj6lX+tvQF
	 mkzAQpiEKQYGdTcKEg4jZ1TpRMwYGPp898Lfxay9MJKBX0gOKdwqoA0nkmM5eiKSNtfd1
	 nFiAeFJMasvoL4yQB7cBMJ0B5OdaGAhVz3G1b8YACtcuF7jsAiuLCMB9zBerrprPB7+4R
	 cq0O6e6unEAkGPYgszvaidFKPwZKgRO9aEAb/h4O0Agbuba1QoQOVOChlYfIHokNSFCe1
	 ai4l37CzIV2MzFfQ7v7KL8AamlUSaaY7fz91oOQlq41WjpcCjz01HljJAMBZZKqHoQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421680;
	h=Received:Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Date;
	bh=Q11luggSm8mm1dxT2r915WM+wuyuWy5YCjdgEfM22Rw=;
	b=eV8L49H/IBh0g1HIaeXKt/DNqxOuNJfnhRJ6YciiIPFjg3pPbXRWHCw6zqj6nRiqW1ez
	 QplXKRdKbygwpcRFDErKbPbssXxhgBRtg7uN0hcfr4j1uxMGbR+OEtTqDBh1LB4L3VGcM
	 8uSpO/goU/oeE6ekZwpZfe6f9KU6pnLrGIY7h3fUwAZVXb1IbEbhsuUTYFB1hwQiqm8s0
	 7MdsFvUDZEy4kisrTOZWeqAsXfEUwudKfAlYHlcu54/vN+Cg/34HIq6RjNY06sRccTNBN
	 8InvjVpRqlYGLNfPDiFVK65DN5dfoV3ka0B0bvdTmCxAlrHEc+Tkh1wvonVLptiCivQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lH5WqyZT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9395606DA7A
	for <linux-s390.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lH5WqyZT
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFD3451CE
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421679; cv=none; b=L/HNtWIBDXyCHNhnONCAEEE3oDqiUp0ucNpyo9QZtI4voaONaHXSIc1eIXFc8Nmsu5EaysojGkAUeb7+Gg8LsYCdfmSMOieeMTQUHHf/zjPUbQlhj0UBKKwqqZ314ZS+sC0hIBs6nE2SIC4QQl4XeCA8dIKtuJy9sm2QEyWPRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421679; c=relaxed/simple;
	bh=Q11luggSm8mm1dxT2r915WM+wuyuWy5YCjdgEfM22Rw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VP2Ou8JDjaeP5temG6BAsCPIWP6CUMPC/tsVSFt0inirQjeJNg54C/7vGijtT9svmlsSh/oXUTr99sTIwq5MvZf594ZqLc1I7rPwvH8TXv852dVNV7qeir3Se/RXMey/iGrh95Pdxdhjp/vKUDRtTF2389WFc+lq1Pz2MY10RRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH5WqyZT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A51F000C4;
	Mon, 19 Oct 2026 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421678;
	bh=Q11luggSm8mm1dxT2r915WM+wuyuWy5YCjdgEfM22Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lH5WqyZTtqGA5N1dJ75A+xUCClccwSHsETqgONXZ1y+ebqCnuXCt9brslei0L7s/a
	 3rfWMuGm181R1jHHvnsw5QpQBNG5Qrpk/sFi0PAhRKt4dlC5QTgd3gBU3Xf9UYz9W8
	 pb/aXgXAKz4FV3jF2auz8FjwSPnbKVnJE7QeTNu94Xq7mPbsWLdm5VJm5YXDK6duqq
	 hw7/hJwvCDjZwKOiqNz2mujqxmKWyYbYubq3u4v/wRbjPQgkeS5pUkgqHuCB1CF+x1
	 EVCE+Vi6qqYrgfEuU1izgOB27DMg/Tj07MT+1LoJqhNPP30MxI4/YFbgoDGZxfNffy
	 ZxkMPygvWLsfQ==
Message-ID: <sashiko-outbox-177547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] s390/dasd: Snapshot intrc before
 freeing the request block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019135441.1420968-284-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-284-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:54:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Stefan Haberland <sth@linux.ibm.com>
>=20
> [ Upstream commit dc3e3f7306cb74066f231251602b1be5aaec7bd8 ]
>=20
> __dasd_cleanup_cqr() maps the completion result to a block status by
> reading cqr->intrc, but only after discipline->free_cp() has returned the
> request block to its memory pool (dasd_eckd_free_cp() ends in
> dasd_sfree_request()). On SMP another CPU can reallocate that block and
> overwrite cqr->intrc before it is read, completing the request with the
> wrong error. proc_bytes is already snapshotted before free_cp() for the
> same reason; do the same for intrc.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Link: https://patch.msgid.link/20260805111612.1285190-5-sth@linux.ibm.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-284-sashal@kernel.org?part=3D1

