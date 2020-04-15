Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2897322AbgDOLjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 07:39:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FBXt1l125791
        for <linux-s390@vger.kernel.org>; Wed, 15 Apr 2020 07:39:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dnnf2jdu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Apr 2020 07:39:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 15 Apr 2020 12:39:25 +0100
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <11dc928d-60b4-f04f-1ebf-f4cffb337a6c@intel.com>
 <20200414180300.52640444@p-imbrenda>
 <93dc9885-adb4-8b9d-a62a-e40301053551@intel.com>
 <20200415112639.525e25bc@p-imbrenda>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Apr 2020 13:39:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200415112639.525e25bc@p-imbrenda>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P4mBed8k4peDWIX8tgyLce74tUHYggYbe"
Message-Id: <f1594ee2-0eea-9f8a-8e5b-8efd81af8c05@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P4mBed8k4peDWIX8tgyLce74tUHYggYbe
Content-Type: multipart/mixed; boundary="bynVyiNEgR8wsJ3XDMDD8KjfApXPH52u2"

--bynVyiNEgR8wsJ3XDMDD8KjfApXPH52u2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/15/20 11:26 AM, Claudio Imbrenda wrote:
> On Tue, 14 Apr 2020 11:50:16 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 4/14/20 9:03 AM, Claudio Imbrenda wrote:
>>> On Mon, 13 Apr 2020 13:22:24 -0700
>>> Dave Hansen <dave.hansen@intel.com> wrote:
>>>  =20
>>>> On 3/6/20 5:25 AM, Claudio Imbrenda wrote: =20
>>>>> On s390x the function is not supposed to fail, so it is ok to use
>>>>> a WARN_ON on failure. If we ever need some more finegrained
>>>>> handling we can tackle this when we know the details.   =20
>>>>
>>>> Could you explain a bit why the function can't fail? =20
>>>
>>> the concept of "making accessible" is only to make sure that
>>> accessing the page will not trigger faults or I/O or DMA errors. in
>>> general it does not mean freely accessing the content of the page
>>> in cleartext.=20
>>>
>>> on s390x, protected guest pages can be shared. the guest has to
>>> actively share its pages, and in that case those pages are both
>>> part of the protected VM and freely accessible by the host. =20
>>
>> Oh, that's interesting.
>>
>> It sounds like there are three separate concepts:
>> 1. Protection
>> 2. Sharing
>> 3. Accessibility
>>
>> Protected pages may be shared and the request of the guest.
>> Shared pages' plaintext can be accessed by the host.  For unshared
>> pages, the host can only see ciphertext.
>>
>> I wonder if Documentation/virt/kvm/s390-pv.rst can be beefed up with
>> some of this information.  It seems a bit sparse on this topic.
>=20
> that is definitely something that can be fixed.
>=20
> I will improve the documentation and make sure it properly explains
> all the details of how protected VMs work on s390x.

I'd also definitely appreciate more people looking over that document
and adding things I forgot ;-)

>=20
>> As it stands, if I were modifying generic code, I don't think I'd have=

