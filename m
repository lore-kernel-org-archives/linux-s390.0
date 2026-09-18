Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB042464B
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722064; cv=none; b=qaVDm/bqHIQdqu0MxnJiFRFfG31lDXEnWMo+KtB0t7H4OHcNFc6Qs20yss+QX23DvB4JwTKJO3xYreKQamqTouCAp9dDlrgW88pEqmJLthywarWsKqf2acE1346+RtUBqh0IWnf6tgnSai6W8FBWpLUUY7w9awJEpXOHUNYjo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722064; c=relaxed/simple;
	bh=70pCFdWORW+QDKrpzZBgT3YjmBSF7wj2LOpzrTEGcgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nA0SSV0ARgseqKMnKhD0Xuob7bGxFa6Yu/cKLuJCcDtvYMbArvoXxI0GaPDrsp9NMMmFA4Oc1UqzJwD7yRnEo9dQZQDAkB4X2jJM5L7r6uyJcw7tn70mcB8fsk9OmXrIlsKf3lNMHidEIaJc/ujnpS9xwCc4/Xhlr1yLREVTVEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DocopVLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DocopVLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D43F1F000FF;
	Fri, 18 Sep 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789722062;
	bh=//bymWxsNFnmtlMzgAvPHN5ERiJsnwoCnoUHensXi00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DocopVLfHm+lrdGD1VArdsPq4esGu5GFzObFZjQuOGQ7q415wunuTQxoiaqHauLw7
	 ecHUebeRBLSJCzwSlGZbjBbrbvRGBG03hkdBxKsjpEWx80g+3lkE2lKk8nK1rGdg5g
	 cm5nLoZ6jnx5OceHzbB37XlvGJjeZxmcNmyEda1cjxnyKYBpIYXhhBDB2wF9uh208s
	 AFVnxviEvFXRTWWcuIpnNHQx6ino5p3uiMXUczUrnQWVU8L9Grhdc/LVOjw5PGMPIG
	 QlYaz4gaCRb7kk5vEh5C6ZBnq+7LmpIrTo10EMiGGyPFJ9poyHJp11/FQ2F3D2/qle
	 NGJT2MA9bIq2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-13-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-13-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:01:01 +0000
Message-Id: <20260918090102.4D43F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] s390: missing semicolon in struct pt_regs definition
--

commit bee75225b6c8e3d1889d09e2fdf377d073ca5fc4
Author: Heiko Carstens <hca@linux.ibm.com>

s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

This commit simplifies the percpu code section functionality on s390 by
encoding three register numbers into the percpu_register field. It allows
removing a complex instruction checking method.

> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrac=
e.h
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -132,7 +132,7 @@ struct pt_regs {
>  	};
>  	unsigned long flags;
>  	unsigned long last_break;
> -	unsigned int cpu;
> +	unsigned int cpu

[Severity: Low]
Does this struct pt_regs definition lack a semicolon after the cpu field?

This looks like a regression that invalidates the C syntax for the struct
definition, meaning any source file including <asm/ptrace.h> will fail to
compile.

>  	unsigned char percpu_register;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D12
