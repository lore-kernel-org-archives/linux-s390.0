Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728800AbfHAM3C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 08:29:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71CSt5t084616
        for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2019 08:29:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3yseh3xq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 08:29:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 1 Aug 2019 13:28:56 +0100
Date: Thu, 1 Aug 2019 14:28:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731114453.GD3488@osiris>
Message-Id: <20190801122849.GB4163@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Stephen Rothwell <sfr@canb.auug.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>

On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote:
> On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote:
> > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
> > >
> > > However that doesn't fix the simd.h header file breakage with the
> > > second patch :)
> > 
> > That fix should be there now too.
> 
> Yes, works now. Thank you!

Still not... with linux-next as of today I get this (s390 defconfig):

ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
