Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F5370D4C
	for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699175; cv=pass; b=hFt0VoZk/cL1xsdbL6SRNTNlJz++qPa3U5U9KtulPZS/Amk9OHDKh34QyevUIiWXAZA541WjdixAmj/wVBkRO3u8sg21X1SKalDUr3X8u4cwgkWQo6yA2f8KF0vrw2X8Fn6+LCCW9Km1mz057l129EXK7OitOcIhSfblQ7FAvVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699175; c=relaxed/simple;
	bh=rsp7Ihi8TSAj7hc2vakkxGqqL2oEkNH6XMA5zjqI1qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjIQRX6zwnaaPjKPTGcMi0eiX984D4r104AXT5pZ+XC+AKdlWeCloGvHbSvedEvBE5SK/SwDX8lwwigxqO8euraPtnNpq6Xn2zKruaXBh2D6pwnbRa2TjQQ7o8yNHI9rHrxOIQf7wu4X+UDCMssFvTFCMXhPG7uKR0Sj66t26hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXFirVf+; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXFirVf+"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6652452d94aso3127830a12.3
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 15:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699172; cv=none;
        d=google.com; s=arc-20240605;
        b=dzZCfoP0tMFqjb5y98qU2/SyNpH6RV3FHfUiBQ98PYZnkvJNeYMFb8O+UKKt0OkfXx
         kiP0tOKpgIGG2iLv46q+Ak6De2gWzE6cDGiQCDf1/ySLfcbFrgNfldN7KGp1NwO2uRq1
         0zNlgV2rwpTLkx7cYHvk2REQhYqHuib2FGlIaGQn1EeNE5VeLf4/5BUvzM3HkQ7ywSEt
         q9pXz9VSPCFZRl0cf7pa5s5FeCZCwAip/Qqw7U60nqK6TA1S2lr4uKGc7mXUPtNT75NU
         eCUCOPgPmieENdOt/CksbfcCudI6eu07LM9p54jS2/xlFfBYd+xTEVQUBau5PWdGc4oI
         1gLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        fh=Z+ppi+1YKARUBrytdSYdFog4kwaoKdOapehHDVn59sc=;
        b=Mw1BhjiweMSdD1AbTpPwW0+5MQvtAZKBeAGFjVGs0npgmYnGSbEC4hyU2gIoqKoKp4
         OYNgIDQAsVYwxy5+fKU4bVb3QDEGH6y3HkaSQ69LS+lswAiTwgHjxWKv5VwWduoXUKBz
         J9/j/Ua1xd6w/IOt1LV2v5FpR33i1f2CeQ65buyNE0V81PrTEOxyxrkorxp3qdhj6ZFf
         h3Vt0ESP4I5DkXM5RSxjWkDF+K2WwDdw2/f4QrZXENClkmp1g9+aokkkDoGSomnZdsJG
         SatWv1V3s/jN16d9crvc9UO6W1TyBWmXuWbUiLq1W5m1EECZhqudqOBRmmXedXvrfuLB
         KTKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699172; x=1774303972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=nXFirVf+3TZ7nayCWf+YAe8f5IxUtczrfP1EXNbBIrmwKiqwYyLnNpAauLND8FQtug
         qyiFy+esPMVr68OOOX82lIQLtv4g9BlFNZaBwo4KsXwCVqnfA/cnHzxN3Su9BCI72YRq
         auyRj61mHF94yEemJmjWC/U+E7H+3VcjkmPSPrWbYeT/sNINXe1KOC5DtsQxJjPZdVBP
         hNMRzTNBiyInnITmm9ONHtYXDRin1mMnPr1z331IK2KJiXXPmzS1yp1rdXfeMlAWA2Ci
         qg4RD1I8Hp+NegL76P7aa4Y8Cgz6Ykhx1YR2At11/HUaYDUKWkEbjQlI4WP+iffGCmKo
         wGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699172; x=1774303972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=cEONMS6AUMfmyW/pMHg/Of0E3R3K3D4D0J5jNkQAS0+rQQQdyx6UVoTy7H1NOISbls
         nyCKmNvGXz6LJ++QS25oeu9J7xeWNeCLaxPqjBjNQAtX/NF1ooqkcElORkt4/9VofnUa
         UOV6ATEz3m3EhJvpU6uQxDzINYWyJzqIVn8SmdOokJO5KtEfEp+g696vWlSU8hWzMiv3
         C2xQ4eaTRKbYb897BjE8OevhrdHhiAV9b4shEX7u/Z9sKBIJj0PftvnnFZN01u0PZGAi
         SvpprhQX6f7fYteRgV5Soikjw3GNVbAfvwG9XzZTM55S5c5y9LiI5WT6mqaeJ4ZR40Vd
         u5fg==
