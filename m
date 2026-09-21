Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F634D9562
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008483; cv=none; b=shSU0KcCOd7aL7Ut4BJdEx37zMtP1OuDKltIYoilLh5cH53zOgxgePCknXsjsEA9mBgqxk5TCGKYYPtG8vDCNjcyozL9SI4NnNeS5rO6QRXLAINQ49vtR685r4qgk59k3BO3XsKpqihZv3rSZENKobUVmAx8jQdwZAGIJAqstzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008483; c=relaxed/simple;
	bh=2OSSsS37ibJaAAWTLZwQbzqFvRMpm8D4zZOeuZgZfgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifWJ+HyvTxqEuSl7W2TE5E4KukQQyj0gM/7MlvhZbPEqu2j4vDeT0AL0ng5/MLISaXHgrxk0h1wN9A6IscuMLE0kdsSwvB2dWH573G1njAEjpaGsJauqgEeoxQucxyOBzTaYG7JyzG/ZotgzTegYfs4DEBnRmwTXy9morRWmmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGKYKqZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGKYKqZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7611F00893;
	Mon, 21 Sep 2026 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008481;
	bh=2OSSsS37ibJaAAWTLZwQbzqFvRMpm8D4zZOeuZgZfgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGKYKqZTqxXdr+pBFS2vY2ca6n5/jgc0I9uByDifOwTfGQElJLQvOUfNw2PiduIwQ
	 j2wefBYj/0Dwf4TZQ6OkcCjmVsZFqFCZzQXQ+sOWmEXyes1KtTtkqV6KApBcT74UsK
	 S3U0iFnYRILZVmNXvfIEKcO0VDWuBIgDKHcfm9ojhGdePOyhqF4IDLLXUwfQ3VSG17
	 ymLNV04kJm788W15ZhwDGOYRPcJR66+qMrpMNW9CliQ8U8tywpBKlLfSpms9bVUDo8
	 Wz8qMOsdBruCckbkTAII8f7R05fFbC0RoFqZXbqEvsoKPm4Ws9fCPeH7cSl/MWQiku
	 cSS8YCA0LKNBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/11] s390/percpu: Use percpu code section for
 this_cpu_xchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921155806.2447506-10-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:34:40 +0000
Message-Id: <20260921163441.0B7611F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_xchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are no compare and
> swap instructions for one and two bytes available. For one and two byte
> use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D9

