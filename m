From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Software evolution around scripts for the semantic patch
 langugae
Date: Thu, 25 Aug 2016 19:40:39 +0200
Message-ID: <20160825194039.218e795d.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
        <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
        <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
        <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
        <20160825181009.381411d9.cornelia.huck@de.ibm.com>
        <b35caa5e-35c7-d2d9-b1e0-bd8ca5379535@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b35caa5e-35c7-d2d9-b1e0-bd8ca5379535@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Aug 2016 19:34:29 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> >>   This issue was detected also by using the Coccinelle software.
> > 
> > Do you have the scripts you use published somewhere?
> 
> I would like to add another view for the corresponding software development.
> 
> The complete answer depends also on the kind of "scripts"
> you are looking for. Would you like to clarify any details
> a bit more here?

You obviously run some kind of semantic patching. It would really help
ease review if you could publish the semantic patches that generate
your patches - that is probably more helpful in review than just
posting the generated patches.

And it does not need to be "complete", I'd think everyone on the cc:
list here is able to handle a cocchinelle patch, for example.
