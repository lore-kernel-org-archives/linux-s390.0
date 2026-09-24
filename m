Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A82EA173
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230801; cv=none; b=RHxLpt+pDtodTvhCn5qH8fsX/rd4ve02j0w3t/ajpyT6Qrm05v/2wmg8lrueIiZWtg4dP/MKrNu6XIdgWfTtCjwqG0j7zpt7S+8tc8p5hmFi11RNHzaAbScrifq7BjXx1Ug4Uzd1dfh/EnltcMfEm8hmYDzX351mc9oVBG/0kmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230801; c=relaxed/simple;
	bh=VkDsf3G8wK3ggtrVvj+ngpssgGxt4lKcKju2LkgUl0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6ALrlgXlRNBFzLBwiKJbXVPC4AOGpXYr6hikHZhDDP4gcCqK0DiZkvtLpPDzbOhi5GNs2RlN83d08vLRLYEwc2r57euGHjJ+8Pnow9BptDH+n35X2vOmpCe6Bhgj4wzc/XPWuHMPiumSqfOtI0/rA4ULBJsevPK/I200Edqc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSaGrpRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSaGrpRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514361F000FF;
	Thu, 24 Sep 2026 06:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230799;
	bh=VkDsf3G8wK3ggtrVvj+ngpssgGxt4lKcKju2LkgUl0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSaGrpREnHN208GM9+S9bHGwQBiD/D8n2I4IndMooHq6UbdhGMPxcVxNvBJzM1HJ3
	 d7MK37WpdRXRPW03Z3ArcyDVPiGSmcsSjhhHgjB5KWQAW9rseE97N/8ACr0YfaAICz
	 QbVRiIE3VgVXB/W0o6mQx01czOPT3IH+dl4vLy9hW7HLGTdOOCev5YkVRkwM+Z+kAM
	 5WSEI5VaYCfHrjDd4BLGlUbZF93v1pVkIISf2MqxBD0RrYZ7+MKxQCqA7t4Fts77kt
	 4Val2dTiwt1hA05jHJ4Op68Pu+UhsPH+701L2/vebnk9VSnKy9QF3QKezWvdgwH+YU
	 zlxc6VsVfxsIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924060923.3076902-2-nikh1092@linux.ibm.com>
References: <20260924060923.3076902-1-nikh1092@linux.ibm.com>
 <20260924060923.3076902-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:19:58 +0000
Message-Id: <20260924061959.514361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060923.3076=
902-1-nikh1092@linux.ibm.com?part=3D1

