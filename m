Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:45209 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfKMRJs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 12:09:48 -0500
Subject: Re: [v4] s390/pkey: Fix memory leak in error case by using
 memdup_user() rather than open coding
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
 <aca044e8-e4b2-eda8-d724-b08772a44ed9@web.de>
 <0c47ee47-35a0-65ee-4da1-e1745f882947@de.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <52593fb9-cfc4-e444-6657-aff6c622607d@web.de>
Date: Wed, 13 Nov 2019 18:09:27 +0100
MIME-Version: 1.0
In-Reply-To: <0c47ee47-35a0-65ee-4da1-e1745f882947@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>, Stephen McCamant <smccaman@umn.edu>, Harald Freudenberger <freude@linux.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Joe Perches <joe@perches.com>

> applied. [...]

I find it interesting how the commit message was changed once more.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b57e7c852fc58a62e668a83c0fa8d9246131803
("s390/pkey: use memdup_user() to simplify code")

Regards,
Markus
