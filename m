Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF5498907
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721631; cv=none; b=uBJIN77PBQGbI0XOEWdfhfhsfBZF5NCYXW5bi6EGKuDMAM/WSVuOQ5mKZos844e1bfRU1tMdWirCqRD4CNH8IFWMtSKCOcqoRzLQiYmBOc4YHqguwWzncMvmIhhJE7vkbjEYQJ98OlgQ6FQmtpubkb6gFH/HYoBoFHYsOCKLd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721631; c=relaxed/simple;
	bh=V3hJNBAIzDSkVCkuJJIHxlQtNDbRfblZ/5S6UJnMHyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F2ZTlRQ9PiIpz8R6c55b91tR1iF2+0GHzBK2y7+t/w1z7q43rZ/gE3ODLRnAaXFYGqbqbnmeXt4VBn6sNFqEmamw166nU7f8FoTuBVYBx4zdtX2YdDNBMUag7F3gybHq0LoEpKkVhyiljBoe4rLx3m/GP7IOsEzOD2RLo0R2twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjJfJFcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjJfJFcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42801F000FF;
	Fri, 18 Sep 2026 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721630;
	bh=V3hJNBAIzDSkVCkuJJIHxlQtNDbRfblZ/5S6UJnMHyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjJfJFcQ0iaJZizCj8J7DwD8Y8sRFLq+ddxPabqjD1ezWXKHXFBYDWZQpkQah5CMS
	 qkvh88DOw2XhqRBUIF4E0PDXE1BNDHNuhasq9xUm8sfr8SaVCSzXmB5ntmMxqPnZe8
	 LFbZqyt0BBL57+kLFi9Zvb5dS7NB6OwP5JW1qzeMvhzD7gmBlSSCy9TfJGslHgv82a
	 clgExW8BvV+JTlJ+8nNVguFRg48RhtHnA450SAj7h4jnevah0dW/rSxm7ai16BKiPj
	 mp5//jnHu2y1kcax/k+ORHyTVn5jDRL+Q3Cu9cmpVR4EOaV1q7LhrbU4N5w5f5xiPa
	 HhPswntY7kdXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] s390: Add CC_HAS_ASM_M_FORMAT_FLAG config
 option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-12-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:53:49 +0000
Message-Id: <20260918085349.C42801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add CONFIG_CC_HAS_ASM_M_FORMAT_FLAG as an indicator if the compiler
> supports the 'M' operand modifier in inline assemblies. The 'M' modifier
> allows to access the odd register of a TImode operand. Clang support for
> this modifier was added recently to llvm-project [1].
>=20
> The config option can be used to write conditional code depending on
> compiler features.
>=20
> [1] 28c23411e15f ("[SystemZ] Support the 'M' code for the odd register in=
 inline-asm (#215481)")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D11

