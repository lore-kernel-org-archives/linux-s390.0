Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:43155 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfKFSzJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 Nov 2019 13:55:09 -0500
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
 <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
Date: Wed, 6 Nov 2019 19:55:00 +0100
MIME-Version: 1.0
In-Reply-To: <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>

> There is no bug here.

Do you find duplicated source code questionable?

Is this also an error item?

Regards,
Markus
