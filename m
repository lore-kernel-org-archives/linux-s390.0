From: Thomas Huth <thuth@redhat.com>
Date: Tue, 18 Dec 2018 12:17:02 +0000
Subject: Re: [kvm-unit-tests PATCH v3 04/13] s390x: Switch to z/Arch if needed
Message-Id: <cfb8cd65-194d-43a1-0658-c7d6a1f03ddf@redhat.com>
In-Reply-To: <73e6da55-b5a8-4727-2d2b-cdfd2156ac93@linux.ibm.com>
References: <73e6da55-b5a8-4727-2d2b-cdfd2156ac93@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--8RE8lhFmdlZtUWO2mtFPW1aqCXvPuGTDA"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RE8lhFmdlZtUWO2mtFPW1aqCXvPuGTDA
Content-Type: multipart/mixed; boundary="SzOKycOzM0NVLtg4oWWJREn3tDKIXrQY4";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <cfb8cd65-194d-43a1-0658-c7d6a1f03ddf@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 04/13] s390x: Switch to z/Arch if needed
References: <20181218092657.46466-1-frankja@linux.ibm.com>
 <20181218092657.46466-5-frankja@linux.ibm.com>
 <cc3ceaae-2f36-ac21-7677-2efe30471722@redhat.com>
 <73e6da55-b5a8-4727-2d2b-cdfd2156ac93@linux.ibm.com>
In-Reply-To: <73e6da55-b5a8-4727-2d2b-cdfd2156ac93@linux.ibm.com>

--SzOKycOzM0NVLtg4oWWJREn3tDKIXrQY4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-12-18 12:45, Janosch Frank wrote:
> On 18.12.18 11:04, Thomas Huth wrote:
>> On 2018-12-18 10:26, Janosch Frank wrote:
>>> LPAR and z/VM start in esam mode depending on the hardware, so we nee=
d
>>> to switch to z/Arch and set 64 bit addressing.
>>>
>>> Under Qemu/KVM we already start out with both when being run with the=

>>> Qemu --kernel argument or we lack 64 bit when booting from disk
>>> because of the initial psw specifying 31 bit for z/VM and lpar
>>> compatibility.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  s390x/cstart64.S | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>> index d382497..7886f35 100644
>>> --- a/s390x/cstart64.S
>>> +++ b/s390x/cstart64.S
>>> @@ -20,9 +20,17 @@
>>>   *
>>>   * For KVM and TCG kernel boot we are in 64 bit z/Arch mode.
>>>   * When booting from disk the initial short psw is in 31 bit mode.
>>> + * When running under LPAR or z/VM, we might start in 31 bit and esa=
m mode.
>>>   */
>>>  	.globl start
>>>  start:
>>> +	/* Switch to z/Architecture mode and 64-bit */
>>> +	slr     %r0, %r0		# Set cpuid to zero
>>> +	lhi     %r1, 2			# mode 2 =3D esame
>>> +	sigp    %r1, %r0, 0x12		# sigp set arch
>>> +	bras	%r13,0f			# Jump over zero area
>>> +	.fill	16,4,0x0		# Zero area for lmh
>>> +0:	lmh	%r0,%r15,0(%r13)	# Clear high-order half of gprs
>>
>> Do we really want to keep the lmh here? ... yes, I know the kernel is
>> doing this, too, but I really fail to see why we would need it in the
>> kvm-unit-tests, too... have you tried it also without this clearing?
>=20
> I think I had it without that for a few days.
> What's your reasoning against it?

It just looks weird this way. Like we wanted to execute some 32-bit code
in 64-bit mode afterwards, but we don't do that.

> We loose more cycles when clearing BSS
> under KVM where it's empty anyway. I'd rather expand it to a lm, to
> really have a fresh start.

Fine for me, just add a comment like that ("Clear all registers to make
sure that we have a well-defined fresh start" or so).

I think I'd also rather write this as:

	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	 xgr \i,\i
	.endr

=2E.. since that takes a little bit less space.

 Thomas


--SzOKycOzM0NVLtg4oWWJREn3tDKIXrQY4--

--8RE8lhFmdlZtUWO2mtFPW1aqCXvPuGTDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcGOVGAAoJEC7Z13T+cC21E0gQAIZEOFd3C9kQ+6AexjDvJn2X
JyEZcIFGb9oNypmVOkzIpTpBPd2ckcAT1N0Yy3GEQbLiivQZwswBEgzxGVuOl+7p
kxqI6I/yhI9jNkdQZqzzFFf1adF3tkLtekSjsxeD14bszIPL6MQng+Uv1KqfhGDV
8SLfuTfePWcSImNWawqJTEvERNaN/GcsZQA1+33qoB88d0r19sIkA8ZQZPNwMp/V
utmnUFXyhxlJRlRAN1tUGtUd6jwsKfE/SpCdWpB8f8QG4vWcOxzUZK4KxOG0vmY9
//QvBVsqfWTUv2SWlREClV99b3ImfhD8mDVRhI0M7jEnBPJI4liu8p3r8t3euHxA
5/Thkr0EWA+XCOkU+1OEEejxqWyNitdvg8Z+/ehWVDns1E5NRqOtOCUAwExaCvRN
sG01r/UPa9HXwlxTfh6tASamYX3j29NWqVH2uvVczyMJ/RA69TFctvju7xL0VnMx
WGpjY+l0WBMPzqCLyTu+3K0enY12myycTA6CbiCgjcQNQcyjQQr0QHfaenkX+RUB
tGzG//Gfc9rXW45mAWk5tsDngW/rvB4J2Vq0oj8CSzgo1HdiK/0+yWSEw8fus/AX
Kv8ZiC8r5pBITPvfiWr57knbDwru6AgA3hBow3uN1CChVPlu++CoAzHmKbJ9fkZt
hBEVOBBJUCvH/KhMhwaP
=29e5
-----END PGP SIGNATURE-----

--8RE8lhFmdlZtUWO2mtFPW1aqCXvPuGTDA--
