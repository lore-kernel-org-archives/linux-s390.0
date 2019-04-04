Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 4 Apr 2019 15:01:04 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
Message-ID: <401506569.4710878.1554408064001.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
References: <cover.1554396090.git.jpoimboe@redhat.com> <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com> <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404200104.INe2nbO9Bg__dm-H_nSr2d4XkjWKVig0XnWHSYky-mk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Will be joining in ~ 5 mins.  Getting Chromium set up here.

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Josh Poimboeuf" <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra" <peterz@infradead.org>, "Heiko Carstens" <heiko.carstens@de.ibm.com>, "Paul Mackerras"
> <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>, "Andrea Arcangeli"
> <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, "Will Deacon" <will.deacon@arm.com>, "Linus
> Torvalds" <torvalds@linux-foundation.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Waiman Long"
> <longman@redhat.com>, linux-arch@vger.kernel.org, "Jon Masters" <jcm@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
> "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, "Tyler Hicks" <tyhicks@canonical.com>,
> "Martin Schwidefsky" <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
> Sent: Thursday, April 4, 2019 2:49:05 PM
> Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline options

> On Thu, 4 Apr 2019, Josh Poimboeuf wrote:
> 
>> Configure powerpc CPU runtime speculation bug mitigations in accordance
>> with the 'cpu_spec_mitigations=' cmdline options.  This affects
>> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
> [ ... snip ... ]
>> -	if (!no_nospec)
>> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
> 
> '!no_nospec' is something that I am sure will come back to hunt me in my
> bad dreams.
> 
> But that's been there already, and fixing it is out of scope of this
> patch. Other than that, as discussed previously -- I really like this new
> global option. Feel free to add
> 
>	Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> 
> for the whole set.
> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs
