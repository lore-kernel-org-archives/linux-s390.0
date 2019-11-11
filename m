Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:58685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKJHC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 04:07:02 -0500
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
 <a2dbda2a-1c2f-20f1-6b97-c59dbbcaa7a8@web.de>
 <6de4f605-6f74-a3b6-92d5-c5162cb54a6f@de.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <ae4cb7b4-68e7-f989-be4b-1a9df8ce51ed@web.de>
Date: Mon, 11 Nov 2019 10:06:47 +0100
MIME-Version: 1.0
In-Reply-To: <6de4f605-6f74-a3b6-92d5-c5162cb54a6f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>, Stephen McCamant <smccaman@umn.edu>

>> Does hinder you anything from continuing to use the previous known emai=
l address?
>
> Can you at least send a mail from sourceforge address with the Signed-of=
f-by?

Not any more (for a while).

Message filter systems got difficulties with email redirection services.


> The Sign-off is meant to keep track of flow.

I find the provided tag still fine.

Regards,
Markus
