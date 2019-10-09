Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Oct 2019 11:39:17 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [RFC v2 0/1] s390/purgatory: Make sure we fail the build if
 purgatory has missing symbols
In-Reply-To: <20191008085421.11011-1-hdegoede@redhat.com>
References: <20191008085421.11011-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191009113917.47ef6eda@laptop-ibm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>

Hi Hans,

also adding Ingo on Cc.

I tested you patch on s390 and it does what it's supposed to do. The build now
fails with 

  LD      arch/s390/purgatory/purgatory.chk
arch/s390/purgatory/purgatory: In function `sha256_update':
(.text+0x3bc2): undefined reference to `memzero_explicit'
/home/prudo/git/linux/linux/arch/s390/purgatory/Makefile:38: recipe for target 'arch/s390/purgatory/purgatory.chk' failed
make[3]: *** [arch/s390/purgatory/purgatory.chk] Error 1

After applying Arvid's memzero_explizit fix ("[PATCH] lib/string: make
memzero_explicit inline instead of external") as well the build works again.

My only problem is how to uptream your patch. Just adding it to our branch
would cause a (intentional) build breakage until Ingo's branch is merged.

@Vasliy & Ingo: Can you please find a solution for this.

Thanks
Philipp

On Tue,  8 Oct 2019 10:54:20 +0200[PATCH] lib/string: make memzero_explicit
inline instead of external Hans de Goede <hdegoede@redhat.com> wrote:

> Hi s390 maintainers,
> 
> Here is a second RFC version of my patch for $subject, mirroring the
> changes in v2 of the x86 patch.
> 
> As last time this patch is completely UNTESTED.
> 
> Changes in v2:
> - Using 2 if_changed lines under a single rule does not work, then
>   1 of the 2 will always execute each build.
>   Instead add a new (unused) purgatory.chk intermediate which gets
>   linked from purgatory.ro without -r to do the missing symbols check
> - This also fixes the check generating an a.out file (oops)
> 
> Relevant part of the cover letter from v1:
> 
> In 5.4-rc1 the 2 different sha256 implementations for the purgatory resp.
> for crypto/sha256_generic.c have been consolidated into 1 single shared
> implementation under lib/crypto/sha256.c .
> 
> At least on x86 this was causing silent corruption of the purgatory due
> to a missing memzero_explicit symbol in the purgatory string.c/.o file.
> 
> With the x86 equivalent of this patch applied a x86 build of 5.4-rc1 now
> correctly fails:
> 
>   CHK     arch/x86/purgatory/purgatory.ro
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> make[2]: *** [arch/x86/purgatory/Makefile:72:
>     arch/x86/purgatory/kexec-purgatory.c] Error 1
> make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
> make: *** [Makefile:1650: arch/x86] Error 2
> 
> It would be great if the s390 maintainers can test this equivalent patch
> on s390.
> 
> As for fixing the missing memzero_explicit symbol, we are currently
> discussing making memzero_explicit a static inline wrapper of memset
> in string.h, so that we do not need to implement it in multiple places.
> 
> This discussion is Cc-ed to the generic linux-kernel@vger.kernel.org list,
> it is happening in the
> "[PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit" thread.
> 
> Regards,
> 
> Hans
> 
> 
> 
