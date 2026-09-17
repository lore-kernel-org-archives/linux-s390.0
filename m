Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AB45000
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673489; cv=none; b=AWM52UE/Xe6P1sxXtHKmr166QM5k93OI+SiFu48OmS8OWtEuXvQ6L2g11CO6pO/GgGGQaKen84H1cm7wzO2uNGbWXiyuAXgXkUQzgYBTzuH9HbNZ62hehA/N/X/51HVKLfOWrqEQC+j9wJKtp0qsyi4aVCHOM5RTSiGx7XtUhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673489; c=relaxed/simple;
	bh=XkuoiENygCgS8w9CxHV4dHZWrCHUUahO5cc6tm8Qzaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mu65S3q2TfgiRbLBO5dlvzEwwMoTlAr/H2JMnCr2PD64YzKyj3jReWzJHD7oTUKROTt0JOk80afjc5PQRbpw6AK7i5n9oqC3ezF8NqgvWbMOAzIUZc74Yd05kN7Urc7+g7UlQWun/oDpV2ZgdSQBj6fBfC83S7Q1usV+phlrDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3YH4dEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3YH4dEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BE41F000FF;
	Thu, 17 Sep 2026 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673488;
	bh=XkuoiENygCgS8w9CxHV4dHZWrCHUUahO5cc6tm8Qzaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3YH4dEeCy9u03aQpXES016T6OOQJ1dXJR4TCtSAhYVa0zSy7Deol9RxDFZ3sbmqR
	 BNxCf5upUHcnfNJe8QmGWYF2rXv4py417pXsqQK8ERSRmZ7ZFpiCEXqMkroZUkp1TY
	 iDfXflZKoulS4ySRhXQ4/R4eBNVGtvydLaRWCaOmdvX2HC2mxedIoo6NPINsMRkWS1
	 w6XuphynL8yRlgX9ZyKi8nXwfjCr70KfloYN0I/HrjEi7jUAnIiZ5t3uoBES7hEwRb
	 ms5/7drcwtaMWuSgLwXipLZYhhdk/Dko/e+SNw/6g5hU5Smkx1ryykRVm+2wcuoln9
	 YgnrQ1/nF6ntQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917192237.638324-11-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:31:27 +0000
Message-Id: <20260917193127.B3BE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are no compare
> and swap instructions for one and two bytes available. For one and
> two bytes use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D10

