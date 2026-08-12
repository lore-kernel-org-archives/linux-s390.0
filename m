Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE047885C;
	Wed, 12 Aug 2026 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549695; cv=none; b=cTbFDXNBu/9ijP4apsU8/ppXgc9npeB6rqb9Hat6CMK5hSS8nxJTNM7NUnUkhc9S0STd4+DYyDgXm1vFwQJGMJ407JgpO9wySXDHIZZmzEJOW3yEftMxTptyjmoHhtzrwSRiUnWeqxPbYo+3dwDnNUdL2Znw61Yt3/KvKJ0skKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549695; c=relaxed/simple;
	bh=sSRmsza0HNUFgppBC/u66CVHedsLYqHMhlv4R0lnvro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+6Q0jJvqFxJVbm94vR8os9z8ndfxImhfOC933O+sEY5v57MVNf+FXKVT6c209LKqOlmf2q9RNu84vZOod6VOgC7+K6mcxBQtHDpFI+Vy8BSzeogaQZhO+jPBw6/jkXROUaPweTRKd23UYO2xJCkBsgkF7bqIU7GYCTRiJ8CdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmqhlFge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmqhlFge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FEB1F00A3A;
	Wed, 12 Aug 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549693;
	bh=sSRmsza0HNUFgppBC/u66CVHedsLYqHMhlv4R0lnvro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmqhlFgeab/U8sfZvdseMwnZJ4zHQSyBtUycGrH9auO2728dL3MgWZ7tHiCUNtXQs
	 eNz4LCceWX1rczQ8miR3FQBgkI9xJcvsPvDpENMRyV+LA5jVMiUcsdM43r/Vn2QJbf
	 ZkmS/YAapDczKeCV3NX8gDx4a58gpvS9/q1YWC+aXRpJnyDuiN9Oj7830aYSZjSJPP
	 u6KpC14bb+RbFEkek1BJzXY9Dr+bE4VSeDzmFLhJvZXU1YxkycodHVQQ3qvyUTohP5
	 exghaK0Mqbda+jpR0LMHcko+FU9gaaYOgBaUJ0kY7ihTeiG7sZo73usHQplrepa5XY
	 YRX+8RwLD0X1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/33] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260812153631.3376090-7-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:48:12 +0000
Message-Id: <20260812154813.13FEB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> DDIO616 2026-06. No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D6

