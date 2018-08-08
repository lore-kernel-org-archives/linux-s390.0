Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 8 Aug 2018 14:44:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
Message-ID: <20180808144414.75369a40.cohuck@redhat.com>
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
References: <20180807125131.3606-1-david@redhat.com>
        <20180807125131.3606-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  7 Aug 2018 14:51:30 +0200
David Hildenbrand <david@redhat.com> wrote:

> VCPU requests and VCPU blocking right now don't take care of the vSIE
> (as it was not necessary until now). But we want to have VCPU requests
> that will also be handled before running the vSIE again.
> 
> So let's simulate a SIE entry when entering the vSIE loop and check
> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
> detect that the SIE (in form of the vSIE execution loop) is running and
> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
> therefore the vSIE interception handler, allowing it to handle VCPU
> requests.
> 
> E.g. if we want to modify the crycb of the VCPU and make sure that any
> masks also get applied to the VSIE crycb shadow (which uses masks from the
> VCPU crycb), we will need a way to hinder the vSIE from running and make
> sure to process the updated crycb before reentering the vSIE again.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>  arch/s390/kvm/kvm-s390.h |  1 +
>  arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
>  3 files changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
