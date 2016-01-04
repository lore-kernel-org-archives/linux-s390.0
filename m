Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 23:07:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
Message-ID: <20160104230528-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-4-git-send-email-mst@redhat.com>
 <1451926073.4334.90.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451926073.4334.90.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104210713.psoWkdCmlS4MeUt1fyqjyBr_LFcXvzXIaT3XUGFNNoA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > Add virt_ barriers to list of barriers to check for
> > presence of a comment.
> 
> Are these virt_ barriers used anywhere?
> 
> I see some virtio_ barrier like uses.

They will be :) They are added and used by patchset
	        arch: barrier cleanup + barriers for virt

See
http://article.gmane.org/gmane.linux.kernel.virtualization/26555


-- 
MST
