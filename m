From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 2/5] s390/alternative: use a copy of the facility bit
 mask
Date: Tue, 23 Jan 2018 15:40:06 +0100
Message-ID: <20180123154006.14fb7ce0@mschwideX1>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
        <1516712825-2917-3-git-send-email-schwidefsky@de.ibm.com>
        <20180123145947.72bb1cd2.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123145947.72bb1cd2.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Jan 2018 14:59:47 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 23 Jan 2018 14:07:02 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > To be able to switch off specific CPU alternatives with kernel parameters
> > make a copy of the facility bit mask provided by STFLE and use the copy
> > for the decision to apply an alternative.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  arch/s390/include/asm/facility.h | 18 ++++++++++++++++++
> >  arch/s390/include/asm/lowcore.h  |  3 ++-
> >  arch/s390/kernel/alternative.c   |  3 ++-
> >  arch/s390/kernel/early.c         |  3 +++
> >  arch/s390/kernel/setup.c         |  4 +++-
> >  arch/s390/kernel/smp.c           |  4 +++-
> >  6 files changed, 31 insertions(+), 4 deletions(-)  
> 
> You have dropped various r-bs (including mine). Has this patch been
> changed? (Doesn't look like it.)
 
Added your and Davids r-b to patch #2, as well as your a-b to patch #4.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
