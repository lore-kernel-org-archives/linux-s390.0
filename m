Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:57963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfKKImd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 03:42:33 -0500
Subject: Re: [v3] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
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
 <c701adc9-dab2-46af-003f-d8a2c47bc0af@web.de>
 <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <a2dbda2a-1c2f-20f1-6b97-c59dbbcaa7a8@web.de>
Date: Mon, 11 Nov 2019 09:42:18 +0100
MIME-Version: 1.0
In-Reply-To: <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>, Stephen McCamant <smccaman@umn.edu>

> No, I just want to have the word "fix" in the subject.

How do you think about to use the preferred subject in your final commit directly?
(Do you insist on sending a fourth patch variant?)


> If you are OK with changing the sign-off to your web.de address

Does hinder you anything from continuing to use the previous known email address?

Regards,
Markus
