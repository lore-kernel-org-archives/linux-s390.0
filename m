Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 3 Jul 2011 19:15:39 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/7] pm: improve error code of pm_notifier_call_chain()
Message-ID: <20110703171539.GF21127@elf.ucw.cz>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
 <1309702581-16863-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309702581-16863-2-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, Jiri Kosina <jkosina@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun 2011-07-03 23:16:15, Akinobu Mita wrote:
> This enables pm_notifier_call_chain() to get the actual error code
> in the callback rather than always assume -EINVAL by converting all
> PM notifier calls to return encapsulate error code with
> notifier_from_errno().
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>

Nothing obviously wrong here.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
