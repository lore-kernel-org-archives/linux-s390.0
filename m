Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2F43C058
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192461; cv=none; b=JKmqnF5zM5g/mpy6Bmj6znjg7flIQWErsXm6cjBM474H0SWAs/IfpoWzeEGWIIkk/Xd2g3u7n0J6+Feqc8G76+0JTAaoZOnKB9iQBs2Cprse5vUUCXTpnPZ590vEZhsTEdYIzXHYtJ7JSwUXXEeVswdy0WTNGCwVdoFau0JlzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192461; c=relaxed/simple;
	bh=eIf4UjlK4sJ7sqAWqhpHzsK+xWCmqRS3DSgN0kEMtFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/6wCCpLdXuN7+O9eVi+fKb8zGfyRI7hMAUr4OobdE19cq6KNZN3SXaR6YunbaFrhnSzbIz0oVYvJ4L3QSrp9OCTwuL7AEu5qKFvSiXVN3/dxfkcCtCLITHClQ2eQhJPDb2rMUxmYVM6HN1GBzx/Oah/D8Bc01shbNO+zA7Ena8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOJ8HNLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOJ8HNLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06FB1F000FF;
	Mon,  5 Oct 2026 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192460;
	bh=eIf4UjlK4sJ7sqAWqhpHzsK+xWCmqRS3DSgN0kEMtFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOJ8HNLBwLQpay9RbfPQRFkJBX9auyFW1sSF0BykeSclriMixlKexVuCSgekU7LwG
	 r2htg8JwBqRitHYbNx/qT98eFfX2R2fZdEOw/9GzvTPQsbPuvZt9cL4ONvNkJPzH2M
	 AlGdG72nYg37yVeXPMxqCDE001nBJErPmhWbQkuIoJPdij5+GVvNiRUOQD8AriWW/C
	 BUG/j/OwTnbteiIxDsWZgdAfjbH1WTS/ZaMK9bUXdrm+F1E8JLwHt+BXs4QeKAGX4M
	 0NwOxyeMuz4FTnAqSMSxve2CafTM0kkQzWQo4hBRXoIOFp1Ueyfyqr3f1tlYKcaukD
	 7h/APQXv+yqHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/dis: Mark non-NUL-terminated character arrays
 with __nonstring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005092256.2740363-1-hca@linux.ibm.com>
References: <20261005092256.2740363-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 09:27:39 +0000
Message-Id: <20261005092739.F06FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With [1] the generated string initializers were changed to use an
> array instead of a non-NUL-terminated string. The reason was that GCC 15
> warns about string initializers that truncate the NUL terminator with
> -Wunterminated-string-initialization.
>=20
> The better solution is to use the __nonstring annotation, which exists
> to deal exactly with this problem. Therefore use it and basically
> revert [1] in order to generate more readable initializers:
>=20
> Before:
> [LONG_INSN_ALGHSIK] =3D { 'a', 'l', 'g', 'h', 's', 'i', 'k', },
>=20
> After:
> [LONG_INSN_ALGHSIK] =3D "alghsik",
>=20
> [1] commit 7cbae7ea3de5 ("s390/tools: Use array instead of string initial=
izer")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005092256.2740=
363-1-hca@linux.ibm.com?part=3D1

