Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111748;
	b=Wh80g2CB7xMeYLO7mtQ00YXj5ZQJ+77WYV59Pjf9uHskMqwUsC894xHSpsYIOAmc78Eh
	 2VSAf77MTEMLR9Sgq4mhwvtdayC4hBqiWWRIaLr4C0XDbHYKkLFIsSi8E4FReFMfKpRs+
	 x1vw7J5QhLzG3szB/kcTrbZW7GYqkmNCK5loEy9FpwU4UvMGxyNd2+qcNLtPxBWw+mtFW
	 4d5+S3t+i5chx8qdb+H+ktA6ABHAf9faEPk/piMN2ruj5SSAIW6AHOdS3dCJWtmKpLkiC
	 Qi6zNOw1TmHxdSZyXnTqZMzFrIfOysOqdZhBLSat9m4KihRu6awqQUHUYdkRwYa/HCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111748;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/rBv/z3z1rUDhHPJM05fHYgG3VzOuLPY6g0/hPt+6xY=;
	b=VPT+qFg3XTpQ4cvK2td/TeSt3hrs36XTF2OybzqaX0Q9H6KDwKj9tvQ9OLoDJg23j0oP
	 bb7WmXmIedc9gwWkbO7TFuWttwxCaNhkH3eu1I3DgZCltiBhhTzshSMk0wk1oGfnlp2++
	 JbVXuLrqZGAqy7FFwQ+V2QodxrSBu+wTvj/K9OjH37vxnVx103fegw8o6WuAMWmBHlq06
	 rzmdjTm6tARJz4BhxFjMcVKlmtyGddwsrNKTViZplgaSsTxlID/3IMDi9ZYQRpnne6Rpi
	 8i2qiX0aQJyFMVAWWAmBJ6PFCiXfP5uYOm/6DTSZ4rvth73aHie12FSqmGKbgQL+Vog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf5MqzAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A12606A31B
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf5MqzAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4061F01828;
	Tue, 27 Oct 2026 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111747;
	bh=/rBv/z3z1rUDhHPJM05fHYgG3VzOuLPY6g0/hPt+6xY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cf5MqzAV6W+OjupQf92yyrzW6GP9AGVN/2AGerZIeV+uY99TDcnx1RWjZhTc3xscL
	 4U94akk51FpvHzFeRq+XdgTYRwztl14HgOqTPywQBnsTYkgTVlg5Sdkpnf9pe2Cpqt
	 YP/g4Dr1daACZr0ZdEAuBtstZwuS/F9i8hclW82i2j3Vb79rUQcj1xbsnxkvH11WZA
	 JhSW7ABP0xetMkILJQhfBRzl9OAfbp96KraG314POZCt6b7eGh0MOvTPXNW8aLaByk
	 RDVcz0F/V2LQWeeaFSPyfwJr6vSl4uIQxmLWEBWcGq862HVdJ4Q7MnlGP3vniam9Vo
	 cwycgRIcM/BzQ==
Message-ID: <sashiko-outbox-186732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] s390/uaccess: Move s390_kernel_write() to
 asm/text-patching.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-10-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:35:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> s390_kernel_write() is a text-patching primitive, not a user access
> function. Move its declaration and the inline wrapper from uaccess.h
> to text-patching.h.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D9

