Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] bitmap: Fix optimization of bitmap_set/clear for big-endian machines
In-Reply-To: <20171025121102.GA15531@bombadil.infradead.org>
References: <20171025121102.GA15531@bombadil.infradead.org>
Date: Fri, 03 Nov 2017 13:57:09 +1100
Message-ID: <87d1506pdm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Paul Mackerras <paulus@ozlabs.org>, Matthew Wilcox <mawilcox@microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> (I don't think I can reliably send patches from outlook; sorry for
> breaking the threading)
>
> I see where we're not incrementing the failure count ... try this patch!
>
> --- 8< ---
>
> Subject: Fix bitmap optimisation tests to report errors correctly
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> I had neglected to increment the error counter when the tests failed,
> which made the tests noisy when they fail, but not actually return an
> error code.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@kernel.org

Thanks, that works for me.

  test_bitmap: failed 31840 out of 460506 tests

cheers
