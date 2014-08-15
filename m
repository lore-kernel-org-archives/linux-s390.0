Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 15 Aug 2014 13:57:53 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: add support for DYNAMIC_FTRACE_WITH_REGS
Message-ID: <20140815115753.GA4215@osiris>
References: <20140703120046.GA10664@suse.cz>
 <20140708080740.GA4491@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140708080740.GA4491@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vojtech Pavlik <vojtech@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jslaby@suse.cz>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 08, 2014 at 10:07:40AM +0200, Heiko Carstens wrote:
> On Thu, Jul 03, 2014 at 02:00:46PM +0200, Vojtech Pavlik wrote:
> > Add support for DYNAMIC_FTRACE_WITH_REGS to 64-bit and 31-bit s390
> > architectures. This is required for kGraft and kpatch to work on s390.
> > 
> > It's done by adding a _regs variant of ftrace_caller that preserves
> > registers and puts them on stack in a struct pt_regs layout and
> > allows modification of return address by changing the PSW (instruction
> > pointer) member od struct pt_regs. 
> >
> > Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> > Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> So I assume you use the instruction_pointer() macro to access the
> return address then?
> 
> All of this seems a bit of a hack to me.. the natural place of the
> return address of a function would be register 14, and not the
> psw member of the pt_regs structure.
> 
> It's then also inconsistent to only save register r0-r13 to the
> gprs member.. well, you can't save r14, since what should
> happen if both r14 in the gprs member of pt_regs and in the psw
> part would have been changed?
> 
> Besides that a couple more comments below.

[...]

> Some objections: this code assumes that sizeof(struct pt_regs) does not
> change, which is not correct. So as soon as we touch struct pt_regs this
> code would be broken. Also the order of the members within struct pt_regs
> is not necessarily static (pt_regs is not ABI).

FWIW, this already happened with d3a73acbc26a4a81a01a35fd162973e53d0386f5
"s390: split TIF bits into CIF, PIF and TIF bits".

Anyway, since I didn't got any response from you during the last couple of
weeks, I changed the ftrace code so it should fit your needs.
I will send five patches in reply to this mail - patch 4 of 5 is the one
that implements the DYNAMIC_FTRACE_WITH_REGS functionality, how differently
to your patch, especially possible return address changing.
