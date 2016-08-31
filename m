From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] KVM-S390: Less function calls in
 kvm_s390_import_bp_data() after error detection
Date: Wed, 31 Aug 2016 14:29:41 +0200
Message-ID: <57711295-6c3c-c2f3-41e3-a85a552de82b@redhat.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
 <20160822150048.309a3e10.cornelia.huck@de.ibm.com>
 <cff92477-f426-a4c7-fffb-f8bbc378afe7@users.sourceforge.net>
 <20160822213736.62f1ae29.cornelia.huck@de.ibm.com>
 <5da7978a-922b-8ccc-fce4-2bffffca888f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5da7978a-922b-8ccc-fce4-2bffffca888f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>



On 22/08/2016 23:17, SF Markus Elfring wrote:
>> If in doubt, the compiler will be _much_ better at optimizing
>> that kind of stuff anyway.
> 
> Which compiler (or optimizer) implementation is capable to restructure
> the jump targets for you automatically in the way I propose here?

If kfree were implemented as

	if (p)
		really_kfree(p);

then the compiler would be able to jump over the NULL test.  In
principle one could also add a "does nothing if NULL" attribute to GCC
and annotate kfree with it.

Paolo
