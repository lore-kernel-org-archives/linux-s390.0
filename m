From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Tue, 28 May 2013 17:43:52 +0200
Message-ID: <201305281743.52649.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com> <20130528081910.GA29557@gmail.com>
 <51A4C564.4040301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51A4C564.4040301@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@kernel.org>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, H?vard
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 01:19 AM, Ingo Molnar wrote:
> > 
> > So I think the same principle applies to it as to any other debugging 
> > code: it's fine to be able to turn debugging off. It's a performance 
> > versus kernel robustness/determinism trade-off.
> > 
> 
> I suspect, rather, that BUG() should turn into a trap (or jump to a
> death routine) under any circumstances.  The one thing that can be
> omitted for small configurations are the annotations, which only serve
> to output a more human-readable error message.

Right, that is what the patch I just posted does.

On a related note, I found that WARN_ON() can no longer be compiled
out since there is already code that relies on the side-effects of
the condition. I assume that was an intentional change I missed,
since it used to be defined so that you could remove it completely.

	Arnd
