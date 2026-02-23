Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F32641C6;
	Mon, 23 Feb 2026 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882878; cv=none; b=XWnmtynMURjJjJEYQziwCttur2YXWgcLFHVa+O0ckxkLqSHMKOgXqJpFyDagoS4jhV4fTpET2K0iJ7L3DcMEeR3IYN8PRPYA4AuQJ2ay3zyCk5hRhWO3xZDteeahgVnX4XnQObrcj5Qy2iyIGkWaGjuMSgefDXfsbyhJgNQ2thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882878; c=relaxed/simple;
	bh=wrr10yUbLz45GAK1lj/y1Kf0SDtNxNPpmCwrCE0/gGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0Zdc4QRYdwKVj6UiMbwZbgpaonGekiH1Y+5GAfkb3fbEmmqjZi+TAABUOOEVs/1nlTM27hxSgGVz1+qn3OYNiSr3CWrOR/OIU3mVZV0l38HF8NfrIV2I1G7ZCl5ReiGdpzMwpFsiQplpEB4H5Yd7x3mlyOtYtwhl4NToWKrvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RZWdv4YW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RZWdv4YW"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15A06411D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771882877; bh=ZRQa2cOn659cnxVYpFsMZCFW3idK5YofI4YJEYo6eC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RZWdv4YWLSMCgc0lq4KWV2Rr3zeCtq5R+7pGrvvDTPfAkiCtebImA2EwtC85211YK
	 9A+GEIpQDwBzgQJ1lKhZuh+A9e531sC9M3reRofDCnPp9lmGgftZ0dU44SfPH4hqZb
	 GS5lIQWJgesk1IlOmAk0Zb0M/5CdQ7MZJfCnJ1rWd4lBTKGIQqJnnXaOa1jGZLNaGq
	 hknvWfrrUs6XY7ZKYwjLOLutUBJ7AEvAFG0TB4rxkL0YpHUxVv7/Zy00cDA9kfbKf6
	 /7jsjqYhWbSYDb/Sq3th214LIp3qcpIA3syEdnjoeVQYri19n+DekHrxA87oOJe0hz
	 uj6O0I+16dxbA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 15A06411D3;
	Mon, 23 Feb 2026 21:41:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Miquel =?utf-8?B?U2FiYXTDqSBTb2zDoA==?= <mssola@mssola.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Miquel
 =?utf-8?B?U2FiYXTDqSBTb2zDoA==?= <mssola@mssola.com>
Subject: Re: [PATCH] documentation: update arch features
In-Reply-To: <20260219234040.3260616-1-mssola@mssola.com>
References: <20260219234040.3260616-1-mssola@mssola.com>
Date: Mon, 23 Feb 2026 14:41:16 -0700
Message-ID: <87ecmb3zpf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com> writes:

> PA-RISC has perf-event support since commit 610cb23bcc75 ("parisc: Add
> initial kernel-side perf_event support"); and s390 has stackprotector
> support since commit f5730d44e05e ("s390: Add stackprotector support").
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> ---
>  Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
>  Documentation/features/perf/perf-regs/arch-support.txt       | 2 +-
>  Documentation/features/perf/perf-stackdump/arch-support.txt  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
