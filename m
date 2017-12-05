From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
Date: Tue, 5 Dec 2017 10:51:47 +0100
Message-ID: <20171205105147.7efcf684.cohuck@redhat.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
        <20171205083321.102933-5-borntraeger@de.ibm.com>
        <20171205101359.1d3b09c3.cohuck@redhat.com>
        <0657b07a-cb1c-506b-eba3-1c0c9ea1e564@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <0657b07a-cb1c-506b-eba3-1c0c9ea1e564@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Dec 2017 10:39:26 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12/05/2017 10:13 AM, Cornelia Huck wrote:

> > This reminds me of something I stumbled upon the other day:
> > 
> > handle_ri() and handle_gs() (both implemented in priv.c) don't seem to
> > have a check for PSTATE, yet they enable ri/gs before retrying the
> > instruction. Is that correct?  
> 
> The guarded storage ops (e3 49 and e3 4d) are problem state.
> Most of the ri instruction are as well, so problem state can enable RI
> interpretion.
> 
> We could do some optimization to only enable RI if the
> instruction would enable in for the guest (e.g. an inspection of the
> control block could leave RI disabled). On the other hand that would
> require to implement these instruction in KVM, which I would like
> to avoid. Right now we enable RI and re-drive the instruction.

It's probably not worth it, I think.
