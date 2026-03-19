Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAD36EA99
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930245; cv=none; b=WVdraHPDFJ8d3NWd+Yv+nfJRH9lfL2H/QjaRMvAph2mnTP+oqO3d1mxdyUzEAdJYJd8JZ8RcESDxN8G90hBGp5pyPfHB6SncpIhIQir1nhcITnnYp4U2YFQ6gjllm3WFdrPgRT7IcGmfPD+XlpQacSNCVy63HRKemqWlIWChwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930245; c=relaxed/simple;
	bh=mxxVMwi+amuARXgZJlpNP/DAVNmSWHXpqOJ6NIWzRro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVbFWPenyYA29dVwNOFdUHA+sBaYxQQAGZWtqDfTSbEz8Y0wxX+HBdD4spRaegHZmyc0CznPPdzu8l0QIbHmQUty+GEhhXJyYrB8iLeEfzRCvAZf9zRwnkXcZdrG1iHGqwaJA0MMBiuk2UnKQyfKNDVIx0hL1qRJk8BQJWGqWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzA6SFTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzA6SFTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F8BC2BD05
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930245;
	bh=mxxVMwi+amuARXgZJlpNP/DAVNmSWHXpqOJ6NIWzRro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzA6SFTtPWn03heeNo4yw8hM5247QD9zqhx30gj84DBMh8wCSa03K1KHsC4fgEqUD
	 TJsSoc2/0vKSYjRyje/o+fgBYmlAp26EE+9bAW29d8ZDEYxUBZW1PpAUZ2u7cK0twC
	 Ek7Axh904Kzk9JDRaTUtuINzRqWux6VDFim6hZ8m4exW2S03xRX5oiYXEP2KWjWeU0
	 bPRGwphS5k1A2FHd+xaIZtly7ophDfugenlp4pVW7B7b/9SIBPI2m5HucQVTQS9+EW
	 4UmdsJvS4D44OpWmmwbfdXBuTFJK7sd+9a7HaOw9aq1ARfba1ZdcbxlgNkQRjJXXnu
	 fKXknLPDnFNew==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46260385so10549827b3.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3IwQpwiHmczBb6Hjk2euGqPEXse7/5aIv40ub00PKkNdogmnHtsx+/3CH9qYAde6D3Awaut3Ne8k9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3K8+96xPYfrnPzcQtAJVCrd1OdD/IkwwQqAAcexaA7E1ZTezY
	S7P5ZWF9VDKm+mt/0rsYRPfmklQEmy9VTPxkUUz9T9OmdE9g2eKFhYlpDA2hh8+dcbrxAJ/po2r
	uyDZbhwzdr2+BsE6f5kmLRrlQ8CrFry8=
X-Received: by 2002:a05:690c:6e83:b0:79a:8484:442b with SMTP id
 00721157ae682-79a84845790mr32815777b3.3.1773930244063; Thu, 19 Mar 2026
 07:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-12-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-12-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:23:53 +0100
X-Gmail-Original-Message-ID: <CAD++jLnjCH6bZwXW+-3N2+dJswyN5swegOKXcHqG9R9e8F-fgA@mail.gmail.com>
X-Gm-Features: AaiRm50TkPXCutMYcHDL-oXLW1RR0xw09hqcl1IbIAqwzNsobr5zacTUU40ydP8
Message-ID: <CAD++jLnjCH6bZwXW+-3N2+dJswyN5swegOKXcHqG9R9e8F-fgA@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 11/14] s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Rename TIF_SINGLE_STEP to TIF_SINGLESTEP to align with the naming
> convention used by arm64, x86, and other architectures.
>
> By aligning the name, TIF_SINGLESTEP can be consolidated into the generic
> TIF bits definitions, reducing architectural divergence and simplifying
> cross-architecture entry/exit logic.
>
> No functional changes intended.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
