Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84843CE79;
	Fri, 28 Aug 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918914; cv=none; b=FBfM9f4ub6YqPUAxz8kgQW+SKmSZax7bKHYLP+GqeLYlU/HP1qBQ12jRBsQu752PauYI58HImnL2F20KCW9mtNmjs4Qh5o+/+YGkD8f5RnWmISBDC/Lj9kPnpyemtkuUPbrKqxX6sKZD7fshfW+7lbLmyGRkJHWrYdlZBO0PmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918914; c=relaxed/simple;
	bh=JnHFzlS6+aJEn8qXlALaxzt6DpkLytyDhs8tN6vzHWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2sO8TCyjPkejbJ1c+MVh3YZImkFuJDh3KGDIjh9zKS4GbjNvC8IwLbdDOeZK5Wr4WlQSjZ+flvbDCbvP/3oYz7iXU+UFVRImfbhS2vuQ75RhlQ1lCzd+6Lu4xss1EZT+SUzLrm4ffdwRETFEVP/ccTlUeUrUWSDEP7enZ9J2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAuKSMCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAuKSMCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EBB1F00A3E;
	Fri, 28 Aug 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918903;
	bh=JnHFzlS6+aJEn8qXlALaxzt6DpkLytyDhs8tN6vzHWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAuKSMCIIgzRR5eKO7duogSTD0Wyq//ZFkUi2ITzN1H9BXuKQ8DG9lrVF7oYKs6Yt
	 pB7j3pjqHjJHGJNU1gTbYoFeheMK+fLNv6z2BuHP+w2bWSLa9PYy8pklHkk2dN1b+g
	 Q5F7c6miqQzLEkdTw7Dly89MA0pkJV1hoRxbKapwQPwXb/uBB4fEhR4xfb6lvPS/U8
	 3RFC0n4KWjnPAL9QJAF+vqZl5S2FH97s97OnTbSbTV/6fW6FMtJLqgObB537puZ1qs
	 yL6db9Ecu534uLHu95DdZbLoLfHWU3xZMwgDVCZxk7m1ffYsd57rM+H5W0gV+06VTw
	 dy6uOzc79kccQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] KVM: s390: Fix _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828115439.145885-4-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:08:22 +0000
Message-Id: <20260828120822.D1EBB1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In some circumstances, it is possible that the page of nested guest
> memory that is being shadowed is not present at all in the parent guest
> gmap. dat_entry_walk() will not find any leaf entry and return with
> -ENOENT, which will erroneously be propagated all the way to userspace.
>=20
> Fix by manually calling gmap_link() on the memory of the nested guest
> that is being shadowed if the mapping was not already present.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D3

