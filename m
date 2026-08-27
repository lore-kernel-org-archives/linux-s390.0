Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CE480359;
	Thu, 27 Aug 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846345; cv=none; b=drkATevoo5Kq4ZrGf5tYUarmtTjhhjjOnGNRHvcR7vXIm0z0l4ZKiCzgoGgXeWJeopahK4YfknzNxJI5ZnIFix8K9lKH9HQN+xE8vaAZsN3IhezKNA7qutLVH4BhJVrOndoyEfFcnDuxl0rXbGwgaaEJ4Y45DPhF0dj4RoSG4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846345; c=relaxed/simple;
	bh=RlSv1hLQuYOofJUUu0046/ciYl6qQFMEnNk1UCTu9Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5cIiNHw4vRyrnvDdVVZTWBAlBi63/Fw9qA4k2eGEAZ2nqUu++CcS4b4+miJNctn46AFws4Jfw11niNdGq10ZGhaKxOSosKyubvE9+fHbyqCcXNmsFxbIZektefLINegtSzBH0PEsZVSwtcnAJC49VwLSU3ySIZPoAH1Nt7Pduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxaoGjcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxaoGjcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D28F1F000E9;
	Thu, 27 Aug 2026 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846342;
	bh=RlSv1hLQuYOofJUUu0046/ciYl6qQFMEnNk1UCTu9Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxaoGjcFYGHHd6w3VwlvYJmucIOTnjLijg9p0NpXOeXuuK44Xkdv0qMttypRO9V1N
	 o4cmN26fmFN+JV8YHHyYJac1dCCvVlg325LuEPb5p8BX7ShSLss/5ZEtodn8ggw5ib
	 43/zBR9PZ+quOPeifJ/gQmqTn849IRWoChoLx0KsxqYKZrLSwQ5pQjgT9oDS3yeb9J
	 st+uCfvoBJsERmbFR7/F0S/IHJ4ZOfy5sJmWauna8dXQkRoiEtlnVPlOEVmfBq3aiB
	 NziAg7TPjUfho1jlF3D5bp1Ki95++ld62UzVlUAfP0BE4xNT8cKh31cK7N9i3kkXwF
	 9kGbXpwu7ja6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/21] KVM: s390: vsie: Add vsie_interp_extf
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-3-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-3-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:59:01 +0000
Message-Id: <20260827155902.5D28F1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D3

