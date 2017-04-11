From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [GIT PULL 5/9] KVM: s390: gs support for kvm guests
Date: Tue, 11 Apr 2017 21:23:47 +0200
Message-ID: <20170411192346.GA32380@potion>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
 <1491562082-6392-6-git-send-email-borntraeger@de.ibm.com>
 <70b26028-8076-c7ff-be17-b99946a20642@redhat.com>
 <dca21aab-9696-79ab-8e5f-62c03afffa76@de.ibm.com>
 <e2a724be-790d-ea9f-69a0-72b5782740a2@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2a724be-790d-ea9f-69a0-72b5782740a2@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Fan Zhang <zhangfan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2017-04-11 14:42+0200, Christian Borntraeger:
> On 04/07/2017 02:01 PM, Christian Borntraeger wrote:
> > 
> > Indeed this looks like a bug (and the right fix).
> > 
> > This was not noticed during test since KVM enables the host management of
> > registers and we do not use the sdnx. So for the KVM under KVM case this
> > does not matter. Still, we should fix it.
> > 
> > Radim, Paolo, do you want a respin of the whole series or can I simply send
> > a fixup patch with the next round of patches?
> 
> Radim, Paolo,
> 
> is it ok to schedule the fixup patch for the next round of patches(I plan to
> have some more for 4.12 anyway) and apply this series as is?

I have not noticed the bottom hunk on Friday and waited before asking,
sorry.  Pulled now, the new capability numbers are

  #define KVM_CAP_S390_GS 140
  #define KVM_CAP_S390_AIS 141

Thanks.
