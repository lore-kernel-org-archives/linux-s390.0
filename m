From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/1] [PATCH] include storage keys in
	hibernation image.
Date: Tue, 9 Aug 2011 17:45:24 +0200
Message-ID: <20110809174524.45cd496d__34955.8333204643$1312905323$gmane$org@mschwide>
References: <20110608074523.211912903@de.ibm.com>
	<20110608074648.287491002@de.ibm.com>
	<201107290001.14465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107290001.14465.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
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
