From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 05/12] s390/css: expose the AIV facility
Date: Thu, 25 Jan 2018 16:13:37 +0100
Message-ID: <20180125151337.GB3887@osiris>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-6-borntraeger@de.ibm.com>
 <29f77b94-a5e1-178d-2364-9dcf77dc9096@redhat.com>
 <dbfae6e1-ceda-880c-3908-b03193c7d714@linux.vnet.ibm.com>
 <20180118185400.34533a23.cohuck@redhat.com>
 <13254019-23b0-5bad-27c8-3874400288a1@de.ibm.com>
 <20180125130036.19e68a82.cohuck@redhat.com>
 <c44a76c6-4573-7325-d3b2-0f4177daba2e@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c44a76c6-4573-7325-d3b2-0f4177daba2e@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 25, 2018 at 01:04:42PM +0100, Christian Borntraeger wrote:
> >> Its a separate code (not KVM) so I keep it separate.
> > 
> > I would just have collected an ack from the relevant maintainers, but
> > fair enough.
> 
> I need that anyway and its easier if I just have this hunk.
> 
> Heiko Martin, can any of you ack
> 
> this patch ([PATCH 05/12] s390/css: expose the AIV facility)
> as well as
> [PATCH 03/12] s390/bitops: add test_and_clear_bit_inv()
> and
> [PATCH 11/12] s390/sclp: expose the GISA format facility
> 
> for handling these patches via the KVM tree.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
