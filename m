Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362003D47AE
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851597; cv=none; b=VvFx/Itq+3RUpo7jOWvMTBdQ3rxg3887FiV04aLoy34xqv3cClq/fY1S89pcnexrqOVd9DKKVuRmIb+X6Y4NAvO9QtSdp3jiXVF5jnvXmWXJKdgQdBwQDcheKEzvR8cXJvXe5hIPfhzoolgnIhUeZxWkXFRFDSdKBloH5gx4Ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851597; c=relaxed/simple;
	bh=ayVoPVAdRV0UN8Gv0yrFk6VO4AJERJyiXqnIM6nVFio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMQr+XjUZ/+IvYvWs3k+jFrV8Tm+2BipfJtZhXAxlrgjHzwQ0EIETZ2AfesJdR3Rj97qu2352WbW0pZctEv7Hh+H+NsnICBAzV2A9dLtnG2wXRjcBtFHKZ+RhlHKQPO1hKLJRsVAAHZ05FSIJ1+cDsu+0OJXEcSy9zQm5to0u7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkYCKjg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkYCKjg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDC1F000FF;
	Thu,  1 Oct 2026 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851595;
	bh=ayVoPVAdRV0UN8Gv0yrFk6VO4AJERJyiXqnIM6nVFio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkYCKjg1I19deA6bPTcMwbWmzsNxWGZkcDPHC7krKUJJOAkeS0gorhIaNXdx6j4Ua
	 6MDwptFnvt30DcnSzeAP4wOcC5WC6gxdHjaNDILg/hbbpATnfKhCizRbHTpekRReXu
	 Gnockb51vGPw7/Dr/fEnCKLwYGpcQKgoEHVE4519CzHpsw0DP5C+g7XtcQdlHuFOXW
	 07JWQI+qynIH+BtLm687bH9V0MDRVqzwDxw7PFaZ3YgxvbjJ78HuheQlFQkHgvBNoL
	 mp5PDnBhVgWJSpG/84mc4wGjeeVIPCBqupCK2OCvVH4rcBoTqk+RWSdheqpo98HtG1
	 iZSDiD0RcmLvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/32] s390/bpf: Simplify exception table entry handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-32-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-32-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:46:35 +0000
Message-Id: <20261001104635.8ECDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With exception table lookup always pointing to the faulting instruction,
> only a single exception table entry per probe instruction is needed.
>=20
> Remove the second exception table entry, the extra nop instruction
> emitted between/after probe instructions, and simplify probe handling
> in the BPF JIT.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D31

