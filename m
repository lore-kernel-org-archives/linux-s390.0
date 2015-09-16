From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Fixes: 805de8f43c20 (atomic: Replace
 atomic_{set,clear}_mask() usage)
Date: Wed, 16 Sep 2015 16:38:24 +0200
Message-ID: <55F97EE0.2020906@redhat.com>
References: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
 <55F97DFA.80709@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <55F97DFA.80709@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: cornelia.huck@de.ibm.com, peterz@infradead.org, tglx@linutronix.de, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 16/09/2015 16:34, Christian Borntraeger wrote:
> Am 16.09.2015 um 15:13 schrieb Jason J. Herne:
>> The offending commit accidentally replaces an atomic_clear with an
>> atomic_or instead of an atomic_andnot in kvm_s390_vcpu_request_handled.
>> The symptom is that kvm guests on s390 hang on startup.
>> This patch simply replaces the incorrect atomic_or with atomic_andnot
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Paolo,
> can you take this via kvm tree for 4.3?
> 
> Maybe move the subject line into the mail body an rephrase the subject line.

Sure.

Paolo
