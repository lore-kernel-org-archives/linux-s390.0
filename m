Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AF3D954C;
	Fri, 31 Jul 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503614; cv=none; b=Dmu03D/mMD638O1hRXaojEHo6HE77ukdYDkHh5sWTY2gyU4ToYUnoqyJZnknMF+QbCBNXJWQplspTcoSdC9KG/Mm3vDxJKCeI+YB0RMyHUn3HHk7weiPbCB33EKp8GEg02L2jrFM/AU456s+stBOcTluSJ+2R2ijLEn4FIhLbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503614; c=relaxed/simple;
	bh=Mt0xP8iaAdnWshbpkQ295ykPHYmxdfMBKfQkRppnwuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GkI4lyHo5PhbjlQUl+RJy7ZwOrN+DG6LR/fywKSiJcv0b6dgy5XIvcZTV0HaSj03+fSEuabcKsCF2yJLoIJjzIbRDBjF8ABAoxv18dDe77mUUs8wgZjk4GssAt3a2LDddK6PgWgJylUQJGPJqtpHt5pwAW/0+023arZoij20qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtPEA+R+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtPEA+R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6241F000E9;
	Fri, 31 Jul 2026 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503613;
	bh=Mt0xP8iaAdnWshbpkQ295ykPHYmxdfMBKfQkRppnwuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtPEA+R+fZAvZa6StQCom1MiZe0xg6Sy+QWKswMjQgG0bM4gO3+BmIvcJaZZJV2nO
	 YNXEk+LXokfJ9fP/RCbCYYcRCC6xo5k/ZZVWAYo3hkFO0zZvu3Fj6bSIBeJISbtq5K
	 qsWMkHy/dPRwMfyo0VJ79cES0hcsVJSD67ESAqAiDKmnwB7iJzlt/8zanb3cZnqTFV
	 z/qfnM5EQWu7TP1zkyvv/jxSI6iRBCxQyYUyKjdy5MLOwHajhHGwKSUSRRMIr7k80v
	 Hy2O9jWhyNpOr+r6Lt1i9vjAx3QtmvQ+2AoCWMCA/yL/Q/cRJ0f/4qfqeT5m8OLUtT
	 Z+Prn6jO/6y/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/14] KVM: s390: Do not free SCA if it was not
 allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130138.173983-3-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:13:32 +0000
Message-Id: <20260731131333.0D6241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If VM creation fails early in kvm_arch_init_vm(), the cleanup code
> tries to free up the SCA, even though the address is 0. Due to using
> free_pages_exact(), only the first page is skipped, accidentally
> freeing pages 1, 2, and 3.
>=20
> Fix by checking whether the pointer is NULL before attempting to free
> the SCA in sca_dispose().
>=20
> Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D2

