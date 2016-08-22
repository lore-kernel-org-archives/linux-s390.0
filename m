From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/4] KVM-S390: Improve determination of sizes in
 kvm_s390_import_bp_data()
Date: Mon, 22 Aug 2016 14:58:07 +0200
Message-ID: <20160822145807.4b8fb1cb.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <033d8595-d051-1fa8-95b1-5d2056eb5667@users.sourceforge.net>
        <57B562F3.1080004@bfs.de>
        <alpine.DEB.2.10.1608180502080.3107@hadrien>
        <9db1986a-9b93-72ca-f35e-85b5b5e9f351@redhat.com>
        <57B5935B.3050602@bfs.de>
        <38bba070-d157-dc49-b428-47768ad647ca@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38bba070-d157-dc49-b428-47768ad647ca@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: wharms@bfs.de, Julia Lawall <julia.lawall@lip6.fr>, SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 18 Aug 2016 12:55:11 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> This is _not_ premature optimization.  (k)calloc tells the reader that
> it's safe not to initialize part of the array.  kmalloc_array says the
> opposite.  Using the right function adds important hints in the
> code---which unlike comments cannot get stale without also introducing
> visible bugs.

Ack. I'd accept a patch changing this to use kmalloc_array.
