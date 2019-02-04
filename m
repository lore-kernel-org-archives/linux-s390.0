Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 4 Feb 2019 11:01:40 +0100 (CET)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com> <alpine.LFD.2.21.1901301912380.2372@schleppi> <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1902041056190.1862@schleppi.aag-de.ibmmobiledemo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Jan 2019, Tony Krowiak wrote:
> On 1/30/19 1:32 PM, Sebastian Ott wrote:
> > On Wed, 30 Jan 2019, Tony Krowiak wrote:
> >> +++ b/drivers/s390/cio/chsc.h
> >> @@ -9,6 +9,7 @@
> >>   #include <asm/chsc.h>
> >>   #include <asm/schid.h>
> >>   #include <asm/qdio.h>
> >> +#include <asm/ap.h>
> > 
> > This should be moved to chsc.c
> 
> I can do that, but I'm curious why.

You only need to include ap.h because of the ap_bus_cfg_chg definition and
you only use that in chsc.c . Other users of chsc.h don't call that
function.

Regards,
Sebastian
