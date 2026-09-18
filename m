Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811824AF168
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721781; cv=none; b=Wny2+iAPdvX4NyN3sj5ZiBMwfqTmrdxsd/DmLJdkJIlRCuc7AZ+/ol6h0NuUlBU2YtkBSjcX9gttZtZaOJX0tK+9qby9v/9Af4VCy2/ZAgxzGTSCO7PJSt6IwNbicuoI8SJss/rh0LLXXj1R1fKRH+iTK35QjlyzZFMory5iW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721781; c=relaxed/simple;
	bh=ytMo6g4aXb7OygT/xEbjTTCS7FH0Ia52AbOIqEV9XYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hwwd0y/bh5djIBnkBuocVK9t+3AzQ1htRp9VzaxRlL0M2q48s9mcEmWniSJ3SaFuwwVUlMWgXqZBVgapvKqg9+DaGCWEcqxqsN8LxGjVEDhbN2nPq3yN76h6JzvmYwWGK8Qn6oRw35cUMQVSJDWolsMscXmIF0l8CM9V6PzeMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ppKcIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ppKcIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DCD1F000FF;
	Fri, 18 Sep 2026 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721779;
	bh=ytMo6g4aXb7OygT/xEbjTTCS7FH0Ia52AbOIqEV9XYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3ppKcIJTIASWQk6jbGyBex9yZ2sZ8A0LZx4f6zqkQzih1YjKcAswv4oJVqHpNdzr
	 D6wYK4PDWYa8HVCWyVaWNHLonqc/QDX+MLn6nVGfYV99w8pm7G8oyX6f9vC4vEl2NH
	 TbfWWJ9Vbet0G/Sn9zrIhUGAnQ2mGxCWtoz+ZDZwtQztHNAlAOc5kApVZcPhovrNuk
	 vmD6kgvZG/YnkZDrWevIPtQZtJLqRyRtz7cx6smd5Wuf//GrCq5FW+O5OmOY1gfjiz
	 LSRkeS+QvVTTjERfWqxJzAAiU2h5oTzNYIQzomOsWdysQWSdlJz5QVnRKJ1Msrm0hy
	 Vxh3gBVvqFTDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] s390/percpu: Let MVIY_PERCPU() calculate
 alternative displacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-5-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:56:18 +0000
Message-Id: <20260918085618.C1DCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Let MVIY_PERCPU() calculate the alternative lowcore displacement instead
> of passing the same value(s) again and again in all percpu inline
> assemblies.
>=20
> This shortens the inline assemblies and makes them a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D4

