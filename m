Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065137E304;
	Sat,  3 Oct 2026 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991233; cv=none; b=th+jZFs22CbQB8UPuYIsUC8OZWTnR9sIuUNaupUeG96j5lDy/OYaaC7LI1Q1xgCh2W56t15YREihd6YV8B6u0diapgHukFRqBgDZe84sCfjegfaeTEqdKANBBsa2jSJy1CiqEIBXdWINZYjCP563DUygNPg9zyZI6a6VwAfoGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991233; c=relaxed/simple;
	bh=dnHLZYm3dHbErqikHaStOp5cWzH+pHqn/9ltin0H2kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4bt9MznoB7IjR9LXYVlk4BNvhiBgy84hTjBHTJOhEw1uCKQHI3Wie74zPEgBAgpRBH/b4LnoMmehxW3OTMaNRlyOAIXVcEJfKMSaDkGBtPiN8IyYfkpDJ7fwlv2+1IoVAuz+yPf0jFCATTjliVknddzZA1IwtZX+ckbqWSnpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGWxAD15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGWxAD15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250461F00898;
	Sat,  3 Oct 2026 01:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991231;
	bh=3tmMpCfScgMPkZKTkNH41u5I0qOqVIw1W29Avtfqx3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGWxAD15zPMuwSuA52GCDynnhkGDDxTfZrknQmJyRgHmHhJPaPT00R1ASKaKpArrK
	 IwKFAtVayIUs8ZfMtC9ewLoiDqLO2Oh+5pIpgXkg+TqaLh5nNFjECzEI4dOjWn8KLc
	 AnqTa+YJ/zsZ43Z41Da66vEhggrIV7/8YyyvZEhAWmKjbVwj5tqHmr8R9WDVeyD5w4
	 t033EOssZNANG7pj8yaFn3Q4Qn7qttEOdJvQJ6DLpApLGSuKDYiO0+OTQAKuz5WIWl
	 f8mkU/qmR23qWlRCb/TkS5crFA7jyQEo/AfI6nj6QALgc1RnXOPPhOq9gMEiJs3XNl
	 XcERZkDvO5V4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] kvm: s390: Reject memory region operations for
 ucontrol VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261002194904.21236-1-artem@trailofbits.com>
References: <20261002194904.21236-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:50 +0000
Message-Id: <20261003013351.250461F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Christoph Schlameuss <schlameuss@linux.ibm.com>
>=20
> [ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]
>=20
> This change rejects the KVM_SET_USER_MEMORY_REGION and
> KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
> This is necessary since ucontrol VMs have kvm->arch.gmap set to 0 and
> would thus result in a null pointer dereference further in.
> Memory management needs to be performed in userspace and using the
> ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.
>=20
> Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
> and KVM_SET_USER_MEMORY_REGION2.
>=20
> [ Backport to 6.1.y: omitted KVM_SET_USER_MEMORY_REGION2 documentation
>   because that ioctl is absent from 6.1. ]
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Fixes: 27e0393f15fc ("KVM: s390: ucontrol: per vcpu address spaces")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Link: https://lore.kernel.org/r/20240624095902.29375-1-schlameuss@linux.i=
bm.com
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [frankja@linux.ibm.com: commit message spelling fix, subject prefix fix]
> Message-ID: <20240624095902.29375-1-schlameuss@linux.ibm.com>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002194904.2123=
6-1-artem@trailofbits.com?part=3D1

