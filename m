Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgHNNGp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Aug 2020 09:06:45 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC v2 3/4] run_tests/mkstandalone: add arch dependent function to `for_each_unittest`
In-Reply-To: <20200813083000.e4bscohuhgl3jdv4@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com> <20200812092705.17774-4-mhartmay@linux.ibm.com> <20200813083000.e4bscohuhgl3jdv4@kamzik.brq.redhat.com>
Date: Fri, 14 Aug 2020 15:06:36 +0200
Message-ID: <87h7t51in7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Aug 13, 2020 at 10:30 AM +0200, Andrew Jones <drjones@redhat.com> w=
rote:
> On Wed, Aug 12, 2020 at 11:27:04AM +0200, Marc Hartmayer wrote:
>> This allows us, for example, to auto generate a new test case based on
>> an existing test case.
>>=20
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  run_tests.sh            |  2 +-
>>  scripts/common.bash     | 13 +++++++++++++
>>  scripts/mkstandalone.sh |  2 +-
>>  3 files changed, 15 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/run_tests.sh b/run_tests.sh
>> index 24aba9cc3a98..23658392c488 100755
>> --- a/run_tests.sh
>> +++ b/run_tests.sh
>> @@ -160,7 +160,7 @@ trap "wait; exit 130" SIGINT
>>     # preserve stdout so that process_test_output output can write TAP t=
o it
>>     exec 3>&1
>>     test "$tap_output" =3D=3D "yes" && exec > /dev/null
>> -   for_each_unittest $config run_task
>> +   for_each_unittest $config run_task arch_cmd
>
> Let's just require that arch cmd hook be specified by the "$arch_cmd"
> variable. Then we don't need to pass it to for_each_unittest.

Where is it then specified?

>
>>  ) | postprocess_suite_output
>>=20=20
>>  # wait until all tasks finish
>> diff --git a/scripts/common.bash b/scripts/common.bash
>> index f9c15fd304bd..62931a40b79a 100644
>> --- a/scripts/common.bash
>> +++ b/scripts/common.bash
>> @@ -1,8 +1,15 @@
>> +function arch_cmd()
>> +{
>> +	# Dummy function, can be overwritten by architecture dependent
>> +	# code
>> +	return
>> +}
>
> This dummy function appears unused and can be dropped.

So what is then used if the function is not defined by the architecture
specific code?

>
>>=20=20
>>  function for_each_unittest()
>>  {
>>  	local unittests=3D"$1"
>>  	local cmd=3D"$2"
>> +	local arch_cmd=3D"${3-}"
>>  	local testname
>>  	local smp
>>  	local kernel
>> @@ -19,6 +26,9 @@ function for_each_unittest()
>>  		if [[ "$line" =3D~ ^\[(.*)\]$ ]]; then
>>  			if [ -n "${testname}" ]; then
>>  				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$che=
ck" "$accel" "$timeout"
>> +				if [ "${arch_cmd}" ]; then
>> +					"${arch_cmd}" "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts=
" "$arch" "$check" "$accel" "$timeout"
>> +				fi
>
> Rather than assuming we should run both $cmd ... and $arch_cmd $cmd ...,
> let's just run $arch_cmd $cmd ..., when it exists. If $arch_cmd wants to
> run $cmd ... first, then it can do so itself.

Yep, makes sense.

>
>>  			fi
>>  			testname=3D${BASH_REMATCH[1]}
>>  			smp=3D1
>> @@ -49,6 +59,9 @@ function for_each_unittest()
>>  	done
>>  	if [ -n "${testname}" ]; then
>>  		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check=
" "$accel" "$timeout"
>> +		if [ "${arch_cmd}" ]; then
>> +			"${arch_cmd}" "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" =
"$arch" "$check" "$accel" "$timeout"
>> +		fi
>>  	fi
>>  	exec {fd}<&-
>>  }
>> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
>> index cefdec30cb33..3b18c0cf090b 100755
>> --- a/scripts/mkstandalone.sh
>> +++ b/scripts/mkstandalone.sh
>> @@ -128,4 +128,4 @@ fi
>>=20=20
>>  mkdir -p tests
>>=20=20
>> -for_each_unittest $cfg mkstandalone
>> +for_each_unittest $cfg mkstandalone arch_cmd
>> --=20
>> 2.25.4
>>
>
> In summary, I think this patch should just be
>
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 9a6ebbd7f287..b409b0529ea6 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -17,7 +17,7 @@ function for_each_unittest()
>=20=20
>         while read -r -u $fd line; do
>                 if [[ "$line" =3D~ ^\[(.*)\]$ ]]; then
> -                       "$cmd" "$testname" "$groups" "$smp" "$kernel" "$o=
pts" "$arch" "$check" "$accel" "$timeout"
> +                       "$arch_cmd" "$cmd" "$testname" "$groups" "$smp" "=
$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"

If we remove the $arch_cmd variable we can directly use:

arch_cmd "$cmd" =E2=80=A6

>                         testname=3D${BASH_REMATCH[1]}
>                         smp=3D1
>                         kernel=3D""
> @@ -45,6 +45,6 @@ function for_each_unittest()
>                         timeout=3D${BASH_REMATCH[1]}
>                 fi
>         done
> -       "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$c=
heck" "$accel" "$timeout"
> +       "$arch_cmd" "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts"=
 "$arch" "$check" "$accel" "$timeout"
>         exec {fd}<&-
>  }
>=20=20
>
> Thanks,
> drew
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
