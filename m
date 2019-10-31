Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49907 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726892AbfJaJPJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Oct 2019 05:15:09 -0400
Subject: Re: [RFC 13/37] KVM: s390: protvirt: Add interruption injection
 controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-14-frankja@linux.ibm.com>
 <c09046eb-380f-d930-8e99-42b9cc8a62ae@redhat.com>
 <26dfdefa-edbe-40e5-5b41-a4de86d47d15@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5e8c5e1c-d08a-6ba4-da28-ee387522c257@redhat.com>
Date: Thu, 31 Oct 2019 10:15:01 +0100
MIME-Version: 1.0
In-Reply-To: <26dfdefa-edbe-40e5-5b41-a4de86d47d15@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mimu@linux.ibm.com, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 31.10.19 09:48, Michael Mueller wrote:
>=20
>=20
> On 30.10.19 16:53, David Hildenbrand wrote:
>>> @@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 oai;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00e2 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 armid;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00e3 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 reservede4[4];=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00e4 */
>>> -=C2=A0=C2=A0=C2=A0 __u64=C2=A0=C2=A0=C2=A0 tecmc;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00e8 */
>>> -=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 reservedf0[12];=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00f0 */
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64=C2=A0=C2=A0=C2=A0 tec=
mc;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x00e8 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
16=C2=A0=C2=A0=C2=A0 subchannel_id;=C2=A0=C2=A0=C2=A0 /* 0x00e8 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
16=C2=A0=C2=A0=C2=A0 subchannel_nr;=C2=A0=C2=A0=C2=A0 /* 0x00ea */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
32=C2=A0=C2=A0=C2=A0 io_int_parm;=C2=A0=C2=A0=C2=A0 /* 0x00ec */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
32=C2=A0=C2=A0=C2=A0 io_int_word;=C2=A0=C2=A0=C2=A0 /* 0x00f0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> I only wonder if we should give this member a fitting name, e.g.,=20
>> "ioparams"
>=20
> Do you see a real gain for that? We have a lot of other unnamed structs
> defined here as well.

I was wondering if we could just copy the whole struct when delivering
the interrupt.

You could even reuse  "struct kvm_s390_io_info" here to make that more
clear.

--=20

Thanks,

David / dhildenb
