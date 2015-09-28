Return-Path: <yarygin@linux.vnet.ibm.com>
From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
In-Reply-To: <1443161838-31462-1-git-send-email-hemant@linux.vnet.ibm.com>
 (Hemant Kumar's message of "Fri, 25 Sep 2015 11:47:15 +0530")
References: <1443161838-31462-1-git-send-email-hemant@linux.vnet.ibm.com>
Date: Mon, 28 Sep 2015 16:00:36 +0300
Message-ID: <87bncm7l6z.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, acme@kernel.org, scottwood@freescale.com, sukadev@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org, mingo@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hemant Kumar <hemant@linux.vnet.ibm.com> writes:

> Its better to remove the dependency on uapi/kvm_perf.h to allow dynamic
> discovery of kvm events (if its needed). To do this, some extern
> variables have been introduced with which we can keep the generic
> functions generic.
>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> ---
> Changes since v7:
> - Removed __maybe_unused for some parameters which weren't needed.
>
>  tools/perf/arch/s390/util/kvm-stat.c | 10 ++++++++-
>  tools/perf/arch/x86/util/kvm-stat.c  | 12 ++++++++++-
>  tools/perf/builtin-kvm.c             | 39 +++++++++++++++++++++++-------------
>  tools/perf/util/kvm-stat.h           |  3 +++
>  4 files changed, 48 insertions(+), 16 deletions(-)

Hello,


The patchset doesn't break s390 code (and at least build on x86), but I
don't really like some things here (e.g. direct access to
kvm_events_tp), see below.

Thanks.

CC: David Ahern 

>
> diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
> index a5dbc07..c2acb3e 100644
> --- a/tools/perf/arch/s390/util/kvm-stat.c
> +++ b/tools/perf/arch/s390/util/kvm-stat.c
> @@ -10,7 +10,11 @@
>   */
>
>  #include "../../util/kvm-stat.h"
> -#include <asm/kvm_perf.h>
> +#include <asm/sie.h>
> +
> +#define DECODE_STR_LEN 40
> +#define VCPU_ID "id"
> +#define KVM_EXIT_REASON "icptcode"
>

I would probably drop them. There are no users besides newly
introduced const char *vcpu_id_str and decore_str_len etc anyway.

