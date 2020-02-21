Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBUKzC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 05:55:02 -0500
Subject: Re: [PATCH v3 00/37] KVM: s390: Add support for protected VMs
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5556ee4a-09c6-117a-be99-4a5e136b78ea@redhat.com>
Date: Fri, 21 Feb 2020 11:54:48 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On 20.02.20 11:39, Christian Borntraeger wrote:
> mm people: This series contains a "pretty small" common code memory
> management change that will allow paging, guest backing with files etc
> almost just like normal VMs. It should be a no-op for all architectures
> not opting in. And it should be usable for others that also try to get
> notified on "the pages are in the process of being used for things like
> I/O". This time I included error handling and an ACK from Will Deacon.
>=20
> mm-related patches CCed on linux-mm, the complete list can be found on
> the KVM and linux-s390 list.=20
>=20
> Andrew, any chance to either take " mm:gup/writeback: add callbacks for
> inaccessible pages" or ACK so that I can take it?

Summary: Mostly LGTM. Especially
- UAPI interface is minimal and clean
- Core MM changes are minimal and clean (and AFAIKT Andrea was involved
  when discussing the approach, so it can't be wrong ;) )
- Is no longer prototype quality ;)

There are still some things I want to double check (esp. how KVM memory
slots are handled - I somewhat dislike that we cannot replace/add new
ones while in PV. One would have to fence that somehow in QEMU as long
as the guest is in PV mode e.g., once we would support memory hotplug
... but looks like this is what the HW requires us to enforce for now),
certain races, etc. but I assume these things could be fixed later on.

Can we get a new version once the other reviewers are done, so at least
I can have a final look?

Thanks!

--=20
Thanks,

David / dhildenb
