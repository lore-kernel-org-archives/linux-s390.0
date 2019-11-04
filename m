Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32030 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728810AbfKDOcl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:32:41 -0500
Subject: Re: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-8-frankja@linux.ibm.com>
 <20191025082446.754-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7918ea28-8f10-dc1c-e35b-c1b66631877e@redhat.com>
Date: Mon, 4 Nov 2019 15:32:25 +0100
MIME-Version: 1.0
In-Reply-To: <20191025082446.754-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 25.10.19 10:24, Janosch Frank wrote:
> KSM will not work on secure pages, because when the kernel reads a
> secure page, it will be encrypted and hence no two pages will look the
> same.
>=20
> Let's mark the guest pages as unmergeable when we transition to secure
> mode.

Patch itself looks good to me, but I do wonder: Is this really needed=20
when pinning all encrypted pages currently?

Not sure about races between KSM and the pinning/encrypting thread,=20
similar to paging, though ...

--=20

Thanks,

David / dhildenb
