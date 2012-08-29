From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Aug 2012 20:19:01 +0000
Subject: Re: personality does not preserve across execve on s390 (31bit) systems
Message-Id: <CAJaTeTpX6xMEiZyQpVLQ5=7Uj4A+uD2OTYFxxfyP3Be0ZStRSA@mail.gmail.com>
In-Reply-To: <20120828080740.GB3375@osiris.de.ibm.com>
References: <20120828080740.GB3375@osiris.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 28, 2012 at 4:07 AM, Heiko Carstens wrote:
> From 6aa377637e3b0280ace1ae86780630105de405a1 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Tue, 28 Aug 2012 10:02:08 +0200
> Subject: [PATCH] s390/32: Don't clobber personality flags on exec
>
> In native 32 bit mode the personality flags were not correctly inherited.
> This is the s390 version of 59e4c3a2 "powerpc/32: Don't clobber personality
> flags on exec".
>
> Reported-by: Mike Frysinger <vapier@gentoo.org>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

thanks, works nicely for me
-mike
