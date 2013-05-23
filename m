From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
Date: Thu, 23 May 2013 12:24:01 +0100
Message-ID: <20130523112401.GO18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <201305231259.43750.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201305231259.43750.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, Ser
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 23, 2013 at 12:59:43PM +0200, Arnd Bergmann wrote:
> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> > So, if you want to use this, then you should update the CONFIG_BUG text
> > to include a warning to this effect:
> > 
> >      Warning: if CONFIG_BUG is turned off, and control flow reaches
> >      a BUG(), the system behaviour will be undefined.
> > 
> > so that people can make an informed choice about this, because at the
> > moment:
> > 
> >           Disabling this option eliminates support for BUG and WARN, reducing
> >           the size of your kernel image and potentially quietly ignoring
> >           numerous fatal conditions. You should only consider disabling this
> >           option for embedded systems with no facilities for reporting errors.
> >           Just say Y.
> > 
> > will become completely misleading.  Turning this option off will not
> > result in "quietly ignoring numerous fatal conditions".
> 
> I must be missing something, to me the two descriptions mean the same thing.

To me, the current text suggests that we still detect the fatal condition
but the code continues to execute in a manner controlled by the program.

The latter is uncontrolled code (or data) execution in ways unspecified
by the program.

> You don't just want to avoid the code for printing the bug message and
> the invalid instruction, we also want the compiler to not emit the 
> function call or check the enum for unexpected values. The meaning of
> BUG() is really that person writing that statement was sure it cannot
> happen unless there is a bug in the kernel, which has likely already
> corrupted data. Printing a diagnostic at this point is nice if someone
> is there to look at it, but letting the kernel do further actions that
> may be undefined is not going to make things worse.

I'm not talking about printing a diagnostic.  I'm talking about the CPU
remaining under the control of the program it is running - that being
the Linux kernel.

With CONFIG_BUG unset, turning on things like reboot-on-panic and such
like is worthless.  Arguably even is having a hardware watchdog - because
even if you hit one of these BUG() conditions where the CPU goes off and
does its own thing, it might be sufficient that the system is still able
to take care of the watchdog.

This is the problem you guys are missing - unreachable() means "we lose
control of the CPU at this point".

If you have an embedded system and you've taken out all the printk()
stuff, you most certainly want the system to do _something_ if you hit
an unexpected condition.
