From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
Date: Tue, 5 Dec 2017 10:45:51 +0100
Message-ID: <20171205104551.139d7d2f.cohuck@redhat.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
        <20171205083321.102933-5-borntraeger@de.ibm.com>
        <20171205101359.1d3b09c3.cohuck@redhat.com>
        <742d333c-a229-c28b-fea1-5885fdbb0358@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <742d333c-a229-c28b-fea1-5885fdbb0358@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Dec 2017 10:32:03 +0100
Janosch Frank <frankja@linux.vnet.ibm.com> wrote:

> On 05.12.2017 10:13, Cornelia Huck wrote:

> > This reminds me of something I stumbled upon the other day:
> > 
> > handle_ri() and handle_gs() (both implemented in priv.c) don't seem to
> > have a check for PSTATE, yet they enable ri/gs before retrying the
> > instruction. Is that correct?
> >   
> 
> None of the gs instructions are privileged as far as I know. Same seems
> to be true for ri as far as I've scanned the spec.
> 
> The privileged parts are the control register and PSW changes which are
> handled elsewhere.

OK, thanks. I found the z14 PoP, but the ri instructions don't seem to
be documented in there.
