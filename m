Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbgHSLtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 07:49:46 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 4/4] s390x: add Protected VM support
In-Reply-To: <6bd69c28-12df-f300-9cb2-9da1d80672f1@redhat.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com> <20200818130424.20522-5-mhartmay@linux.ibm.com> <6bd69c28-12df-f300-9cb2-9da1d80672f1@redhat.com>
Date: Wed, 19 Aug 2020 13:49:36 +0200
Message-ID: <87o8n6svn3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Aug 19, 2020 at 12:42 PM +0200, David Hildenbrand <david@redhat.com=
> wrote:
> On 18.08.20 15:04, Marc Hartmayer wrote:
>> Add support for Protected Virtual Machine (PVM) tests. For starting a
>> PVM guest we must be able to generate a PVM image by using the
>> `genprotimg` tool from the s390-tools collection. This requires the
>> ability to pass a machine-specific host-key document, so the option
>> `--host-key-document` is added to the configure script.
>>=20
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  configure               |  9 +++++++++
>>  s390x/Makefile          | 17 +++++++++++++++--
>>  s390x/selftest.parmfile |  1 +
>>  s390x/unittests.cfg     |  1 +
>>  scripts/s390x/func.bash | 35 +++++++++++++++++++++++++++++++++++
>>  5 files changed, 61 insertions(+), 2 deletions(-)
>>  create mode 100644 s390x/selftest.parmfile
>>  create mode 100644 scripts/s390x/func.bash
>>=20
>> diff --git a/configure b/configure
>> index f9d030fd2f03..0e64af58b3c1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -18,6 +18,7 @@ u32_long=3D
>>  vmm=3D"qemu"
>>  errata_force=3D0
>>  erratatxt=3D"$srcdir/errata.txt"
>> +host_key_document=3D
>>=20=20
>>  usage() {
>>      cat <<-EOF
>> @@ -40,6 +41,9 @@ usage() {
>>  	                           no environ is provided by the user (enabled=
 by default)
>>  	    --erratatxt=3DFILE       specify a file to use instead of errata.t=
xt. Use
>>  	                           '--erratatxt=3D' to ensure no file is used.
>> +	    --host-key-document=3DHOST_KEY_DOCUMENT
>> +	                           Specify the machine-specific host-key docum=
ent for creating
>> +	                           a PVM image with 'genprotimg' (s390x only)
>>  EOF
>>      exit 1
>>  }
>> @@ -92,6 +96,9 @@ while [[ "$1" =3D -* ]]; do
>>  	    erratatxt=3D
>>  	    [ "$arg" ] && erratatxt=3D$(eval realpath "$arg")
>>  	    ;;
>> +	--host-key-document)
>> +	    host_key_document=3D"$arg"
>> +	    ;;
>>  	--help)
>>  	    usage
>>  	    ;;
>> @@ -205,6 +212,8 @@ PRETTY_PRINT_STACKS=3D$pretty_print_stacks
>>  ENVIRON_DEFAULT=3D$environ_default
>>  ERRATATXT=3D$erratatxt
>>  U32_LONG_FMT=3D$u32_long
>> +GENPROTIMG=3D${GENPROTIMG-genprotimg}
>> +HOST_KEY_DOCUMENT=3D$host_key_document
>>  EOF
>>=20=20
>>  cat <<EOF > lib/config.h
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index 0f54bf43bfb7..cd4e270952ec 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -18,12 +18,19 @@ tests +=3D $(TEST_DIR)/skrf.elf
>>  tests +=3D $(TEST_DIR)/smp.elf
>>  tests +=3D $(TEST_DIR)/sclp.elf
>>  tests +=3D $(TEST_DIR)/css.elf
>> -tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>>=20=20
>> -all: directories test_cases test_cases_binary
>> +tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>> +ifneq ($(HOST_KEY_DOCUMENT),)
>> +tests_pv_binary =3D $(patsubst %.bin,%.pv.bin,$(tests_binary))
>> +else
>> +tests_pv_binary =3D
>> +endif
>> +
>> +all: directories test_cases test_cases_binary test_cases_pv
>>=20=20
>>  test_cases: $(tests)
>>  test_cases_binary: $(tests_binary)
>> +test_cases_pv: $(tests_pv_binary)
>>=20=20
>>  CFLAGS +=3D -std=3Dgnu99
>>  CFLAGS +=3D -ffreestanding
>> @@ -72,6 +79,12 @@ FLATLIBS =3D $(libcflat)
>>  %.bin: %.elf
>>  	$(OBJCOPY) -O binary  $< $@
>>=20=20
>> +%selftest.pv.bin: %selftest.bin $(HOST_KEY_DOCUMENT) $(patsubst %.pv.bi=
n,%.parmfile,$@)
>> +	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --parmfile $(pa=
tsubst %.pv.bin,%.parmfile,$@) --no-verify --image $< -o $@
>> +
>> +%.pv.bin: %.bin $(HOST_KEY_DOCUMENT)
>> +	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --i=
mage $< -o $@
>> +
>>  arch_clean: asm_offsets_clean
>>  	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
>>=20=20
>> diff --git a/s390x/selftest.parmfile b/s390x/selftest.parmfile
>> new file mode 100644
>> index 000000000000..5613931aa5c6
>> --- /dev/null
>> +++ b/s390x/selftest.parmfile
>> @@ -0,0 +1 @@
>> +test 123
>> \ No newline at end of file
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index 0f156afbe741..12f6fb613995 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -21,6 +21,7 @@
>>  [selftest-setup]
>>  file =3D selftest.elf
>>  groups =3D selftest
>> +# please keep the kernel cmdline in sync with $(TEST_DIR)/selftest.parm=
file
>>  extra_params =3D -append 'test 123'
>
> This is ugly, can't we somehow create the parmfiles dynamically?

