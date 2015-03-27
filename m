Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Mar 2015 10:19:00 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/1] livepatch: add support on s390
Message-ID: <20150327091900.GA4379@osiris>
References: <1427361017-23354-1-git-send-email-jslaby@suse.cz>
 <alpine.LNX.2.00.1503261924430.6781@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503261924430.6781@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jslaby@suse.cz>, jpoimboe@redhat.com, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 26, 2015 at 07:24:58PM +0100, Jiri Kosina wrote:
> On Thu, 26 Mar 2015, Jiri Slaby wrote:
> 
> > This is a trivial port from kGraft. Module relocations are not
> > supported.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > ---
> > [v2] return ENOSYS
> > [v3] proper return value from klp_check_compiler_support
> 
> Applied to for-4.1/core.

Hello Jiri,

while I do appreciate your work on the s390 architecture backend for
livepatching:  this should go upstream only via the s390 tree or with
an Ack from Martin or me.

That being said, what is the reason why module relocations are not
supported?
As far as I can tell right now there is only one simple in-kernel
test case available (which is fine). However is the tool chain to
generate additional livepatch modules, available somewhere?
If so, where?

Thanks,
Heiko
