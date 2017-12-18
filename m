From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 3/3] bpf: fix broken BPF selftest build
Date: Mon, 18 Dec 2017 11:50:39 +0100
Message-ID: <5197f2a2-acfe-2225-1a20-f0371a0cdfc4@iogearbox.net>
References: <20171212012532.30268-1-daniel@iogearbox.net>
 <20171212012532.30268-4-daniel@iogearbox.net>
 <20171218092843.GA4571@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171218092843.GA4571@linux.vnet.ibm.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: ast@kernel.org, netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/18/2017 10:28 AM, Hendrik Brueckner wrote:
[...]
> This is actually necessary on s390:
> 
> cc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated  -I../../../include    test_verifier.c /root/git/linux/tools/testing/selftests/bpf/libbpf.a /root/git/linux/tools/testing/selftests/bpf/cgroup_helpers.c -lcap -lelf -o /root/git/linux/tools/testing/selftests/bpf/test_verifier
> In file included from ../../../include/uapi/asm/bpf_perf_event.h:4:0,
>                  from ../../../include/uapi/linux/bpf_perf_event.h:11,
>                  from test_verifier.c:29:
> ../../../include/uapi/../../arch/s390/include/uapi/asm/bpf_perf_event.h:7:9: error: unknown type name 'user_pt_regs'
>  typedef user_pt_regs bpf_user_pt_regs_t;
>          ^~~~~~~~~~~~
> make: *** [../lib.mk:109: /root/git/linux/tools/testing/selftests/bpf/test_verifier] Error 1
> 
> The s390 bpf_perf_event.h header file contains an #include for asm/ptrace.h
> that defines the user_pt_regs (introduce with my patch set).  For building,
> the ptrace.h header file from the tooling must be used, not the local
> installed version.
> 
> Including the ptrace.h header file directly solves the issue.  Feel free to
> merge below snippet into your patch.

Argh, fwiw, I tested on x86 and arm64. :/ Given it already landed in Linus'
tree, could you send me the below as an official patch and I'll take it via
bpf? I think the below is minimal enough, and should then hopefully be the
last remaining fallout on this uapi issue. I think it's fine to do it this
way. The other option would be to pull in ptrace.h for all the others as well
and map it similarly as with bpf_perf_event.h, but that gets out of hand very
quickly (plus we could not have a default fallback include since it would
otherwise be recursive). Anyway, could you add a comment over the include
below stating that this is necessary to include this way? Just to make sure
it doesn't accidentally get changed back until we have a proper framework
in tools/ for dealing with asm includes.

Thanks a lot,
Daniel

> Thanks and kind regards,
>   Hendrik
> 
> ---
> diff --git a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
> index cefe7c7cd4f6..0a8e37a519f2 100644
> --- a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
> +++ b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
> @@ -2,7 +2,7 @@
>  #ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
>  #define _UAPI__ASM_BPF_PERF_EVENT_H__
>  
> -#include <asm/ptrace.h>
> +#include "ptrace.h"
>  
>  typedef user_pt_regs bpf_user_pt_regs_t;
>  
> 
