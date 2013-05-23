From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Thu, 23 May 2013 12:59:43 +0200
Message-ID: <201305231259.43750.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130523100409.GK18614@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?iso-8859-1?q?H=E5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Serge Hallyn <serge.hallyn@canonical.com>, Mike
List-ID: <linux-s390.vger.kernel.org>

On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> So, if you want to use this, then you should update the CONFIG_BUG text
> to include a warning to this effect:
> 
>      Warning: if CONFIG_BUG is turned off, and control flow reaches
>      a BUG(), the system behaviour will be undefined.
> 
> so that people can make an informed choice about this, because at the
> moment:
> 
>           Disabling this option eliminates support for BUG and WARN, reducing
>           the size of your kernel image and potentially quietly ignoring
>           numerous fatal conditions. You should only consider disabling this
>           option for embedded systems with no facilities for reporting errors.
>           Just say Y.
> 
> will become completely misleading.  Turning this option off will not
> result in "quietly ignoring numerous fatal conditions".

I must be missing something, to me the two descriptions mean the same thing.

> And I come back to one of my previous arguments - is it not better to
> panic() if we hit one of these conditions so that the system can try to
> do a panic-reboot rather than continue blindly into the unknown?

I think this all comes from the 'linux-tiny' project that tried to squeeze
out the last bits of kernel object code size at some point. The idea was
that if you have code like

	BUG_ON(something_unexpected_happened());

or

	switch (my_enum) {
	case FOO:
		return f1();
	case BAR:
		return f2();
	default:
		BUG();
	}

You don't just want to avoid the code for printing the bug message and
the invalid instruction, we also want the compiler to not emit the 
function call or check the enum for unexpected values. The meaning of
BUG() is really that person writing that statement was sure it cannot
happen unless there is a bug in the kernel, which has likely already
corrupted data. Printing a diagnostic at this point is nice if someone
is there to look at it, but letting the kernel do further actions that
may be undefined is not going to make things worse.

	Arnd
