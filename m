From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 12:29:37 +0000
Subject: Re: [kvm-unit-tests PATCH v3 09/13] s390x: Add binary generation to makefile
Message-Id: <48821091-d3d6-1ba8-e9fd-193721d8d7ba@linux.ibm.com>
In-Reply-To: <e400840b-0520-e491-52bc-6a0e2a4765a0@redhat.com>
References: <e400840b-0520-e491-52bc-6a0e2a4765a0@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--v5SaYin5vWl4oKl89CHp8F9y4z6MBCCbE"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v5SaYin5vWl4oKl89CHp8F9y4z6MBCCbE
Content-Type: multipart/mixed; boundary="BAH37VU9uX0R7LSLbL7GsFGEtzJmBxkI8";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <48821091-d3d6-1ba8-e9fd-193721d8d7ba@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 09/13] s390x: Add binary generation to
 makefile
References: <20181218092657.46466-1-frankja@linux.ibm.com>
 <20181218092657.46466-10-frankja@linux.ibm.com>
 <66a316ed-7b61-caaf-a889-27a462c10eaf@redhat.com>
In-Reply-To: <66a316ed-7b61-caaf-a889-27a462c10eaf@redhat.com>

--BAH37VU9uX0R7LSLbL7GsFGEtzJmBxkI8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.12.18 12:24, David Hildenbrand wrote:
> On 18.12.18 10:26, Janosch Frank wrote:
>> make bin will now generate binaries that can be booted from this or as=

>> a non ELF kernel boot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index ede2961..eaad18c 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -10,9 +10,11 @@ tests +=3D $(TEST_DIR)/cmm.elf
>>  tests +=3D $(TEST_DIR)/vector.elf
>>  tests +=3D $(TEST_DIR)/gs.elf
>>  tests +=3D $(TEST_DIR)/iep.elf
>> +test_bins =3D $(patsubst %.elf,%.bin,$(tests))
>> =20
>>  all: directories test_cases
>> =20
>> +bin: $(test_bins)
>>  test_cases: $(tests)
>=20
> Maybe a different naming and build it along with "all" ?

Are you sure you want it in "all", the default is KVM elf boot after all?=


>=20
> tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>=20
> all: directories test_cases test_cases_binary
>=20
> test_cases_binary: $(tests_binary)
>=20

Sure, fixed the naming

>> =20
>>  CFLAGS +=3D -std=3Dgnu99
>> @@ -55,8 +57,11 @@ FLATLIBS =3D $(libcflat)
>>  	$(RM) $(@:.elf=3D.aux.o)
>>  	@chmod a-x $@
>> =20
>> +%.bin: %.elf
>> +	objcopy -O binary  $< $@
>> +
>>  arch_clean: asm_offsets_clean
>> -	$(RM) $(TEST_DIR)/*.{o,elf} $(TEST_DIR)/.*.d lib/s390x/.*.d
>> +	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
>> =20
>>  generated-files =3D $(asm-offsets)
>>  $(tests:.elf=3D.o) $(cstart.o) $(cflatobjs): $(generated-files)
>>
>=20
>=20



--BAH37VU9uX0R7LSLbL7GsFGEtzJmBxkI8--

--v5SaYin5vWl4oKl89CHp8F9y4z6MBCCbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcGOgxAAoJEONU5rjiOLn4w7oP/3fDtuHAz4vgW5fCNOnRW0ZT
+dNtV3IsphLXrp8kNxyB+JMNQkIXEpX5pXPSmrGoCBrdKiEotPmLqxTA/7rE/FJ9
z8pQFymnG5N6Hok0i3QAUDy19SOqMAOwmyCRcB8EHCtV4L1Ywx7yGq7SM/26nGtS
Oev0YPInGUKa7BRAiWbs8V1+vWsKH5eEdoMl6UYvpO5rYzTvrPKBTMyozgA4teZ1
CyXiM/25iqw+ykJ83e5jq8LaDc4Nr18wAsBBKlMqPOPNBo/XW9zI4W7gBgt4d7xE
OiwxkhCriOuMYtLh+Df7Dg61aNjpxLIX9VqQIT1yOjLjpjnP8JUV++qA6YMsfY0g
8QUPhe7NCYQwYZpx5xkZ40ckjQRTLsdUG4QogM3nF1WH9T0un/kfyNOn2TaOydxo
cvZGE21twqPg1ONE2etFgBX53CoeArewQW6ZXNmATZF0GpBGEH2NQd/Wg9Py0N9v
Fk/cRDlBbHvmdNeGnEQZGlDzbV860r4gwHdPcFPUW/m5Mwg4S+w7vaaiJQSovcTs
ULcmW7vIm3czoNKw03m9z8Oc9WlTBWudHCneyYBPqmhDH4uHKPH/WtRtD4J7LYvG
cqsH53dTNa+ZAfrPYQMVdnAIkELPQynGXwoHCxIGsLAGALH5wl4LstpFbYMu+GEF
U5SY4gqkloEaw8XeQqRh
=dOyY
-----END PGP SIGNATURE-----

--v5SaYin5vWl4oKl89CHp8F9y4z6MBCCbE--
