Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF80493646;
	Fri, 21 Aug 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342815; cv=none; b=eZUsoc1WgDJCkJJEH/iordUxPzZPV1Tbjc5Lj8lkz3umzQ+se+iQIXqpdhuO84xTOHFHoQPHBn1rATyS/SOUhQHpkFifpjMEIMzYDrA6xHFWvRYjbcgn1hKPclgkqVcBVwPRzwfQNXIIw49q2dquqFn7cIXRkoULg1z2iTZVL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342815; c=relaxed/simple;
	bh=enNH6IWezHDDHfy3K+qhT29MOivhRmctko9B4KqWnEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxPh9z7899UMbJGTSMNykyy9kjoyHsmK/Z9aD8V/M+c9R/1Vdgkw1T9GGmAOX3lUxxCsk7+CpBSSHeGGIa32xQGXVn27UtU/Ii+aRIZ6EmN6k7qOQU0UNZuIEhH/PpjPXpJ2GE2XDwGJRYPkWV85raaOf8rrUueXiCDMEz4SPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euspMB3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euspMB3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBEB1F000E9;
	Fri, 21 Aug 2026 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342811;
	bh=vmfToE4tbMJ2pwDnsxizbPNnXpfdRZC0bTEo4yO7guI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euspMB3NKitiZQYQQ/hwYtkuED99HcytMlCy6ZtG/ZsaYV2ULIs4E9xBIUQTRs9rG
	 zoHzMP4ANKbDd2PuZoqCpMjRYdr5d3trtN4wD5nBPSGgfjdK7C63RXLmyX8gP/ZruZ
	 YiOr58DxCzVHlQOfqCpZRRhpaNnRzBvTMmPSu8F0Y5yBoRkoeTpPjmrex1VsdCeaip
	 vN3mIHlN8kh+GVATW3tGGSpcLSYfX1xubMmD7ceigG3IMdIehDsDzBz6iwQLsKhdrW
	 FT2k9IolAtnS9Vdok19aJ/nJTGuVTlosQcCHGXaxWg0WIPe0B5zwsrFh1s3SxfXXiq
	 og2FsY1J8ekmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/24] unwind_user/eh_frame: Show file name in
 debug output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-14-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-14-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:06:51 +0000
Message-Id: <20260821200651.7FBEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When debugging eh_frame issues, the error messages aren't all that helpful
> without knowing what file a corresponding .eh_frame[_hdr] section belongs
> to.  Prefix debug output strings with the file name.
>=20
> Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
> implementation.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D13

