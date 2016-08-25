From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Software evolution around scripts for the semantic patch
 langugae
Date: Thu, 25 Aug 2016 23:04:58 +0200
Message-ID: <20160825230458.7fc85c66.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
        <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
        <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
        <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
        <20160825181009.381411d9.cornelia.huck@de.ibm.com>
        <b35caa5e-35c7-d2d9-b1e0-bd8ca5379535@users.sourceforge.net>
        <alpine.DEB.2.10.1608251412520.3094@hadrien>
        <fe9cae9f-6dbd-984c-1c12-32b55964a8f4@users.sourceforge.net>
        <alpine.DEB.2.10.1608251422030.3094@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1608251422030.3094@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Aug 2016 14:23:35 -0400 (EDT)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Thu, 25 Aug 2016, SF Markus Elfring wrote:
> 
> > > Or some close variant.
> >
> > I have got more script variants evolving in my software collection.
> >
> > There are further approaches available from various contributors,
> > aren't there?
> 
> What she is asking for is a concise and precise decription of what you
> have done.  If you have some other variants, eg controlling where the
> sizeof argument is (left or right of *), you don't necessarily have to
> include it in the patch, if such a rule was not used for the specific
> patch anyway.

*nod*

If I see a patch that says "I've run the following cocchinelle patch to
perform $TRANSFORMATION, and here's the result", I can be reasonably
sure that the result will be what is intended to be changed in the
first place (and I can assess whether the change makes sense at all.)
If I see only the resulting patch, I won't know whether you have
performed the changes manually (and possibly introduced bugs, as
happens to all of us.)

Moreover, a good semantic patch is useful to others as well and might
even be reused in other contexts that have similar requirements. You
really lose value if you don't publish them.