>> even a chance of getting an arch_make_page_accessible() in the right
>> spot.
>>
>>> in our case "making the page accessible" means: =20
>> ...
>>>  - if the page was not shared, first encrypt it and then make it
>>>    accessible to the host (both operations performed securely and
>>>    atomically by the hardware) =20
>>
>> What happens to the guest's view of the page when this happens?  Does
>> it keep seeing plaintext?
>>
>>> then the page can be swapped out, or used for direct I/O (obviously
>>> if you do I/O on a page that was not shared, you cannot expect good
>>> things to happen, since you basically corrupt the memory of the
>>> guest). =20
>>
>> So why even allow access to the encrypted contents if the host can't
>> do anything useful with it?  Is there some reason for going to the
>> trouble of encrypting it and exposing it to the host?
>=20
> you should not overwrite it, but you can/should write it out verbatim,
> e.g. for swap
>=20
>>> on s390x performing I/O directly on protected pages results in (in
>>> practice) unrecoverable I/O errors, so we want to avoid it at all
>>> costs. =20
>>
>> This is understandable, but we usually steer I/O operations in places
>> like the DMA API, not in the core VM.
>>
>> We *have* the concept of pages to which I/O can't be done.  There are
>> plenty of crippled devices where we have to bounce data into a low
>> buffer before it can go where we really want it to.  I think the AMD
>> SEV patches do this, for instance.
>>
>>> accessing protected pages from the CPU triggers an exception that
>>> can be handled (and we do handle it, in fact)
>>>
>>> now imagine a buggy or malicious qemu process crashing the whole
>>> machine just because it did I/O to/from a protected page. we
>>> clearly don't want that. =20
>>
>> Is DMA disallowed to *all* protected pages?  Even pages which the
>> guest has explicitly shared with the host?
>>
>>
>>>>> @@ -2807,6 +2807,13 @@ int __test_set_page_writeback(struct page
>>>>> *page, bool keep_write) inc_zone_page_state(page,
>>>>> NR_ZONE_WRITE_PENDING); }
>>>>>  	unlock_page_memcg(page);
>>>>> +	access_ret =3D arch_make_page_accessible(page);
>>>>> +	/*
>>>>> +	 * If writeback has been triggered on a page that cannot
>>>>> be made
>>>>> +	 * accessible, it is too late to recover here.
>>>>> +	 */
>>>>> +	VM_BUG_ON_PAGE(access_ret !=3D 0, page);
>>>>> +
>>>>>  	return ret;
>>>>> =20
>>>>>  }   =20
>>>>
>>>> This seems like a really odd place to do this.  Writeback is
>>>> specific to block I/O.  I would have thought there were other
>>>> kinds of devices that matter, not just block devices. =20
>>>
>>> well, yes and no. for writeback (block I/O and swap) this is the
>>> right place. at this point we know that the page is present and
>>> nobody else has started doing I/O yet, and I/O will happen
>>> soon-ish. so we make the page accessible. there is no turning back
>>> here, unlike pinning. we are not allowed to fail, we can't  =20
>>
>> This description sounds really incomplete to me.
>>
>> Not all swap involved device I/O.  For instance, zswap doesn't involve=

>> any devices.  Would zswap need this hook?
>=20
> please feel free to write to me privately if you have any further
> questions or doubts :)
>=20
>=20
> best regards,
>=20
> Claudio Imbrenda
>=20



--bynVyiNEgR8wsJ3XDMDD8KjfApXPH52u2--

--P4mBed8k4peDWIX8tgyLce74tUHYggYbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6W8nkACgkQ41TmuOI4
ufjQrhAApTm5ET47E8CZVBCVdlO7moJz84Tv7YykLGxWrhn2Pyd4AB19nt0lSTgn
HBDhKhosoktkLEmwOxS2xNrtzP7KnMvIqNeuCdXbZduJDE5DKnc/mZf75/sv2gHz
rDzuwmqAPnb7D3rkml/t5O4cO/39/MhbH+cBm0UEEpcvvem05kkKXaAqFocuGk1I
3mD9i7Vh7lM0gHBY7bLYuBk5JnUmLGfk/SH4efdRw5uXzBXkRYIn7juBj4WWucBC
jS0iyrDAtBdf6TYMx2PUEJJTiIvCkecNkwd+wBUQz+nUgpQOPsi4HlGLq/rOloKL
7W16V5cQRuIALx0y5choFuKryAcv6zl/Sa6pn543wvc3Z8cIxFgKR4AP+su47cxC
QJEwVyKsNvl3rcR+15xl7mr0VGv6LuC8+aapDuChACeoRcUPxdw3FeTfN1RvrWZf
xbcnac0DN4oRCeboCiEdUJ280C7ApN/SvJPfXUKPGk3fMRSE9ganF4EdfoqfThkm
gQY/+qXlT9e7bc70X7Cz3pWxC+Hq9VxrLLrWeBXpEtS04fTEtu9D8LmiG/l727Wg
T/b9oyDkCYZSct/+q/vp0kD2NBxKr/9bRfvJ2U9ytxGmDHwRIU36qQajdpVfqD7k
RP0+eLOFqZ/1Ml1xwFMRpPs0OchC+EkTZEZQyd90AeiBnnO9k0Y=
=KK2k
-----END PGP SIGNATURE-----

--P4mBed8k4peDWIX8tgyLce74tUHYggYbe--
