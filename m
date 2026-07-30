Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB738655A
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389864; cv=none; b=gLR2A35mDeXO6pW43OT8z8OyoY4HbdD9/uU9UL0UGUSccpgHcFli5VUZX2B7XYvs8a5nJn+nNCvVla+1D5cIc99QZKClC84nZ828IF0zO2jNJ1Aq6ZqSL7vu0bfGSUqmtZ8DGCYLEcMjRVIO0a67vQrd9Xkbas9yHDRHDYJWzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389864; c=relaxed/simple;
	bh=TqRa913xTq2iSWb6YOJS/PUbyyB8SMEPCYiqCMIzGNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peSi+I7I7pL/6Z7Pk4LDG9ZSZePO62DrUC3izpQk8kvHj94dswcZb6CHvp5JAQ5qjMwvAW8xQDfogQgANVIZE9lmJKUeRCoJ3ZTexYOG1vrTTL6QINXqhrAPgaYafJY4mEv16HwXjRJ4z/SIGm/WrF6iPo+8Ud+o91rSV6jJykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6elg0bI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6elg0bI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7757D1F000E9;
	Thu, 30 Jul 2026 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785389862;
	bh=TqRa913xTq2iSWb6YOJS/PUbyyB8SMEPCYiqCMIzGNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6elg0bIbWRRoYftejQyhDwwEd6lgNFSUzHhTLZC59ubQqTZvZhVDkgPLpst3rlZQ
	 RelCwX6r9Mz/p52Za3AQ4rkLemrZv3N0iIb6BldlbfbfAunFwH+FENN8cLkmCZBqW6
	 +toOUJy07OPFpsbY/eMRqj+KJKgcZB1jue4xvFmXRLMErCMPGnXu1cln31XBs3WNeC
	 K0LFdiN2YK2N/BRZNRqJWydDPpBTfgFDbw2nVj6R1fOfYWUh189R2LQuQByX3gMwqV
	 JkqsktPB+go+fKKjMotGs0TjikdD7UR1r6eBCtggbOhbkXSKZbN7Q9364/pB6Szkll
	 4s15cA2IGywJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] s390/cio: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730052907.2607026-5-hca@linux.ibm.com>
References: <20260730052907.2607026-1-hca@linux.ibm.com>
 <20260730052907.2607026-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:37:42 +0000
Message-Id: <20260730053742.7757D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730052907.2607=
026-1-hca@linux.ibm.com?part=3D4

