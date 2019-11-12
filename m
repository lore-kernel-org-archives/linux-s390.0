Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfKLOik (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 09:38:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACEcPQC009401
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 09:38:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7w2jmj8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 09:38:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 12 Nov 2019 14:38:34 -0000
Subject: Re: [RFC 01/37] DOCUMENTATION: protvirt: Protected virtual machine
 introduction
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-2-frankja@linux.ibm.com>
 <20191104151815.6f11a274.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 12 Nov 2019 15:38:28 +0100
MIME-Version: 1.0
In-Reply-To: <20191104151815.6f11a274.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cFb54glxZkpSyYvJMawuK0AVQOlXL9nup"
Message-Id: <d83e9ac1-c211-872c-25b0-183a139bd11e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cFb54glxZkpSyYvJMawuK0AVQOlXL9nup
Content-Type: multipart/mixed; boundary="npGzRwObC5rRZWhNpuPXe8h81aIy10Z5e"

--npGzRwObC5rRZWhNpuPXe8h81aIy10Z5e
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/4/19 3:18 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:23 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Introduction to Protected VMs.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  Documentation/virtual/kvm/s390-pv.txt | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/virtual/kvm/s390-pv.txt
>>
>> diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/vir=
tual/kvm/s390-pv.txt
>> new file mode 100644
>> index 000000000000..86ed95f36759
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/s390-pv.txt
>=20
> This should be under /virt/, I think. Also, maybe start out with RST
> already for new files?
>=20
>> @@ -0,0 +1,23 @@
>> +Ultravisor and Protected VMs
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +Summary:
>> +
>> +Protected VMs (PVM) are KVM VMs, where KVM can't access the VM's stat=
e
>> +like guest memory and guest registers anymore. Instead the PVMs are
>=20
> s/Instead/Instead,/

Fixed

>=20
>> +mostly managed by a new entity called Ultravisor (UV), which provides=

>> +an API, so KVM and the PVM can request management actions.
>=20
> Hm...
>=20
> "The UV provides an API (both for guests and hypervisors), where PVMs
> and KVM can request management actions." ?

I applied your proposal, but removed the part in the brace, as it is
obvious from the words that follow.

>=20
>> +
>> +Each guest starts in the non-protected mode and then transitions into=

>=20
> "and then may make a request to transition into protected mode" ?

Sure

>=20
>> +protected mode. On transition KVM registers the guest and its VCPUs
>> +with the Ultravisor and prepares everything for running it.
>> +
>> +The Ultravisor will secure and decrypt the guest's boot memory
>> +(i.e. kernel/initrd). It will safeguard state changes like VCPU
>> +starts/stops and injected interrupts while the guest is running.
>> +
>> +As access to the guest's state, like the SIE state description is
>=20
> "such as the SIE state description," ?
>=20
>> +normally needed to be able to run a VM, some changes have been made i=
n
>> +SIE behavior and fields have different meaning for a PVM. SIE exits
>> +are minimized as much as possible to improve speed and reduce exposed=

>> +guest state.
>=20



--npGzRwObC5rRZWhNpuPXe8h81aIy10Z5e--

--cFb54glxZkpSyYvJMawuK0AVQOlXL9nup
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3Kw+UACgkQ41TmuOI4
ufh60BAAmp939Ydj/z/C9ZcICBj1gqmNrhV+bHBpSYHP4hUBAsk0q03/5iupb1vE
XFZC9K4I4k2aqOM9h6hE8gJNgrHCOWls3K6e7TxWvxFktZXEfcln1zMVLwCrXA19
POF5AN3C/5Afwp91M7hJxCB5QI4t22haW0yIOe/yUq69/euJIf/sqwB8+wOmSWKG
dZ+uVVK1zYEqSkksCEKTa3pskp5yCqwCjmv5OU9YyXIPI09PfrXLwZ81A1Up6GVV
0hojCtbMovYg9XgmHnMwvBeeGh0NhNeZFt1E9sbMlprw22nMfku7Uq5W87svva3i
bCHHmCByKUhLEmMCKH6OuavqqOvD8pfeAoEFfcmECMq7v+5aE/mMBXx+eMnZKkVk
UboVqPBvU93kfYSK+RWRdDGT6gRqVQ+dUHq6s/4cnIJLXrj9tcw740TNlevT1Jl/
togPmNxV/UJVRa9809wfCLgG6nEoDiPA4wBRqD0BwJPr/LfP1ecLLxgIWrej6jZ6
Ii7JcyBtIidLquihR0IVRFP6a5cXlYdNYLXz71F01w8bXiusqB4p6zo3nlR9IfPq
EHV10C+9qGgoqJfFgmKCoGoDktdPrKtFkVRmwE38VgqCaslE3nDA8+i54qu7L4lj
5qBcORgJoxMYfu3ir5Gij+TVBP4jbxUTAaUYCAfITzs2WlJsM7k=
=InlW
-----END PGP SIGNATURE-----

--cFb54glxZkpSyYvJMawuK0AVQOlXL9nup--
