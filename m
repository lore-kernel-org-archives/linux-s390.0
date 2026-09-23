Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD652FE32;
	Wed, 23 Sep 2026 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177477; cv=none; b=mFqbc0muBX9rz5phuzahkzxHu9yEGbvqx17AE2bE6zRCUvsKC7Mv/H5/guZznA5Jfnw4J6n9kzXyvsbIlzAYcfZ75Mg/sSPsZaAZRx7l868z5rihu5XQjtOrFIs4Hjh2vCIkL8cwldOO9dde2bngC3MZ6xd6o2kqYuIY4TLRfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177477; c=relaxed/simple;
	bh=8Jsegy2ZpRC/UAphpp5jcfdMawYv+Yh+GTdw2Bl/WJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kZarcoY6/dto1usFk8T1F8AZZZKzIElH8Vi9lcwNUe9z+ocdNnKRZt7TVfd8yyQmT++rbQoxbu+59wMnRlWkC2/6qkjdibDRW80qzko4MZqztlkb3DjJwmgpoGorWcaIWJv3O9Xb7Ac8yAOCGyTukftBFYjvkltjaWOu1EqqNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7CPKJU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7CPKJU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942051F00893;
	Wed, 23 Sep 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177468;
	bh=8Jsegy2ZpRC/UAphpp5jcfdMawYv+Yh+GTdw2Bl/WJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7CPKJU0qqR/hBamw/t5nDVxJQI64XdJixcpFkrsBfvHv8gUYpCIJlCUP8fAxnjmY
	 MtUF0wHodug5xK0khD+1UQcqgS9AB5rpc8EXIYUh32l0tIACzYoISbPcYlixpCed7I
	 +JX8r8hyLzFKrHGv0CFWc6dAeGLbcmK6hT9Gyjq3VUH2VAZC45WukonluDnE32kZd+
	 H5UAxbr18yTUC9uAHvD6kiWlZkK6GI9mnMh2pfBVHdF3e6hszl/jmIR9rGz2NYHdIp
	 OVmK4doyc2fV5h5a3zfwjJudfNmdK9zFZ75nquIRkQyBTHlgo64xOZ6o14f/QsUJGn
	 npSdurSlGFCAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] Documentation: KVM: document arm64
 KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Oliver Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-11-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-11-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:31:07 +0000
Message-Id: <20260923153107.942051F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Update the KVM API documentation to reflect the fact that arm64 now
> supports this functionality.
>=20
> Also document error values and arm64-specific behaviour.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D11

