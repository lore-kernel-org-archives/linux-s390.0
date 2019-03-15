From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 15 Mar 2019 18:43:52 +0100
Message-ID: <20190315184352.0151d972@oc2783563651>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
        <9302bd83-44e6-eb60-3e39-dcb3fc33f280@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9302bd83-44e6-eb60-3e39-dcb3fc33f280@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 15 Mar 2019 15:10:25 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Sorry, wrong conclusion, handling this in userland will bring us much 
> too far if we want to answer correctly for the case the hook is not 
> there but QEMU accepted the facility for AQIC.
> 
> The alternative is easier, we just continue to respond with the 
> OPERATION exception here and only handle the specification and 
> privileged exception cases in QEMU and in the hook.

I don't quite understand what do you mean by this paragraph. Especially
not what do you mean by 'just continue to respond with the OPERATION
exception here'.

In any case if the guest is supposed to have ap instructions, and does
not have facility 65 the right answer is specification and not operation
exception. And this has to work regardless of vfio-ap module loaded or
not.

Regards,
Halil

> 
> So, I think the discussion will go on until you come back :)
> 
> Regards,
> Pierre
