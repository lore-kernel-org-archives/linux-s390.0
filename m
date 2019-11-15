Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34850 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKONz2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 08:55:28 -0500
Subject: Re: [RFC 32/37] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-33-frankja@linux.ibm.com>
 <6fb6b03f-5a33-34ec-53e6-d960ac7bbae6@redhat.com>
 <302337a3-5a1f-4ee9-2ee8-a10b7fe17479@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76e04877-93c5-0785-290e-4d8739b4c4b8@redhat.com>
Date: Fri, 15 Nov 2019 14:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <302337a3-5a1f-4ee9-2ee8-a10b7fe17479@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 15/11/2019 12.39, Janosch Frank wrote:
> On 11/15/19 11:07 AM, Thomas Huth wrote:
>> On 24/10/2019 13.40, Janosch Frank wrote:
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  arch/s390/include/asm/uv.h | 25 +++++++++++++++++++++++++
>>>  arch/s390/kvm/diag.c       |  1 +
>>>  arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
>>>  arch/s390/kvm/kvm-s390.h   |  2 ++
>>>  arch/s390/kvm/pv.c         | 19 +++++++++++++++++++
>>>  include/uapi/linux/kvm.h   |  2 ++
>>>  6 files changed, 69 insertions(+)
>>
>> Add at least a short patch description what this patch is all about?
>>
>>  Thomas
>>
>=20
> I'm thinking about taking out the set cpu state changes and move it into
> a later patch.
>=20
>=20
> How about:
> diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since
> the cpus have to be set into multiple reset states.
>=20
> * All cpus need to be stopped
> * The unshare all UVC needs to be executed
> * The perform reset UVC needs to be executed
> * The cpus need to be reset via the set cpu state UVC
> * The issuing cpu needs to set state 5 via set cpu state

Could you put the UVC names into quotes? Like:

* The "unshare all" UVC needs to be executed

... I first had to read the sentence three times to really understand it.

 Thomas
