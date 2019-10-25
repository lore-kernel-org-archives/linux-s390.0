Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30518 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405057AbfJYIlH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Oct 2019 04:41:07 -0400
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
 <32166470-43c1-f454-440f-3f660b995ca2@redhat.com>
 <ed8860e6-176a-64dd-e697-5ed80dd3c872@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <257d9326-9af9-5986-aeb0-4323fb66c81d@redhat.com>
Date: Fri, 25 Oct 2019 10:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <ed8860e6-176a-64dd-e697-5ed80dd3c872@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 25.10.19 10:39, Janosch Frank wrote:
> On 10/25/19 10:31 AM, David Hildenbrand wrote:
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> The convert to/from secure (or also "import/export") ultravisor calls
>>> are need for page management, i.e. paging, of secure execution VM.
>>>
>>> Export encrypts a secure guest's page and makes it accessible to the
>>> guest for paging.
>>
>> How does paging play along with pinning the pages (from
>> uv_convert_to_secure() -> kvm_s390_pv_pin_page()) in a follow up patch?
>> Can you paint me the bigger picture?
>=20
> That's a stale comment I should have removed before sending...
> The current patches do not support paging.

Note that once you pin you really have to disable the balloon in the=20
QEMU (inhibit it).


--=20

Thanks,

David / dhildenb
