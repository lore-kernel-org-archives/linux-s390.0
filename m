From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] sparc: convert mdesc_handle.refcnt from atomic_t
 to refcount_t
Date: Mon, 03 Apr 2017 09:16:12 -0700 (PDT)
Message-ID: <20170403.091612.1886244463475403493.davem@davemloft.net>
References: <2236FBA76BA1254E88B949DDB74E612B41C86E2F@IRSMSX102.ger.corp.intel.com>
        <20170403.061252.1545979851987245996.davem@davemloft.net>
        <2236FBA76BA1254E88B949DDB74E612B41C87070@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C87070@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: elena.reshetova@intel.com
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, ishkamiel@gmail.com, keescook@chromium.org, dwindsor@gmail.com
List-ID: <linux-s390.vger.kernel.org>

From: "Reshetova, Elena" <elena.reshetova@intel.com>
Date: Mon, 3 Apr 2017 16:06:44 +0000

>> From: "Reshetova, Elena" <elena.reshetova@intel.com>
>> Date: Mon, 3 Apr 2017 07:28:01 +0000
>> 
>> >
>> >> From: Elena Reshetova <elena.reshetova@intel.com>
>> >> Date: Mon, 20 Feb 2017 13:06:20 +0200
>> >>
>> >> > refcount_t type and corresponding API should be
>> >> > used instead of atomic_t when the variable is used as
>> >> > a reference counter. This allows to avoid accidental
>> >> > refcounter overflows that might lead to use-after-free
>> >> > situations.
>> >> >
>> >> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> >> > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
>> >> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> >> > Signed-off-by: David Windsor <dwindsor@gmail.com>
>> >>
>> >> Acked-by: David S. Miller <davem@davemloft.net>
>> >
>> > Hi David,
>> >
>> > Would you be able to propagate this patch further or should I send
>> > it (with your acked-by) once more to specific list/maintainer for
>> > the inclusion?
>> 
>> I'm generally not happy with the refcount_t and the added overhead it
>> has compared to the existing atomic_t operations.
>> 
>> I know it is going to make a difference for networking.
>> 
>> I understand that this sparc case is a slow path, but I know that if
>> we just apply all of these refcount_t conversions, there will be no
>> work done to address the performance issues.
> 
> I think we will have to address the performance problems in places where we can see it matters. 
> The problem is that so far noone told us how to measure in any reasonable way the overhead neither in networking, not in mm changes. 
> If this change is a slow path, why would it matter for *this particular patch*?

I think not having a way to avoid the functional call makes the facility
unusable as a core kernel facility.

You can't just say "oh well, just convert the slow paths, we'll solve the
fundamental performance issue later".  Sorry, that is not how we do things.
