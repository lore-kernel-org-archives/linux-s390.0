Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5C58596D
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156506; cv=none; b=GjOlxBmYO2KLuVyWNqMadhPx+RVfzqNPScx8dIRf81o20WUJlrwQfb1f+vvWjVWMTQeUHMJV+zYKYjv1kgS+LEytLuhyZfdmguq4ljWMfoycKrzu84ruW48maTHulBkKLiw8NEBTtLFrmjAcHJ+wK757dYmp4Mt3NaNeaP6QcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156506; c=relaxed/simple;
	bh=u0Jxlm7p/Gt7uJPpyqPxk1VHEUCc3aIXpkJLXNWgiaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=boy4iJz+IscW3i+FGreym9gBkQiQkDDc8zBF9EnjlZknI1/I6dwKG8Wj0Yza8iS0wAs8Hgz/1IvtJ3nXYH+BXfFME9CYqfyuUpHA/Nys7F6w5MJPgg3az8F5j+/QNA2WZWsDDGuTbPUkLoTsP9mLrH5w8DFmfTuduNuSY05Fh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BICJEBo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BICJEBo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3A11F00893;
	Fri, 11 Sep 2026 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156496;
	bh=u0Jxlm7p/Gt7uJPpyqPxk1VHEUCc3aIXpkJLXNWgiaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BICJEBo4RnJdkwuu2v7Wd0RzT/mKvNV+Sq5KxPd1c1SHp2bQgILd+GmthD+mjREkq
	 dlG4gGUON5OZv0BhMpDID19AUh/cfV0A7OcW5r0MT02BHVBYsrNzpV3jweOrqJKj/U
	 6CzLAaEobC2EeLsjWnIKgHCVWX5L4k5qwhsHSOtTVVjR/N2PeS+lPwSWVOqD/NSpn2
	 VNSMji3/ys3XyD8Lm6YY4BeCT66cdp0RWViPht9Y/eP0db/d7Vo2I82m5bXEwXCVHf
	 eRdx+66i5bHWc0Uor3qHK4z4mK6Fd9sXd0EqsJtIJ0ztXBdsqkoQTJOeZqtH/2MauH
	 sLFOFf5UujthA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] mm: change the contract for free_pgtables(),
 update docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-12-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-12-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:54:55 +0000
Message-Id: <20260911195456.5A3A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that page tables are freed after an RCU grace period, it is safe for
> read-only page table walkers to walk page table ranges that are being
> concurrently torn down, provided the mm is kept alive via mmgrab().
>=20
> It is however unsafe for writers to do so, as they must obtain an
> appropriate lock to do so safely.
>=20
> Update the pte_offset_map_lock()'s comment block to reflect this.
>=20
> Similarly update the process addresses documentation.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D12

