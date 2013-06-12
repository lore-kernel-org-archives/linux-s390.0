Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 12 Jun 2013 12:40:05 -0700
From: Zach Brown <zab@redhat.com>
Subject: Re: [PATCH v3 next/akpm] aio: convert the ioctx list to radix tree
Message-ID: <20130612194005.GC8389@lenny.home.zabbo.net>
References: <1366026055-28604-1-git-send-email-octavian.purdila@intel.com>
 <20130612181440.GC6151@google.com>
 <20130612182430.GE14404@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130612182430.GE14404@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Kent Overstreet <koverstreet@google.com>, Octavian Purdila <octavian.purdila@intel.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

> I've got an alternate approach for fixing this wart in lookup_ioctx()...  
> Instead of using an rbtree, just use the reserved id in the ring buffer 
> header to index an array pointing the ioctx.  It's not finished yet, and 
> it needs to be tidied up, but is most of the way there.

Yeah, that might work.

Note that the patch wasn't using an rbtree, it was storing the pointer
value in a *radix* which is why single lookups took so long.  Presumably
radix was used for RCU lookups.

Your ring->id trick lets us use RCU with small ints instead of the
context pointer.  It might be worth using idr instead of rolling manual
array code.  It'd still be much faster than the list, but get rid of the
large alloc, array walking, memcpy(), etc.

- z
