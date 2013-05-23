From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
Date: Thu, 23 May 2013 16:10:04 +0200
Message-ID: <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
 <201305231409.02359.arnd@arndb.de>
 <20130523125033.GP18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130523125033.GP18614@n2100.arm.linux.org.uk>
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Serge Hallyn <serge.hallyn@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 23, 2013 at 2:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 02:09:02PM +0200, Arnd Bergmann wrote:
>> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
>> > This is the problem you guys are missing - unreachable() means "we lose
>> > control of the CPU at this point".
>>
>> I'm absolutely aware of this. Again, the current behaviour of doing nothing
>> at all isn't very different from undefined behavior when you get when you
>> get to the end of a function returning a pointer without a "return" statement,
>> or when you return from a function that has determined that it is not safe
>> to continue.
>
> Running off the end of a function like that is a different kettle of fish.
> The execution path is still as the compiler intends - what isn't is that
> the data returned is likely to be random trash.
>
> That's _quite_ different from the CPU starting to execute the contents
> of a literal data pool.

I agree it's best to e.g. trap and reboot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
