Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA92F5474
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252729; cv=none; b=bi4vVrg854u45iJKHVVRXKWPeIO94STtj4urlDciHXVDEXryncIAIDa8TOsSH36lNinuhWG1N0euHULxDwKMlDQcNSxT4QAoD07PbZoYObwuwSjyEKlIEkSgpzlAqxomaKEJQgF+XR6Drd4UvWt0VzJ45L8UA7PXMUjg+COpecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252729; c=relaxed/simple;
	bh=sQVEkc3qFttUpVbpNGHfUblVyKzFSv1Wjwjz0J7Dd+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OR0wrCl7OvJwU7TxmHpoI2r+Ld8yQat5Sz0vjAea0R3ISdO+HqcCIdCZ6OcTm1J4y7A3OhqkqnHzkpI8JfDBTR7/T93MynXFs9subUYLJPYJsiJIHRZXp8cQNzoM0SvDd3MckVc+KnW2iFK5XGAGzTRjW9p5YXkrQpt+9BRW3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUkMwNlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUkMwNlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69BB1F000E9;
	Tue, 28 Jul 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252728;
	bh=sQVEkc3qFttUpVbpNGHfUblVyKzFSv1Wjwjz0J7Dd+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUkMwNlkVaN5EkERNHCPZhvPKoBzbFRi9EnW05wQzOddheFThSymhZzLe8r0TSowK
	 ijeJ1NGWmrlUJ3Y7CAH/JolMFMrLv4htyUFQBbEW//OiRMIzkp1pXZy5RlKkpgugii
	 SsigBksp7yDF4x5FbyVRKScYgc+7BYzEgQv4EYv2vlEspDCnPgqJow3WtXMGd7ul3B
	 LMJ8B4GADP5eNz+XluHvQd685XVF/v+v8x9ATWGsV4xTWhEGioDV9/4u0Csri3DHYH
	 3Ap5NUKOhzc5sk/ScTlQ62d0kCwanLPPlIYXsUZMVr8NGQLSZT3Gz0RxaCS0jZoPzw
	 5tWXJ53pC+O0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] s390/crypto: Replace cond_resched() with
 msleep(1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728150412.3893933-2-hca@linux.ibm.com>
References: <20260728150412.3893933-1-hca@linux.ibm.com>
 <20260728150412.3893933-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:32:06 +0000
Message-Id: <20260728153207.B69BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With [1] cond_resched() is always compiled away and becomes a no-op.
>=20
> The comments for all cond_resched() calls in crypto code however indicate
> that the current process should be scheduled away to avoid instant
> re-invocation of a callback. This is not what cond_resched() would do or
> did.
>=20
> Instead of just removing the cond_resched() calls, replace them with
> msleep() calls, as suggested by Holger Dengler. This forces the current
> task to be scheduled away (sleeps) like originally intended.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728150412.3893=
933-1-hca@linux.ibm.com?part=3D1

