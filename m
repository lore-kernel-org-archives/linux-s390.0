From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] zfcp: drop open coded assignments of
 timer_list.function
Date: Thu, 16 Nov 2017 15:45:51 +0100
Message-ID: <20171116154551.01934c5d@mschwideX1>
References: <20171108141709.79074-1-maier@linux.vnet.ibm.com>
        <20171108141709.79074-4-maier@linux.vnet.ibm.com>
        <cb2bd7ca-f240-285e-a804-90fa6f74b682@linux.vnet.ibm.com>
        <20171116131639.GA3462@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20171116131639.GA3462@osiris>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Remus <jremus@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 16 Nov 2017 14:16:39 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Nov 16, 2017 at 01:38:18PM +0100, Steffen Maier wrote:
> > If this has not been picked/merged yet (it's not in Linus' tree yet),
> > could you please drop it because it's buggy?
> > 
> > This would buy me time to come up with a proper solution,
> > otherwise I would be forced to fix it within 4.15-rc and
> > am not sure I can make it.  
> 
> It's not upstream and not in linux-next, so I guess it is in no tree.
> 
> So to make Kees' life easier the first two patches, including ("s390/scsi:
> Convert timers to use timer_setup()"), will simply go upstream via the s390
> tree together with the other conversion patches.

I have added the two zfcp related patches for the timer_setup conversion
to the s390/linux features branch.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
