Return-Path: <linux-kernel-owner+w=401wt.eu-S1761451AbXEWIym@vger.kernel.org>
Subject: Re: 2.6.22-rc1-mm1 - s390 vs. md
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070523104639.6bc0650e@gondolin.boeblingen.de.ibm.com>
References: <0C7297FA1D2D244A9C7F6959C0BF1E5201E39968@azsmsx413.amr.corp.intel.com>
	 <1179907539.17849.16.camel@localhost>
	 <20070523104639.6bc0650e@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Wed, 23 May 2007 10:55:03 +0200
Message-Id: <1179910503.17849.19.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-05-23 at 10:46 +0200, Cornelia Huck wrote:
> Taking a quick look at the async_*.c stuff, the functions in question
> basically seem to be of the form
> 
> check_if_we_can_do_it_async();
> if (async_ok) {
>         /* do async stuff */
>         /* that's where the dma mapping creeps in */
> } else {
>         /* do it sync */
>         /* seems fine for us */
> }

Hmm, on what does the async_ok depend? Is that a runtime check that is
done once or is it something more complicated like the availability of a
dma slot? If it is a simple runtime check then there should be a
operations structure that has indirect function pointers for the
different async_memset_{sync,async}() functions. Instead of doing the
async_ok check just call the function. That would save an if as well.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
