From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 3/7] dump_stack: consolidate dump_stack() implementations
 and unify their behaviors
Date: Fri, 12 Apr 2013 16:39:01 -0400
Message-ID: <516870E5.3050901@tilera.com>
References: <1365016497-32033-1-git-send-email-tj@kernel.org> <1365016497-32033-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1365016497-32033-4-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org, Fengguang Wu <fengguang.wu@intel.com>
List-ID: <linux-s390.vger.kernel.org>

On 4/3/2013 3:14 PM, Tejun Heo wrote:
> This patch expands the dummy fallback dump_stack() implementation in
> lib/dump_stack.c such that it prints out debug information (taken from
> x86) and invokes show_stack(NULL, NULL) and drops arch-specific
> dump_stack() implementations in all archs except blackfin.  Blackfin's
> dump_stack() does something wonky that I don't understand.

arch/tile has a dump_stack() entry point in assembly (see arch/tile/kernel/entry.S) that passes to _dump_stack(), which passes to dump_stack_regs(), which passes to tile_show_stack().  Similarly, show_stack() passes to tile_show_stack(), which does lots of work to cross into userspace and continue showing the stack if possible, print symbol info for both kernel and userspace, etc.  I don't know if that's all supported fully in Tejun's generic version.

Would it make sense for me to look at this after it's merged up into -next and see what tile needs?  Unfortunately I'm taking off for a week's vacation so won't be able to do much until after the 23rd.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
