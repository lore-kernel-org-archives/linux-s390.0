From: Joseph Myers <joseph@codesourcery.com>
Date: Tue, 30 Jun 2015 10:48:49 +0000
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc soft-fp
Message-Id: <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
 <1435634913.24866.1.camel@ellerman.id.au>
In-Reply-To: <1435634913.24866.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 30 Jun 2015, Michael Ellerman wrote:

> Is there some way you can imagine of splitting this up into smaller chunks, so
> that different arches can merge the pieces separately?

Well, it could be split as:

1. Rename include/math-emu to math-emu-old and update architectures for 
the renaming (mechanically).

2. Add new include/math-emu.

3,4,5,6,7. Move each architecture from math-emu-old to math-emu.

8. Remove math-emu-old.

You still have patch 1 affecting all five architectures, but with the 
per-architecture changes being much simpler.

-- 
Joseph S. Myers
joseph@codesourcery.com
