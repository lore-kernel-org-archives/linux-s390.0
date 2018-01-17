From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 4/6] s390: add system call to run tasks with modified
 branch prediction
Date: Wed, 17 Jan 2018 12:55:06 +0100
Message-ID: <20180117125506.26f3813c@mschwideX1>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
        <1516182519-10623-5-git-send-email-schwidefsky@de.ibm.com>
        <5bda76be-0fec-8165-20bf-5cd8e51e955a@redhat.com>
        <c80554d9-a7e0-00cf-9f03-b16ce34205c5@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c80554d9-a7e0-00cf-9f03-b16ce34205c5@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 12:14:52 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/17/2018 11:03 AM, Florian Weimer wrote:
> > On 01/17/2018 10:48 AM, Martin Schwidefsky wrote:  
> >>          rc = syscall(__NR_s390_modify_bp);
> >>          if (rc) {
> >>                  perror("s390_modify_bp");
> >>                  exit(EXIT_FAILURE);
> >>          }  
> > 
> > Isn't this traditionally done through personality or prctl?  
> 
> I think we want this per thread (and not per process). So I assume personality
> will not work out. Can a prctl be done per thread?

The prctl interface seems to be usable to set a per-thread control
as well. But there is no architecture specific prctl as far as I
can see. Maybe a common PR_SET_NOBP with an arch function like
arch_set_nobp.

> > 
> > This looks like something other architectures may want as well.  

Yes, that is likely.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
