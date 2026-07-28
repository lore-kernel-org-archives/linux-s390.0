Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033232B109
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253703; cv=none; b=e4yRUN9H1MIjGqUNoauBsyfXmOC/hiTVjO5ZDGEC+8TpoxixblngG0ky4h4OGNHU1vZIYIDQ+gGP9UBfO53+IeZD9+npA9ZuWaiPSff7HanccwMa3haEbAVoDeaS+4lC0WPPYPpvbCIx2MdwlC61S0vLlOw1Uo70DIuxVfc7VTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253703; c=relaxed/simple;
	bh=ALCuMjJ2DPB8zgpua1i+R/Ge+efzof5ebG9F4BIyYbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KLM0VlUFk7mhcehPwTprR3qgez/4kD+6HHmUQwY9OIpocqlJ4I8AQzcA+iZQWMPOvmogRfRcwdAudhbYw1ZfDXU0AiH08a1txBK/59I2RmhZKtP2BcFt8/XQJ3wegTksgnI/3HwwCAg7AUTmmm+KpIaeyNxhs9JquMpqcgCnC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuETt/xt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuETt/xt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8391F000E9;
	Tue, 28 Jul 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253701;
	bh=ALCuMjJ2DPB8zgpua1i+R/Ge+efzof5ebG9F4BIyYbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BuETt/xtw8JabU8rWORtGdHFUkGTh3MnIf9CFQwyBXKyet7vp8j0VwkwdqgtT3NZA
	 xexJVRMEM5Fw1wZBkeJXfQN4+2umZXZNwi+qmqCj+/LrwKuXRvgqIs0ePqDHPB6kCF
	 5hvN5JG1yIRB+i5ZklQ1qNdTdsVLSb4QhIuePXPmq+qG0rGRp4fVw1hGfRtVXto5ei
	 Rb3CIcBOHe/xU2HaAk6pASiP8QnN97rMD8UEu0r5MTOFHYtEaMxjmZ2ezucltryLHx
	 w4W2q7H4+TGf1GVsFPfJJobCGXc95rybyK2aPnQs0C8cLn+mwQfghOqy5QuUZKeNIn
	 wyMRlqOJrU53w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] s390/cio: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728150412.3893933-5-hca@linux.ibm.com>
References: <20260728150412.3893933-1-hca@linux.ibm.com>
 <20260728150412.3893933-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:48:20 +0000
Message-Id: <20260728154821.2B8391F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728150412.3893=
933-1-hca@linux.ibm.com?part=3D4

