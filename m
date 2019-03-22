Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-3-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-3-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@gmail.com>
Date: Fri, 22 Mar 2019 14:30:35 -0700
Message-ID: <CAA9_cmcs+kUMA=j2UYwSRpEo+NMktTv5Od73fS-E9wxVr_v43g@mail.gmail.com>
Subject: Re: [RESEND 2/7] mm/gup: Change write parameter to flags in fast walk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: ira.weiny@intel.com
Cc: Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> In order to support more options in the GUP fast walk, change
> the write parameter to flags throughout the call stack.
>
> This patch does not change functionality and passes FOLL_WRITE
> where write was previously used.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
