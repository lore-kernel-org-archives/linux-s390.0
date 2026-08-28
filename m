Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC3442B32;
	Fri, 28 Aug 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919068; cv=none; b=fbNVVcP91AYFIsndloSG/LbDf4ivkJhL5/dZiYI7PuAikRU2a0NaEtPenQ1JQwr1uJS7htHCHWEaYc4c0E3BWBGjZgNWE4gRRF44f9apcSmR0WOQu2xUVsLaxt3uJJH2AKJx+VdrGlHKeQfO+5lgXh2rh/JPMztprnEOGCUR64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919068; c=relaxed/simple;
	bh=naUrtYYxzFiERNmUJY7Gdc8DqcU7F9DuAfpbwKBSvz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mtY6mheYW9swG/M9nYaDy+wpaRpnc3oEqZ3hDVVw6c4smP4mrLXzHUSgPxfW4tC4MTjc5KLa340kBx2JP8KK65nKh2aGzt9Tun64zOAFwNk3kF5mjvIqc7a7p0WQbbi2QwHPrTQgOO4eRP7NMtgzvF0nw7ct6SSeFmh5BeeTih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNkGXtaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNkGXtaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A81F00ACA;
	Fri, 28 Aug 2026 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787919055;
	bh=naUrtYYxzFiERNmUJY7Gdc8DqcU7F9DuAfpbwKBSvz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNkGXtaSf8OsqiYptendbl0Wax2FCAmuY9P3G5DQ2iGB/ksoYcCfHacs5X2oVQdNS
	 FMvqlpWCoKKvvUAZP9A2WsDijJIZylfIr5W03oPrEpSvXXCYaZ42SocorVsOHceSkN
	 vUuoht+tYBEmObu/lvhjUgWryvSZPQq7BTHirdOCYkYnR+J6ekFqulaNkfQnXu7/3d
	 g5e4h6Dc601d2M5sRQZskF5BNq4HPAWpT4ZQqVwN4AaJ+TH4Zf2BszuP3+p46khNRY
	 kvU55c+pOtTDOqkywhThXL3Gbdv53p5HhQeQ3NV8wXXkiP9J50IkNqtZc1JOu0L16h
	 8IZNdkYEkQZAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] KVM: s390: Add missing srcu in
 kvm_s390_set_irq_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260828115439.145885-7-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:10:54 +0000
Message-Id: <20260828121055.458A81F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
> kvm->srcu or the slots lock when performing the Store status operation.
>=20
> Fix by taking kvm->srcu in kvm_s390_set_irq_state().
>=20
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
> Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl=
()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D6

