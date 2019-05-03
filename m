From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
Date: Fri, 3 May 2019 13:39:40 +0100
Message-ID: <20190503123940.GC32046@fuggles.cambridge.arm.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
 <20190413035621.tohihjksatqushwf@treble>
 <20190503063756.09c74f6e@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20190503063756.09c74f6e@lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, Steven Price <steven.price@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Phil Auld <pauld@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.co>
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 03, 2019 at 06:37:56AM -0600, Jonathan Corbet wrote:
> On Fri, 12 Apr 2019 22:56:21 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > Add ARM64 to the legend of architectures.  It's already used in several
> > places in kernel-parameters.txt.
> > 
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> It looks like nobody has picked this up...so I've applied it.

It's queued and tagged in the arm64 tree, which should also be in next!

Will
