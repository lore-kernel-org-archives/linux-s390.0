Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbfKLQSB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 11:18:01 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Load reset psw on diag308
 reset
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-4-frankja@linux.ibm.com>
 <7683adc7-2cd0-1103-d231-8a1577f1e673@redhat.com>
 <a22f8407-efb1-ab0e-eaf6-77d0b853c6de@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f3be87c4-135e-dd42-b9b4-aadc0d0c90ca@redhat.com>
Date: Tue, 12 Nov 2019 17:17:50 +0100
MIME-Version: 1.0
In-Reply-To: <a22f8407-efb1-ab0e-eaf6-77d0b853c6de@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

On 12/11/2019 14.42, Janosch Frank wrote:
> On 11/12/19 1:09 PM, David Hildenbrand wrote:
>> On 11.11.19 16:33, Janosch Frank wrote:
>>> On a diag308 subcode 0 CRs will be reset, so we need a PSW mask
>>> without DAT. Also we need to set the short psw indication to be
>>> compliant with the architecture.
>>>
>>> Let's therefore define a reset PSW mask with 64 bit addressing and
>>> short PSW indication that is compliant with architecture and use it.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  lib/s390x/asm-offsets.c  |  1 +
>>>  lib/s390x/asm/arch_def.h |  3 ++-
>>>  s390x/cstart64.S         | 24 +++++++++++++++++-------
>>>  3 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
>>> index 4b213f8..61d2658 100644
>>> --- a/lib/s390x/asm-offsets.c
>>> +++ b/lib/s390x/asm-offsets.c
>>> @@ -58,6 +58,7 @@ int main(void)
>>>  =09OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
>>>  =09OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
>>>  =09OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
>>> +=09OFFSET(GEN_LC_SW_INT_PSW, lowcore, sw_int_psw);
>>>  =09OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
>>>  =09OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
>>>  =09OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>> index 07d4e5e..7d25e4f 100644
>>> --- a/lib/s390x/asm/arch_def.h
>>> +++ b/lib/s390x/asm/arch_def.h
>>> @@ -79,7 +79,8 @@ struct lowcore {
>>>  =09uint32_t=09sw_int_fpc;=09=09=09/* 0x0300 */
>>>  =09uint8_t=09=09pad_0x0304[0x0308 - 0x0304];=09/* 0x0304 */
>>>  =09uint64_t=09sw_int_crs[16];=09=09=09/* 0x0308 */
>>> -=09uint8_t=09=09pad_0x0310[0x11b0 - 0x0388];=09/* 0x0388 */
>>> +=09struct psw=09sw_int_psw;=09=09=09/* 0x0388 */
>>> +=09uint8_t=09=09pad_0x0310[0x11b0 - 0x0390];=09/* 0x0390 */
>>>  =09uint64_t=09mcck_ext_sa_addr;=09=09/* 0x11b0 */
>>>  =09uint8_t=09=09pad_0x11b8[0x1200 - 0x11b8];=09/* 0x11b8 */
>>>  =09uint64_t=09fprs_sa[16];=09=09=09/* 0x1200 */
[...]
>> This patch breaks the smp test under TCG (no clue and no time to look
>> into the details :) ):
>=20
> I forgot to fixup the offset calculation at the top of the patch once
> again...

Maybe add a

_Static_assert(sizeof(struct lowcore) =3D=3D xyz)

after the struct definitions, to avoid that this happens again?

 Thomas
