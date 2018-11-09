Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 9 Nov 2018 14:40:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.20 #2
In-Reply-To: <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
References: <20181109081402.777716d1@mschwideX1>
        <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20181109144042.4546b7ce@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 9 Nov 2018 06:39:07 -0600
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 9, 2018 at 1:14 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > s390 updates for 4.20-rc2  
> 
> Pulled.
> 
> >  - A fix for the pgtable_bytes misaccounting on s390. The patch changes
> >    common code part in regard to page table folding and adds extra
> >    checks to mm_[inc|dec]_nr_[pmds|puds].  
> 
> Ugh. This is somewhat invasive, I worry  that some header include or
> architecture doesn't pick up on the subtle __PAGETABLE_XYZ_FOLDED
> things (if you don't get the includes, the mm_xyz_folded() maros will
> be mis-defined.
> 
> Has this been in linux-next or any other wide testing? The changes
> aren't _new_, but...

Just checked linux-next, the first version that picked up the patches
is 2018-11-19. The one dated 2018-10-19 does not have them.

Bad timing, no wider testing has been done. The bug itself shows up
as a false warning, nothing really breaks. I would understand if you
prefer not to have them in the official tree at this time.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
