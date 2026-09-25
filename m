Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17E4E3EEC
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368129; cv=none; b=sU5Y5pBhr2GafvRuTwvV0rq2i1itOQgJcrGtgloNWQiPV3ZcG2wpdwD0+O4rleTyawigwc5DL87y64buSElvPL8v36mNczHESV7gapHp99it0G3cFjVYuq0mUOrp9j3lRyhs+yRj8oH2ZbhnL+fQS6Je4rUz9zP0YDqEwbbwldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368129; c=relaxed/simple;
	bh=2JEZ9oAhjarOtzmFhuM6leYYB0wLfFeOb2XtV499v+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gopmaWJycNspePxZgOhX9UE5LkxuXVcEMBXKDX7+ZMBUCZUtAXn+MwGDaKmtA6nr+WDeDFJyhLpKAFKiCFOmWkEzrB1Z1i61Afoq4bx3u2a5uVjJxZg8VL77ct25/Pbh6yasfFSsybXKSY/pnfftGg43EnsXHHkgWMBafXGeq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bofTtfyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bofTtfyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F9A1F000FF;
	Fri, 25 Sep 2026 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368128;
	bh=2JEZ9oAhjarOtzmFhuM6leYYB0wLfFeOb2XtV499v+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bofTtfybZ+I6GBP2teJKqealEFPjXfXOQwoJXoiEQnpnOWuZW0yDdyz/GlIpo6XPH
	 5f0AbXxCb8NEQ0tZdNVgczJy5msMpuX200ihqHHpcQQBmJZAOyKcJRnRAkGRqV4GFE
	 0if8nXq3JadLdsaDKijKQFYOwly73x4GG8Yh4iU+4atajJGbjjkUfmEsKlcuIiPE3N
	 Bo/Ac2xFS4tEhk3/LH/d/s1ZCGmBmi9HCxRTnwEIoQQxUCU3vMJsGgM5PCmjN4++0e
	 T6vDxi+24TlHbcOy77U1Pv7O96chCvjZ9OWPjkXCcG2WOUgL/WJJmKaqDxW9GlMqbe
	 WsoVYJfw1mGhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] mm: change the contract for free_pgtables(),
 update docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-12-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-12-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:28:47 +0000
Message-Id: <20260925202848.06F9A1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D12

