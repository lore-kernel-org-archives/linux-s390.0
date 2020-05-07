Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGNPC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 09:15:02 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC] s390x: Add Protected VM support
In-Reply-To: <20200506135016.ml3k73siokhltyl5@kamzik.brq.redhat.com>
References: <20200506124636.21876-1-mhartmay@linux.ibm.com> <20200506135016.ml3k73siokhltyl5@kamzik.brq.redhat.com>
Date: Thu, 07 May 2020 15:14:53 +0200
Message-ID: <871rnv7upe.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, May 06, 2020 at 03:50 PM +0200, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, May 06, 2020 at 02:46:36PM +0200, Marc Hartmayer wrote:
>> Add support for Protected Virtual Machine (PVM) tests. For starting a
>> PVM guest we must be able to generate a PVM image by using the
>> `genprotimg` tool from the s390-tools collection. This requires the
>> ability to pass a machine-specific host-key document, so the option
>> `--host-key-document` is added to the configure script.
>> 
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>> @@ -16,6 +16,8 @@
>>  #			 # a test. The check line can contain multiple files
>>  #			 # to check separated by a space but each check
>>  #			 # parameter needs to be of the form <path>=<value>
>> +# pv_support = 0|1       # Optionally specify whether a test supports the
>> +#                        # execution as a PV guest.
>
> Maybe pv_supported vs. pv_support?

pv_supported is better, thanks.

>>  
>>  	exec {fd}<"$unittests"
>>  
>>  	while read -r -u $fd line; do
>>  		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
>> -			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"

This line was accidentally removed.

>> +			if [ "${pv_support}" == 1 ]; then
>> +				pv_cmd "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>> +			fi
>> +
>>  			testname=${BASH_REMATCH[1]}
>>  			smp=1
>>  			kernel=""
>> @@ -27,6 +48,7 @@ function for_each_unittest()
>>  			check=""
>>  			accel=""
>>  			timeout=""
>> +			pv_support=""
>>  		elif [[ $line =~ ^file\ *=\ *(.*)$ ]]; then
>>  			kernel=$TEST_DIR/${BASH_REMATCH[1]}
>>  		elif [[ $line =~ ^smp\ *=\ *(.*)$ ]]; then
>> @@ -43,8 +65,14 @@ function for_each_unittest()
>>  			accel=${BASH_REMATCH[1]}
>>  		elif [[ $line =~ ^timeout\ *=\ *(.*)$ ]]; then
>>  			timeout=${BASH_REMATCH[1]}
>> +		elif [[ $line =~ ^pv_support\ *=\ *(.*)$ ]]; then
>> +			pv_support=${BASH_REMATCH[1]}
>>  		fi
>>  	done
>> +
>>  	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>> +	if [ "${pv_support}" == 1 ]; then
>> +		pv_cmd "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>> +	fi
>>  	exec {fd}<&-
>>  }
>> -- 
>> 2.17.0
>>
>
> I don't think making the changes to scripts/common.bash will work for
> standalone tests.

With the fix above it works (tested on x86 and s390x).

$ make standalone
Written tests/selftest-setup.
Written tests/intercept.
Written tests/intercept_PV.
Written tests/emulator.
Written tests/emulator_PV.
Written tests/sieve.
Written tests/sieve_PV.
…

> Why not do this stuff in s390x/run instead?

I will try.

> Also,
> do you need the pv_support[ed] parameter? You could just do a
> [ -f "${kernel%.elf}.pv.img" ] to decide if you should run again
> with PV, right?

AFAIK, for the other test cases the kernel file is also not checked, but
this would be an option - thanks.

>
> Thanks,
> drew
>

Thanks for the feedback!

-- 
Kind regards / Beste Grüße
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
