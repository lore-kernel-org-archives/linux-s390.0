Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10F276038;
	Fri, 31 Jul 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505681; cv=none; b=mVnNdndFbIzFRrWXzGH9BaLTNZAlHQJEfw15F2/LQs10OIfNJ/5rJMu1Qu6tjP89jG29erHuLPnOEOLBFBZintg5K8fJbQggL83q/staNrQgfuxpWnTG2j853BmXJgM3sI28eXXRf7lvv1PHpn1/60haDZ77T8YbHRKBiafHPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505681; c=relaxed/simple;
	bh=/ZVit74pd2/P+SNiXVkp70eAZ09ifKIrI7sWRwu6AOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBMUB9Tgo9Z97pjIBFDt6W6BDDwI9BQ2+7r4laz7Irs4t45ZtuIbZo/8z/aW2a5L8tEcHcaSWEpZjJ1p63asIB9QFAwbTGfy/vdjJ1ALJxOclc6I/GNzSAM/8rACxGfeQCMkCtMeUakOIVb8puUpvwrnc2zQjDdvAS6hVhbyDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4NAeClR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4NAeClR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934F41F000E9;
	Fri, 31 Jul 2026 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505680;
	bh=/ZVit74pd2/P+SNiXVkp70eAZ09ifKIrI7sWRwu6AOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4NAeClR5ooelWAmQi9RU+ml59UBqn4Pl4stvFLZX/tD48A4sdUX8IOqHfFVAHD1Y
	 fLLeteo9s41tl3Zab/KWXJXb5LxsXuqPOiQWbuFDYdI917//CXs1h2yEY/3c3LWpFI
	 4/KVVPIn6oqBx/H+cUDzhDdlwClVVJTmE0Ks+J9LtCtrgbfwxGV7Ra45v8e6GOTpUG
	 ssT18AEgSiAM9nTnhdXC4se9MAWpVm616i8ufXVDNWS7OSOelvFtyAbIEKir787o4q
	 sDOtNY4a8z7OARwWCmE4LMRnjxD1MWJ8rVaHkevPILzICC4j9NpH4cJl3TEXqO4Qga
	 1+k363RqdSvtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/31] KVM: s390: Guard KVM/s390 behind
 CONFIG_KVM_S390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260731130902.654679-16-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:47:59 +0000
Message-Id: <20260731134759.934F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To allow for a second KVM Module guard KVM/s390 behind CONIG_KVM_S390
> instead of CONFIG_KVM and turn CONFIG_KVM on if selected.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D15

