Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEA223DC6;
	Wed, 26 Aug 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757592; cv=none; b=d1VsexUNtQZDJ3rZYmAkwiDW52lK+rneMRFsa6IeC1J8m4g0b4rSWDi7QNYqkHDn1cYMbCJ247gR4XqsLUs1Z6cUTk3LREmypK/fsmU+oCypIKSMLJ68761R+2BpbVReFRtlxbVxL6FHF8yiRCwHa8MaGsHvVI7Y9MKmaS+LK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757592; c=relaxed/simple;
	bh=8RhGTQFyg0fueHcenHrAsZCWybwOCEz6FqN7ZUwN1Q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Do/eU/KIgs7Uz2Zz8PtyN6V1C3Jchs6pzITAGjPHKv3J9TX7VBUmKYvylNJ6r0KNDQUPtWgYSazlT8zp4mAmuVxKbuJ3SeTcj4K5Jps51eVsbXNsYOWodYFSVfdAYf6/S6PHRY14erMx3gtAqQHkQ+/oRlUZcZu46Pc/0in1pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJS5AhU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJS5AhU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1D81F00A3A;
	Wed, 26 Aug 2026 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757591;
	bh=c9uUd4RF1VM2MKpLGii7LZPWq9Tpgmcinl3WewgejQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJS5AhU2rWvkkqsEx8reY8vcS6v/dDh854FgkS6WyqTQt+b+9zj45UwQ0NzXiRc7c
	 Ger6jr6XlXDhd3efqFpFhyajrR/HRH3fjHG9lmsNcgCAwuNU/i6tLn1dfYu+5on2Km
	 Bwwb/Yn1n/cANv3b5MZCwJwH59S2H9rwjNCYtVf6m4lzLGn9tG5Xz6zEt2i6R+2WNT
	 oV16B7MVkhb7dFGztHRW4lh4fYf4dlrAMLJersWe1ktnjLpRKiZ+3CLkzQKvYNkfAe
	 wMJv1hE1Xhz17qejRZliJqkfEmxHhqkrkrfC2+kNY+OoKA1mYI4+MWPeJGlDA0DUTa
	 XbuzpymDQQ4YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-19-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-19-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:19:50 +0000
Message-Id: <20260826151950.BD1D81F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D19

