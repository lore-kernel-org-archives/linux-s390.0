Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32966 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727373AbhADPZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jan 2021 10:25:03 -0500
Date: Mon, 4 Jan 2021 14:58:02 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/4] s390/kvm: VSIE: stop leaking host addresses
Message-ID: <20210104145802.7a2274a2@ibm-vm>
In-Reply-To: <b1a31982-a967-7439-1a7c-3c948deeb79d@redhat.com>
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
        <20201218141811.310267-2-imbrenda@linux.ibm.com>
        <b1a31982-a967-7439-1a7c-3c948deeb79d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On Sun, 20 Dec 2020 10:44:56 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 18.12.20 15:18, Claudio Imbrenda wrote:
> > The addresses in the SIE control block of the host should not be
> > forwarded to the guest. They are only meaningful to the host, and
> > moreover it would be a clear security issue.  
> 
> It's really almost impossible for someone without access to
> documentation to understand what we leak. I assume we're leaking the
> g1 address of a page table (entry), used for translation of g2->g3 to
> g1. Can you try making that clearer?

this is correct.

I guess I can improve the text of the commit
 
> In that case, it's pretty much a random number (of a random page used
> as a leave page table) and does not let g1 identify locations of
> symbols etc. If so, I don't think this is a "clear security issue"
> and suggest squashing this into the actual fix (#p4 I assume).

yeah __maybe__ I overstated the importance ;)

But I would still like to keep it as a separate patch, looks more
straightforward to me
 
> @Christian, @Janosch? Am I missing something?
> 
> > 
> > Subsequent patches will actually put the right values in the guest
> > SIE control block.
> > 
> > Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested
> > virtualization") Cc: stable@vger.kernel.org
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/kvm/vsie.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> > index 4f3cbf6003a9..ada49583e530 100644
> > --- a/arch/s390/kvm/vsie.c
> > +++ b/arch/s390/kvm/vsie.c
> > @@ -416,11 +416,6 @@ static void unshadow_scb(struct kvm_vcpu
> > *vcpu, struct vsie_page *vsie_page) memcpy((void *)((u64)scb_o +
> > 0xc0), (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
> >  		break;
> > -	case ICPT_PARTEXEC:
> > -		/* MVPG only */
> > -		memcpy((void *)((u64)scb_o + 0xc0),
> > -		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
> > -		break;
> >  	}
> >  
> >  	if (scb_s->ihcpu != 0xffffU)
> >   
> 
> 
