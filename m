Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5801A7AE4
	for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868801; cv=none; b=VKUqRrRvzFzEz5kTCRXrBKUbzpII66x10+FCr2NvauZs3MuZnGWMsWVRmhn0ThVbLkxnRE/cnZBaGMrxYEjCfLaInVCzMu0LkpmRq5tl1beOql/gMFaYbZaKQSP2w7TMAXJeh0/q6/kT6pZEF8YLKbQFkC5I0qpC5jR+fiu9w3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868801; c=relaxed/simple;
	bh=GjNoHkVtc76GrU4YhTR/L/zP4IfI5x+2GTndy1pzi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSExNlKB286NV/P1PjezE0DSOZSNjCclUg1JIzgNb3JCnTzqyXXlM8ktq0GLy95QNwFA/pSvQcaNhaNogt3ZgTJj88ViBmwh/8qrzM7aruHUE3wgTs+LktQOVTufi7IRCF4Tj6f8BzVDnu1kgjtMoKPb7+HfU9J7/NJFu9wNHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hko6XWNR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hko6XWNR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2020b730049so56023905ad.3
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2024 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724868797; x=1725473597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LALoI8v52A4/X4uxJhIa0heHcwoa9eC5vLoHkCEA7Ac=;
        b=hko6XWNR1U9Va28J0QMAOLkvAdlT1yDDHgL2BGKkWhWQdGg6U5W+GJWE5nwFemlnxq
         RkE8tiPBBsyjjAWV4QTeEItLURhcOw/5Z/xMYVylknRN1kLLP7O1Yb0bMk4Xf2nB1Hcc
         ZIziH5SRnO3cE4x9WiBpMDY85aVJ1P1hmU2LmW4fLvtYzWB26mk4F7CavlIXsJ0SPrTY
         uUl6Lq7TDeCLzmj1OB2lR+lUd8kma0+ctGLst4GzUQIbb4gTvJhdRvZ9xsaYZmxrsanM
         ABDvyZGH/ElJIfdmiXYh9XTfkVZCn6AWYqcmiHeqDysq+BIfMg85TvymAkIQPO/iQ51B
         gnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868797; x=1725473597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LALoI8v52A4/X4uxJhIa0heHcwoa9eC5vLoHkCEA7Ac=;
        b=K6+opa55LaZquu9AuZWTrIVjMXnhdZDc3ljSV+NETlcyB12hYnXLL/JfbcWnysA6jb
         TZZhNVoEn8zd89SFkQivqsZGbddIbm0/J0MLDyHwAT0pkQqc26imDDyQ2Gopf1ZQyvSz
         7k7dyXRpE42BfjmHG1IgZv8yyX8VQWzhLjOHZ4H23yK4PXSkmkGvKDzpinigWcuhQXlb
         HQaRniMgx5S93wRYVks3Z8ZyeVlY2QKUKjePhKghUzXZ65f/d3Eq3Av6rJv/lXLq1n/R
         K30RWnva/7+TPAxY3LMy0EkKmdsi3YAqPa0uIcDYtYZzhtYmwiLF3cNuED5sdURw8+xX
         +0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWdN1yjI3YZilqIl5O6Ow6WkAUVY5gIAK+OjA4K2kYMHCNkOw8VatDkk1g3FvL1tjK9/EBVkwt0mfOA@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBZO37Q9kofaAcKW7UjaRVOuiTHayB0VTiW+dxKtZstI6ljfI
	koQQYdiaK8Z5EoaKWSpg/l29bZXxq23vv7X5xz+X16ni3BgUK84jC2tR579hgTA=
