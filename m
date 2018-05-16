From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 02/13] KVM: s390: refactor crypto initialization
Date: Wed, 16 May 2018 14:21:13 +0200
Message-ID: <20180516142113.3d23d356.cohuck@redhat.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-3-git-send-email-akrowiak@linux.vnet.ibm.com>
        <67656726-4d9b-44e1-1e2b-ab11de83f513@linux.ibm.com>
        <6835f3b9-c660-fe7c-5583-8706cc1fa732@linux.vnet.ibm.com>
        <40b5c7d2-a855-f11b-3dbd-afdc8fae268d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40b5c7d2-a855-f11b-3dbd-afdc8fae268d@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 May 2018 14:17:52 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 16/05/2018 13:14, Tony Krowiak wrote:
> > On 05/16/2018 04:51 AM, Pierre Morel wrote:  
> >> On 07/05/2018 17:11, Tony Krowiak wrote:  

> >>> @@ -1896,19 +1917,17 @@ static u64 kvm_s390_get_initial_cpuid(void)
> >>>
> >>>   static void kvm_s390_crypto_init(struct kvm *kvm)
> >>>   {
> >>> -    if (!test_kvm_facility(kvm, 76))
> >>> +    /*
> >>> +     * If neither the AP instructions nor the message security assist
> >>> +     * extension 3 (MSAX3) are installed, there is no need to 
> >>> initialize a
> >>> +     * crypto control block (CRYCB) for the guest.
> >>> +     */
> >>> +    if (!kvm_ap_instructions_available() && !test_kvm_facility(kvm, 
> >>> 76))
> >>>           return;
> >>>
> >>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
> >>> -    kvm_s390_set_crycb_format(kvm);  
> >>
> >>
> >> For my point of view the all patch can be reduced to putting this
> >> call (kvm_s390_set_crycb_format(kvm);) before testing for facility 76.
> >>
> >> (and setting the format correctly in kvm_s390_set_crycb_format(kvm))  
> >
> > I don't see what that buys us; it will just be reshuffling of the logic.
> > The idea here is that all of the code related to formatting the CRYCB for
> > use by the guest is contained in the kvm_s390_format_crycb(kvm) function.
> > We don't need a CRYCB, however, if the AP instructions are not installed
> > and the MSAX3 facility is not installed, so why even call
> > kvm_s390_format_crycb(kvm) in that case?  
> 
> It byes a lot of lines.
> I mean that you do exactly the same by only using 3 lines inserted 
> instead of 65 changes.
> No logic change.

Sounds like a winner from my POV :)
