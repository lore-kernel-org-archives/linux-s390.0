Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Mar 2015 10:29:28 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] livepatch: add support on s390
In-Reply-To: <20150327091900.GA4379@osiris>
Message-ID: <alpine.LNX.2.00.1503271020470.6781@pobox.suse.cz>
References: <1427361017-23354-1-git-send-email-jslaby@suse.cz> <alpine.LNX.2.00.1503261924430.6781@pobox.suse.cz> <20150327091900.GA4379@osiris>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, jpoimboe@redhat.com, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 27 Mar 2015, Heiko Carstens wrote:

> On Thu, Mar 26, 2015 at 07:24:58PM +0100, Jiri Kosina wrote:
> > On Thu, 26 Mar 2015, Jiri Slaby wrote:
> > 
> > > This is a trivial port from kGraft. Module relocations are not
> > > supported.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > ---
> > > [v2] return ENOSYS
> > > [v3] proper return value from klp_check_compiler_support
> > 
> > Applied to for-4.1/core.
> 
> Hello Jiri,
> 
> while I do appreciate your work on the s390 architecture backend for
> livepatching:  this should go upstream only via the s390 tree or with
> an Ack from Martin or me.

Fair enough; I merged it because I was convinced that we have your Ack for 
the very same patch in our tree for kGraft, but now that I look again, we 
apparently don't. So sorry for that. What is your standpoint on this one 
then, please?

> That being said, what is the reason why module relocations are not
> supported?

That's an addon feature that can be added gradually, it's not crucial for 
basic functionality. Basically: someone has to write the code, but it's 
useful even without it.

> As far as I can tell right now there is only one simple in-kernel test 
> case available (which is fine). However is the tool chain to generate 
> additional livepatch modules, available somewhere? If so, where?

For the current feature set of livepatching as-is upstream, no tooling is 
really hard requirement and the patches are to be written by hand (exactly 
as the one in the samples/ directory).

Thanks,

-- 
Jiri Kosina
SUSE Labs
