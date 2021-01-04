Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21854 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727225AbhADPZB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jan 2021 10:25:01 -0500
Date: Mon, 4 Jan 2021 16:22:31 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 4/4] s390/kvm: VSIE: correctly handle MVPG when in
 VSIE
Message-ID: <20210104162231.4e56ab47@ibm-vm>
In-Reply-To: <6836573a-a49d-9d9f-49e0-96b5aa479c52@redhat.com>
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
        <20201218141811.310267-5-imbrenda@linux.ibm.com>
        <6836573a-a49d-9d9f-49e0-96b5aa479c52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On Sun, 20 Dec 2020 11:13:57 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 18.12.20 15:18, Claudio Imbrenda wrote:
> > Correctly handle the MVPG instruction when issued by a VSIE guest.
> >   
> 
> I remember that MVPG SIE documentation was completely crazy and full
> of corner cases. :)

you remember correctly

> Looking at arch/s390/kvm/intercept.c:handle_mvpg_pei(), I can spot
> that
> 
> 1. "This interception can only happen for guests with DAT disabled
> ..." 2. KVM does not make use of any mvpg state inside the SCB.
> 
> Can this be observed with Linux guests?

a Linux guest will typically not run with DAT disabled

> Can I get some information on what information is stored at [0xc0,
> 0xd) inside the SCB? I assume it's:
> 
> 0xc0: guest physical address of source PTE
> 0xc8: guest physical address of target PTE

yes (plus 3 flags in the lower bits of each)

> 
> Also, which conditions have to be met such that we get a
> ICPT_PARTEXEC:
> 
> a) State of guest DAT (I assume off?)
> b) State of PTEs: What happens if there is no PTE (I assume we need
> two PTEs, otherwise no such intercept)? I assume we get an intercept
> if one of both PTEs is not present or the destination PTE is
> protected. Correct?

we get the intercept if the guest has DAT off, and at least one of the
host PTEs is invalid (and I think if the destination is valid but
protected)

> So, when we (g1) get an intercept for g3, can we be sure 0xc0 and 0xc8
> in the scb are both valid g1 addresses pointing at our PTE, and what
> do we know about these PTEs (one not present or destination
> protected)?

we only know that at least one of the following holds true:
* source invalid
* destination invalid
* destination protected

there is a bit that tells us if the destination was protected (bit 62),
but that does not exclude an invalid source

> [...]
> >  /*
> >   * Run the vsie on a shadow scb and a shadow gmap, without any
> > further
> >   * sanity checks, handling SIE faults.
> > @@ -1063,6 +1132,10 @@ static int do_vsie_run(struct kvm_vcpu
> > *vcpu, struct vsie_page *vsie_page) if ((scb_s->ipa & 0xf000) !=
> > 0xf000) scb_s->ipa += 0x1000;
> >  		break;
> > +	case ICPT_PARTEXEC:
> > +		if (scb_s->ipa == 0xb254)  
> 
> Old code hat "/* MVPG only */" - why is this condition now necessary?

old code was wrong ;)

> > +			rc = vsie_handle_mvpg(vcpu, vsie_page);
> > +		break;
> >  	}
> >  	return rc;
> >  }
> >   
> 
> 
