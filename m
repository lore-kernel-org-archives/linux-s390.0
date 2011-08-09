Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Aug 2011 17:45:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/1] [PATCH] include storage keys in hibernation image.
Message-ID: <20110809174524.45cd496d@mschwide>
In-Reply-To: <201107290001.14465.rjw@sisk.pl>
References: <20110608074523.211912903@de.ibm.com>
	<20110608074648.287491002@de.ibm.com>
	<201107290001.14465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jul 2011 00:01:14 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Sorry for the extreme delay.

No big deal, I have been busy with other things anyway.
 
> Having reconsidered things I think the code under the #ifdef above
> should really go to arch/s390.

Ok, that is reasonable.
 
> Now, for the purpose of exporting the headers I'd introduce
> CONFIG_ARCH_SAVE_PAGE_KEYS and make S390 do
> 
> select ARCH_SAVE_PAGE_KEYS if HIBERNATION
> 
> and I'd put a #ifdef depending on that into include/linux/suspend.h.
> 
> Apart from this, I have only one complaint, which is that the kerneldoc
> comments should follow the standard (the other comments in snapshot.c don't,
> but that's a matter for a separate patch).

Sounds good. I will come up with new patches for this and resend them
for review. Might be one or two weeks though, currently conferencing in
Orlando..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
