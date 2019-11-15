Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45335 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727333AbfKOK2E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 05:28:04 -0500
Subject: Re: [RFC 31/37] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-32-frankja@linux.ibm.com>
 <a1c263ff-954e-a7c3-28b4-e9bd866eb35f@redhat.com>
 <f9ecf949-3f0d-fb64-cc77-44974a71625e@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e8e80d38-ef63-c394-0e5d-9dbfdfc5241f@redhat.com>
Date: Fri, 15 Nov 2019 11:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <f9ecf949-3f0d-fb64-cc77-44974a71625e@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 15/11/2019 11.20, Janosch Frank wrote:
> On 11/15/19 11:04 AM, Thomas Huth wrote:
>> On 24/10/2019 13.40, Janosch Frank wrote:
>>> If the host initialized the Ultravisor, we can set stfle bit 161
>>> (protected virtual IPL enhancements facility), which indicates, that
>>> the IPL subcodes 8, 9 and are valid. These subcodes are used by a
>>> normal guest to set/retrieve a IPIB of type 5 and transition into
>>> protected mode.
>>>
>>> Once in protected mode, the VM will loose the facility bit, as each
>>
>> So should the bit be cleared in the host code again? ... I don't see
>> this happening in this patch?
>>
>>  Thomas
>=20
> No, KVM doesn't report stfle facilities in protected mode and we would
> need to add it again in normal mode so just clearing it would be
> pointless. In protected mode 8-10 do not intercept, so there's nothing
> we need to do.

Ah, ok, that's what I've missed. Maybe replace "the VM will loose the
facility bit" with "the ultravisor will conceal the facility bit" ?

 Thomas
