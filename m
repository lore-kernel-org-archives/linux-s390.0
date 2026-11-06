Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987382;
	b=DMF7fPYY1+VJp0VYOJKo5iYsPLB5qu/mYi26hrh/fV7Wct47D/3etqZDxbBJ9xZHZZOK
	 eysK+EEXU3+uwxlrQmpu65ouFPDaSklqvxZ7qtrHpkRsO3sdwwMUa+FBDrxRGBIcX3pVR
	 sUhXJAC2Nc5x+tXAA5eERpEnUZuw93NfCRTmyup4SxsrHK0/sHwZUZCPBT7URUNO04+os
	 MmEIOp1iPOQsn69RpYE1HWIWIdxXGikk3pRQcPrc9xEftUbcY3RFaQ8afB4QgLaAP0/v+
	 Qkxwhacd89G5q6M1tWamMOad9IklQoRfvvqhzoH0D9tUL5PjTF4cuUSUxFdUEjAUO9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RiiHtFahOon4riJefsleISvmBFbi0CFp3GLVd3PFoM4=;
	b=GKUhRhepT91p0rUkIRoa/4ngM8mxDii8c71JOYfxebKtyo77r75XE9hrpHgqRFIH5WaH
	 8qAcXk2Sz/cmeujzhFET5X1wuM9CQAWPO43RXUqsDlW2QBtv7oqpLVl7cppzLhszVTErJ
	 lqSi2V3AFxkaPmLzHD4decPKDPvtVrF8j9vuHKV32hNFYegpSDxzIobXQikG2u4X4e5t2
	 J2tSkyLqChjtMgcsQwV/r8tEkhI2I9veZG3oxM6GQKqPg3SbKqJk5g8xwXHOfr8hkY7iP
	 33phaX4O/1C1eXd9/FQMRYIGb62ZAbQubCaM2TvuykR1f1bz3cb06aIAPreu7+auk9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDFiqBj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0601606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDFiqBj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D06C1F008A4;
	Fri,  6 Nov 2026 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987381;
	bh=RiiHtFahOon4riJefsleISvmBFbi0CFp3GLVd3PFoM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GDFiqBj8pXn9zfiI3dSHoi6ggpzBGHVn+k0qyxYFuV2UHnLN9hixfkkq0TiwGy/vm
	 EALIComYIBSp0hkPFRxUa8+BQWXtFdMe7HvWRYj9uAmcN+iDqq3hrWi/DZmpyUaWf1
	 e2gn4mr5xL1d8hfhh9qFS9nm1TzgmwlWfoUb/Vf6X0KFDo72CbNI5X3UfNZWQTlvH1
	 vekTMhyjzE43VIAKMs2l3ZSX07EkYIPefKDI4N1dqWG/SlXkzzXO5X97U08JJnGbgb
	 ZcEKDdixbXB4BHetxITRlQfFO5NRMhfoGe75p2YqgHffYDlYWkhQspKHZN/DbC0ZNK
	 gJXdZNnYY218w==
Message-ID: <sashiko-outbox-201971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/23] KVM: s390: arm64: Verify machine feature set
 before loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-14-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-14-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:49:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Arm guests on s390 need more than the Arm Execution Facility alone. In
> addition, the PTFF time conversion functions are required. In addition
> the guest mapping relies on EDAT2 for large pages.
>=20
> Verify that these features are present before loading the kvm_arm64
> module. Every machine having the aef facility present should also
> support those. Print an error message if this is not the case.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D14

