Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887143932E
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009797; cv=none; b=bZpUHCIhGNV/hgWQGZaUkLhjh0XSniJ9kRNKPMJkS96CSceduYLJf/N+Tw9BZTKQ8xYiOWGhxRRbk4qAW4p+aTzA5lHwgdMZuou0abPtfZihj5J+ZtEqwoa4vSwCZ5kRxXq75V+wEuDEWIZQcXgYqQ9EkoH++lQlInEpJzFW7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009797; c=relaxed/simple;
	bh=EV0QH2Y/HvGNH1hvZxi4jiBCce+Nq7j6sNv4GjiGDGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFgL8dKD/rXuwNyhczaYyC4PNDHTy1D7t0WkU/I7q444GHaoyhcNA8Kbdayu+b6rGRUAhw4V1xbdKj24WkPpEWpQZ7KRQQpD3GiFIynRRZ7N02xjDkfCb4AALaA0Fx39QXlsgSOKCcYOHzdsxkLfaumqAp88J9qN8iDa74YcYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9wxYO+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9wxYO+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF691F000E9;
	Thu,  6 Aug 2026 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786009796;
	bh=EV0QH2Y/HvGNH1hvZxi4jiBCce+Nq7j6sNv4GjiGDGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9wxYO+lBNbB3LX3drsR17hmeDJhutFRhVxZfgYAFTFDDe5gJyTgv8Dys0ThN7ik5
	 lFmi+jQ5pZ2rgnGMt9l9I9hnQNhdEcGln8x1YFJJQklYHUNSpDEwi9Lf57PaXLtCWW
	 d8s1Pzu4/GgnBcLADe9/mVExm3gh1jXU/s/TWZRXqzdABwXWYQt0LGOicoI+gSkIez
	 oQ7AA4GQ1j92o9W61X73InJQnQ3hrKwFWtcO45w7xkEfZyCJ5D5CW8y/W/fOJtAgnI
	 fPtax9frUvKEPhzUh4Oi0U+t8zHIl4ReHjqoaeJf9N/xckt6fiO3PEQSqto/RZRX5W
	 Uy8G4FSqkKZOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/pci: Fix leak of uninitialized kernel data in
 SCLP report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
References: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:49:55 +0000
Message-Id: <20260806094955.DFF691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While report_error_write() checks that the provided buffer is at least
> as large as the header struct, but not that it is large enough to
> contain the report with the length claimed by report->length. If
> user-space provides a short buffer, meaning a larger report->length than
> the actually written payload, up to around 4K of kernel data from past
> the kmalloc(len + 1) sized buffer allocated in kernfs_fop_write_iter()
> will leak into the SCLP report.
>=20
> However, as the entity processing the SCLP is privileged and able to
> access at least the page including the report, this does not leak data
> that entity could not access but it is still an out of bounds read and
> a malformed error report that should be rejected.
>=20
> Fixes: 368704a65be8 ("s390/pci: add report_error attribute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix_pci_sc=
lp_length_check-v2-1-9ee9428e659f@linux.ibm.com?part=3D1

