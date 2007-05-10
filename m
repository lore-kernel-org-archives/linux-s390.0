Return-Path: <linux-kernel-owner+w=401wt.eu-S1759476AbXEJHZ2@vger.kernel.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070509093547.55ca7f8c.akpm@linux-foundation.org>
References: <20070423141123.GA21174@skybase>
	 <20070423104534.51bac974.akpm@linux-foundation.org>
	 <1178709710.30649.37.camel@localhost>
	 <20070509093547.55ca7f8c.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 10 May 2007 09:25:41 +0200
Message-Id: <1178781941.24359.7.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-05-09 at 09:35 -0700, Andrew Morton wrote:
> > So when will be a good time to add the Kconfig patches to git390?
> 
> Go wild.
> 
> > And do you prefer to let them rot^H^H^Hmature in -mm for a while before
> > they can go upstream?
> 
> Your call.  I'd be inclined to push them early personally - Kconfig
> problems tend to be easy to spot and easy to fix and there's ample time to
> fine tune it.

Ok, that is my feeling as well. The patches won't get better by waiting.
I will add them to the for-linus/for-andrew branches and include them in
the next please-pull for Linus. Be prepared for some breakage in -mm..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
