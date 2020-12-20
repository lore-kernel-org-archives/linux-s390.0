Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbgLTKPa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 20 Dec 2020 05:15:30 -0500
Subject: Re: [PATCH v1 4/4] s390/kvm: VSIE: correctly handle MVPG when in VSIE
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-5-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6836573a-a49d-9d9f-49e0-96b5aa479c52@redhat.com>
Date: Sun, 20 Dec 2020 11:13:57 +0100
MIME-Version: 1.0
In-Reply-To: <20201218141811.310267-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On 18.12.20 15:18, Claudio Imbrenda wrote:
> Correctly handle the MVPG instruction when issued by a VSIE guest.
> 

I remember that MVPG SIE documentation was completely crazy and full of
corner cases. :)

Looking at arch/s390/kvm/intercept.c:handle_mvpg_pei(), I can spot that

1. "This interception can only happen for guests with DAT disabled ..."
2. KVM does not make use of any mvpg state inside the SCB.

Can this be observed with Linux guests?


Can I get some information on what information is stored at [0xc0, 0xd)
inside the SCB? I assume it's:

0xc0: guest physical address of source PTE
0xc8: guest physical address of target PTE


Also, which conditions have to be met such that we get a ICPT_PARTEXEC:

a) State of guest DAT (I assume off?)
b) State of PTEs: What happens if there is no PTE (I assume we need two
PTEs, otherwise no such intercept)? I assume we get an intercept if one
of both PTEs is not present or the destination PTE is protected. Correct?

So, when we (g1) get an intercept for g3, can we be sure 0xc0 and 0xc8
in the scb are both valid g1 addresses pointing at our PTE, and what do
we know about these PTEs (one not present or destination protected)?

[...]
>  /*
>   * Run the vsie on a shadow scb and a shadow gmap, without any further
>   * sanity checks, handling SIE faults.
> @@ -1063,6 +1132,10 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		if ((scb_s->ipa & 0xf000) != 0xf000)
>  			scb_s->ipa += 0x1000;
>  		break;
> +	case ICPT_PARTEXEC:
> +		if (scb_s->ipa == 0xb254)

Old code hat "/* MVPG only */" - why is this condition now necessary?

> +			rc = vsie_handle_mvpg(vcpu, vsie_page);
> +		break;
>  	}
>  	return rc;
>  }
> 


-- 
Thanks,

David / dhildenb
