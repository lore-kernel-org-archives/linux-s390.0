Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993947532A
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806056; cv=none; b=DmpFHMM3GnuLl8uFqGZqPF+x8EeZHM/X/TA8rEI10CFvJirjz99Bk81GCm8y9XDqBKhkL67QcFo69C8U6Q42dbMMyyS+/CCNKClkRemJxen1DkizMai+70m2NthQw9HTFvTiCQM8uNGInps1VNMEQrviZur7XPz8T8e7ncufhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806056; c=relaxed/simple;
	bh=hdR4HT8srofyXK3VC6NZ1ExfODGpJ4eCZa/U/6DyGsA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z6zY097yBxccp30ULXpX76KezfErhZl0GkdfO3W2zdAF2m/s5GvqoiNfI/mGkpqs5/3lbjeBMOGr4q5MI3ti6hbNwQ1OYyuKlFKoSaC0dD82Qu1izA71s0lkfNT4gJApytZHFg7dVCmiI5ZSNTPtoa54DLahwyMG9liMHLCY/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suq/RYP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suq/RYP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB141F0089F;
	Mon, 12 Oct 2026 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791806055;
	bh=2SdVerJi1p8mNCp4bt5Pi9uT/UL4WRnhnkE4V9oqcEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Suq/RYP/+blaJZfjzfitEeDDUjXL4/NloiCVcteIMG2Rc1rAlXaffeurckT+2V0K/
	 18ONFchxvwHmsEHprH7iqY2efpwovgzY1jLNSMofgfQ51cRckSxMQwYAR1PfkrTfmc
	 S2wx7YvdxUH3XSZXt2X3VzZLMjUWeai3m4AdBFF4IBItQ9DcWFWCJcKKBfg6DqemVQ
	 lyoMlXqt55DUV4FMJOB9aYOdKO2hOalVp+XmgwoIWUXrBTmDkss1JgV9tvJFEyoszV
	 dMBVRCNzqE5gB59BcIaxVBFrnkvVv1oUJj6Bwqnnt4UkDApbubxvR5m3dPKD0DfbW2
	 6ZxvLo81NrC0Q==
Message-ID: <sashiko-outbox-168033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390/percpu: Drop unused output register from
 arch_this_cpu_to_op()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261012114249.2898572-4-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:54:14 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/percpu: unpredictable LAN/LAO behavior from R1=3D=3DR3
--

commit 657f51d5e5b9873bdbdaca586024d213577edd7b
Author: Heiko Carstens <hca@linux.ibm.com>

s390/percpu: Drop unused output register from arch_this_cpu_to_op()

The lan/lang/lao/laog instructions return the old memory content, but
arch_this_cpu_to_op() does not need it. This commit changes the val__
constraint to use it as an input/output register instead of a dedicated
old__ register, aiming to reduce register pressure.

> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percp=
u.h
> index fd0a3a9951ce7..7d87e0a262c37 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> @@ -257,18 +257,18 @@ do {									\
>  	typedef typeof(pcp) pcp_op_T__; 				\
>  	union register_pair rp__;					\
>  	pcp_op_T__ val__ =3D (val);					\
> -	pcp_op_T__ old__, *ptr__;					\
> +	pcp_op_T__ *ptr__;						\
>  									\
>  	ptr__ =3D PERCPU_PTR(&(pcp));					\
>  	asm_inline volatile(						\
>  		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
>  			     "%[pair__]","%N[pair__]")			\
> -		op "    %[old__],%[val__],0(%N[pair__])\n"		\
> +		op "    %[val__],%[val__],0(%N[pair__])\n"		\

[Severity: High]
Does this inline assembly string force the compiler to emit the atomic
instruction using the identical register for both the r1 and r3 operands?

According to the z/Architecture Principles of Operation, if r1 and r3
designate the same register in laa, lan, and lao instructions, the results
are unpredictable.

By hardcoding `%[val__],%[val__]`, the exact same register is used for both=
 r1
(the output destination for the old value) and r3 (the input addend/mask). =
Does
this emit unpredictable assembly for invocations of this_cpu_and_* or
this_cpu_or_*?

Also, arch_this_cpu_add() was modified similarly just one commit earlier in
this series ("s390/percpu: Drop unused output register from
arch_this_cpu_add()"). Does that macro have the same unpredictability
regression for laa?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114249.2898=
572-1-hca@linux.ibm.com?part=3D3