X-Google-Smtp-Source: AGHT+IGuZvjR8n1DEJgaREJ89Ekx33Df2TcjSjzsxg5aNNIN6dSl+M4/n8ZHA/SWHFgBiHe+4H0WZQ==
X-Received: by 2002:a17:902:f78c:b0:1fd:9269:72c6 with SMTP id d9443c01a7336-2050c4a5b8fmr3765425ad.62.1724868797179;
        Wed, 28 Aug 2024 11:13:17 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df88esm101966005ad.152.2024.08.28.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:13:16 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:13:11 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
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
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 16/16] selftests/mm: Create MAP_BELOW_HINT test
Message-ID: <Zs9oty09IysKUHCF@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <20240827-patches-below_hint_mmap-v1-16-46ff2eb9022d@rivosinc.com>
 <71528354-4884-41e4-a4a9-318e26187f86@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71528354-4884-41e4-a4a9-318e26187f86@lucifer.local>

On Wed, Aug 28, 2024 at 06:48:33PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 27, 2024 at 10:49:22PM GMT, Charlie Jenkins wrote:
> > Add a selftest for MAP_BELOW_HINT that maps until it runs out of space
> > below the hint address.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/testing/selftests/mm/Makefile         |  1 +
> >  tools/testing/selftests/mm/map_below_hint.c | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > index cfad627e8d94..4e2de85267b5 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -50,6 +50,7 @@ TEST_GEN_FILES += hugepage-shm
> >  TEST_GEN_FILES += hugepage-vmemmap
> >  TEST_GEN_FILES += khugepaged
> >  TEST_GEN_FILES += madv_populate
> > +TEST_GEN_FILES += map_below_hint
> >  TEST_GEN_FILES += map_fixed_noreplace
> >  TEST_GEN_FILES += map_hugetlb
> >  TEST_GEN_FILES += map_populate
> > diff --git a/tools/testing/selftests/mm/map_below_hint.c b/tools/testing/selftests/mm/map_below_hint.c
> > new file mode 100644
> > index 000000000000..305274c5af49
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/map_below_hint.c
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test the MAP_BELOW_HINT mmap flag.
> > + */
> > +#include <sys/mman.h>
> > +#include "../kselftest.h"
> > +
> > +#define ADDR 0x1000000UL
> > +#define LENGTH (ADDR / 100)
> > +
> > +#define MAP_BELOW_HINT	  0x8000000	/* Not defined in all libc */
> > +
> > +/*
> > + * Map memory with MAP_BELOW_HINT until no memory left. Ensure that all returned
> > + * addresses are below the hint.
> > + */
> > +int main(int argc, char **argv)
> > +{
> > +	void *addr;
> > +
> > +	do {
> > +		addr = mmap((void *)ADDR, LENGTH, MAP_ANONYMOUS, MAP_BELOW_HINT, -1, 0);
> 
> How can this be correct? mmap() has parameters:
> 
>        void *mmap(void addr[.length], size_t length, int prot, int flags,
>                   int fd, off_t offset);
> 
> You'r setting prot = MAP_ANONYMOUS, flags = MAP_BELOW_HINT...
> 
> This surely should be:
> 
> mmap(..., PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE | MAP_BELOW_HINT, -1, 0);
> 
> > +	} while (addr == MAP_FAILED && (unsigned long)addr <= ADDR);
> 
> How can addr == MAP_FAILED (i.e. ~0) and addr <= ADDR? This will just loop
> through once...
> 
> If you want to make sure you're getting mappings only below the hint until
> you start getting MAP_FAILED's you'll need to handle this more robustly.
> 
> > +
> > +	if (addr != MAP_FAILED && (unsigned long)addr > ADDR)
> > +		ksft_exit_fail_msg("mmap returned address above hint with MAP_BELOW_HINT\n");
> 
> This is just going to fail because your flags are wrong then wrongly claim
> to have passed...

I obviously didn't spend enough time thinking about this test case...
You are correct that I wrote this incorrectly. I will make a proper test case
and send out a new version.

- Charlie

> 
> > +
> > +	ksft_test_result_pass("MAP_BELOW_HINT works\n");
> > +}
> >
> > --
> > 2.45.0
> >
