Date: Wed, 8 Jun 2011 15:04:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
 ptrace.h
Message-ID: <20110608140416.GA19926@linux-mips.org>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, monstr@monstr.eu, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, richard@nod.at, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 03, 2011 at 06:04:51PM -0400, Eric Paris wrote:

Thanks, this looks good & compiles, so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I will rebase my pending MIPS audit patches on top of this patch and resend.

Thanks,

  Ralf
