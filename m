From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
Date: Tue, 28 May 2013 10:19:10 +0200
Message-ID: <20130528081910.GA29557@gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, H?vard Skinnemoen <hskinnemoen@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


* Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

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
> will become completely misleading.  Turning this option off will _not_ 
> result in "quietly ignoring numerous fatal conditions".

I'm fine with adding your text as a clarification - but I think 'quietly 
ignoring fatal conditions' very much implies an undefined outcome if that 
unexpected condition does occur: the code might crash, it might corrupt 
memory or it might do some other unexpected thing.

There are many other places that do a BUG_ON() of a NULL pointer or so, or 
of a zero refcount, or a not held lock - and turning the BUG_ON() off 
makes the code unpredictable _anyway_ - even if the compiler does not 
notice an uninitialized variable.

So pretty much any weakening of BUG_ON() _will_ make the kernel more 
unpredictable.

> And I come back to one of my previous arguments - is it not better to 
> panic() if we hit one of these conditions so that the system can try to 
> do a panic-reboot rather than continue blindly into the unknown?

It will often continue blindly into the unknown even if the compiler is 
happy ...

The only difference is that it's "unpredictable" in a way not visible from 
the C code: the code won't necessarily fall through the BUG() when hitting 
that condition - although in practice it probably will.

So I think the same principle applies to it as to any other debugging 
code: it's fine to be able to turn debugging off. It's a performance 
versus kernel robustness/determinism trade-off.

Thanks,

	Ingo
