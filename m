From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Replacing specific kmalloc() calls by kmalloc_array()?
Date: Wed, 24 Aug 2016 11:00:04 -0400 (EDT)
Message-ID: <1214121824.5255512.1472050804153.JavaMail.zimbra@redhat.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net> <033d8595-d051-1fa8-95b1-5d2056eb5667@users.sourceforge.net> <57B562F3.1080004@bfs.de> <alpine.DEB.2.10.1608180502080.3107@hadrien> <9db1986a-9b93-72ca-f35e-85b5b5e9f351@redhat.com> <f2c99dcc-8dea-b8a4-5244-08bb7c0ee1e8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <f2c99dcc-8dea-b8a4-5244-08bb7c0ee1e8@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, walter harms <wharms@bfs.de>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?utf-8?Q?Borntr=C3=A4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



----- Original Message -----
> From: "SF Markus Elfring" <elfring@users.sourceforge.net>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Julia Lawall" <julia.lawall@lip6.fr>, "walter harms" <wharms@bfs.de>, kvm@vger.kernel.org,
> linux-s390@vger.kernel.org, "Christian Bornträger" <borntraeger@de.ibm.com>, "Cornelia Huck"
> <cornelia.huck@de.ibm.com>, "David Hildenbrand" <dahi@linux.vnet.ibm.com>, "Heiko Carstens"
> <heiko.carstens@de.ibm.com>, "Martin Schwidefsky" <schwidefsky@de.ibm.com>, "Radim Krčmář" <rkrcmar@redhat.com>,
> "LKML" <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
> Sent: Wednesday, August 24, 2016 2:10:13 PM
> Subject: Re: Replacing specific kmalloc() calls by kmalloc_array()?
> 
> > Or kmalloc_array, since zeroing is not necessary.  Might be an idea for
> > a new Coccinelle script, like
> > 
> > - kmalloc (N * sizeof T, GFP)
> > + kmalloc_array(N, sizeof T, GFP)
> 
> I have picked your idea up. The corresponding script for the semantic
> patch language became longer than your general suggestion
> (if additional source code control flow aspects are integrated).
> 
> Would it make sense to check any more function combinations
> in a similar way?

I don't know :) but I'm interested in seeing the semantic patch!

Paolo
