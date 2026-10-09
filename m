Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7513BD64D;
	Fri,  9 Oct 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556838; cv=none; b=ZUyt699owTm28XcdGeu8OJ1xlA0TvYILmCSlRn9XX+ksM+3t0yQabhKXJFW62cDbOoZgpZoRcPgwgPHza+oeMait4YOsi+6NeVEdAQ5F5TtEUOn3S8nE/iJ3Bn8ET8tS8y2xu4ErUnYmOY3YvuUTvXMlgnt6v0tFtoKhybnare4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556838; c=relaxed/simple;
	bh=YS/+Yd+hVNlctE3VhEez296HzfaPRy9r6HeFWRoJQU8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E2O3l/j8z6+LwCGLrqLnpMIFSIHSTS6Uy4ZeA8ud/jrdDu64RH0FZ3fvtXCklexqw26rah/QBT3B6eauHMvVLrlK9+ell0EkaWwSkeGgz73XqoRiF94pfXDhLYlsakprTsVCPaeDyTMpPzxq0/k+ZVpc9WqM25tPeKZrFME53aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNZ4hg9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNZ4hg9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B796B1F000FF;
	Fri,  9 Oct 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791556837;
	bh=YS/+Yd+hVNlctE3VhEez296HzfaPRy9r6HeFWRoJQU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNZ4hg9bqDa7nTIpfJiEUM2N8JlqKM8wTmNjbqVzxTByDBn2Itlodco/q2amBMpnp
	 H8sybQKJ0IJLAupUlYrQLUfEnmOVwVcSryA9CSOA50hpTUsCHQUDNNiVeC6ovF0v4o
	 eWTZ7+YjRG6H6aRcj9NBBKmkUmuRwkIA6zKAlNPjnHyPwaaHHKoor1Moc/2U2CxfTw
	 5vPg4NrI+rmwwjqhxEH4PzdYImnzeFUt2W34uR8pA6eC5ZTxSySyNMXaJ95Enujk2P
	 PaCyE4/aAGuudIb2nsYx/NQfKLFZw6mplbIhLUNWgs5HhGt68CqiBMo7rbTswAmwx8
	 09F+ADKRxHNLg==
Message-ID: <sashiko-outbox-165726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 2/6] KVM: Add file back-pointer to struct kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009142749.186650-3-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:40:36 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Add kvm->file as a no-reference back-pointer to the VM file in struct
> kvm. The pointer is set at VM creation time and cleared under
> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> Callers storing the file must take their own reference.
>=20
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009142749.1866=
50-3-borntraeger@linux.ibm.com?part=3D1

