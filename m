Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466140E8D7;
	Fri, 14 Aug 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725835; cv=none; b=VtUyVf+ZJOBp+AUMHkHa1Mumr37cB1/Qx/SNTZvkJn4EIFWJeZ0mVNhsu1MHwYrs42SoiTI6cF3edJcjkp0U87DpvoJGtUWa8peLvMNbwAjQyz4kVxkFfhxh1KHrIMOjWIqQrvfRpuY6S1j4eXtlL0bBWmTRBRz/wp/wUn1mAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725835; c=relaxed/simple;
	bh=mI5f665LgEmU8MdOHU8YHgBPiRniTiY+tpgPy7K4sgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1+NSebupRL4Ip2LXbOLKYQf0y2p/TKzQSbEy4vmuj3cxvWY/SmZy9ZfnLGl72zdOb9gf/95XDX5UaCpDhtmlioTixNQhaXZm+A1PPMse4ziYrkN/+DM0F6go0DaBWVXchc2i+CIGtGm9Wn9a6frMQBzzRmbtz1IT+DzojXn7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaPJd7/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaPJd7/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D9E1F000E9;
	Fri, 14 Aug 2026 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725833;
	bh=mI5f665LgEmU8MdOHU8YHgBPiRniTiY+tpgPy7K4sgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jaPJd7/2IqeVkixik2SwA59zw9XZGUcPubNKFeLF85g/3KArguZkImOTzhiH27JK7
	 IiGmsfHmiJDeNNO7FYK1DYDbfYibr3gGZYYt+hrPYvW8bx5CoQNGTTD/sbKoQ9wB8Q
	 fFLz8kGqhctGVkypdxEdXnRP1MVbgdQmjobQ040QK6ZT48YyR9wI1iIPdROef6aV8o
	 SeBNzR4FDmB5979GNp8hMP7IYQ45bTda81SC4IPJ6eqJjhkST9ixIykvgX0ncYiGUc
	 OhtYT5pSA1S3e0mw63w6WHXb4F1IFcqoWeElKi9LWpeI3/gE0/fR0Zav8S97m7HAl2
	 eUDIy6mTEDy8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] KVM: s390: Add missing srcu in
 kvm_s390_set_irq_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814163355.227191-6-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:43:52 +0000
Message-Id: <20260814164353.56D9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
> kvm->srcu or the slots lock when performing the Store status operation.
>=20
> Fix by taking kvm->srcu in kvm_s390_set_irq_state().
>=20
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
> Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl=
()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D5

