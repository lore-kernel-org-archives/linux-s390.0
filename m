Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE7560AB1
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092077; cv=none; b=UCRxMc8sqNo9nG3e7z+ywV3Zys07vUB4QDw7zsFjtXpGNA8TwCi4ZtJxt6iHAdRZyeBQ/WUq+V9YLJYmLm9J/fMG8gxi/oqN3lBVyWkkkrPgM4JXf8BH4QKnU4jJHoulSncffZfslOjYf/+V2YKuk2/duCa+fj50XGbFISX13q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092077; c=relaxed/simple;
	bh=d1t/jxrZZrqy2lG4zP/CQBW3YnAG2lniHyuDOnhHwlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DeklWqE7HR43buwfswuxyAGsmkLUClxtZKLpfQ6Bjx51Q2xNseFHUiqz9WiaNbskIQ5lNbdtU8Acaj3ytzM8y3K428egh/gmD3cJzRGPveqxMzjuiXlPPHVN3X+r+wkzPDmP1wFlHGVaJlycQ3sWGgbt5I2donEF/+GvquJ7Lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuytfHd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuytfHd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEC81F000FF;
	Tue, 22 Sep 2026 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092072;
	bh=d1t/jxrZZrqy2lG4zP/CQBW3YnAG2lniHyuDOnhHwlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WuytfHd1UWrCvpOEncjb9icZQtUFVuxOE9Oe86tszxDdyMpHClZJAOeijrbfJjy4T
	 mwGHEn4Uiny1KS7gZYWBCXIhIu4S6NQHQwKja1zdcff0frkTo9TkJfRk77LpF0naK/
	 G/UcB9CaamJkl6YD12mkxZVHek7VNUXQPi4f6/iguw6nGnM3XvWqjegB/6i81zd63D
	 QZeKuebtoRbFcJHLYcBzM0d6CmIgAFdagYceNFzm2ApgqheKdcS4NMhwx7toivSK/M
	 yVL3cOsaEEQgddheCqbwqkC5rEmw5dF7ladC4Zg77ljWX1pni6H9elttxwZAnrs0Ay
	 nVXILNqDWCV+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:47:51 +0000
Message-Id: <20260922154751.EEEC81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
> for GUP-fast page table walkers.
>=20
> Naturally, UP systems do not have to worry about concurrent GUP fast
> operations.
>=20
> However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
> future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
> enabled on UP, even if concurrent GUP fast is not possible there.
>=20
> To enable future pure-RCU page table walkers, enable
> MMU_GATHER_RCU_TABLE_FREE unconditionally.
>=20
> With this change, it is no longer necessary to have !CONFIG_SMP
> pgtable_free_tlb(), so also remove this now dead code.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D6

