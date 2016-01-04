From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Date: Mon, 04 Jan 2016 08:15:14 -0800
Message-ID: <1451924114.4334.85.camel@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	 <1451907395-15978-2-git-send-email-mst@redhat.com>
	 <1451923660.4334.83.camel@perches.com>
	 <20160104161123.GJ19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenpr
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-01-04 at 16:11 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > > +
> > > +		if ($line =~ /\b($all_barriers)\(/) {
> > 
> > It would be better to use /\b$all_barriers\s*\(/
> > as there's no reason for the capture and there
> > could be a space between the function and the
> > open parenthesis.
> 
> I think you mean
> 
> 	/\b(?:$all_barriers)\s*\(/
> 
> as 'all_barriers' will be:
> 
> 	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb
> 
> and putting that into your suggestion results in:
> 
> 	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/
> 
> which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
> applies to smp_rmb.

right, thanks.
