From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC v2 4/7] asm/sections: add a generic push_section_tbl()
Date: Fri, 26 Feb 2016 15:56:04 +0100
Message-ID: <20160226145603.GA3964@osiris>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-5-git-send-email-mcgrof@kernel.org>
 <56C77A8B.7080800@zytor.com>
 <20160219210609.GU25240@wotan.suse.de>
 <56CA7889.60000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CA7889.60000@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 21, 2016 at 06:55:05PM -0800, H. Peter Anvin wrote:
> On 02/19/16 13:06, Luis R. Rodriguez wrote:
> >>
> >> I think the \n\t is unnecessary.
> > 
> > Super! I wonder if we we can just use this on s390 as well without it pooping?
> > I ask as this would set a precedent.
> > 
> 
> Ask Heike, but I think just ; or \n ought be be fine.  I do not know of
> *any* case where \t at the end of a string would ever be necessary, and
> it would *always* be possible to replace it with a space in a pinch.

\n should be fine on s390.
