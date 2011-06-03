MIME-Version: 1.0
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Date: Fri, 3 Jun 2011 15:52:09 -0700
Message-ID: <BANLkTik4qRe--C6L5WU3XvpP-TMEZ6RQ-w@mail.gmail.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch ptrace.h
From: Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, richard@nod.at, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 3, 2011 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> The other major change is that on some arches, like ia64, we change
> regs_return_value() to give us the negative value on syscall failure. =A0=
The
> only other user of this macro, kretprobe_example.c, won't notice and it m=
akes
> the value signed consistently for the audit functions across all archs.

v2 builds and boots on ia64 now
Acked-by: Tony Luck <tony.luck@intel.com>


> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

  ^^^^^^^^^^^^^^^^^^^^  :-)

-Tony
