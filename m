Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgHSLi6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 07:38:58 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 4/4] s390x: add Protected VM support
In-Reply-To: <20200819123443.2287abc3.cohuck@redhat.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com> <20200818130424.20522-5-mhartmay@linux.ibm.com> <20200819123443.2287abc3.cohuck@redhat.com>
Date: Wed, 19 Aug 2020 13:38:49 +0200
Message-ID: <87r1s2sw52.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Aug 19, 2020 at 12:34 PM +0200, Cornelia Huck <cohuck@redhat.com> w=
rote:
> On Tue, 18 Aug 2020 15:04:24 +0200
> Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
>
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
>
> (...)
>
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
>> +	# run PV test case
>> +	kernel=3D${kernel%.elf}.pv.bin
>> +	if [ ! -f "${kernel}" ]; then
>> +		if [ -z "${HOST_KEY_DOCUMENT}" ]; then
>> +			print_result 'SKIP' $testname '(no host-key document specified)'
>> +			return 2
>> +		fi
>> +
>> +		print_result 'SKIP' $testname '(PVM image was not created)'
>
> When can that happen? Don't we already fail earlier if we specified a
> host key document, but genprotimg does not work?

./configure
make -j
./configure --host-key-document=3D=E2=80=A6
./run_tests.sh

A contrived example, but=E2=80=A6

>
>> +		return 2
>> +	fi
>> +	"$cmd" "${testname}_PV" "$groups pv" "$smp" "$kernel" "$opts" "$arch" =
"$check" "$accel" "$timeout"
>> +}
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
