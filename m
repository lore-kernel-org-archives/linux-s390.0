From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 11:16:01 +0000
Subject: Re: [CRIU][PATCH 0/3] s390: Enable travis for gcc
Message-Id: <20170718131601.5b5b1f56@TP-holzheu>
In-Reply-To: <20170718022504.GB11035@outlook.office365.com>
References: <20170718022504.GB11035@outlook.office365.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Mon, 17 Jul 2017 19:25:05 -0700
schrieb Andrey Vagin <avagin@virtuozzo.com>:

> Applied, thanks!

Thanks Andrey!

It looks like the s390 emulation is not very stable:

 - https://travis-ci.org/xemul/criu/jobs/254709844

 LINK      pidns01
 LINK      pidns02
make[1]: fork: Interrupted system call
 LINK      pidns03
 LINK      s390x_mmap_high

I think this is a s390 qemu issue and no real build failure.

Let's see how it goes for the next commits ...

Michael
