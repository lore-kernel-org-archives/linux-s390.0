Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E144429032;
	Mon, 27 Jul 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172345; cv=none; b=kg1jlJmECP41W7ZCjMfr4fCtFn5XHTq2rx63pUt3VJtm6lcHDWtGMFgoX6FgsGab7nq4VLMqCTEuKDqTWeEXvjZbpck65Xru23FLD3z7BQX3tXbwjLAfz5OzsOjW3ce4JiE2auPvgW4k7/5Gk+0pIDPTuONd5yKq9I/H/hheVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172345; c=relaxed/simple;
	bh=FVbKoJoPPEyGzbxOClEqs2xJJNuDTTqn7kRxOktgTUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwEJhyTfzWNI6pFFhfGlg9D5OQ1YuOWsQPlLU54py8DoxEHfy7Pvxyhm4KIHJTO5QIlZbt8Byq7XatB+akp1nTbsiwL7NhCQhLXOt8liPhqop9fJGhY2WOjkUMeHZj+b4zayV0zsaG7oIGwDxMGtsYs+vKJLoIjqV5vFV3qUZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss/h/bIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss/h/bIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7F1F000E9;
	Mon, 27 Jul 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172344;
	bh=FVbKoJoPPEyGzbxOClEqs2xJJNuDTTqn7kRxOktgTUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ss/h/bImLLiLMMJLfsp0ZWcPsBLhzgqOJytWD5KX7GdjQV6nG7BBbnuEe6dkI7YIv
	 BBhf92YT2nvGYHdo6pjqmM+/47BrmV+iPLevTb1DFrdNPxZnms4uuIC7w+YdYAJSKh
	 Up/+l54m5gwysRYDw0e9mUjhBXupTgWM9S1GRlZ2li8yB6EAmpQtLFP65sauNT5KQe
	 1/EPF7qkCiNfZM2Y4iNKBSY2A/AOZ7S4jDRKnctHDZSoS2/xOfpbRfp12CG4SepXu9
	 3Q+Bu4kpn2JuE9VN7B1Eaj7EdlkR5Y2NfIgY/mgXCXo7XjFHuDe4xVmLbp4a2CIodg
	 +Qr7/8ZluoqlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727150254.236021-10-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:12:23 +0000
Message-Id: <20260727171223.CCB7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D9

