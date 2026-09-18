Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F02502D78;
	Fri, 18 Sep 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745993; cv=none; b=VWVOMggAf8TmoSVykX6wMYIC24uU4JeMW8z6h0cUBAwMabZxe4q4pV9Mr2VtBrbzuO53sdYictYOrCGC/R8Xy/5PSfp9iuavYR32JqsLoJOSitf5VJCjUutSZZF4ZA046bbs/ScwUiD8ZOKdACoGWvqn8ZQUkXXsY4z93jripG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745993; c=relaxed/simple;
	bh=wS0NVZftNQTird2TN+G7TyTDd0wQ7bHzgnnfNARWGsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqGhNpn4EW3VyQ+gxbkW8xna8pmQ/XSjpJFNn6HMEX7uS+BXV1L6YHapKz/Ldmt4OJeRrtmb6nXWpTJND4mdi/wW6lp8D48YAAPTWApvyCBcYiZER1RWP0dZXX5EKNtu4Q0i4vP/cq0Sk/wZTnf9sltJOovSPEUbrbb9VQA8HoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bblhFN2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bblhFN2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD91F00899;
	Fri, 18 Sep 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745978;
	bh=igpLbHIpngvhmtNHOZn1zfsutprVpRBOlEUmGejvxv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bblhFN2kSeLbOAJH/uzpuTWFEDwG7G1XwsiMfowOei+ip8iUuJoEfjbTdPLlkysPy
	 PnkToqREBFgbolY2a10m1ol2u3Tf1mTNPdNw4IJy9HWz26m1MdIL63cyv4mJJAYjyF
	 fncmep8DZHl1VH8qKr3o55sJ1ElZv4K03kPTaK0NiUgyn2hzmadO6XYOWKjtl8zoIB
	 0wcoz5PvMccSlTF2MAJPSyQivR3dCFKKvywM62eRAkSHMBpuQxFmhwJ4SqPrlkwo6Q
	 wOrJG9eueH+WHTn1x4SOhCHmikEFhlVU/6S/q/dnrNVunSJ3wLJrOG9hZCyXWzyh7W
	 Pbfp4GNQyTuSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-19-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-19-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:39:37 +0000
Message-Id: <20260918153937.9EAD91F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add new stat counters to VSIE shadowing to be able to verify and monitor
> the functionality.
>=20
> * vsie_shadow_scb shows the number of allocated SIE control block
>   shadows. Should count upwards between 0 and the max number of active
>   CPUs or configured value.
> * vsie_shadow_sca shows the number of allocated system control area
>   shadows. Should count upwards between 0 and the max number of active
>   CPUs or configured value.
> * vsie_shadow_scb_reuse shows the number of reused SIE control block
>   shadows.
> * vsie_shadow_sca_reuse shows the number of reused system control area
>   shadows.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D19

