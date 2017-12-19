From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: fix broken BPF selftest build on s390
Date: Tue, 19 Dec 2017 01:21:53 +0100
Message-ID: <cace78cc-7105-4a5b-cc15-56283ad5dfe5@iogearbox.net>
References: <1513602597-12280-1-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1513602597-12280-1-git-send-email-brueckner@linux.vnet.ibm.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/18/2017 02:09 PM, Hendrik Brueckner wrote:
> With 720f228e8d31 ("bpf: fix broken BPF selftest build") the
> inclusion of arch-specific header files changed.  Including the
> asm/bpf_perf_event.h on s390, correctly includes the s390 specific
> header file.  This header file tries then to include the s390
> asm/ptrace.h and the build fails with:
> 
> cc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated  -I../../../include    test_verifier.c
> +/root/git/linux/tools/testing/selftests/bpf/libbpf.a /root/git/linux/tools/testing/selftests/bpf/cgroup_helpers.c -lcap -lelf -o
> +/root/git/linux/tools/testing/selftests/bpf/test_verifier
> In file included from ../../../include/uapi/asm/bpf_perf_event.h:4:0,
>                  from ../../../include/uapi/linux/bpf_perf_event.h:11,
>                  from test_verifier.c:29:
> ../../../include/uapi/../../arch/s390/include/uapi/asm/bpf_perf_event.h:7:9: error: unknown type name 'user_pt_regs'
>  typedef user_pt_regs bpf_user_pt_regs_t;
>          ^~~~~~~~~~~~
> make: *** [../lib.mk:109: /root/git/linux/tools/testing/selftests/bpf/test_verifier] Error 1
> 
> This is caused by a recent update to the s390 asm/ptrace.h file
> that is not (yet) available in the local installation.  That means,
> the s390 asm/ptrace.h must be included from the tools/arch/s390
> directory.
> 
> Because there is no proper framework to deal with asm specific
> includes in tools/, slightly modify the s390 asm/bpf_perf_event.h
> to include the local ptrace.h header file.
> 
> See also discussion on
> https://marc.info/?l=linux-s390&m=151359424420691&w=2
> 
> Please note that this needs to be preserved until tools/ is able to
> correctly handle asm specific headers.
> 
> References: https://marc.info/?l=linux-s390&m=151359424420691&w=2
> Fixes: 720f228e8d31 ("bpf: fix broken BPF selftest build")
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>

Applied to bpf tree, thanks Hendrik!
