Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Jul 2011 10:29:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/1] [PATCH] include storage keys in hibernation image.
Message-ID: <20110708102911.3c4d83b6@mschwide>
In-Reply-To: <201107072336.26151.rjw@sisk.pl>
References: <20110608074523.211912903@de.ibm.com>
	<201106142250.15041.rjw@sisk.pl>
	<20110615093629.07f01779@mschwide>
	<201107072336.26151.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Jiri Slaby <jslaby@suse.cz>, Len Brown <lenb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 7 Jul 2011 23:36:25 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday, June 15, 2011, Martin Schwidefsky wrote:
> > On Tue, 14 Jun 2011 22:50:14 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> ...
> > 
> > Well before the preallocation kicked in we don't know which are the relevant
> > storage keys. The only other option would be to store all of them which I
> > consider to be a inferior solution. 
> 
> I've been thinking about that recently a bit.
> 
> Don't we need to restore the keys of the page frames that aren't copied
> into the image too?

Pages that are free (= not part of the image) will get a zero storage key
once they are allocated again. So no, we do not need to include these
keys into the hibernation image.


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
