Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfGaLP3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 07:15:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VBDHro130675
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:15:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u395at82s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:15:28 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 31 Jul 2019 12:15:26 +0100
Date: Wed, 31 Jul 2019 13:15:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731110816.GA20753@gondor.apana.org.au>
Message-Id: <20190731111520.GC3488@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>

On Wed, Jul 31, 2019 at 09:08:17PM +1000, Herbert Xu wrote:
> On Wed, Jul 31, 2019 at 10:58:20AM +0200, Heiko Carstens wrote:
> > On Wed, Jul 31, 2019 at 04:39:15PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20190730:
> > 
> > Hello Ard,
> > 
> > two of your patches in the crypto tree cause build breakage on s390:
> > 
> > The patch ("crypto: aes - create AES library based on the fixed time AES code")
> > causes this:
> 
> Ard already sent a patch for this which I've just pushed out.

Ok, thanks!

However that doesn't fix the simd.h header file breakage with the
second patch :)
