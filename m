Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJK2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Dec 2019 05:28:42 -0500
Subject: Re: [kvm-unit-tests PATCH v3 5/9] s390x: Library resources for CSS
 tests
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-6-git-send-email-pmorel@linux.ibm.com>
 <66233a15-7cc4-45b5-d930-abbedbd0729d@redhat.com>
 <c37b0a10-358d-08be-7a59-20048b7af620@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23770c1c-8aba-85ef-09a1-346393bb90d6@redhat.com>
Date: Tue, 10 Dec 2019 11:28:19 +0100
MIME-Version: 1.0
In-Reply-To: <c37b0a10-358d-08be-7a59-20048b7af620@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 10/12/2019 11.07, Pierre Morel wrote:
>=20
>=20
> On 2019-12-09 12:49, Thomas Huth wrote:
>> On 06/12/2019 17.26, Pierre Morel wrote:
>>> These are the include and library utilities for the css tests patch
>>> series.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>> =C2=A0 lib/s390x/css.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 259 ++++++++++++=
+++++++++++++++++++++++++++++++
>>> =C2=A0 lib/s390x/css_dump.c | 156 ++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 415 insertions(+)
>>> =C2=A0 create mode 100644 lib/s390x/css.h
>>> =C2=A0 create mode 100644 lib/s390x/css_dump.c
>>>
>>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>>> new file mode 100644
>>> index 0000000..6f19bb5
>>> --- /dev/null
>>> +++ b/lib/s390x/css.h
>> [...]
>>> +/* Debug functions */
>>> +char *dump_pmcw_flags(uint16_t f);
>>> +char *dump_scsw_flags(uint32_t f);
>>> +#undef DEBUG
>>> +#ifdef DEBUG
>>> +void dump_scsw(struct scsw *);
>>> +void dump_irb(struct irb *irbp);
>>> +void dump_schib(struct schib *sch);
>>> +struct ccw *dump_ccw(struct ccw *cp);
>>> +#else
>>> +static inline void dump_scsw(struct scsw *scsw) {}
>>> +static inline void dump_irb(struct irb *irbp) {}
>>> +static inline void dump_pmcw(struct pmcw *p) {}
>>> +static inline void dump_schib(struct schib *sch) {}
>>> +static inline void dump_orb(struct orb *op) {}
>>> +static inline struct ccw *dump_ccw(struct ccw *cp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return NULL;
>>> +}
>>> +#endif
>>
>> I'd prefer to not have a "#undef DEBUG" (or "#define DEBUG") statement
>=20
> Anyway hawfull!
>=20
>> in the header here - it could trigger unexpected behavior with other
>> files that also use a DEBUG macro.
>>
>> Could you please declare the prototypes here and move the "#else" part
>> to the .c file instead? Thanks!
>=20
> What if I use a CSS_DEBUG here instead of a simple DEBUG definition?
>=20
> It can be enabled or not by defining CSS_ENABLED ahead of the include...?

Why does it have to be in the header and not in the .c file?

 Thomas
