Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8985356767
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362410; cv=none; b=WvNzMxALvBlY34yU8sC+DYXdbr/kOBLQ389WcPy5OlbAf46mssv/ZURVK4z9MzKbyyiJAhNHlF9H2rqzEkkdxdi0XbKdmKFLnQmqFRUQJ3xdya+AwEaX1WpAxQNXOcBUIKVk3jrxq0EPyU5qr5rlmwhtV0BM9rEQtEcZSpXPgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362410; c=relaxed/simple;
	bh=6tDzfNqK3SuR1SHGdQhIjM4Ta6TVAjWae8sDZXA3MR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLgudS+gJnI7V/HG09ty/zkfRuoIl/0tMgpmWXAWAdQ7EskJmyMQrr6FArs2DN8Ov83Pxa3lKUbpJi5EAkDWcu5Tj/KJWtgvegK9W2UbdsdK6ua1KzwxC/G76K956o5ZnHHMUZ3SsDxdCmPXh7gMKef+NvI+nLrq/TVMOmc2qYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+VvE8NE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+VvE8NE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF681F00A3A;
	Mon, 10 Aug 2026 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362409;
	bh=6tDzfNqK3SuR1SHGdQhIjM4Ta6TVAjWae8sDZXA3MR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+VvE8NEMle6muXS1GoV4rbEy+WdCkc8iCeAP5Mu4p7hEYr/AiOq2hVvyRAJ5SNA6
	 RrND21LGHXB2SKnkdxkhZ5+X6eYYrhiSpN25MR70ov62A5UCP/R2XpVIbCgKR5ECvP
	 JKRJg1mBUuMbvW6yryDhF7S7W24n0CToI2GD6lR762MqislrBs4zHn0bnnjrgLIHVs
	 Yv9s8060tOChYOFyK+JFix9Q1zw+KQlb3Be4p+QstHBEig2ZMgGjuUpvM+mDMRw2yr
	 VxwyQlY1JbarpKW/9VFUdbbg8EDWIluoIWVK+0INYanZeCm+gK/ww93pBz36Vwf/Jt
	 0Qsm8EgoYTFdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260810-arch_do_panic-v5-1-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
 <20260810-arch_do_panic-v5-1-e86ae992c253@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 11:46:48 +0000
Message-Id: <20260810114649.2AF681F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a hook for architectures to put their specific panic handlers.
> s390 and sparc already has ifdef preprocessor checks to execute
> architecture specific code. Pave the way for vpanic() cleanup.
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-arch_do_pa=
nic-v5-0-e86ae992c253@linux.ibm.com?part=3D1

