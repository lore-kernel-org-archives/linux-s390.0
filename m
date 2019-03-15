From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 15 Mar 2019 14:41:41 +0100
Message-ID: <20190315144141.100f2be7.cohuck@redhat.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 15 Mar 2019 14:26:34 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Conclusion:  we must handle this in userland, it will have the benefit 
> to keep old behavior when there is no callback.
> OLD QEMU will not see change as they will not set aqic facility
> NEW QEMU will handle this correctly.
> 
> In this case we also do not need to handle all other tests here but can 
> move it to the callback as Tony wanted.
> 
> Would you agree with something simple like:
> 
> static int handle_pqap(struct kvm_vcpu *vcpu)
> {
>          int ret = -EOPNOTSUPP;
> 
>          /* Verify that the hook callback is registered and call it */
>          if (pqap_hook)
>                  if (try_module_get(pqap_hook->owner)) {
>                          ret = pqap_hook->hook(vcpu);
>                          module_put(pqap_hook->owner);
>                  }
>          return ret;
> }
> 
> All other tests in QEMU and in the callback.

With the hook checking for priv, fc, etc.? Yeah, might work.

But don't count on my feedback too much right now, better wait for
others' comments :) I'll resume in April, if needed.
