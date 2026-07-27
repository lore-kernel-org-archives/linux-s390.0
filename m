Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5E389111;
	Mon, 27 Jul 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162996; cv=none; b=JUzShqpiXlQk4mxzqtc8qMRvXc3b5/iTBSUaAwvLrR0gOogXgE29xWXKrd/JnVSpiyeHM/coFftCAlejBq8mfqVuuCNkAyEf6z1ScjvkMavId4NkBc3zMg1kh/6jGO28mMd+wz+s8YRg1TtADW6YO00zmyuGWxEvJKha49mMaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162996; c=relaxed/simple;
	bh=W2lwqKg1HXDcDJGX1N6RvzgGetvAMAycoEPNY0Spucc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLB4FgZXKRjiTVRR+rq+Y/zPufOI85XgbPl3+HHmA5Uj9nR2wWHO9MqOqwK7tCoIoh08deD+5x4JV3T3aSJlUKA1HGlU+ipzdlBVqEeQVMtt4wjWuyf4xMmZq//UfyIfqUfim4UkYfNzKBAdWZs0IY5GOB4RF+I67TQc2oNAwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeJPCCXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeJPCCXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602C51F00A3E;
	Mon, 27 Jul 2026 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162994;
	bh=W2lwqKg1HXDcDJGX1N6RvzgGetvAMAycoEPNY0Spucc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WeJPCCXSDbgWakbMb+UymYxdQA936op9z2LejNOTULmkqspuq2M/pOJ6bohrOBx4p
	 +eefg8OgBpPzV9aUrHjHvRWsokGBsq0qSI6qudkzpDAPYXGdK9Zsd0fpiz0GByaMj1
	 sW6HqxJzPvXDcvgqEDlzMVLHpRNSbDOEBJDcm8rWD6gZQpae9/R7pXvQj9GxObzc0g
	 RHi8X/0ZelycqiN8bztM//6Vh3iNN+NbzY6x/mzCzmB4aZpG2xX5WbsNFvR6LSOU9U
	 U0JdS49uOlDXiVWr4O2SEO1luAKak5S+bav10AE1kNWd1UnY1tsWPcsMjhzfgQSUak
	 lch5NRFDssBbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] s390/tools/relocs: Ignore __kcfi_typeid_
 relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727140514.116501-3-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:36:33 +0000
Message-Id: <20260727143634.602C51F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is the s390 variant of commit ca7e10bff196 ("x86/tools/relocs: Ignore
> __kcfi_typeid_ relocations"):
>=20
> "The compiler generates __kcfi_typeid_ symbols for annotating assembly
> functions with type information. These are constants that can be referenc=
ed
> in assembly code and are resolved by the linker. Ignore them in relocs."
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D2

