Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EB502792;
	Fri, 18 Sep 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745045; cv=none; b=T9QO0XhhETwIu93NmPZhg5NJIumc4dwzKFNYi38SigfnCHHIxXraTHpRmFw9yZIRODXtWnwPkdAMgtqryPrbavrhDXPq8Mhs29lBC2MwR2vNLHIMQfEjtDCUtPo8Mga1vAPKpVNmZdzaY2iWSPXly/tX+iHU2NjTDCXNv/11wiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745045; c=relaxed/simple;
	bh=7EgPpv6+7E85k29wDOwrtNWuCMOQn0Utmy1LBeYCyvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwOswyLyVPWakqG3gLqEffyd1h3VhS4C0WIMUXNCQsKsdNVS4P7CA5lqOMFTZxEgonGvmZBqNP6GKctOJ9nMKLoB++tmswH0FlhXpUIjbORFzAmhWPDiMc9BYzmdEHu5pwmc/Y177VWwXF2zG9FE7YnVp0OVoaY7+Y6ejQ6G1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me1LSRY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me1LSRY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C0C1F000FF;
	Fri, 18 Sep 2026 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745043;
	bh=7EgPpv6+7E85k29wDOwrtNWuCMOQn0Utmy1LBeYCyvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=me1LSRY0LeE5Wtibj5GQgeL+o759a3yPyUEEKwCszBwHggfRWa3Z8rgMxE9flvcJT
	 wMo2WFz7X8uqO/SXibLrCwOhlI3KqcbXG/9Sr0EIcBHliFPlDfUg1hSB6fTWglgU5f
	 yzcHWl/j8h3llMLH7lbZ4r0krI3vsh500Oiss9H1VLOEPvldKFqsU5+/k2TM09O5BC
	 C9ud22o5fyNn5z9mGNesSnPNhvLMy1f2IO9uajnhGOQYDoCLCo9Td8YJsyXflWWA8F
	 lQ8+Fgk7kvmyL6MBnpI65xQ1da/dua9WHgs6jLE2c7jHF5w0oX76Kn8B73MeXHz2/e
	 kAQpQYcSYEE3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/21] KVM: s390: vsie: Move pin/unpin_scb methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-6-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-6-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:24:03 +0000
Message-Id: <20260918152403.86C0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_scb() up in preparation for the next patches to avoid
> having to resort to forward declarations later on.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D6

