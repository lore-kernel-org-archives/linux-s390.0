From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 3/4] KVM: s390: Fix possible memory leak in SIGP functions
Date: Tue, 25 Mar 2014 15:43:10 +0100
Message-ID: <533195FE.2010300@redhat.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-4-git-send-email-borntraeger@de.ibm.com> <53318C82.80600@redhat.com> <5331952D.4030408@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5331952D.4030408@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 25/03/2014 15:39, Christian Borntraeger ha scritto:
> This bug is not yet in 3.14-rc
> It is only in kvm/next via commit  1ee0bc559dc34fe36a29494faf7b7c91533bd31c ( KVM: s390: get rid of local_int array)
> So no need for stable.
> patch 2 just reduces the memory usage from 64 bytes to 8 bytes.
> Dont think we should use the stable folks for that.

Ok.  Then I can apply this pull request!  Thanks for explaining it to me.

Paolo
