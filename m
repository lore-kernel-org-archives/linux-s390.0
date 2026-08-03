Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66775377559;
	Mon,  3 Aug 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761770; cv=none; b=kin2U0l5EiSPEXMpq7989sAK2jv3ccMTNmtwq5VobwWSny5v9vhiNVT3EmU2L+FRdllkpaT00BCFCarAr6fnjJJcodFjQc3XiyNl0O5gMq2y9f1TyO5XW9Qx5yPG5pRNCFEaH6ydHmC0tNNotibht58mMJrrasNGNlEX1VcycuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761770; c=relaxed/simple;
	bh=/3wh+nWOM+w6yrvPv8F3j80MyERhjGyugEr4abKDIUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEW+pdDYpovc037OHFINeo0e3QK97uFxX6U+Osx+Qhz1i2HrUrr+YSVj/KXZBOOqL16+ATzKOYeuWh3PjeV1pj5WNHkm92/fjM3UD/HTI6qVcGSUsKxIbOMrHjMbmZKaoM7vDiuSGWGQc7CnqwxeB60jvh5hO4JArAzoc0A6qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPnTtiwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPnTtiwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BA81F000E9;
	Mon,  3 Aug 2026 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761768;
	bh=/3wh+nWOM+w6yrvPv8F3j80MyERhjGyugEr4abKDIUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPnTtiwb5AZUukyG1nvKdRIi9qyysoHoXyO/QHrJ5+KkDHC0nciqDucwZE1Oh3UoV
	 M/Q1SZ6IEMvK9Ilym7kBhadp9RJBsfa7lIfJm8zudBMzqQOCir1CjZ2IlzXJssWYnY
	 7UiBBmv3xfiT0L8vzbJVpia/PJGWphs2VaQeHY+1a9hqVmsWh3M2elkRg1VVlyGKOX
	 bCfEn0Lw18zoC9X1MYt+kU+hg3yTphTjjcrVGiGoHxDR7m0Fc5g5KY8OaGFg0zCOSH
	 /5Mc2Nf80dEqgGrz8X07A/wpQMfu1HhGDfmkoPB/HTi0Gy9w3yg4Z1Axwt04Jj86et
	 NdOspfVTjO92Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/13] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803124040.126471-8-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:56:07 +0000
Message-Id: <20260803125607.E8BA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D7

