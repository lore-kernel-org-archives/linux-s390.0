Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4A43DA59;
	Fri, 24 Jul 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906062; cv=none; b=PyTnYy4llq3KpUGLFI48dW2KKDW5FEIViLy+z4ZOyuNO+4TUh0NKQO+/N02PoB9lPF+/zf/YdPfBN8D4KF2o0oorNfefH2knIz4jfitcyLryGmzOkoIDE73ltyVlNUuYWK0X7C5AvyNSy032lRIC5MqCFMqvFOMBerM8iofLYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906062; c=relaxed/simple;
	bh=ridgwYklRdOpNnSI94E2boBzclkwxlswD5oEDXwjwC0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=te+Gj9MG8cgR/1XbxXwGSMw9rqo8Ok3hEaA4rsXOT5P/sYHrgVeVrRf/C9oR01bLy7zvxtWejsjZCj9kw7EluvPpus8mUGKTjslOXEd1TeAb+ltSnR5L0WnK4sICKmkhYbH967yzWsm90p8k3lCQHCo8NyfLwrGC8LThXZNErHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOfWS7EX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOfWS7EX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A701F000E9;
	Fri, 24 Jul 2026 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784906057;
	bh=a/BLPrj+yfTZqgdHPx6b7emve2XGylV4F1XKc3QhWXo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UOfWS7EXjvhQWbtU1BEK6aP9XB3BzSggOPVvd+fuioAxlzlv0jpN7H3Cjg3hKJn17
	 1flSSN5yVxliMA1pM2fBVcwdibB9+0n54CdO8R6fXk4mPsHuC5Pus1Bxyt4I0S3UVV
	 uuFN8btD5w0qZzC9RJ5BC9lvmkCZ59tAZNJhevIWWScS8YigTslerOcIysVaPb1+1b
	 rIqVZJuvNVIGkWDO2Y6EDH/ZsbvFopgSCS65YCjo22UJT8TYwjA0+txrc48c56tXlx
	 O0ht9G7GrrswiBV5bJTXax8veXHdRskGYdCvvX2DoHQzS5eUgkOqYx9zUAUPup8Nqp
	 OebJfwRZLwirA==
Content-Type: multipart/mixed; boundary="===============7634794707977318539=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <639df699848dfe787ab17d36cb6bf0a84593e07ce341e2f2265e77208fdfd061@mail.kernel.org>
In-Reply-To: <20260724141318.1037434-2-hca@linux.ibm.com>
References: <20260724141318.1037434-2-hca@linux.ibm.com>
Subject: Re: [PATCH 1/6] s390/tools: Pass symbol name to do_relocs()
From: bot+bpf-ci@kernel.org
To: hca@linux.ibm.com,stefansf@linux.ibm.com,jchrist@linux.ibm.com,iii@linux.ibm.com,dost@de.ibm.com,agordeev@linux.ibm.com,svens@linux.ibm.com,gor@linux.ibm.com,borntraeger@linux.ibm.com,max@linux.ibm.com,jremus@linux.ibm.com,samitolvanen@google.com,kees@kernel.org,nathan@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: llvm@lists.linux.dev,bpf@vger.kernel.org,linux-s390@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Jul 2026 15:14:15 +0000 (UTC)

--===============7634794707977318539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Pass the symbol symbol name which corresponds to a relocation to
> do_relocs(). This is preparation for kcfi support.
>
> Given that the s390 specific relocs tool is a stripped down version of the
> x86 version, add more code from the x86 version to the s390 version, while
> keeping coding style, etc. in order to add the required functionality.

This isn't a bug, but "the symbol symbol name" in the first sentence looks
like it has "symbol" repeated.  Should that read "the symbol name"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30100858043
--===============7634794707977318539==--
