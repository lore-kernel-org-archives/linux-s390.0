Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:36857 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732219AbfKFTCJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 14:02:09 -0500
Message-ID: <7b6295e48dbb4b5b9c578516f40b61ad2afd115b.camel@perches.com>
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
From: Joe Perches <joe@perches.com>
Date: Wed, 06 Nov 2019 11:01:53 -0800
In-Reply-To: <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
         <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
         <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
         <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
         <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Christian =?ISO-8859-1?Q?Borntr=E4ger?= <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, 2019-11-06 at 19:55 +0100, Markus Elfring wrote:
> > There is no bug here.
> 
> Do you find duplicated source code questionable?

No.  It is something that can be improved through
code consolidation though.

> Is this also an error item?

Definitely not.  It is _only_ an error if there is
some logic defect.  There is no logic defect here.
