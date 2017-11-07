From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
Date: Tue, 7 Nov 2017 11:53:38 +0100
Message-ID: <ff27b699-86c3-3af5-99a1-e4a4f189475a@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
 <20171107110728.6e56d33d.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lCCv0RqgJClC04XQSs9mOnPFst9KP9XXR"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171107110728.6e56d33d.cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCCv0RqgJClC04XQSs9mOnPFst9KP9XXR
Content-Type: multipart/mixed; boundary="6ArfOjfsRIVlOXIP7HdNIb5XEWFmeK9dA";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com,
 david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <ff27b699-86c3-3af5-99a1-e4a4f189475a@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
 <20171107110728.6e56d33d.cohuck@redhat.com>
In-Reply-To: <20171107110728.6e56d33d.cohuck@redhat.com>

--6ArfOjfsRIVlOXIP7HdNIb5XEWFmeK9dA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.2017 11:07, Cornelia Huck wrote:
> On Mon,  6 Nov 2017 23:29:59 +0100
> Janosch Frank <frankja@linux.vnet.ibm.com> wrote:
>=20
>> KVM huge page backing support can not be easily tested under
>> s390. Currently testing is only possible after most of the guest has
>> already been set up.
>>
>> To indicate, that KVM has huge page backing support, we add the
>> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
>> huge pages are supported.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/kvm.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 8388875..2cd359a 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -930,6 +930,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_SMT_POSSIBLE 147
>>  #define KVM_CAP_HYPERV_SYNIC2 148
>>  #define KVM_CAP_HYPERV_VP_INDEX 149
>> +#define KVM_CAP_S390_HPAGE 150
>> =20
>>  #ifdef KVM_CAP_IRQ_ROUTING
>> =20
>=20
> Not looking into the rest of this patch set (for fear of my sanity :),
> but I think this needs to be documented in
> Documentation/virtual/kvm/api.txt.

I'll add it right away, before I forget it :)
Thanks for looking and risking your sanity.



--6ArfOjfsRIVlOXIP7HdNIb5XEWFmeK9dA--

--lCCv0RqgJClC04XQSs9mOnPFst9KP9XXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAZDJAAoJEBcO/8Q8ZEV50UgP/2rZefBVUX088SK1ZWej76kk
KZek4OFFrCyvgDhiea2NZuQ19tNVKStZh8Oiu0qLhfr0Z3ErFIhjebn+62TmincZ
vwbqnvg65JcbBuroMX52N9QQH+r/uOvIpIP6xrZfoKU7/RbYk6rj957nYhPQ/v0A
3WlLpvBnZivm9pdiOCjOIx3pCMm8LMfdD/wSRu4+IOVFOyRzqkw4xdg71emVYIZ3
b+9wzGRGWIe+fD9Mhh8h+bMFIwdaCdoPCflYIFv38qLCao+jyTyKNDCSd45n61RV
l+Z8QwAA9Zoe+D5wE2SUPYYVBJpLr8DPnQZo9mvgFlfBzUIVb/CzTzUBJ+FHKuBZ
m6RWhPULKlZ6vMw85+MI9aGTdzwE0nODLBIAjoH/TANFovEZ8rado/2qJtccfffj
X2p28lqEnUd+Z09cMozhkxBZaFCkxmzCjzUMwJmZI8XZGBS/Ti9S7e6ffx5UPCAt
AfE1zEKfhS+wvd3skZGMReIgdqiWa/IRmkLbbuSR7ACNBhsQ2AVyB1tb0Dj5zP9q
FeIYp1sHWoXJV9Ux4jQG6rjIXt0xtcAWPpHWOx498BYVWRQb2TiGtnk131ak/YCP
vy6XOneUlzuGhoPIMWPZdhAHXTCjXU+hC7PHDYd6OQOYmLY7pS6FfQEp4AaEILMR
opjO39/JWRp4LEVbkrPZ
=VurI
-----END PGP SIGNATURE-----

--lCCv0RqgJClC04XQSs9mOnPFst9KP9XXR--
