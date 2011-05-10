Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 May 2011 11:00:54 +0200
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH resend] s390: oprofile: fix error checks in
 oprofile_hwsampler_init()
Message-ID: <20110510090054.GS31407@erda.amd.com>
References: <20110502154805.71664123@absol.kitzblitz>
 <20110503085540.GX31407@erda.amd.com>
 <20110510105510.455bbf5d@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110510105510.455bbf5d@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nicolas Kaiser <nikai@nikai.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 10.05.11 04:55:10, Martin Schwidefsky wrote:
> On Tue, 3 May 2011 10:55:40 +0200
> Robert Richter <robert.richter@amd.com> wrote:
> 
> > On 02.05.11 09:48:05, Nicolas Kaiser wrote:
> > > Checking 'oprofile_min_interval < 0' and
> > > 'oprofile_max_interval < 0' doesn't work because
> > > 'oprofile_min_interval' and 'oprofile_max_interval' are unsigned.
> > 
> > max/min_interval are through all the code always unsigned. I don't
> > know how min/max_sampl_rate in struct hws_qsi_info_block is spec'ed,
> > but there it is unsigned too.
> > 
> > So the best would be to return qsi.min/max_sampl_rate in
> > hwsampler_query_min/max_interval() directly with no error codes as
> > unsigned longs and to change the code in oprofile_hwsampler_init() to
> > check for null. Both functions hwsampler_query_min/max_interval()
> > could be moved to hwsampler.h as static inline functions. This makes
> > the code also easier.
> > 
> > This patch does not handle the null value case and the data truncation
> > by casting from unsigned to singed is not fixed.
> 
> Ok, the improved patch now looks like this:
> --
> Subject: [PATCH] s390: oprofile: fix min/max interval query checks
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> oprofile_min_interval and oprofile_max_interval are unsigned, checking
> for negative values doesn't work. Change hwsampler_query_min_interval
> and hwsampler_query_max_interval to return an unsigned long and
> check for a zero value instead.
> 
> Reported-by: Nicolas Kaiser <nikai@nikai.net>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Looks good.

Acked-by: Robert Richter <robert.richter@amd.com>

Martin, can you queue this up?

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
