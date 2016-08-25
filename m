From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Software evolution around scripts for the semantic patch
 langugae
Date: Thu, 25 Aug 2016 14:14:26 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1608251412520.3094@hadrien>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net> <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net> <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com> <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
 <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net> <20160825181009.381411d9.cornelia.huck@de.ibm.com> <b35caa5e-35c7-d2d9-b1e0-bd8ca5379535@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <b35caa5e-35c7-d2d9-b1e0-bd8ca5379535@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?ISO-8859-15?Q?Christian_Borntr=E4ger?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>



On Thu, 25 Aug 2016, SF Markus Elfring wrote:

> >>   This issue was detected also by using the Coccinelle software.
> >
> > Do you have the scripts you use published somewhere?
>
> I would like to add another view for the corresponding software development.
>
> The complete answer depends also on the kind of "scripts"
> you are looking for. Would you like to clarify any details
> a bit more here?

I imagine that she is asking for:

@@
expression e1,e2,e3;
@@

- kmalloc(e1 * e2, e3)
+ kmalloc_array(e1, e2, e3)

Or some close variant.  It seems pretty straightforward to provide and
can help orient the reader to what is going on.

julia
