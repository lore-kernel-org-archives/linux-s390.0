Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CE2AD00
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787470236; cv=none; b=MUXwOPHOq1F4Zi3GIP5WNMu+mwFBoAWUPX8FHpYAGYH0jpsmUCoVS+whrK+tHWHtJO3iBLIcPTWHeZWjgGbHRoPlOyySXwf6P+mnlJGhjrKnR1q4d85uFroLbyf7ciC5FbxR71nglhEY1gA3tjWRDp9Xe2EmSQt4cvqdGFBsmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787470236; c=relaxed/simple;
	bh=aEdsDN4qGL2Egtz2NickaqfjvR+uXYWcMsOgP8rDXY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bR+c5r5np6UA0EBQVsyq58DH9PhLUMcFCqEftrAzqkzbDNxlbvWbal1rBgePSuJDqHlZq/sHEPJqGYuhzTxCBYv5B99K5HSTnA/0OhfL57WfD7vgoYyWe9FvOqisJ2AAY/N61GhdZojZ40H5CROKiRHr/elT+G6LZ/k897j4Kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgODYu/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgODYu/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB31F000E9;
	Sun, 23 Aug 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787470235;
	bh=jA6CYvY62JzMxRBvOSjES9r81iXyV/kg5CgOjCLg1S0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgODYu/mJnKur5hDnA6IKJUC2Y1Tq6moIbpDVN5RInCpuOe3O0X6NA8fQG5dDsndH
	 gW+2oO0ZvLxRnSxl6jEx/qvbkITxIHWWu5bhpQmRxMnWZ1xiEHVkcQzho3GrQD0yFF
	 lAQpt4yR48qdjit4uSnH4Wp37657PsfbX+KOjlYZN7goSpioP+uhRsQxjJB/ftM4a9
	 EIoAh11+YCGg3MXXHOKdQnObPXsi6uk2+x63FEsR9wi23ssd2lf2tAsoi0gTh0NZE8
	 DBan/brFJl6o0Y08cNKnZlZRHa0pOKmhi+PSHbkso92jQZkP9b3xUBVKkgmbDIxbm8
	 BistYP8K39q9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: prevent device removal during
 connection setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Zhang" <marsy12010123@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260823071908.93212-1-marsy12010123@gmail.com>
References: <20260823071908.93212-1-marsy12010123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 07:30:34 +0000
Message-Id: <20260823073035.34CB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Chengfeng Ye <nicoyip.dev@gmail.com>
>=20
> smc_pnet_determine_gid() stores an smc_ib_device pointer in connection
> initialization data while holding smc_ib_devices.mutex. Connection setup
> keeps using the pointer after releasing the mutex, but device removal only
> waits for links which have already incremented lnk_cnt.
>=20
> This permits the following interleaving:
>=20
>   connection setup                 device removal
>   ----------------                 --------------
>   select smcibdev
>   store ini->smcrv2.ib_dev_v2
>   mutex_unlock()
>                                    remove smcibdev from the device list
> [ ... ]
>=20
> Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Signed-off-by: Qi Zhang <marsy12010123@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823071908.9321=
2-1-marsy12010123@gmail.com?part=3D1

