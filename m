Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388847AbfHBGqP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 02:46:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x726bPdG141807
        for <linux-s390@vger.kernel.org>; Fri, 2 Aug 2019 02:46:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4cq9pjfd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 02:46:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 2 Aug 2019 07:46:11 +0100
Date: Fri, 2 Aug 2019 08:46:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris>
 <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
Message-Id: <20190802064605.GA4158@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>

On Thu, Aug 01, 2019 at 08:28:56PM +0300, Ard Biesheuvel wrote:
> On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > Still not... with linux-next as of today I get this (s390 defconfig):
> >
> > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
> >
> 
> Hello Heiko,
> 
> Apologies for the breakage. The first two fixes addressed obvious
> shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
> The calls to these missing functions should be optimized away, since
> have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
> defined, but for some reason, this isn't working. Which version of GCC
> are you using?

Plain vanilla gcc 9.1.0.

> Also, could you please try whether the patch below fixes the problem? Thanks
> https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/

Yes, with that patch applied the code compiles.
