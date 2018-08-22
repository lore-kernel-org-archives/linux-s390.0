From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Date: Wed, 22 Aug 2018 09:38:30 +0200
Message-ID: <20180822093830.185998c2.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820180359.38cc4af3.cohuck@redhat.com>
        <a305a39b-1196-ae64-97fd-f970387d82d4@linux.ibm.com>
        <af7d64a8-23fb-7953-57e8-18683a4f334d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af7d64a8-23fb-7953-57e8-18683a4f334d@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 21 Aug 2018 20:54:49 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 08/20/2018 10:16 PM, Tony Krowiak wrote:
> >> Does the SIE complain if you specify a control
> >> domain that the host does not have access to (I'd guess so)?  
> > 
> > The SIE does not complain if you specify a domain to which the host - or a
> > lower level guest - does not have access. The firmware performs a logical
> > AND of the guest's and hosts's - or lower level guest's - APMs, AQMs and ADMs  
> 
> Rather a bit-wise AND, I guess (of the same type masks corresponding to Guest 1 and
> Guest 2). The result of a logical AND is a logical value (true or false) as
> far as I remember.
> 
> > to create effective masks EAPM, EAQM and EADM. Only devices corresponding to
> > the bits set in the EAPM, EAQM and EADM will be accessible by the guest.  
> 
> I'm not sure what is the intended meaning of 'the SIE complains'. If it means
> getting out of (SIE when interpreting lets say an NQAP under the discussed
> circumstances) with some sort of error code, I think Tony's answer, ' SIE does not complain'
> makes a lot of sense. It's the guest that's is trying to stretch further than
> the blanket reaches, and it's the guest that needs to be educated on this fact.

Yep, that's what I meant. If the hypervisor can call the SIE with that
config, but the guest gets an error if it tries to use something that
it cannot use, that's fine.
