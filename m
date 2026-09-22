Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC252E071
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071729; cv=none; b=qnac8p1bWPSAeevVNP7MzJ6uZ1EbZGwfjyAtYYSwxbMN0BBTxq8XgzAKUPQMFQiaZAkzHeMzNrBMwEhyotd+A4TLGvaYUI7y70MOqT2BfFPoOEjyfWDeVQOAyG/jZL1Ll3KXnkX3bbAJlxRosrXZQ5IKAiKK07THIaVbVX1I/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071729; c=relaxed/simple;
	bh=ykQMEEO+Aj3HpFi9KSJDZpmf8cmHfSxgUfLZIoBQTuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eVqH51qecZS4cTARiTJKNK/fpG14bjCzWRpnJ5GAQNnmu4ob1/hMbdeEGMWvQPNFP6o1q3U5WCNhW4RziRRiU3M3Z4+r9pk0zYocbcwlZHHfhFhy5ycLv8V/HYw/clo6FE+0+ymtbx6GZTe+OdJ4c69t3Q3mZaU1+WWPQzNt/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feLvi5cB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feLvi5cB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54C91F000FF;
	Tue, 22 Sep 2026 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071722;
	bh=ykQMEEO+Aj3HpFi9KSJDZpmf8cmHfSxgUfLZIoBQTuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=feLvi5cBWuiabAHxag31DDWxA5n2JbRJkN2aQWbF7NY4e7znJAig3pMBfCZmjLTKt
	 zK9KfiGPZNAppnEr1D5prNuQOT1O/ItJHxhppAk4swa+J0zVtCbspNfLBBKKmqgCDR
	 ipRwpejbsLYZgmnKAD8KWYO2bl5eDoVSFdER+IO9vaZoUb7MBS7mJG12awDOxb269M
	 +iylIKPjw0KMZBwT2cdpZjMkmkkV8/PAyWdGc/1H/ia/m0z0CQyhV/KllMc3arauEx
	 5wvnaTXWw2gc4lW0kakdwzRK8NM8oeChiyXzIZrG8tqM/8BwG3w259qRqOKoGG3zqL
	 bd5RkcS1EJW+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/sclp: Introduce dedicated sclp-vt220 event
 buffer type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922095903.1595794-2-maxbr@linux.ibm.com>
References: <20260922095903.1595794-1-maxbr@linux.ibm.com>
 <20260922095903.1595794-2-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:08:42 +0000
Message-Id: <20260922100842.A54C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce sclp-vt220 event buffer type to replace the
> byte-manipulation behavior in the receiver function with well defined
> primitives.
>=20
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922095903.1595=
794-1-maxbr@linux.ibm.com?part=3D1

