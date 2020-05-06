Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbgEFODy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 10:03:54 -0400
Subject: Re: [kvm-unit-tests RFC] s390x: Add Protected VM support
References: <20200506124636.21876-1-mhartmay@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <ad0d5c9d-bde2-2143-0440-d47d6e28bb29@linux.ibm.com>
Date: Wed, 6 May 2020 16:03:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200506124636.21876-1-mhartmay@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jZut8F33B4APfBdtVC0v4hTbISFH8KYqm"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jZut8F33B4APfBdtVC0v4hTbISFH8KYqm
Content-Type: multipart/mixed; boundary="4hBbH78mIQ1Qsi4w7wHYYnvkZXsvYfagY"

--4hBbH78mIQ1Qsi4w7wHYYnvkZXsvYfagY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/6/20 2:46 PM, Marc Hartmayer wrote:
> Add support for Protected Virtual Machine (PVM) tests. For starting a
> PVM guest we must be able to generate a PVM image by using the
> `genprotimg` tool from the s390-tools collection. This requires the
> ability to pass a machine-specific host-key document, so the option
> `--host-key-document` is added to the configure script.
>=20
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  .gitignore          |  1 +
>  configure           |  8 ++++++++
>  s390x/Makefile      | 16 +++++++++++++---
>  s390x/unittests.cfg | 20 ++++++++++++++++++++
>  scripts/common.bash | 30 +++++++++++++++++++++++++++++-
>  5 files changed, 71 insertions(+), 4 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 784cb2ddbcb8..1fa5c0c0ea76 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -4,6 +4,7 @@
>  *.o
>  *.flat
>  *.elf
> +*.img
>  .pc
>  patches
>  .stgit-*
> diff --git a/configure b/configure
> index 5d2cd90cd180..29191f4b0994 100755
> --- a/configure
> +++ b/configure
> @@ -18,6 +18,7 @@ u32_long=3D
>  vmm=3D"qemu"
>  errata_force=3D0
>  erratatxt=3D"errata.txt"
> +host_key_document=3D
> =20
>  usage() {
>      cat <<-EOF
> @@ -40,6 +41,8 @@ usage() {
>  	                           no environ is provided by the user (enable=
d by default)
>  	    --erratatxt=3DFILE       specify a file to use instead of errata.=
txt. Use
>  	                           '--erratatxt=3D' to ensure no file is used=
=2E
> +	    --host-key-document=3DHOST_KEY_DOCUMENT
> +	                           host-key-document to use (s390x only)
>  EOF
>      exit 1
>  }
> @@ -91,6 +94,9 @@ while [[ "$1" =3D -* ]]; do
>  	--erratatxt)
>  	    erratatxt=3D"$arg"
>  	    ;;
> +	--host-key-document)
> +	    host_key_document=3D"$arg"
> +	    ;;
>  	--help)
>  	    usage
>  	    ;;
> @@ -207,6 +213,8 @@ PRETTY_PRINT_STACKS=3D$pretty_print_stacks
>  ENVIRON_DEFAULT=3D$environ_default
>  ERRATATXT=3D$erratatxt
>  U32_LONG_FMT=3D$u32_long
> +GENPROTIMG=3Dgenprotimg
> +HOST_KEY_DOCUMENT=3D$host_key_document
>  EOF
> =20
>  cat <<EOF > lib/config.h
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ddb4b48ecbf9..a57655dcce10 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -17,12 +17,19 @@ tests +=3D $(TEST_DIR)/stsi.elf
>  tests +=3D $(TEST_DIR)/skrf.elf
>  tests +=3D $(TEST_DIR)/smp.elf
>  tests +=3D $(TEST_DIR)/sclp.elf
> -tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
> =20
> -all: directories test_cases test_cases_binary
> +tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
> +ifneq ($(HOST_KEY_DOCUMENT),)
> +tests_pv_img =3D $(patsubst %.elf,%.pv.img,$(tests))
> +else
> +tests_pv_img =3D
> +endif
> +
> +all: directories test_cases test_cases_binary test_cases_pv
> =20
>  test_cases: $(tests)
>  test_cases_binary: $(tests_binary)
> +test_cases_pv: $(tests_pv_img)
> =20
>  CFLAGS +=3D -std=3Dgnu99
>  CFLAGS +=3D -ffreestanding
> @@ -68,8 +75,11 @@ FLATLIBS =3D $(libcflat)
>  %.bin: %.elf
>  	$(OBJCOPY) -O binary  $< $@
> =20
> +%.pv.img: %.bin $(HOST_KEY_DOCUMENT)
> +	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --=
image $< -o $@
> +
>  arch_clean: asm_offsets_clean
> -	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
> +	$(RM) $(TEST_DIR)/*.{o,elf,bin,img} $(TEST_DIR)/.*.d lib/s390x/.*.d
> =20
>  generated-files =3D $(asm-offsets)
>  $(tests:.elf=3D.o) $(cstart.o) $(cflatobjs): $(generated-files)
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index b307329354f6..6beaca45fb20 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -16,6 +16,8 @@
>  #			 # a test. The check line can contain multiple files
>  #			 # to check separated by a space but each check
>  #			 # parameter needs to be of the form <path>=3D<value>
> +# pv_support =3D 0|1       # Optionally specify whether a test support=
s the
> +#                        # execution as a PV guest.
>  ######################################################################=
########
> =20
>  [selftest-setup]
> @@ -25,62 +27,80 @@ extra_params =3D -append 'test 123'
> =20
>  [intercept]
>  file =3D intercept.elf
> +pv_support =3D 1

So, let's do this discussion once more:
Why would we need a opt-in for something which works on all our current
tests? I'd much rather have a opt-out or just a bail-out when running
the test like I already implemented for the storage key related tests...

I don't see any benefit for this right now other than forcing me to add
another line to this file that was not needed before..


--4hBbH78mIQ1Qsi4w7wHYYnvkZXsvYfagY--

--jZut8F33B4APfBdtVC0v4hTbISFH8KYqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6yw6wACgkQ41TmuOI4
ufhhERAAkTUnnUrCGEoa3BVcyMZVYPXyGcAmolczB8cGHjwutwO/z1wJd7vtCp/k
b+F0ijNkWtWneYvYg+ONQRMbHFYhvVtUTdXE2LjPK16LlaDMh++Mra7+UpaPXws7
GgeRJohAtlcfaYLgqQkkzRki1XJS01P2meGBfithejYNaehGEi4rLB/9opJ1olsX
pgdqthBbSvqAR83tGBWiafzodndpRBsdfcfEnoR+TYV5z3ZJ94AkIcw8cF2jT7se
RKmRkX2FTt6/3I9RgH4Qh5JBb4ADm0mSr0k0aoDZ/mLePvXEsYPZ7H/4dWgwEaYx
a3YPXLPcSbD0/Moq3dIimx3CnCNrbyulCoDNfamVZOYGdYMcAUSFmRFNWxfULYu2
8dLcuKQ+o82/gALuS1FSSp+dv772YplpZTP8vPYlXsn6dnmyozFRZFXItu1mc9TE
xXCz01pVcOfNVC+gt0v0DDCR1pRiokrih4akGCJN+QCPwc9q7gKyCGXaUOD+tFAI
9CVI4s6PysOrebCjXN433wt+/qKDhfEE/f49qrRs0qwnX4/0cO4v2Q/tYwrC54d9
VYTmcUMk5Irrbrjl8DJib7Jeycy1Asq3dhsZuz51W+A9e8LZQJDWTWotuVm9H3R8
TjzcV4h1TJIvZT3btRqB01wFKWYpP1jhIawGhFHjgHcPT7d72rg=
=MmXm
-----END PGP SIGNATURE-----

--jZut8F33B4APfBdtVC0v4hTbISFH8KYqm--
