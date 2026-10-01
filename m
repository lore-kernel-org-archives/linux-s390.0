Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C13EC832
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851350; cv=none; b=En1wLNgxpp4NKRzjmKjfBXIHiQutEncaV7XKB+WbLq02ZAYgbNpwrNgx14Oq6h7G+z8ez8e/kkDOV//XOlVcdsYM7pQzuQeh/nNF+97cS33o31qvJGVGkhqVnZMHWy/w9Z9txwlpDsWA0eQIAuNQs3s1mbCzWY43WOLTLz0W6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851350; c=relaxed/simple;
	bh=L3rmbHnDQyAtWM3XnoIFXzr/ntu6ZFrMLxKqkIDW/HM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XaqlLhSIsfdHoWazyIalc38NkNF77Q7C8zFlbKz013UTfQhiEvxzObtmzjH7SCPvs7VInLh8jLmgSTR3JXkiaZ4nzmOnB+UO0N88YjNyYjdx3T9SfXDg0IQlAO2hCDF8smzr8gUWjVWHnpFjDekdCq+4Scsf878/ZpOo/l7InaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAvbrRJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAvbrRJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBF01F000FF;
	Thu,  1 Oct 2026 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851343;
	bh=L3rmbHnDQyAtWM3XnoIFXzr/ntu6ZFrMLxKqkIDW/HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAvbrRJeVz4/bgCgu25kwT0yGnTbt0VxPMNUeT27+4dbV1r0SBjzYUhBJQ5kTt8ep
	 omy4jNSkalHonS2eXGCLhkScJm1jO1VB1KDxN7BQk6snnRUkAJ/rURAXM3mncsPy26
	 WcBLczgn35RbciaOwcjmNo+5638lx+lioz5H5VXjXRUbe+3pOgAAR5juqdy36veEqC
	 y1kqTuCy62QHFgsDhLJtzCWXlFCjLOYe3lIzfTGc39DE99Wb0ZeOLx86QId8QlkntJ
	 dpS0BoaVsH+/RcZPADWAj1uipO0R/GN3b7O34Hz6CY4KBEtzbia9kgZhYxA5vlX4Ik
	 RF3uWg9VtCyAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/32] s390/word-at-a-time: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-24-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-24-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:42:22 +0000
Message-Id: <20261001104222.9FBF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the load_unaligned_zeropad exception table entries to use
> EX_TABLE_INSN. With EX_TABLE_INSN entries always point to the faulting
> instruction, so the duplicate entry and nopr padding are no longer
> needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D23

