Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD341A565;
	Wed, 12 Aug 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549988; cv=none; b=Xq2HFwongR1K9BExeF6GZ04p2R0fF5mHixOcpkX7Wg0pUM2IYeGNDWI1wH0JA8Ofu8604Knmv7CqFvl8/iJq6FVt0qapPGBdIYDH+EZN+in0UJAJ6K57bbZ57wGMPACsJH8dumoN245F7w/zKOxxxzVfeqC0pUoofqp0Z3cNCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549988; c=relaxed/simple;
	bh=Oeom0uFW8EV1hkECVaZ8DKekVULLQOFZjKB+n2Kyu1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVx3U06iW7V6HlScHfbvlYgLy9Y3qRNWQWsOS33GxpjRIjc6vy1rKKGaY2NzNzNWk/MD+fjRS6IWorAzoObn17Lqi85AhiKae0tlAstITuQGkbirN/kbMMbk2NZAvFKrw1aT8Rba6pxTIOfv0dxaMA61GTMKaabmdR2R+hTTNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmuGHmb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmuGHmb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F41C1F000E9;
	Wed, 12 Aug 2026 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549987;
	bh=Oeom0uFW8EV1hkECVaZ8DKekVULLQOFZjKB+n2Kyu1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmuGHmb9qS/eG2n/QLT2yb1Er8OWrJIK5MHklnQC9c3TQFUJZN5hHEf/uF3tPje2g
	 BKLp6Lpf5TFPuopMyFUquM+hrrffc6Vckui7yLe3IGkXFswRc9gAn6CwZ6izAs9XU2
	 YRyS48Q9C96uw674NdcCVP8qn6TBk1eekYrsHSgaLVhA3vdCB/7n5NXdhS8vlYCImI
	 sFQt1QFbRukWeCd2dyXO3xPCE3vj1Q/ns8rGnnfASSJPg0zKqNYNbqvIKIhjnSSZDm
	 VORPYYRZ5NPxR5e2IVHodxa6p6hOJi60uik6TALhw85Qz2/L178vIyU2bcu8KpEdz0
	 IggIa4ZHcR7ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/33] KVM: s390: Prepare include guards for a new
 location
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-14-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:53:06 +0000
Message-Id: <20260812155306.9F41C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Update include guard names in dat.h, faultin.h, and gmap.h to
> ARCH_KVM_GMAP_* to reflect their upcoming relocation to a shared gmap
> directory.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D13

