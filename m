Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126E4FE2C9;
	Fri, 18 Sep 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744554; cv=none; b=fwbmKzDM3W7SsKZ20ajKDkG4YfQPkaSMPjy12pzUK46pqqSP1EO3OT7D8Ho2ixCQVVtMnDb8paekS7qmbK4kJomkFGuQDgjN5/2xha5Jr7OmhgFqQ1ZAbt+D9OvgjGiifRXE+CZsq0kJehEc8NNnk9Z9FXmMPoSbrszDzzmWhdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744554; c=relaxed/simple;
	bh=AiB4Zy3gbmy85Gps8iqtFngDRZTlGV5HhV45+44JHMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n2xhN4IpQVCU9lkVB7WVvl9iyqnQr5yprgb+oSd65G47VxSgDMRTdvFM0VWywrAuqJfMtiuYZ7FoAAs2an0imosTSYNkmJb/X7ok2VreXqoSLMHmHJrd1Eal7P4IowmTzlS2oNYO7IVsyZjGQNv6Y7WLD62ABYbr70aWwEMTZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDZX9zDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDZX9zDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475561F000FF;
	Fri, 18 Sep 2026 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744547;
	bh=AiB4Zy3gbmy85Gps8iqtFngDRZTlGV5HhV45+44JHMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDZX9zDCx/DsA7St/qwlCY7x3NmgfSmr7UmK+IEFRVOfo7AkgSxJdNzxE7Ue7O5Z2
	 VJ1f6kCVkXGMqewvHBMyd+1aV57i6NJjtg4LGvsPYytVb75+EyizBg2kFN1PdSNxAu
	 42OyNAaVwfrfOYQ1q+D+z+z3H0nyM0FsIW4DgyaKkdGwjKWZW9R2vJyN8IMe7JQGUw
	 vgJwGOHmxi/RTJPtrdhR5Kwyy9CsnLQilTTesoy+znh3LijEsVVJHWI1PVLYg8qx6v
	 m5ng9Te7jCwJzttteLZ0QBtPJifF21aU4+jLiJ9WNmetYMIXcY3aSaX+d/XMcpYRsW
	 YvzhQka1suwog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/21] KVM: s390: vsie: Add vsie_interp_extf
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-3-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-3-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:15:46 +0000
Message-Id: <20260918151547.475561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add sensing of the VSIE Interpretation Extension Facility as
> vsie_interp_extf from SCLP. This facility is introduced with IBM Z
> gen17.
> Along with the new facility add a KVM struct member use_ssca that we
> enable when the vsie_interp_extf is available.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D3

