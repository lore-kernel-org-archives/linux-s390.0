Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGMam (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 08:30:42 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC] s390x: Add Protected VM support
In-Reply-To: <ad0d5c9d-bde2-2143-0440-d47d6e28bb29@linux.ibm.com>
References: <20200506124636.21876-1-mhartmay@linux.ibm.com> <ad0d5c9d-bde2-2143-0440-d47d6e28bb29@linux.ibm.com>
Date: Thu, 07 May 2020 14:30:32 +0200
Message-ID: <877dxo6i6v.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, May 06, 2020 at 04:03 PM +0200, Janosch Frank <frankja@linux.ibm.com> wrote:
> On 5/6/20 2:46 PM, Marc Hartmayer wrote:
>> Add support for Protected Virtual Machine (PVM) tests. For starting a
>> PVM guest we must be able to generate a PVM image by using the
>> `genprotimg` tool from the s390-tools collection. This requires the
>> ability to pass a machine-specific host-key document, so the option
>> `--host-key-document` is added to the configure script.
>> 
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>

[…snip…]

>>  [intercept]
>>  file = intercept.elf
>> +pv_support = 1
>
> So, let's do this discussion once more:
> Why would we need a opt-in for something which works on all our current
> tests? I'd much rather have a opt-out or just a bail-out when running
> the test like I already implemented for the storage key related
> tests...
>
> I don't see any benefit for this right now other than forcing me to add
> another line to this file that was not needed before..
>

Okay. So shall I add an option ’pv_not_supported’? Or simply assume that
the actual test cases will handle it?

-- 
Kind regards / Beste Grüße
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
