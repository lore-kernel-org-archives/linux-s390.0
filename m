Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1F54705D
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721520; cv=none; b=uGtP8mz2IdU7d0zn9FQGcKAFKBcri0k/6RTYFVbwyCPV4/Xxazltqs0sYAY+MKhb21gy5Mn1CWuTDKO8HX8FJkPpfB1HnmENYZAstgR7bcMrd3vkQxo1RbVkpLLMIu1i5wgxHuaTioYrGw9SYeYRvGh52NTourcsPGVs6QKJuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721520; c=relaxed/simple;
	bh=l3eQ3ZKoEIRBEQmSUmZrl4zz57UpxYpoMXeGHVf3Y70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FkwBm8lg3qM63aifaAChH44ToKB6QDY4nAejnW/ev5NxSlsIcKfEOXkpkpI3zl9s9AwWzDW8byWwgME3E2mg20y1fWK6RxmvjGkXXT5A+z4yWkVcqa4uGFk4iJZthwyUgj0w05h1Ei2Z4/FxxnTU7YOuHJS63X0rOgM5t5OIPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsvJbTzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsvJbTzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78281F000FF;
	Fri, 18 Sep 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721519;
	bh=l3eQ3ZKoEIRBEQmSUmZrl4zz57UpxYpoMXeGHVf3Y70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsvJbTzvyGavii7WB7xPqMhnU7elWGmYgHme/52aRnUWsU4kPI9vHQwT3e103AsW6
	 1b02aH2gzaEP8qzItj0fGMEg/C0arcyz9DxyZHgYD6hWUDOtRm1NM7I0KI4EyhBL8H
	 RqbSbIERqPCQIOxJD29KFxFXj6eW9k9FENkcNh6p4Tn1+eFAqKmqbTeSGg2jTbO73h
	 GvMsgSEmUtfJaWuriDmXIeTGm8pNwJXbx3bdhSUBo+T3s7p5c5r8GxJuN/DkN+qrzF
	 hLGsXG7JPMyE3xSqiuASm7pVI71Y/grfjSqj10z9onl/A6Wb16dDdSxyuOqjlWZaHQ
	 KEjiPUB3TslIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] s390/percpu: Rename inline assembly symbolic
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-7-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:51:58 +0000
Message-Id: <20260918085158.C78281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename perpcu inline assembly symbolic names so they match (more) what is
> specified with input operands. A trivial change which is supposed to make
> the code a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D6

