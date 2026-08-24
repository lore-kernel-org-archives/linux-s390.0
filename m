Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1803F44C0
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563847; cv=none; b=sEsOS4c18rufUW5vZGprOqkv74VtTxrnLN61PDePfruEFjsb9u7zNfTjD4cWdx2aEeZ6dyx973lUAv68pCQP9tdpmFU9XIlbe/W3rlrb3pDgLsmrpgdFtTZL+8qHtO6ZmXiw4vFoTnWY56sL6+uPVz4ZzUVmhD7+88xDoSvopnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563847; c=relaxed/simple;
	bh=JBcBX0J2+Smqjce3rFv8x9rAFNhJkeXxfqxwi80+xHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uz+cWxqsJdbC/04NJqQ2GB/MzVHFXWr3yIjn6MWkpSq0icyV5GX9uuEousSfylP8s7IvNiTmAIhWA1uCiRXFrXVb0lidKY7dy23/lUw6VSWGhdf5t8Uyodi09I3p/u9678cjjZSScnfHleLLsSNmfuFkr9HjrHkpccHa+h7Vmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwomDNJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwomDNJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC21F000E9;
	Mon, 24 Aug 2026 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563846;
	bh=JBcBX0J2+Smqjce3rFv8x9rAFNhJkeXxfqxwi80+xHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwomDNJJJubiZhYbNg6uM2fv5ZVOPWJkbzMOrEK9GnnYBbUUwOjtyw25n2k2Sj9tz
	 WwNy4EJu0AA942h0H9jEOvtrQg54oUHsAEM7QVDubf6EoYxq1XkBGQBksXe4O45ETK
	 Tb/fQS+lws76KWvmRuqO9IrbaKz4i/s+N/LZdhapN097b3zet+oJuptqnoluZ6GIsD
	 EuO9PBsyKCs07LK3yPyUBPxbTeRBp2/33IoU5q1L2I9jke+0CvX1iml5vmyA2jLNmQ
	 mppJWKPIaanpsrExSi+wo6cnh0mOdtoZe4oSo1A+9yAQ0MRzBhFncMO2UohOnZFWge
	 yn0HF8raCTo1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260824092036.3075553-2-tmricht@linux.ibm.com>
References: <20260824092036.3075553-1-tmricht@linux.ibm.com>
 <20260824092036.3075553-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:30:45 +0000
Message-Id: <20260824093045.BEFC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use PAI PMU index value as function argument instead of pointer
> to struct perf_event. Only that index value is used inside
> functions pai_alloc_cpu() and pai_event_destroy_cpu().
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824092036.3075=
553-1-tmricht@linux.ibm.com?part=3D1

