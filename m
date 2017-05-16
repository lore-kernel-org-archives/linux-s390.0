Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 May 2017 06:19:28 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 28/36] docs-rst: convert s390-drivers DocBook to ReST
Message-ID: <20170516061928.14158635@vento.lan>
In-Reply-To: <20170515100940.66de866c.cornelia.huck@de.ibm.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
        <bbff6b86ef7a1602870bbce87443bc1a345a83fd.1494596071.git.mchehab@s-opensource.com>
        <20170515100940.66de866c.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jani Nikula <jani.nikula@intel.com>, Markus Heiser <markus.heiser@darmarit.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.de>, "Herton R. Krzesinski" <herton@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Mon, 15 May 2017 10:09:40 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> escreveu:

> On Fri, 12 May 2017 11:00:11 -0300
> Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
> 
> > Use pandoc to convert documentation to ReST by calling
> > Documentation/sphinx/tmplcvt script.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> >  Documentation/DocBook/Makefile            |   2 +-
> >  Documentation/DocBook/s390-drivers.tmpl   | 161 ------------------------------
> >  Documentation/driver-api/index.rst        |   1 +
> >  Documentation/driver-api/s390-drivers.rst | 111 ++++++++++++++++++++
> >  4 files changed, 113 insertions(+), 162 deletions(-)
> >  delete mode 100644 Documentation/DocBook/s390-drivers.tmpl
> >  create mode 100644 Documentation/driver-api/s390-drivers.rst  
> 
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Thanks!

> 
> ...but I wonder how good the information in there still is, given that
> I haven't touched it in ages...

The text inside it is just a brief description of s390 specifics,
but the real API descriptions are inside those files:

.. kernel-doc:: arch/s390/include/asm/cio.h
.. kernel-doc:: arch/s390/include/asm/ccwdev.h
.. kernel-doc:: drivers/s390/cio/device.c
.. kernel-doc:: drivers/s390/cio/device_ops.c
.. kernel-doc:: arch/s390/include/asm/cmb.h
.. kernel-doc:: drivers/s390/cio/cmf.c
.. kernel-doc:: arch/s390/include/asm/ccwgroup.h
.. kernel-doc:: drivers/s390/cio/ccwgroup.c
.. kernel-doc:: drivers/s390/cio/airq.c

Those 9 files seem to have been updated lately:

$ git log arch/s390/include/asm/cio.h arch/s390/include/asm/ccwdev.h drivers/s390/cio/device.c drivers/s390/cio/device_ops.c arch/s390/include/asm/cmb.h drivers/s390/cio/cmf.c arch/s390/include/asm/ccwgroup.h drivers/s390/cio/ccwgroup.c drivers/s390/cio/airq.c|grep Date
Date:   Fri Mar 17 04:17:42 2017 +0100
Date:   Thu Feb 2 19:15:33 2017 +0100
Date:   Thu Jan 12 18:53:56 2017 +0100
Date:   Sun Oct 30 16:37:24 2016 -0400
Date:   Fri Jul 29 10:43:53 2016 +0200
Date:   Thu Jun 23 11:09:26 2016 +0200
Date:   Tue Jul 12 19:57:57 2016 +0200
Date:   Mon Jun 20 14:03:38 2016 +0200
Date:   Tue May 31 09:09:57 2016 +0200
Date:   Thu Mar 3 20:49:57 2016 -0800
Date:   Fri Dec 18 12:59:36 2015 +0100
Date:   Mon Jun 29 18:39:54 2015 +0200
Date:   Mon Oct 26 12:38:13 2015 +0100
Date:   Mon Oct 26 12:35:06 2015 +0100
Date:   Mon Sep 21 18:40:33 2015 +0200
...

So, I guess that what's there is still valid.

Yet, on a quick grep:

$ git grep -l "/\*\*" drivers/s390/|wc -l
91

So, it seems that only 10% of the kernel-doc markups are actually
documented :-)

Perhaps you could add the missing files there after this patch ;-)


Thanks,
Mauro