An alternative would be to parse the unittests.cfg (and the
extra_params) in the Makefile. Not sure it's worth the effort.

>
>>=20=20
>>  [intercept]
>> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
>> new file mode 100644
>> index 000000000000..b2d59d0d6f25
>> --- /dev/null
>> +++ b/scripts/s390x/func.bash
>> @@ -0,0 +1,35 @@
>> +# The file scripts/common.bash has to be the only file sourcing this
>> +# arch helper file
>> +source config.mak
>> +
>> +ARCH_CMD=3Darch_cmd_s390x
>> +
>> +function arch_cmd_s390x()
>> +{
>> +	local cmd=3D$1
>> +	local testname=3D$2
>> +	local groups=3D$3
>> +	local smp=3D$4
>> +	local kernel=3D$5
>> +	local opts=3D$6
>> +	local arch=3D$7
>> +	local check=3D$8
>> +	local accel=3D$9
>> +	local timeout=3D${10}
>> +
>> +	# run the normal test case
>> +	"$cmd" "${testname}" "$groups" "$smp" "$kernel" "$opts" "$arch" "$chec=
k" "$accel" "$timeout"
>> +
>
> Why ${testname} instead of $testname ?

Probably to be in common with "${testname}_PV" :) I can change it here.

>
>> +	# run PV test case
>> +	kernel=3D${kernel%.elf}.pv.bin
>> +	if [ ! -f "${kernel}" ]; then
>> +		if [ -z "${HOST_KEY_DOCUMENT}" ]; then
>> +			print_result 'SKIP' $testname '(no host-key document specified)'
>> +			return 2
>> +		fi
>> +
>> +		print_result 'SKIP' $testname '(PVM image was not created)'
>> +		return 2
>> +	fi
>> +	"$cmd" "${testname}_PV" "$groups pv" "$smp" "$kernel" "$opts" "$arch" =
"$check" "$accel" "$timeout"
>
> dito

$testname_PV would refer to a non-existent variable.

Thanks for the feedback!

>
>> +}
>>=20
>
>
> --=20
> Thanks,
>
> David / dhildenb
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
