Return-Path: <owner-linux-mm@kvack.org>
MIME-Version: 1.0
In-Reply-To: <1456329483-4220-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1456329483-4220-1-git-send-email-kirill.shutemov@linux.intel.com>
Date: Wed, 24 Feb 2016 10:49:06 -0800
Message-ID: <CA+55aFyTzjpk-7ThfhpksgSxQV0KQL0jHR3hbpwPntWFJdKh2g@mail.gmail.com>
Subject: Re: [PATCH] thp: call pmdp_invalidate() with correct virtual address
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 24, 2016 at 7:58 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Sebastian Ott and Gerald Schaefer reported random crashes on s390.
> It was bisected to my THP refcounting patchset.
>
> The problem is that pmdp_invalidated() called with wrong virtual
> address. It got offset up by HPAGE_PMD_SIZE by loop over ptes.
>
> The solution is to introduce new variable to be used in loop and don't
> touch 'haddr'.

Thanks, I applied this directly rather than wait for this to go
through Andrew (which would have been "proper channels").

This issue has been worrying me for a while now and was my main core
worry for 4.5. Good to have it resolved, and thanks to everybody who
tested and got involved.

                 Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
