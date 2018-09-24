From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 10/26] KVM: s390: interfaces to clear CRYCB masks
Date: Mon, 24 Sep 2018 14:01:20 +0200
Message-ID: <20180924140120.398a3293.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-11-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180924130153.766eaec7.cohuck@redhat.com>
        <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 24 Sep 2018 13:50:36 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/24/2018 01:01 PM, Cornelia Huck wrote:
> > On Wed, 12 Sep 2018 15:43:00 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >   
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
> >> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
> >> not get out of sync.  
> > 
> > Hm, that patch description does not quite match what the patch actually
> > does...
> >   
> 
> You mean it is not obvious where the masks get cleared? Well the APCB is
> defined to contain exactly the three masks. As far as I can tell the patch
> description is correct.

No, I was referring to "two new KVM interface[s]". The patch just
introduces a new function that clears the masks (well, maybe you can
call this an "interface"). So

s/two new KVM interface/a function in KVM/

and I'd be happy :) (sorry for being too vague)
