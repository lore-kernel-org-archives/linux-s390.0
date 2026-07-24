Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486E4399C2;
	Fri, 24 Jul 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902994; cv=none; b=Ee3t09bNgAnuPvM+6JoiQ2MqEttGWEaX9vS9sAukHA2LpKpS1osyUHZg7RO1o2H5xCIEGOPc1SGyjWgnWVkiAxaKS7YhOLpk2biS8B0FZlc480vWfjBQ2ZLqldV0kYJJOpVJATlRFRmek/CBhymq8eMrR4orwXLf1KuDR3/4fJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902994; c=relaxed/simple;
	bh=kwXDIbY7tnlrxTE76Zhvu84QKmk5zDU2ZJt4Dss7E4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ExQmraJ9m9A5U2u59aDZbECMVPIfeEvsx+F2Rtwz3jjt3+AvPn7jg+b3+fORuGdHjM8/gQwwXLny5iohDq4rgvyPUNOO+NJUq1JhAD4x0ELcs2sCLt/AyQAr/y98U/xEkUjxhzjcuLLf7We6jbcAEOgfmz8bWcGukCMsruZI0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk8QONOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk8QONOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2F1F000E9;
	Fri, 24 Jul 2026 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902993;
	bh=kwXDIbY7tnlrxTE76Zhvu84QKmk5zDU2ZJt4Dss7E4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dk8QONOrcAFwsWXJ8Qy6hdyiUvw+BeVvLdJwvQ7FrpyeiJM6vhihkFZIgv/XxyfGI
	 cWgHrLBZJ43JCTLXgCqzcDYP2VSM8Q7S90r0qzPsj116rUEvZXxF5yCX5sWMVFDEzS
	 KqhFcguuZ7oA2Hondki32FSAjAi/FHDZs9ybDbvCZs1LMQgNpIf3F6ZzVK9oUC0h13
	 k1/pK/b8mMuCjMizeiLLrdSdoSYfat+qaNMdiQsMbbcUGuyNqyLmp/Ub1L48UBo2s1
	 vdm65rNrhL55XFx0XsYHrWgS2Ygw4a4HMAzbVmlAa04g9G3UbA1fqhXmfRIW9+TLER
	 yKvFTLnECip4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] s390/tools: Pass symbol name to do_relocs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260724141318.1037434-2-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:23:12 +0000
Message-Id: <20260724142312.AAA2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Pass the symbol symbol name which corresponds to a relocation to
> do_relocs(). This is preparation for kcfi support.
>=20
> Given that the s390 specific relocs tool is a stripped down version of the
> x86 version, add more code from the x86 version to the s390 version, while
> keeping coding style, etc. in order to add the required functionality.
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D1

