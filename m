From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Thu, 23 May 2013 22:59:55 -0700
Message-ID: <877gio3okk.fsf@xmission.com>
References: <519DCBEF.3090208@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <519DCBEF.3090208@asianux.com> (Chen Gang's message of "Thu, 23
 May 2013 15:57:35 +0800")
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, heiko.carstens@de.ibm.com, "paulus@samba.org" <paulus@samba.org>, hpa@zytor.com, walken@google.com, egtvedt@samfundet.no, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, ysato@users.sourceforge.jp, richard@nod.at, deller@gmx.de, x86@kernel.org, jejb@parisc-linux.org, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, paulmck@linux.vnet.ibm.com, hskinnemoen@gmail.com, Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, jdike@addtoit.com, akinobu.mita@gmail.com, user-mode-linux-user@lists.s
List-ID: <linux-s390.vger.kernel.org>

Chen Gang <gang.chen@asianux.com> writes:

> The crazy user can unset 'CONFIG_BUG' in menuconfig: "> General setup >
> Configure standard kernel features (expert users) > BUG() Support".
>
> But in fact, we always need it, and quite a few of architectures have
> already implemented it (e.g. alpha, arc, arm, avr32, blackfin, cris,
> frv, ia64, m68k, mips, mn10300, parisc, powerpc, s390, sh, sparc, x86).
>
> And kernel also already has prepared a default effective implementation
> for the architectures which is unwilling to implement it by themselves
> (e.g. arm64, c6x, h8300, hexagon, m32r, metag, microblaze, openrisc,
> score, tile, um, unicore32, xtensa).
>
> So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.


This looks like the right way to handle this to me.  If the BUG
annotations are too big and not needed they should simply be deleted
from the code base.  Disabling CONFIG_BUG which removes the BUG
annotations from the binaries without modifying the source code seems
like the wrong approach.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
