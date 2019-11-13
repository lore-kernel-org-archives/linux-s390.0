Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbfKMNFf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 08:05:35 -0500
Subject: Re: [kvm-unit-tests PATCH v3 2/2] s390x: SCLP unit test
References: <1573492826-24589-1-git-send-email-imbrenda@linux.ibm.com>
 <1573492826-24589-3-git-send-email-imbrenda@linux.ibm.com>
 <fe853e54-ef79-ed94-eaf8-18b2acfd95f5@redhat.com>
 <20191113134024.75beb67d@p-imbrenda.boeblingen.de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <87d5c8cb-f6d6-4034-629a-4bf26b349b5f@redhat.com>
Date: Wed, 13 Nov 2019 14:05:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191113134024.75beb67d@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 13/11/2019 13.40, Claudio Imbrenda wrote:
> On Wed, 13 Nov 2019 10:34:02 +0100
> Thomas Huth <thuth@redhat.com> wrote:
[...]
>>> +/**
>>> + * Perform one test at the given address, optionally using the
>>> SCCB template, =20
>>
>> I think you should at least mention the meaning of the "len" parameter
>> here, otherwise this is rather confusing (see below, my comment to
>> sccb_template).
>=20
> I'll rename it and add comments
>=20
>>> + * checking for the expected program interrupts and return codes.
>>> + * Returns 1 in case of success or 0 in case of failure =20
>>
>> Could use bool with true + false instead.
>>
>>> + */
>>> +static int test_one_sccb(uint32_t cmd, uint8_t *addr, uint16_t
>>> len, uint64_t exp_pgm, uint16_t exp_rc) +{
>>> +=09SCCBHeader *h =3D (SCCBHeader *)addr;
>>> +=09int res, pgm;
>>> +
>>> +=09/* Copy the template to the test address if needed */
>>> +=09if (len)
>>> +=09=09memcpy(addr, sccb_template, len); =20
>>
>> Honestly, that sccb_template is rather confusing. Why does the caller
>> has to provide both, the data in the sccb_template and the "addr"
>> variable for yet another buffer? Wouldn't it be simpler if the caller
>> simply sets up everything in a place of choice and then only passes
>> the "addr" to the buffer?
>=20
> because you will test the same buffer at different addresses. this
> mechanism abstracts this. instead of having to clear the buffer and set
> the values for each address, you can simply set the template once and
> then call the same function, changing only the target address.
>=20
> also, the target address is not always a buffer, in many cases it is in
> fact an invalid address, which should generate exceptions.=20

Hmm, ok, I guess some additional comments like this in the source code
would be helpful.

>>> +=09expect_pgm_int();
>>> +=09res =3D sclp_service_call_test(cmd, h);
>>> +=09if (res) {
>>> +=09=09report_info("SCLP not ready (command %#x, address
>>> %p, cc %d)", cmd, addr, res);
>>> +=09=09return 0;
>>> +=09}
>>> +=09pgm =3D clear_pgm_int();
>>> +=09/* Check if the program exception was one of the expected
>>> ones */
>>> +=09if (!((1ULL << pgm) & exp_pgm)) {
>>> +=09=09report_info("First failure at addr %p, size %d,
>>> cmd %#x, pgm code %d", addr, len, cmd, pgm);
>>> +=09=09return 0;
>>> +=09}
>>> +=09/* Check if the response code is the one expected */
>>> +=09if (exp_rc && (exp_rc !=3D h->response_code)) { =20
>>
>> You can drop the parentheses around "exp_rc !=3D h->response_code".
>=20
> fine, although I don't understand you hatred toward parentheses :)

I took a LISP class at university once ... never quite recovered from
that...

No, honestly, the problem is rather that these additional parentheses
slow me down when I read the source code. If I see such if-statements,
my brain starts to think something like "There are parentheses here, so
there must be some additional non-trivial logic in this if-statement...
let's try to understand that..." and it takes a second to realize that
it's not the case and the parentheses are just superfluous.

>>> +/**
>>> + * Test SCCBs whose address is in the lowcore or prefix area.
>>> + */
>>> +static void test_sccb_prefix(void)
>>> +{
>>> +=09uint32_t prefix, new_prefix;
>>> +=09int offset;
>>> +
>>> +=09/* can't actually trash the lowcore, unsurprisingly things
>>> break if we do */
>>> +=09for (offset =3D 0; offset < 8192; offset +=3D 8)
>>> +=09=09if (!test_one_sccb(valid_code, MKPTR(offset), 0,
>>> PGM_BIT_SPEC, 0))
>>> +=09=09=09break;
>>> +=09report("SCCB low pages", offset =3D=3D 8192);
>>> +
>>> +=09memcpy(prefix_buf, 0, 8192);
>>> +=09new_prefix =3D (uint32_t)(intptr_t)prefix_buf;
>>> +=09asm volatile("stpx %0" : "=3DQ" (prefix));
>>> +=09asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
>>> +
>>> +=09for (offset =3D 0; offset < 8192; offset +=3D 8)
>>> +=09=09if (!test_one_simple(valid_code, MKPTR(new_prefix
>>> + offset), 8, 8, PGM_BIT_SPEC, 0))
>>> +=09=09=09break;
>>> +=09report("SCCB prefix pages", offset =3D=3D 8192);
>>> +
>>> +=09memcpy(prefix_buf, 0, 8192); =20
>>
>> What's that memcpy() good for? A comment would be helpful.
>=20
> we just moved the prefix to a temporary one, and thrashed the old one.
> we can't simply set the old prefix and call it a day, things will break.

Did the test really trash the old one? ... hmm, I guess I got the code
wrong, that prefix addressing is always so confusing. Is SCLP working
with absolute or real addresses?

 Thomas
