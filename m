Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 May 2011 11:19:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH resend] s390: oprofile: fix error checks in
 oprofile_hwsampler_init()
Message-ID: <20110510111926.788d7336@mschwide>
In-Reply-To: <20110510090054.GS31407@erda.amd.com>
References: <20110502154805.71664123@absol.kitzblitz>
	<20110503085540.GX31407@erda.amd.com>
	<20110510105510.455bbf5d@mschwide>
	<20110510090054.GS31407@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: Nicolas Kaiser <nikai@nikai.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 10 May 2011 11:00:54 +0200
Robert Richter <robert.richter@amd.com> wrote:

> > Ok, the improved patch now looks like this:
> > --
> > Subject: [PATCH] s390: oprofile: fix min/max interval query checks
> > 
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > oprofile_min_interval and oprofile_max_interval are unsigned, checking
> > for negative values doesn't work. Change hwsampler_query_min_interval
> > and hwsampler_query_max_interval to return an unsigned long and
> > check for a zero value instead.
> > 
> > Reported-by: Nicolas Kaiser <nikai@nikai.net>
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Looks good.
> 
> Acked-by: Robert Richter <robert.richter@amd.com>
> 
> Martin, can you queue this up?

Yes, I will do that.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
