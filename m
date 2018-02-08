From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/2] KVM: s390: avoid jump tables
Date: Thu, 8 Feb 2018 09:58:19 +0100
Message-ID: <20180208085819.GC3937@osiris>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <7e9bb181-cec9-0781-03c0-b74d5d087c8a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7e9bb181-cec9-0781-03c0-b74d5d087c8a@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:30:28PM +0100, David Hildenbrand wrote:
> On 06.02.2018 12:21, Christian Borntraeger wrote:
> > Some old patches refreshed.
> > 
> 
> Certainly the right thing to do. Especially also interesting due to
> retpotline (if we get something like that on s390x). If I remember
> correctly, x86 highly benefits by replacing magic function pointer by
> switch statements.

If you look at the generated code for the first patch: gcc now generates
its own jump table which then jumps (indirectly) to a brasl... So it's two
instead of one branch.
I'm not saying that this patch is not good, but there seem be a wrong
assumptions about the benefit here.
