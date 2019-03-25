Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com> <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com> <20190325175150.GA21008@ziepe.ca>
 <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Mar 2019 15:36:28 -0700
Message-ID: <CAPcyv4hG8WDhsWinXHYkReHKS6gdQ3gAHMcfVWvuP4c4SYBzXQ@mail.gmail.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 25, 2019 at 3:22 PM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
> FWIW this thread is making me think my original patch which simply implemented
> get_user_pages_fast_longterm() would be more clear.  There is some evidence
> that the GUP API was trending that way (see get_user_pages_remote).  That seems
> wrong but I don't know how to ensure users don't specify the wrong flag.

What about just making the existing get_user_pages_longterm() have a
fast path option?
