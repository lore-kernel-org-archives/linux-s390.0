Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984355;
	b=urr3ap7K7kwNbOcItW95ayK7Aep+qNgrRTpxmuircpbrzkZ6myh57hYcfOTY+5mNOKYx
	 H9U1LoVmomG/Tlcdmh/KObpu9rTf38cqaN1iZEZ+blWQcO0ZCKbC6cj+t5Gi+NKcWekjU
	 oTwRug8U4eIny24i888ANSrK9aKF1/0OaFtqKYjRuQ9zjT7K9Q1kXuLRu5eDTFa7bPS0U
	 vczpDgBezHfpRrPH+mWv0cIgna2S3NT7ZL/jMhc+rrHabXpL1bZsYB8JiKbizWssHTSSg
	 FHbVGP6564bRve875UsTNEDq8yyHWIpDoTZ86tat7VolM33hD+y3P2httlO266b4Q/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d80VfVqLZ5LzPHvN+Qp7QXqfV2/mGTMFW9uFRBGrIAo=;
	b=OWgIowpZaLTbm96E4ZLNVFRo30Cw/a1QXmGn1nlhrzEizdj68M4eBzEvtIzlwgnvlC/J
	 crFV0jEyUZ/ez1js1Uc5qC7/I18Bf6EEn+zFA1IbDxqyNb9LXfGEe4UEd5D933y8JF9OP
	 406ag5ytuf+b30WO1CBTMoedfGS1yqmlYQABCMrSP7D15D4VAe9bLgd50HuFhJNZ8ezz1
	 QzX6EZFvZJr7O5ovKrl3QyQVK30GzSIveano2HzxpLHWCtQ4Et1nHhtgbCtGXYw0kFSu8
	 3ssSMbYrSdfaVa+TQhXfBKTZ5wWMbVCqwnnjoqCHg2M+7XHYAtrHp57zyuusTQxZj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsrqjcF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A7606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsrqjcF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B11F008A3;
	Fri,  6 Nov 2026 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984355;
	bh=d80VfVqLZ5LzPHvN+Qp7QXqfV2/mGTMFW9uFRBGrIAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsrqjcF0Z0mdEU64901UeN/y2jmh79Hf+vGM/2/Vuoe01JRc+dmHK56eZZCJX6Pe2
	 U0c/M0L8Un9Y/BgXRqnLJOA46AN2Lcmc3HGeKc7lh4jSlucDUVq/KxixqTCGdzA2/x
	 JD5pN/ZfLbsEEWdEOZEMpazHRuwNPovP2rqlG3A3sNwOPJDZsQyGjgM82ql+wtr+yu
	 27GVF8+TvdOqa3/yxT4Pgd4yOBU8HNOj9vArmOsAd0DlPWkGIwcMHCdCKTB1jzuZyp
	 i1GidIHwbwMegaTAQOAKmlmALsVI5CnO3rwUeldjzF6jP2oLUwIYwn+U0kooEXnUM6
	 1W9kyp6RVQBMg==
Message-ID: <sashiko-outbox-201882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 5/6] KVM: s390: arm64: Fix kvm_arm64 module naming
 consistency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-6-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:59:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Andreas Grapentin <gra@linux.ibm.com>
>=20
> the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
> Makefile to produce kvm_arm64.ko instead, so the output file name
> matches the module name.
>=20
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Fixes: 91b87e6eea4d0 ("KVM: s390: arm64: Integrate arm on s390")
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-6-borntraeger@linux.ibm.com?part=3D1

