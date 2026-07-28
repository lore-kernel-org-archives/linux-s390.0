Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458423546D6
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216877; cv=none; b=NEpcigKEBzExSPC8Km7aJTvti6gWdYQxxk6b925Dh+xgon34tFWJvb6Z37AALZze4j+pzVd/hIEd7FOtTfhzxQnyp/b0mo26VLAG9Ce+60B6W6mOp2GZ5ufL6akcjAVvGdarXERgREZ22vUdarKQmFpI1/YhNTByPzDiAk5nH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216877; c=relaxed/simple;
	bh=jDXcM86A1g7OefJzeE1l+uqVCywKUZWsPKfSIJvxsu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LuVh3myD/2O7Si5YkNJ5cHCwZG6Bvi11Dmm3pUB09Oi8KENSDlJ6RA159zlCyy+bZVe3Fx8kgSBxRM9fVqi7St44yLdtw8B2W6554MJtwTANO8qHaZUQH1AigcLXlUOkQS0e5IwF27VIOBFS9XP08SKQrH7Gp8UogW+KvZsL7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSzhXhH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSzhXhH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C051F000E9;
	Tue, 28 Jul 2026 05:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216876;
	bh=jDXcM86A1g7OefJzeE1l+uqVCywKUZWsPKfSIJvxsu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSzhXhH9DMG9zPB5KTPYY4GbYyZdAUw2EpzDGXkcp5oj3L+OGdQmXmMTESLUNwpns
	 ZYghHMGLlqn0I9T0KMifg4Sy4pZMVPZCZ3EqVYyGA/9FY3Q23qux0Imqm9Sh4nZ/TM
	 x6e1KdepVQp/kv0+uM3EgA8zeJvSPjOQSnqqR4Dxc59ORHfCS0PBFk8RLCUlmznbm8
	 tAxjTIHm8BRWjC6N1XAd44o5EOLTYiVA5A3i51HkKW9Fp4TIQYV76aOMhpYa6GcAGS
	 CfU1Vqn6W2lFaCrFtdhIDrLfuqlEqzyXRw1uWe/3GUWr/MHPajMTI0kg2DC/q205Fq
	 x93cLYOmT0DUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] asm-generic/runtime-const: Add dummy
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728052540.4728-8-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:34:35 +0000
Message-Id: <20260728053435.A6C051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peter Zijlstra <peterz@infradead.org>
>=20
> Add a dummy runtime_const_mask_32() for all the architectures that do
> not support runtime-const.
>=20
> Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.=
kicks-ass.net
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D7

