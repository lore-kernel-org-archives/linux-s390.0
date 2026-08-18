Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A453B1BD;
	Tue, 18 Aug 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065077; cv=none; b=NA2JrhLiyW+eANQNZ76ST7qC2C3MlW+X8myeVHRrDGRUcsjyHaLK0shwe9JveR7yXb3gEr24oyXTNBQq22FoGRSqPurAacWsrcfLQ4dmZPPC6L6kZfWDoZg2g5TLAOstpPzcT7h2C+5LMIe441/toLqjiB48AaQ/5Zuduao+uqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065077; c=relaxed/simple;
	bh=c3qZEF7hEoajNlSqHTcnbM4xJu1yit0+3Q70XeogV58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKMm2CmZgbh8b/ezo061IPuk5FeWis4KgEpr6E3W8ZH76q3jaFUU1dgGUmV+95ImfWiCara1xFkfIZKOZaI6PPYS0Z+A2LzCvY1ihkTa2iklG9ngF5X6jMkg6jT6nl9bczt1XaBttsv2g49V8XP+cVPY8KkKc7ZyeTyTOqYlyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee00TllK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee00TllK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E51F000E9;
	Tue, 18 Aug 2026 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065075;
	bh=bdQVK+CIejTKl+lK5969ncwmqEKeph652YfgBB4DBL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ee00TllK/c47+EvC96i213i4Ap7I8yfUoeiicy1AQsVlBNLnV9/F1oPRht3dNEaGc
	 jMok49/8cJExFpJBFVtGUjZ3dOP1r5hSVD1Zy1Yjvvsh8h3PTlbS6yxhe0Ic7PVCH3
	 2V2YjU7aDmBG++17kMMVf+xUINb4xL9HvQR2Hz279BhU3O6EmdCP7x/N5S1DIkYNvm
	 eIPTDuxd6T6AbGjcik/qfimB7LaNWXKepiWBLcxhno6RjW+um+HN2BVKElqwaVptCm
	 wuzuBj+g0eXPchs9nq3oKmIVy5tfxfjiZ7G3tOXp3DDq03auqcxk1LdJ4fodaobi5U
	 skMXaej/mQRjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 05/25] unwind_user: Flexible CFA recovery rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-6-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:57:55 +0000
Message-Id: <20260818145755.8B1E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To enable support for SFrame V3 flexible FDEs with a subsequent patch,
> add support for the following flexible Canonical Frame Address (CFA)
> recovery rules:
>=20
>   CFA =3D SP + offset
>   CFA =3D *(SP + offset)
>   CFA =3D FP + offset
>   CFA =3D *(FP + offset)
>   CFA =3D register + offset
>   CFA =3D *(register + offset)
>=20
> Note that CFA recovery rules that use arbitrary register contents are
> only valid when in the topmost frame, as their contents are otherwise
> unknown.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D5

