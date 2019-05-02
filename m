Return-Path: <SRS0=aDnU=TC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Thu, 2 May 2019 16:15:42 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux 5.1-rc5
Message-ID: <20190502231542.GA9336@infradead.org>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, sparclinux@vger.kernel.org, Hillf Danton <dhillf@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, linuxppc-dev@lists.ozlabs.org, Stas Sergeev <stsp@list.ru>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> largely irrelevant, partly since even theoretically this whole issue
> needs a _lot_ of memory.

Adding the relevant people - while the might be irrelevant, at least
mips and sparc have some giant memory systems.  And I'd really like
to see the arch-specific GUP implementations to go away for other
reasons, as we have a few issues to sort out with GUP usage now
(we just had discussions at LSF/MM), and the less implementations we
have to deal with the better.
