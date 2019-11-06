Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbfKFRFc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 12:05:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6H5BuI085922
        for <linux-s390@vger.kernel.org>; Wed, 6 Nov 2019 12:05:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41we8vph-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 12:05:31 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 6 Nov 2019 17:05:29 -0000
Subject: Re: [RFC 30/37] DOCUMENTATION: protvirt: Diag 308 IPL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-31-frankja@linux.ibm.com>
 <20191106174855.13a50f42.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 6 Nov 2019 18:05:22 +0100
MIME-Version: 1.0
In-Reply-To: <20191106174855.13a50f42.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UkpeVgq64Ns7zUX2ap7pO00Qotpwdfnwg"
Message-Id: <6dd98dfe-63ce-374c-9b04-00cdeceee905@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UkpeVgq64Ns7zUX2ap7pO00Qotpwdfnwg
Content-Type: multipart/mixed; boundary="0eaqKIZJY7E4vhohX80bisHlpRH7k8C1r"

--0eaqKIZJY7E4vhohX80bisHlpRH7k8C1r
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/6/19 5:48 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:52 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Description of changes that are necessary to move a KVM VM into
>> Protected Virtualization mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  Documentation/virtual/kvm/s390-pv-boot.txt | 62 +++++++++++++++++++++=
+
>>  1 file changed, 62 insertions(+)
>>  create mode 100644 Documentation/virtual/kvm/s390-pv-boot.txt
>>
>> diff --git a/Documentation/virtual/kvm/s390-pv-boot.txt b/Documentatio=
n/virtual/kvm/s390-pv-boot.txt
>> new file mode 100644
>> index 000000000000..af883c928c08
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/s390-pv-boot.txt
>> @@ -0,0 +1,62 @@
>> +Boot/IPL of Protected VMs
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> +
>> +Summary:
>> +
>> +Protected VMs are encrypted while not running. On IPL a small
>> +plaintext bootloader is started which provides information about the
>> +encrypted components and necessary metadata to KVM to decrypt it.
>> +
>> +Based on this data, KVM will make the PV known to the Ultravisor and
>> +instruct it to secure its memory, decrypt the components and verify
>> +the data and address list hashes, to ensure integrity. Afterwards KVM=

>> +can run the PV via SIE which the UV will intercept and execute on
>> +KVM's behalf.
>> +
>> +The switch into PV mode lets us load encrypted guest executables and
>> +data via every available method (network, dasd, scsi, direct kernel,
>> +...) without the need to change the boot process.
>> +
>> +
>> +Diag308:
>> +
>> +This diagnose instruction is the basis vor VM IPL. The VM can set and=

>=20
> s/vor/for/
>=20
>> +retrieve IPL information blocks, that specify the IPL method/devices
>> +and request VM memory and subsystem resets, as well as IPLs.
>> +
>> +For PVs this concept has been continued with new subcodes:
>> +
>> +Subcode 8: Set an IPL Information Block of type 5.
>> +Subcode 9: Store the saved block in guest memory
>> +Subcode 10: Move into Protected Virtualization mode
>> +
>> +The new PV load-device-specific-parameters field specifies all data,
>> +that is necessary to move into PV mode.
>> +
>> +* PV Header origin
>> +* PV Header length
>> +* List of Components composed of:
>> +  * AES-XTS Tweak prefix
>> +  * Origin
>> +  * Size
>> +
>> +The PV header contains the keys and hashes, which the UV will use to
>> +decrypt and verify the PV, as well as control flags and a start PSW.
>> +
>> +The components are for instance an encrypted kernel, kernel cmd and
>> +initrd. The components are decrypted by the UV.
>> +
>> +All non-decrypted data of the non-PV guest instance are zero on first=

>> +access of the PV.
>> +
>> +
>> +When running in a protected mode some subcodes will result in
>> +exceptions or return error codes.
>> +
>> +Subcodes 4 and 7 will result in specification exceptions.
>> +When removing a secure VM, the UV will clear all memory, so we can't
>> +have non-clearing IPL subcodes.
>> +
>> +Subcodes 8, 9, 10 will result in specification exceptions.
>> +Re-IPL into a protected mode is only possible via a detour into non
>> +protected mode.
>=20
> So... what do we IPL from? Is there still a need for the bios?
>=20
> (Sorry, I'm a bit confused here.)
>=20

We load a blob via the bios (all methods are supported) and that blob
moves itself into protected mode. I.e. it has a small unprotected stub,
the rest is an encrypted kernel.


--0eaqKIZJY7E4vhohX80bisHlpRH7k8C1r--

--UkpeVgq64Ns7zUX2ap7pO00Qotpwdfnwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3C/VIACgkQ41TmuOI4
ufjACRAAn4Hi4ahrXID5AM+f3hiLUL//qDnl9PPan5AhmPYoTWGeiZzntLmKGJ6s
n6YAUT5tEWB3z3oCpQuAGs1h+AdNMSv98jYEQ0FweJjQTHKfesa2nqMaLKV8DOaH
rHXLzdGv0lXhdNsgwvH2nFQ5ukTboSjs8NY5BazYDkGl6wfcvaHpjDJcXavalNP/
+YRKSKJVI/XDtLH0PTZlk1oismSx8X+Alh7rteHhfvmvfa6DBRICqi7KYMhIpndV
tlcIqBtBwvDWdFvJi5FNmPvyZVS3flPa7/C8VXEZJAG+cDDfye3hXyfIwpmJqATn
KQ89o/CcekLYcJ0+KESad7+/qwoUjfl+hUJg/qcUSLiwNrWaikHZUUfIGPwk+Eor
zSbdvMw90P5b43hJVWJEKMk8xeUQDMQrmcLR1YQ88T1pvR5+us7XIqR3fOf13khp
HtFbYL/q8PztHlGppTFu8Td+StDEZD9oDulr3Vdr43MSAwulyUQpAYsEj+0Qvgxr
MOupSjJu4RlUevQOCnLyG/nBIiNbOe+0GkWjfaNXBCTMApRWRfCHKiC7+vxqS+0n
7514Ay+FNBSJUdugGQbe60Av3nyy7DoXDwenG44YHdxY6ylRzDWhZ1Wyc6BIeApX
+PiigDuBfCR3DDJ8kqp1HlJbAv6DBt5OXDrK6uM5CrUwyxA1h0o=
=0+ZY
-----END PGP SIGNATURE-----

--UkpeVgq64Ns7zUX2ap7pO00Qotpwdfnwg--
