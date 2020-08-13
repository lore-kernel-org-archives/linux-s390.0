Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgHMPNi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 11:13:38 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC v2 4/4] s390x: add Protected VM support
In-Reply-To: <20200813162234.01db539f.cohuck@redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com> <20200812092705.17774-5-mhartmay@linux.ibm.com> <20200813135642.4f493049.cohuck@redhat.com> <87d03uhevw.fsf@linux.ibm.com> <20200813162234.01db539f.cohuck@redhat.com>
Date: Thu, 13 Aug 2020 17:13:17 +0200
Message-ID: <87a6yyh94i.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Aug 13, 2020 at 04:22 PM +0200, Cornelia Huck <cohuck@redhat.com> w=
rote:
> On Thu, 13 Aug 2020 15:08:51 +0200
> Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
>
>> On Thu, Aug 13, 2020 at 01:56 PM +0200, Cornelia Huck <cohuck@redhat.com=
> wrote:
>> > On Wed, 12 Aug 2020 11:27:05 +0200
>> > Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
>> >=20=20
>> >> Add support for Protected Virtual Machine (PVM) tests. For starting a
>> >> PVM guest we must be able to generate a PVM image by using the
>> >> `genprotimg` tool from the s390-tools collection. This requires the
>> >> ability to pass a machine-specific host-key document, so the option
>> >> `--host-key-document` is added to the configure script.
>> >>=20
>> >> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> >> ---
>> >>  configure               |  8 ++++++++
>> >>  s390x/Makefile          | 17 +++++++++++++++--
>> >>  s390x/selftest.parmfile |  1 +
>> >>  s390x/unittests.cfg     |  1 +
>> >>  scripts/s390x/func.bash | 18 ++++++++++++++++++
>> >>  5 files changed, 43 insertions(+), 2 deletions(-)
>> >>  create mode 100644 s390x/selftest.parmfile
>> >>  create mode 100644 scripts/s390x/func.bash
>> >>=20
>> >> diff --git a/configure b/configure
>> >> index f9d030fd2f03..aa528af72534 100755
>> >> --- a/configure
>> >> +++ b/configure
>> >> @@ -18,6 +18,7 @@ u32_long=3D
>> >>  vmm=3D"qemu"
>> >>  errata_force=3D0
>> >>  erratatxt=3D"$srcdir/errata.txt"
>> >> +host_key_document=3D
>> >>=20=20
>> >>  usage() {
>> >>      cat <<-EOF
>> >> @@ -40,6 +41,8 @@ usage() {
>> >>  	                           no environ is provided by the user (enab=
led by default)
>> >>  	    --erratatxt=3DFILE       specify a file to use instead of errat=
a.txt. Use
>> >>  	                           '--erratatxt=3D' to ensure no file is us=
ed.
>> >> +	    --host-key-document=3DHOST_KEY_DOCUMENT
>> >> +	                           host-key-document to use (s390x only)=20=
=20
>> >
>> > Maybe a bit more verbose? If I see only this option, I have no idea
>> > what it is used for and where to get it.=20=20
>>=20
>> =E2=80=9CSpecifies the machine-specific host-key document required to cr=
eate a
>> PVM image using the `genprotimg` tool from the s390-tools collection
>> (s390x only)=E2=80=9D
>>=20
>> Better?
>
> "specify the machine-specific host-key document for creating a PVM
> image with 'genprotimg' (s390x only)"
>
> I think you can figure out where to get genprotimg if you actually know
> that you want it ;)
>
> (...)
>
>> >> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
>> >> new file mode 100644
>> >> index 000000000000..5c682cb47f73
>> >> --- /dev/null
>> >> +++ b/scripts/s390x/func.bash
>> >> @@ -0,0 +1,18 @@
>> >> +# Run Protected VM test
>> >> +function arch_cmd()
>> >> +{
>> >> +	local cmd=3D$1
>> >> +	local testname=3D$2
>> >> +	local groups=3D$3
>> >> +	local smp=3D$4
>> >> +	local kernel=3D$5
>> >> +	local opts=3D$6
>> >> +	local arch=3D$7
>> >> +	local check=3D$8
>> >> +	local accel=3D$9
>> >> +	local timeout=3D${10}
>> >> +
>> >> +	kernel=3D${kernel%.elf}.pv.bin
>> >> +	# do not run PV test cases by default
>> >> +	"$cmd" "${testname}_PV" "$groups pv nodefault" "$smp" "$kernel" "$o=
pts" "$arch" "$check" "$accel" "$timeout"=20=20
>> >
>> > If we don't run this test, can we maybe print some informative message
>> > like "PV tests not run; specify --host-key-document to enable" or so?
>> > (At whichever point that makes the most sense.)=20=20
>>=20
>> Currently, the output looks like this:
>>=20
>> $ ./run_tests.sh=20=20=20=20
>> PASS selftest-setup (14 tests)
>> SKIP selftest-setup_PV (test marked as manual run only)
>> PASS intercept (20 tests)
>> SKIP intercept_PV (test marked as manual run only)
>> =E2=80=A6
>>=20
>> And if you=E2=80=99re trying to run the PV tests without specifying the =
host-key
>> document it results in:
>>=20
>> $ ./run_tests.sh -a
>> PASS selftest-setup (14 tests)
>> FAIL selftest-setup_PV=20
>> PASS intercept (20 tests)
>> FAIL intercept_PV=20
>> =E2=80=A6
>>=20
>> But if you like I can return a hint that the PVM image was not
>> generated. Should the PV test case then be skipped?
>
> Yes, I was expecting something like
>
> SKIP selftest-setup_PV (no host-key document specified)
> SKIP intercept_PV (no host-key document specified)
>
> so that you get a hint what you may want to set up.

Okay, I=E2=80=99ll add this and remove the marker that PV tests aren=E2=80=
=99t executed
by default. Because when someone builds the PV images, he will most
likely want to run the PV test cases as well.

>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
