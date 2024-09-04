Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051C1E1331
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476033; cv=none; b=ZuAuM0W/VV2ujmnkJ0XP3IRsz5/Et8itR378g7MnWVLzuRbKHo+xAtEVkNDy1eODJgn8GdsUjPiMbwRiK4qJCJd54hjhrIaufHRafL0q7lpMDpFdOUpFQZO+TWVRX8TlRWR4Uo29QZ1wLqfpwGOP07ceklj23rZ8B3D0r3UFlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476033; c=relaxed/simple;
	bh=s92rW/1gEQr3xvJKMRwsWt6P8BZ8Funj1rbavwH4oWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ0uSabeQAkUEZTl9cGOKWrvsWNa4MtYWorNmJeTQ8OwgRrXQuoGhnI9x2mBIGmU2Wox/FXPtrSph0aSH+xWm5Lux61FkYjtJRtFUuArfYd2Lb6aa6Ioh8++nMvKuiSNqHlRMILpr7QKqXYyOlFnlgV3hOX1PDj58I1RkzuAjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I1V7lquB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I1V7lquB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso5078795a12.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725476030; x=1726080830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s92rW/1gEQr3xvJKMRwsWt6P8BZ8Funj1rbavwH4oWQ=;
        b=I1V7lquBIV1tuMbzWo1Rmr78uwgd64Cz90/LN5ociO6ZEW/Wqw8V1kSNDjHwc1SQrl
         gBaI66alz16WK+pvTbrtual3WbJtpGuczxNRYdc1gLcuOrMZ4usss1N5f7NdK8JHnD2p
         F0XUwhgMpxkeLvZRW8Uzgt0KvOaFvkDxTAi68bTiJhkqBH+yK8paVuDHYd72QvNHI6kY
         nwO80rF+Oxe0S7e2FzsxLeUgvXejLVpZZJVNZGqiQ+eQ9RCbCRxo2YOrTrYuADPwYNeo
         UMBDEP1bCuHsTMQKOvPWkizZfCYV9cQhfOEuy7O2CfqqeC+9S4/t4PFaZ6WN6eBloGGM
         W2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476030; x=1726080830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s92rW/1gEQr3xvJKMRwsWt6P8BZ8Funj1rbavwH4oWQ=;
        b=UH1nORMkMB/WwaiefyFiGbzZw6+KJaLSFO2R8dtgF+bnMsmo8BihR+zGuHXleDK6/R
         pYBy2nW+oD1SFftphKRk7aL+DIALdieYHxaGeoTW2iSlsc7k6E/FSixqadkH9EBHcpBj
         C/mN2TVEf8uQ+Du/07FnIA7g3fR2u5dDA0vPrJ95ysmr7v4Sn0Y054PZ1lSDH9/eAY9z
         z6rTD/RPQaUd9iGDMbCVMaqRV3aBfkWn6Gn01Gv7G2NB//2wm2hZdZjQDlBmmuc5yTkv
         e7l8UapRzFX7u1ONgzW7KKGB929i4NNcsEiEjnFRfgFHUIbVSq4BjSkVEKWI07tscZdM
         g14g==
X-Forwarded-Encrypted: i=1; AJvYcCUuB5lqX0hMIMxXsAVhpTEvdIim7S6KWXUHIlwjccxk3JxThfKpw07ffnSo6CNUva+wShbEa3rlDiXG@vger.kernel.org
X-Gm-Message-State: AOJu0YxVE4Zc8jloIZUPLYr/rixkqnfZxxRHtwWBzdFaA4+xGFjItk1Y
	T372MNCK2M0BPtF8vOEhOqF0Hh6OvLWwc+MhcURa+BVNY21G7mONj6PJndz2rYA=
X-Google-Smtp-Source: AGHT+IE2IsoC0LRmiLcI1CkvV1DU3vw4DUJdyqp6MID1n1cX+56uyYB7jBo1wGGq/wkl04oTY4Plng==
X-Received: by 2002:a05:6a21:318b:b0:1ce:cbcf:aaa9 with SMTP id adf61e73a8af0-1cecdfdea62mr20770394637.36.1725476029832;
        Wed, 04 Sep 2024 11:53:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778522979sm1947597b3a.30.2024.09.04.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:53:49 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:53:45 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm: Pass vm_flags to generic_get_unmapped_area()
Message-ID: <ZtisuRySfREHjnN/@debug.ba.rivosinc.com>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-2-9acda38b3dd3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-2-9acda38b3dd3@kernel.org>

On Mon, Sep 02, 2024 at 08:08:14PM +0100, Mark Brown wrote:
>In preparation for using vm_flags to ensure guard pages for shadow stacks
>supply them as an argument to generic_get_unmapped_area(). The only user
>outside of the core code is the PowerPC book3s64 implementation which is
>trivially wrapping the generic implementation in the radix_enabled() case.
>
>Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

