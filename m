From: Bruno Haible <bruno@clisp.org>
Date: Tue, 15 Mar 2011 21:23:17 +0000
Subject: Re: [bug-libsigsegv] Re: sigsegv on s390 only giving start address of page in segv handler
Message-Id: <201103152223.19033.bruno@clisp.org>
In-Reply-To: <4D7FD266.8050108@redhat.com>
References: <4D7FD266.8050108@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger wrote:
> Can you give some insights about the other use cases? Userspace page faults can
> be handled just fine with the page address (I have done that for the s390x
> port of valgrind). Would a "works most of the time but might return the page
> address in 10% of the cases" be ok for your other use cases?

For most applications, that would work, yes. In GNU clisp, the fault handler
needs some changes, because it assumed to be able to detect the region
within the page based on the address, and had some related assertions. But
in the end, the mprotect() call emitted by the fault handler depends only on
the page and not on the address within the page.

Bruno
-- 
In memoriam Diego de Enzinas <http://en.wikipedia.org/wiki/Diego_de_Enzinas>
