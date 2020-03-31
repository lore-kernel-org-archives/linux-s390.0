Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29004 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgCaIuj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 04:50:39 -0400
Subject: Re: [kvm-unit-tests 1/2] s390x/smp: fix detection of "running"
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
 <20200330084911.34248-2-borntraeger@de.ibm.com>
 <20200331084917.4ab3f405.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2eeedc49-5ffe-44b4-e88f-f00a2150d0d6@redhat.com>
Date: Tue, 31 Mar 2020 10:50:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200331084917.4ab3f405.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On 31.03.20 08:49, Cornelia Huck wrote:
> On Mon, 30 Mar 2020 04:49:10 -0400
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> On s390x hosts with a single CPU, the smp test case hangs (loops).
>> The check is our restart has finished is wrong.
>=20
> s/is/if/

With that fixed up queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

I'll wait with the other patch until we have a consent there regarding
possible races.

--=20
Thanks,

David / dhildenb
