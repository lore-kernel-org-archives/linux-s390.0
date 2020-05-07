Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgEGNku (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 09:40:50 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC] s390x: Add Protected VM support
In-Reply-To: <20200506135016.ml3k73siokhltyl5@kamzik.brq.redhat.com>
References: <20200506124636.21876-1-mhartmay@linux.ibm.com> <20200506135016.ml3k73siokhltyl5@kamzik.brq.redhat.com>
Date: Thu, 07 May 2020 15:40:39 +0200
Message-ID: <87wo5n6ey0.fsf@linux.ibm.com>
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

[…snip…]

> +
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
> standalone tests. Why not do this stuff in s390x/run instead?

Okay, I’ve looked into the code, and the reason for this approach is
that I want to treat the PVM and the “normal” test case as two separate
test cases, but using the same test configuration. I don’t see how I can
achieve this by editing s390x/run and for the standalone case.

Maybe this approach is already broken and I should simply add the PVM
testcases as extra test cases to the unittest.cfg - but this would
result in duplicated code in the configuration file.

> Also,
> do you need the pv_support[ed] parameter? You could just do a
> [ -f "${kernel%.elf}.pv.img" ] to decide if you should run again
> with PV, right?
>
> Thanks,
> drew
>
-- 
Kind regards / Beste Grüße
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
