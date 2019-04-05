Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 5 Apr 2019 09:31:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405143101.ksj7ayjis4p52dgt@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405135712.GF23348@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190405143101.ehopmxN-UUs4udfFq_s3rur7f147JR8sKQYe2BlTfXQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 03:57:12PM +0200, Borislav Petkov wrote:
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 2bb3a648fc12..7e95b310f869 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -982,6 +982,7 @@ void microcode_check(void);
> >  
> >  enum l1tf_mitigations {
> >  	L1TF_MITIGATION_OFF,
> > +	L1TF_MITIGATION_DEFAULT,
> >  	L1TF_MITIGATION_FLUSH_NOWARN,
> >  	L1TF_MITIGATION_FLUSH,
> >  	L1TF_MITIGATION_FLUSH_NOSMT,
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 2da82eff0eb4..65b95fb95ba5 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -308,8 +308,11 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
> >  
> >  	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
> >  				  arg, sizeof(arg));
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> > +			return SPECTRE_V2_USER_CMD_NONE;
> 
> Instead of sprinkling that test in those three functions, just do it
> once above in check_bugs(), before those *_select_mitigation() functions
> get to run and depending on the value, you either run them or use the
> default settings, for the OFF case, for example.

My thinking was that the individual options could be used to override
the global option.  But maybe that's overkill?  I dunno.

> >  		return SPECTRE_V2_USER_CMD_AUTO;
> > +	}
> >  
> >  	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
> >  		if (match_option(arg, ret, v2_user_options[i].option)) {
> > @@ -444,8 +447,11 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
> >  		return SPECTRE_V2_CMD_NONE;
> >  
> >  	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> > +			return SPECTRE_V2_CMD_NONE;
> >  		return SPECTRE_V2_CMD_AUTO;
> > +	}
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
> >  		if (!match_option(arg, ret, mitigation_options[i].option))
> > @@ -677,8 +683,11 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
> >  	} else {
> >  		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
> >  					  arg, sizeof(arg));
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> > +				return SPEC_STORE_BYPASS_CMD_NONE;
> >  			return SPEC_STORE_BYPASS_CMD_AUTO;
> > +		}
> >  
> >  		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
> >  			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
> > @@ -955,7 +964,7 @@ void x86_spec_ctrl_setup_ap(void)
> >  #define pr_fmt(fmt)	"L1TF: " fmt
> >  
> >  /* Default mitigation for L1TF-affected CPUs */
> > -enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
> > +enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_DEFAULT;
> >  #if IS_ENABLED(CONFIG_KVM_INTEL)
> >  EXPORT_SYMBOL_GPL(l1tf_mitigation);
> >  #endif
> > @@ -1010,8 +1019,23 @@ static void __init l1tf_select_mitigation(void)
> >  
> >  	override_cache_bits(&boot_cpu_data);
> >  
> > +	if (l1tf_mitigation == L1TF_MITIGATION_DEFAULT) {
> > +		switch (cpu_spec_mitigations) {
> > +		case CPU_SPEC_MITIGATIONS_OFF:
> > +			l1tf_mitigation = L1TF_MITIGATION_OFF;
> > +			break;
> > +		case CPU_SPEC_MITIGATIONS_AUTO:
> > +			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
> > +			break;
> > +		case CPU_SPEC_MITIGATIONS_AUTO_NOSMT:
> > +			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
> > +			break;
> > +		}
> > +	}
> > +
> >  	switch (l1tf_mitigation) {
> >  	case L1TF_MITIGATION_OFF:
> > +	case L1TF_MITIGATION_DEFAULT:
> >  	case L1TF_MITIGATION_FLUSH_NOWARN:
> >  	case L1TF_MITIGATION_FLUSH:
> >  		break;
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index ab432a930ae8..83b5bdc3c777 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -233,6 +233,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
> >  		case L1TF_MITIGATION_FLUSH_NOWARN:
> >  		case L1TF_MITIGATION_FLUSH:
> >  		case L1TF_MITIGATION_FLUSH_NOSMT:
> > +		case L1TF_MITIGATION_DEFAULT:
> >  			l1tf = VMENTER_L1D_FLUSH_COND;
> >  			break;
> >  		case L1TF_MITIGATION_FULL:
> > @@ -6686,6 +6687,7 @@ static int vmx_vm_init(struct kvm *kvm)
> >  		case L1TF_MITIGATION_FLUSH:
> >  		case L1TF_MITIGATION_FLUSH_NOSMT:
> >  		case L1TF_MITIGATION_FULL:
> > +		case L1TF_MITIGATION_DEFAULT:
> >  			/*
> >  			 * Warn upon starting the first VM in a potentially
> >  			 * insecure environment.
> 
> The L1TF bits need to be a separate patch.

I assume you mean just the part where L1TF_MITIGATION_DEFAULT is added?

-- 
Josh
