From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Thu, 23 May 2013 03:09:50 -0700
Message-ID: <878v369fdd.fsf@xmission.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201305231139.38233.arnd@arndb.de> (Arnd Bergmann's message of
 "Thu, 23 May 2013 11:39:37 +0200")
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?utf-8?Q?H=C3
List-ID: <linux-s390.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 23 May 2013, Geert Uytterhoeven wrote:
>> > The problem is: trying to fix that will mean the result is a larger
>> > kernel than if you just do the usual arch-implemented thing of placing
>> > an defined faulting instruction at the BUG() site - which defeats the
>> > purpose of turning off CONFIG_BUG.
>> 
>> Is __builtin_unreachable() working well these days?
>> 
>
> Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> Needs a little more investigation, but that might actually be the correct
> solution. I thought that at some point __builtin_unreachable() was the same
> as "do {} while (1)", but this is not the case with the gcc I was using --
> it just tells gcc that we don't expect to ever get here.

Yes.

We already have this abstracted in compiler.h as the macro unreachable,
so the slight modification of your patch below should handle this case.

For compilers without __builtin_unreachable() unreachable() expands to
do {} while(1) but an infinite loop seems reasonable and preserves the
semantics of the code, unlike the current noop that is do {} while(0).

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..9afff7d 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -108,11 +108,11 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() unreachable ()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) unreachable(); } while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
