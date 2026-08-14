Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B6371885;
	Fri, 14 Aug 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718983; cv=none; b=JsHRBorTlfiItSrkjh3jyKtwKd+tYgjXFG9+j0G2EcUguXapsKasrdj+Y5HVkLAmjp3UqJ6dOZlRajpf8q/n8cjr0hen5VhV8f1yZ9FqNxa634WisxKkGzMsDWJsN/fXYhOOG5SgROo5pPxUmSdGe72U79NyhObMBu3b+UNtFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718983; c=relaxed/simple;
	bh=G5n1Z5JNGbTwfxYqYThhKFxr6nFFxEOyHcZUVVJNAcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXJv9HGjM1DM1AZUALPoIeqtUdUhIrlQ3IZtfvrUgLzHHtbTervJP9dt3S5MJDXsB1yWZEzljkcVLoGL2GWjxkE+A1d0pZLMLDvsxSgHC2xmbENA67wG/9lxNy2u9+aAWcjlnlZXO4WrcvP3QScZJNUuxRQo469mm36P5n8aQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXvTncCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXvTncCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46571F000E9;
	Fri, 14 Aug 2026 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718982;
	bh=G5n1Z5JNGbTwfxYqYThhKFxr6nFFxEOyHcZUVVJNAcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXvTncCXlJhdpNM4CKjcquEmeigVCsACAu2hwYfHLMMg2KgQU0B4e/WUEGX/WaFjq
	 tEqKs00IEfPnL/CAXKW5G9U5lcjbOGQBjtKchabEmskrdZfddFrs4I/T0RCcKcZBXs
	 7gbxmk634sBrt4fe9Z0ZrYrFXKR7+O3/qadyLi0sqbiGtFoCyK+sLB/luGqi2IojxI
	 zEV5gDO9Nmat35nNUh/OCet2iClbwclfygpplgLdLGXCnzEIbyc0sT7IrekmU/4Qso
	 66hihZKxBRJ8f62IQyohO3/546LxC5tHAt3lp5i2xjDBepmho9VVIQXAojneJqNUsY
	 sfiK1KTAiwR9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814144041.169025-2-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:49:41 +0000
Message-Id: <20260814144941.A46571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
>=20
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
>=20
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D1

