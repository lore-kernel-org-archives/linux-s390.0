Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A02D8DA8
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583646; cv=none; b=N0XeQ4GVizfYU4XnJbng3a4OzV9cQStLCwvNPa6iQDme5We2XOS5KXN0+cdO6SoosebPrJW63F/OmJYLbWeejg5G57s8U7CgKyFAOJcMY4cjZyu7ttJyrOS8fWg2Z7uwXuVe6mpNyFhbScDBuvsU3a0t3QuyPILFsPJ2mM0rOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583646; c=relaxed/simple;
	bh=o6S1sf7y+VkiMNSHCpbuYoYkWSC+BQs2sBS7/LCd2jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UII+pQAVe6MoNckG9uW03aI7+DyHSsmcCWtjy9hz1QLMGzjrbJ1h3Ol86R18EPw2Z+nIqwBJyn0t9dIuz/jim+gz2zMRVDn7/qRdYj6LkNupcRjgb2VyrQLEkZW/55RLG0kr4Ov51le7XP61rWkB2a7+mlBfjVu7nCNrlfbG9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKkaLQuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKkaLQuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B8C1F00AC4;
	Sat,  1 Aug 2026 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583645;
	bh=o6S1sf7y+VkiMNSHCpbuYoYkWSC+BQs2sBS7/LCd2jQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKkaLQuovldw+6owHj5i9jektjROGsUEJUAXIbUWhbM8pPtIdE4bZbIIu8h217yNS
	 wfjKZUMl/ZGerwl44NtIANu8LA/baqntJTsEZagQK5zKWr7ls4M7wwqUpE79Baj5WD
	 W8KoB2J/g1bDlN6F+jhAG7LONeUGOHkWunMOmjE+Gz0QVlQP2Ieg8ja9XaIpI/r6OS
	 nSWDEJqdyNdfMJgFUEY/LsluNPYCBhVebO9clIL3rZMuY3caFYsIWLHCu7NZBhr5Nc
	 iB84uz81Or8wbaPnp6p2fn7pX4FH5gn6LU/jAHlZpOgkmjSUioohUNmw/tDzU18/bb
	 6Y5Ljxm0M4+Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/18] s390/dasd: Do not complete a failed ESE read
 as successful
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801111008.3391031-2-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:27:24 +0000
Message-Id: <20260801112724.E1B8C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> dasd_int_handler() completes an NRF read of an unallocated ESE track by
> calling ese_read() and unconditionally marking the request
> DASD_CQR_SUCCESS. dasd_eckd_ese_read() can return an error before it has
> zeroed the destination buffer: a failed sense-data parse or a current
> track outside the requested range both return early, leaving the
> destination pages untouched. The request is still completed successfully,
> so the block layer is handed stale / uninitialized memory instead of
> zeros.
>=20
> Check the ese_read() return value and fail the request through the normal
> error path instead of forcing DASD_CQR_SUCCESS.
>=20
> Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned=
 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D1

