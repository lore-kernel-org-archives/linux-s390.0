Return-Path: <linux-kernel-owner+w=401wt.eu-S1423471AbXDZAkR@vger.kernel.org>
Date: Wed, 25 Apr 2007 20:39:11 -0400
From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-ID: <20070426003911.GA19383@redhat.com>
References: <20070423141123.GA21174@skybase> <20070423104534.51bac974.akpm@linux-foundation.org> <20070425112133.4ae86399.randy.dunlap@oracle.com> <20070425143011.57247c1d.akpm@linux-foundation.org> <20070425172447.1576c399.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070425172447.1576c399.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 25, 2007 at 05:24:47PM -0700, Andrew Morton wrote:

 > It would be neat if someone could create and maintain a new
 > scripts/spot-common-mistakes.  Feed it a unified diff and it would complain
 > about newly-added code (and only newly-added code) which has busted
 > whitespace, adds new semaphores, adds new kernel_thread calls, etc, etc.

years and years ago, when the dinosaurs roamed the land, I hacked up..
http://janitor.kernelnewbies.org/scripts/  and then left it by the wayside.
Some of the checks it did are actually bogus, but I'm happy to pick that
up again if there's interest in it being a useful tool.

In fact, I should probably munge it together with a similar thing
I wrote at http://www.codemonkey.org.uk/projects/findbugs/
(Warning: scary regexps)

 > It would need to be fairly simple and easily-extensible, as I can
 > imagine quite a few things getting added to it.
 > 
 > (Imagines a procmail rule which just bounces the email if
 > spot-common-mistakes failed)

or a git checkin rule that refuses to commit if it fails ;-)

	Dave

-- 
http://www.codemonkey.org.uk