X-Forwarded-Encrypted: i=1; AJvYcCW7AEst+B+4GEyq9GXlrRYNnOLxMi5fFPA1T8RXOC+2WZwVLYEFnjWZdilgt9bwn7gknt7iVLKay0uN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2//H4sg6NZWoNPyXt/bTxB9uhJq9SihS1bODXc9FRbbgchHAZ
	SJBFdZZVh1lvTHxQMcMQMt3pvAaNKf7l+sQ0z3CM6nS1vpUIJZoM6zfeMr3sjrSpCnv2HEot++c
	FhX3q2CqaudhrN+utxWkV3KP/PIgZODM=
X-Gm-Gg: ATEYQzwovkKxE7O8a/bWbTKW+xgJJ7FyiMDwZDbd6kVIaEiMAEJPh5x19+bdKDZyy2q
	Zl2yncTY79gi5ntsdelyfZrAHAk3Co5FbyLjktM6YPk8eGHyRdV7MnJEqK/39CcTKSyZ/vsOULk
	ePl8+kWdhk0np2wsZCHACCHIyyF8msZMrW4LE4xGpv3ZSrJppGeIm+joOb7z6haQ5XqO/9wVsFo
	qn9papa3tzTNm5IeNFUcog5r92TgOFRjj9L+Rufn3wDDGbO4MPZkMN+7FUxKd7EEuEuOOJ7XoZ0
	fwVRU4sVLnQIVh1Mp+F8IhjX1XJiGoOEZLaOSSwC
X-Received: by 2002:a17:907:1c0b:b0:b97:b515:31e with SMTP id
 a640c23a62f3a-b97b51509acmr346111966b.50.1773699172087; Mon, 16 Mar 2026
 15:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-11-hch@lst.de>
In-Reply-To: <20260311070416.972667-11-hch@lst.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Mar 2026 23:12:39 +0100
X-Gm-Features: AaiRm53MOL-S4iIRiZrnVZNNZCm-cfe6kMQGe2L4WL9TC_xpq_akeJ994p2lXMA
Message-ID: <CA+=Fv5QkJm8+ysx8W=ypr84oSR=rrikfk-iMMU6_xrtS1PsWvg@mail.gmail.com>
Subject: Re: [PATCH 10/27] alpha: move the XOR code to lib/raid/
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Move the optimized XOR code out of line into lib/raid.
>
> Note that the giant inline assembly block might be better off as a
> separate assembly source file now, but I'll leave that to the alpha
> maintainers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/xor.h | 853 +----------------------------------
>  lib/raid/xor/Makefile        |   2 +
>  lib/raid/xor/alpha/xor.c     | 849 ++++++++++++++++++++++++++++++++++
>  3 files changed, 855 insertions(+), 849 deletions(-)
>  create mode 100644 lib/raid/xor/alpha/xor.c
>

Hi,

I applied this patch and ran it on my UP2000+

The kernel builds and boots, and I verified the new lib/raid/xor/alpha
implementation using the XOR KUnit test, the test passed, see below:

[   25.705064]     KTAP version 1
[   25.705064]     # Subtest: xor
[   25.705064]     # module: xor_kunit
[   25.705064]     1..1
[   28.957992]     # xor_test: Test should be marked slow (runtime:
3.253413330s)
[   28.958969]     ok 1 xor_test

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
