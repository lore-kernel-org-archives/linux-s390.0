From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/1] [PATCH] include storage keys in
	hibernation image.
Date: Mon, 4 Jul 2011 10:09:29 +0200
Message-ID: <20110704100929.68674ea3__40951.7626198523$1309767121$gmane$org@mschwide>
References: <20110608074523.211912903@de.ibm.com>
	<201106121441.35059.rjw@sisk.pl> <20110614105001.2f991377@mschwide>
	<201106142250.15041.rjw@sisk.pl> <20110615093629.07f01779@mschwide>
	<20110703174616.GB26790@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110703174616.GB26790@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-pm/>
List-Post: <mailto:linux-pm@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 3 Jul 2011 19:46:16 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > I think, however, that we really should try to merge them.  The only
> > > difference seems to be how the additionally allocated pages will be populated
> > > and what's going to happen to their contents during restore.
> > > 
> > > ACPI will simply copy the NVS memory to those pages, while S390 will save
> > > the relevant storage key bits in there.
> > 
> > One complication to keep in mind is that we need to know which storage key
> > goes to which page frame. We need something like the orig_bm/copy_bm or
> > we'd have to store the pfn with the key. Simply storing the key for every
> > page will make the array unnecessarily big.
> 
> How big is the overhead? In percent / in megabytes?

Well, that depends on the ratio of the size of the hibernation image and
the total size of the ram. Consider a 1TB machine with a hibernation image
size of lets say 128 GB. The hibernation image would require 32 MB worth
of storage keys (0.024%), for 1TB the array size would be 256 MB (0.19%).

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
