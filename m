From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 06 Aug 2018 14:19:53 +0000
Subject: Re: [GIT PULL 00/19] KVM: s390: Features for 4.19
Message-Id: <740fb5de-19ee-7f46-b7fb-2076a8d2bcfe@linux.ibm.com>
In-Reply-To: <9eb77600-0a43-6ea0-36b8-6355b49b3b9b@linux.ibm.com>
References: <9eb77600-0a43-6ea0-36b8-6355b49b3b9b@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--boPq62pztW6f3LddZ4TVEB0unuyfaLd2Q"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--boPq62pztW6f3LddZ4TVEB0unuyfaLd2Q
Content-Type: multipart/mixed; boundary="CQVJlKcjvlPu3JKLny0ws3pWJBl2OnVga";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini@vger.kernel.org, kvm@vger.kernel.org
 <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <740fb5de-19ee-7f46-b7fb-2076a8d2bcfe@linux.ibm.com>
Subject: Re: [GIT PULL 00/19] KVM: s390: Features for 4.19
References: <20180731084405.28953-1-borntraeger@de.ibm.com>
 <bbadcdad-482e-c9a8-15fd-d7c8cde6a093@redhat.com>
 <c9703b12-9e68-c06a-72b1-3a6f70ae9b13@redhat.com>
 <4a3e1952-6404-83ed-6bfc-b4e09218bbaa@redhat.com>
 <9eb77600-0a43-6ea0-36b8-6355b49b3b9b@linux.ibm.com>
 <e5fcfe81-33ed-81de-10f8-44a2d2e8417d@redhat.com>
In-Reply-To: <e5fcfe81-33ed-81de-10f8-44a2d2e8417d@redhat.com>

--CQVJlKcjvlPu3JKLny0ws3pWJBl2OnVga
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.08.2018 16:01, David Hildenbrand wrote:
> On 06.08.2018 15:47, Janosch Frank wrote:
>> On 06.08.2018 13:59, David Hildenbrand wrote:
>>> On 06.08.2018 13:50, Paolo Bonzini wrote:
>>>> On 06/08/2018 12:17, David Hildenbrand wrote:
>>>>> Hi,
>>>>>
>>>>> We had an internal discussion and some Daniel (cc) wondered if we s=
hould
>>>>> drop the hpage module parameter and instead glue this to the nested=

>>>>> parameter.
>>>>>
>>>>> E.g. nested=3D1 -> hpage cannot be enabled for a VM
>>>>>      nested=3D0 -> hpage can be enabled for a VM
>>>>>
>>>>> Are we ready to expose this feature as default to all VMs? Opinions=
?
>>>>>
>>>>> This means that nested=3D0 (default) environments will get hpage su=
pport
>>>>> and hpage support cannot be disabled by an admin.
>>>>>
>>>>> Benefit is that necessary setup to use huge pages is limited.
>>>>> Downside is, that this is somewhat hidden behind another parameter =
and
>>>>> cannot be disabled.
>>>>
>>>> Regarding nested I agree with Daniel.  However, until dirty page log=
ging
>>>> works at 4kb granularity (by the way---is it the actual KVM dirty pa=
ge
>>>> logging, or storage keys, or both?), I think it's best to keep the
>>>> module parameter.
>>>
>>> storage keys are right now not dirty tracked (there is no iterator mo=
del
>>> for it in QEMU yet, but there were plans to support it - we could use=

>>> ordinary dirty tracking for it - pages that are marked dirty either h=
ave
>>> dirty page content or dirty storage keys - but it would require some
>>> changes).
>>
>> An iterative approach to skey retrieval, and hence skey dirty tracking=
,
>> would only gain us something for really big guests that use keys
>> excessively, right?
>=20
> We migrate them right now as one blob in QEMU (write_keys()) , so an
> iterative approach would allow us to migrate them while the source side=

> is still running (and not while it has to be stopped).
>=20
> We have 8bit/1byte for 4k. So it is 1/4096 of guest memory. A 4TB guest=

> with storage keys touched (or touched by some nested guest!) would
> transfer 1GB of storage keys.
>=20
> But we migrate them only if the guest made use of them, which is alread=
y
> a pretty good optimization for recent guests.

A simple yes would have sufficed :-) Also I think we currently do not
filter out 0 keys, which might be a lower hanging fruit to optimize and
might open up the user space/kernel interface for implementing iterative
migration later on.

But when looking at the stages that cmma migration went through and the
fact that we don't want to use skeys at all it once again boils down to
the statement of my last mail:

>=20
>>
>> That's currently not a scenario we optimize for, as Linux dropped skey=

>> usage a while ago and is the only OS we run as a KVM VM.
>>
>>>
>>> So it KVM dirty page logging that is done on a 1MB basis for now. To
>>> track pages dirty on 4k granularity, we'll have to create fake page
>>> tables ("split") just like x86 for huge pages and write-protect all P=
MD
>>> entries when dirty tracking is enabled (via memslot). Also, these fak=
e
>>> page tables will be required to get proper nested virtualization supp=
ort
>>> running.
>>>
>>> We decided to postpone this complexity and get the basic running and
>>> upstream first.
>>>
>>> I would also vote for the parameter until we are sure that everything=
 is
>>> working as expected (4k dirty tracking, vsie support, some more testi=
ng ...)
>>
>> For now the parameter will stay until we fix all of that. The previous=

>> mm code was very optimized for 4k and PGSTEs and even there I found
>> mistakes, so I don't want a user to be easily able to run a hp VM
>> without opting in first.
>>
>> I might need to extend the documentation a bit, to list all
>> peculiarities of the current implementation.
>>
>=20
> Agreed.
>=20



--CQVJlKcjvlPu3JKLny0ws3pWJBl2OnVga--

--boPq62pztW6f3LddZ4TVEB0unuyfaLd2Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbaFkJAAoJEBcO/8Q8ZEV5VvcQAJKCnF7HsqiW1niABfIxCRvI
2d2B7ywJWp/bRB7IRQCw19T6h/w6mbhQYTNBnMYihP8dylZdkSiS9SN/VMMU5HLS
aW/QaJq+edEx364mp23dWQiaGkxDtnFU0XwTUE6BvVP4ShyNMZBO3tUeuv5bY5FA
VixISIRCBO12rQM6JB/f7pgmNJIGcc170LzIvlfmj9jdxhRKHvCNT2bC6xoLddB6
gqGHQvsTsKoOtfUkRVgz3VozYNW8G9j0/DaaCWp4Ii4qSxUJQshtrHKoFsP1/L1K
td5eEuI09iuJYY9vaigW7KwSPx3VKuCv94Hkvz+sxr/IHWcsJBxGK+meBCB1Sckv
D17XJqhr+nfCUGvj6eTqsQPOjIjFDmmR3EAs/aA+ephM7ivW0Qw8AZrDaPFbltpn
ZSAHtkxCqwOju93CDqO5dMSlpmXb+bQBJlyiZPswiFYeyISoU7YflnZeWO/hunJK
9etqbIlFQApM2NswMOBqthnuBMVJhFiumLt7zOIsE4dgH5ztIlm9niDOqikziMvt
F6FVKy5v3ag01DTf5ef2TFlIMbsw51iYgWK+GLzGP2y46/Rj+426ZfVHqzjgJw1Q
KbtlcGDIJlO1q0WQAzfRWgdTrCPDdZC4VkFlTLOOP60p8tNiONfHDu5Q1o0yeuX6
MNzk76AiTeJdOE1mUBfQ
=esd8
-----END PGP SIGNATURE-----

--boPq62pztW6f3LddZ4TVEB0unuyfaLd2Q--
