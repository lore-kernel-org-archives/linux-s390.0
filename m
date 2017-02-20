From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to
 refcount_t
Date: Mon, 20 Feb 2017 13:30:51 +0100
Message-ID: <20170220123051.ioox335zkcgt672s@pd.tnic>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
 <20170220111727.7vohleiu2btmsx3g@pd.tnic>
 <2236FBA76BA1254E88B949DDB74E612B41C4D921@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C4D921@IRSMSX102.ger.corp.intel.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Luck, Tony" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 20, 2017 at 12:20:04PM +0000, Reshetova, Elena wrote:
> Whole refcount conversion was a long piece of work and the above
> people contributed to this code either as writes or reviewers or both.

We have

Reviewed-by:

for reviewers.

> I am primary writer of the code and I am handing patches in our tree
> and sending them out, so how exactly the above should look like?

Well, the SOB chain should reflect who handled the patch on its way from
the original author to the upstream committer. If you want to express
who contributed, you can use Originally-by, Suggested-by, ...

You could also have free text in the commit message:

"People who contributed to this: ..."

In any case, it is all in Documentation/process/submitting-patches.rst.
Have a look.

> Please note that we have about 300 patches and if I have to modify
> each sign-off to reflect who contributed to each commit in what
> particular way, I will go insane.

There's sed/awk/perl/python/bash... whatever tools that can do the
proper conversions with.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
