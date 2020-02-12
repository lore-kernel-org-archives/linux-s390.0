Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgBLLEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 06:04:10 -0500
Date: Wed, 12 Feb 2020 12:03:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 35/35] DOCUMENTATION: Protected virtual machine
 introduction and IPL
Message-ID: <20200212120357.205e9ede.cohuck@redhat.com>
In-Reply-To: <a2e5f248-4d4d-5650-6f48-174bddd328f9@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-36-borntraeger@de.ibm.com>
        <5d8050a6-c730-4325-2d46-2b5c9cdc8408@redhat.com>
        <a2e5f248-4d4d-5650-6f48-174bddd328f9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Tue, 11 Feb 2020 21:03:17 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11.02.20 13:23, Thomas Huth wrote:
> > On 07/02/2020 12.39, Christian Borntraeger wrote:  
> >> +The switch into PV mode lets us load encrypted guest executables and  
> > 
> > Maybe rather: "After the switch into PV mode, the guest can load ..." ?  
> 
> No its not after the switch. By doing the switch the guest image can be loaded
> fro anywhere because it is just like a kernel.
> 
> So I will do:
> 
> As the guest image is just like an opaque kernel image that does the
> switch into PV mode itself, the user can load encrypted guest
> executables and data via every available method (network, dasd, scsi,
> direct kernel, ...) without the need to change the boot process.

Sounds good to me.

(...)

> >> +All non-decrypted data of the guest before it switches to protected
> >> +virtualization mode are zero on first access of the PV.  
> > 
> > Before it switches to protected virtualization mode, all non-decrypted
> > data of the guest are ... ?  
> 
> No, this is about the data after the initial import.
> What about
> 
> After the initial import of the encrypted data all defined pages will

s/data/data,/

> contain the guest content. All non-specified pages will start out as
> zero pages on first access.

Also sounds good to me.

(...)