>  define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
>  define_exit_reasons_table(sie_icpt_insn_codes, icpt_insn_codes);
> @@ -83,6 +87,10 @@ const char * const kvm_events_tp[] = {
>  	NULL,
>  };
>
> +const char *vcpu_id_str = VCPU_ID;
> +const int decode_str_len = DECODE_STR_LEN;
> +const char *exit_reason_code = KVM_EXIT_REASON;
> +
>  struct kvm_reg_events_ops kvm_reg_events_ops[] = {
>  	{ .name = "vmexit", .ops = &exit_events },
>  	{ NULL, NULL },
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index 14e4e66..2d0d43b5 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -1,5 +1,11 @@
>  #include "../../util/kvm-stat.h"
> -#include <asm/kvm_perf.h>
> +#include <asm/svm.h>
> +#include <asm/vmx.h>
> +#include <asm/kvm.h>
> +
> +#define DECODE_STR_LEN 20
> +#define VCPU_ID "vcpu_id"
> +#define KVM_EXIT_REASON "exit_reason"
>
>  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
>  define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
> @@ -129,6 +135,10 @@ const char * const kvm_events_tp[] = {
>  	NULL,
>  };
>
> +const char *vcpu_id_str = VCPU_ID;
> +const int decode_str_len = DECODE_STR_LEN;
> +const char *exit_reason_code = KVM_EXIT_REASON;
> +
>  struct kvm_reg_events_ops kvm_reg_events_ops[] = {
>  	{ .name = "vmexit", .ops = &exit_events },
>  	{ .name = "mmio", .ops = &mmio_events },
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index fc1cffb..ef25fcf 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -31,20 +31,18 @@
>  #include <math.h>
>
>  #ifdef HAVE_KVM_STAT_SUPPORT
> -#include <asm/kvm_perf.h>
>  #include "util/kvm-stat.h"
>
> -void exit_event_get_key(struct perf_evsel *evsel,
> -			struct perf_sample *sample,
> +void exit_event_get_key(struct perf_evsel *evsel, struct perf_sample *sample,
>  			struct event_key *key)
>  {
>  	key->info = 0;
> -	key->key = perf_evsel__intval(evsel, sample, KVM_EXIT_REASON);
> +	key->key = perf_evsel__intval(evsel, sample, exit_reason_code);
>  }
>
>  bool kvm_exit_event(struct perf_evsel *evsel)
>  {
> -	return !strcmp(evsel->name, KVM_EXIT_TRACE);
> +	return !strncmp(evsel->name, kvm_events_tp[1], strlen(evsel->name));
>  }

Hmm, direct access to kvm_events_tp? Maybe add a getter for this or
something like extern char *kvm_exit_trace;?
/* why strncmp? */

>
>  bool exit_event_begin(struct perf_evsel *evsel,
> @@ -60,7 +58,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
>
>  bool kvm_entry_event(struct perf_evsel *evsel)
>  {
> -	return !strcmp(evsel->name, KVM_ENTRY_TRACE);
> +	return !strncmp(evsel->name, kvm_events_tp[0], strlen(evsel->name));
>  }
>
>  bool exit_event_end(struct perf_evsel *evsel,
> @@ -71,8 +69,8 @@ bool exit_event_end(struct perf_evsel *evsel,
>  }
>
>  static const char *get_exit_reason(struct perf_kvm_stat *kvm,
> -				   struct exit_reasons_table *tbl,
> -				   u64 exit_code)
> +			    struct exit_reasons_table *tbl,
> +			    u64 exit_code)
>  {
>  	while (tbl->reason != NULL) {
>  		if (tbl->exit_code == exit_code)
> @@ -92,7 +90,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
>  	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
>  						  key->key);
>
> -	scnprintf(decode, DECODE_STR_LEN, "%s", exit_reason);
> +	scnprintf(decode, decode_str_len, "%s", exit_reason);
>  }
>
>  static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
> @@ -358,7 +356,12 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>  	time_diff = sample->time - time_begin;
>
>  	if (kvm->duration && time_diff > kvm->duration) {
> -		char decode[DECODE_STR_LEN];
> +		char *decode = zalloc(decode_str_len);
> +
> +		if (!decode) {
> +			pr_err("Not enough memory\n");
> +			return false;
> +		}

I think char decode[decode_str_len]; should work or we can allocate this
once globally (e.g. put it into struct perf_kvm_stat)? Not sure.

>
>  		kvm->events_ops->decode_key(kvm, &event->key, decode);
>  		if (!skip_event(decode)) {
> @@ -366,6 +369,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>  				 sample->time, sample->pid, vcpu_record->vcpu_id,
>  				 decode, time_diff/1000);
>  		}
> +		free(decode);
>  	}
>
>  	return update_kvm_event(event, vcpu, time_diff);
> @@ -386,7 +390,8 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
>  			return NULL;
>  		}
>
> -		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample, VCPU_ID);
> +		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample,
> +							  vcpu_id_str);
>  		thread__set_priv(thread, vcpu_record);
>  	}
>
> @@ -575,7 +580,7 @@ static void show_timeofday(void)
>
>  static void print_result(struct perf_kvm_stat *kvm)
>  {
> -	char decode[DECODE_STR_LEN];
> +	char *decode;
>  	struct kvm_event *event;
>  	int vcpu = kvm->trace_vcpu;
>
> @@ -584,9 +589,14 @@ static void print_result(struct perf_kvm_stat *kvm)
>  		show_timeofday();
>  	}
>
> +	decode = zalloc(decode_str_len);
> +	if (!decode) {
> +		pr_err("Not enough memory\n");
> +		return;
> +	}
>  	pr_info("\n\n");
>  	print_vcpu_info(kvm);
> -	pr_info("%*s ", DECODE_STR_LEN, kvm->events_ops->name);
> +	pr_info("%*s ", decode_str_len, kvm->events_ops->name);
>  	pr_info("%10s ", "Samples");
>  	pr_info("%9s ", "Samples%");
>
> @@ -605,7 +615,7 @@ static void print_result(struct perf_kvm_stat *kvm)
>  		min = get_event_min(event, vcpu);
>
>  		kvm->events_ops->decode_key(kvm, &event->key, decode);
> -		pr_info("%*s ", DECODE_STR_LEN, decode);
> +		pr_info("%*s ", decode_str_len, decode);
>  		pr_info("%10llu ", (unsigned long long)ecount);
>  		pr_info("%8.2f%% ", (double)ecount / kvm->total_count * 100);
>  		pr_info("%8.2f%% ", (double)etime / kvm->total_time * 100);
> @@ -615,6 +625,7 @@ static void print_result(struct perf_kvm_stat *kvm)
>  			kvm_event_rel_stddev(vcpu, event));
>  		pr_info("\n");
>  	}
> +	free(decode);
>
>  	pr_info("\nTotal Samples:%" PRIu64 ", Total events handled time:%.2fus.\n\n",
>  		kvm->total_count, kvm->total_time / 1e3);
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index ae825d4..59ed51c 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -136,5 +136,8 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
>  extern const char * const kvm_events_tp[];
>  extern struct kvm_reg_events_ops kvm_reg_events_ops[];
>  extern const char * const kvm_skip_events[];
> +extern const char *vcpu_id_str;
> +extern const int decode_str_len;
> +extern const char *exit_reason_code;
>
>  #endif /* __PERF_KVM_STAT_H */
