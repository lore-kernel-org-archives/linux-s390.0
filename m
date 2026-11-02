Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631171;
	b=lMD1b/isD7JF2sxvX3Zy6osk5TWwLkZOSYqsUOWcgMdi8u5HlN7u/9/JSJl8eYz6YeYK
	 nF9k3wykrGvxzcnxBI4x9EYAk9aEb/aiZWqcHn/fE+SQTG6Yge1LlpimMWhuyLzttmRb9
	 VySNAhy8vGFAyuW8JpjW5Zz9tPfLib5UGIGXKP6DLJChwVS3FqseCYF+b87HCASPAjC3N
	 gY2oAT4ZzLH3lCEsHbGYdyJPOKcjwTQ9unz1CRlfx2ILbx2H+I+jE8FbT40nTe/6zt3ni
	 o6asbWYn4tdlRJRL/mPQd0jzquYuKNPO7/8Dz4KOfsyCcyhUx+qSyWYaE+onpn8uyxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
	b=SaXB/QkyBCVRkQYaluz8qHadLBUR5wy6990PSXPFJ+jqDnPtNQXkJso5DlkXeZ8/ar0j
	 5a0MPGbJYamcHdxY31kMpGpkEYEAGk8cQEvEWfbQX0oLMiSDkTDFZEOxsYjiyfWQYI1UL
	 5Rj2QgZaHP/bh9oQERg//JvONElnSywM2pnAHNdnVJca7fruAfHNEktdNR/dLXTKxsUwZ
	 9p1NdZnFYbXGgHm6VzhhCLxnz6+5MTbDGnV0uM1L5CFKJM/OFhOGUsbVA5xaba3NTKqFR
	 HXpIdHVGekp4pm1Y9xvHE8cyOV1eBzojBI+vtZKoo0dfGx/Kmx70uFDK415m/k06sMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Co/5Vhq/";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55756606E018
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 14:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55756606E018
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Co/5Vhq/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1531397f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2026 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793631169; x=1794235969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
        b=Co/5Vhq/L8JGGMRN8JLdcMJBKEF/RQ/Lhi9x+AnQwA6LyrEfV25iJj/fXIjEYgpLpQ
         iipaN/pRR+jXeHb19XI8ny1xA+FnMA18B6ZBXoMTzhs0wH1LFqxJI6UpjlYKszLe8PLd
         VxnnbYspqt379w0JGGojHDTAiOskyLIpVh7iTvbFs/wxgDa4Rrx27SwjIYnLMHjSQFOS
         8J7CRDUAtLNHo/d06OZ8EfLlzFtBpM2NVxVo4x83RXyZfzq8bfBHK7SCDhBE95peArhQ
         f7Udn00wyKgRw9eBcbE3WEAz6rFTMDHDcXZlCCHCtVKqvGj6riTMEmJ5UbVVaRcK246Y
         L7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631169; x=1794235969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
        b=ZwKHiuMw9Qp3AEPnWPd31sN3t8ZcoB0ZoQfhyiOS2wOfyxXpxRT4FujHRf8NABkct0
         FS3CfZLTB1HgMH7EvzainRW4s84SqzTrf7PHXSfZ5vysg984Ck/AsmH+Flv6m2O8mhww
         daQ4wazBi0H0kp2fJgOoO3HZjH5m9b8v3BqfNZQkEXFkeeNN2IKjQl84GrKF3M8rf/zm
         hKYu8HwLHWzy+t/D0BBNFx8sISn8vIBZDanjKbjl6wwaGtv2+j3RGYfCs1H0rNkhWOTD
         QAa0VUMBZPNgCNyxx4xCemKWCH7bB89tEW/tLmSrSNxPyyt/RNpvvWthAcSmMrkPU2Gr
         MZJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxc2uxg5ISUWKV8u5Vl5D+22m/xjeIYr5q1ePq5rV1/PkgOmZk8blKj5WdUfvZvFIQdpV20d3rUQaRF@vger.kernel.org
X-Gm-Message-State: APuU4Z8tQzRqpD7Dc9fXhjXDVheElapzf6mPpVm9qRSt0JnK5DoksPzJ
	s/OUAghhNGdFCDEK+OhVFbws4ATD5NbTJe57Z5zn1cvPYgV1bQIkO0+ZbRaAxD0Wcxs=
X-Gm-Gg: AYBFou3R9H1iJwCMgGY9792zMRr+X1jQFQ6C1+en0UNXZSGTSKC51wHwq4lf7zc5bz9
	uD/yaSGdyTvhXQQ5Dhtb2VJmRLwkGYQatPyeyhQV7+ExgEIazbDCiuUU0nB4l3ir1GJEshUPtY3
	6DijOQ7bv+6UHH4c5jumJg4Bpcm9lE16Q2sLkmN3RPK/6eg8Xr4FQo2zN+g9B72TD3gd1aog6Nw
	yriIR2XpIPuH6BxYSvjkqw82d48+HHOElIliY/oNTbLGtMPm7VvceiiCGQNI3AT2Bc2c8bQrDgb
	2Y+ELH2rQB/QVWWQ922IBuD/YmH0lZ9jMrmHlwJ5WIoRnxBI/PcPc4jltrebfJckrziL5Sr0cF7
	slOJIcfNLKDs0mkpETCK+x6X2Qhe9SFkWfpwgKghXrf3wPdl0ETKEeAq6MBq6q3sxRKCKJuGJuR
	x7T6eM1V4YLJ72/XBFcp0vz09vaUCQSlb1seeFTe5GK9cERh3QXS/nODX2jdcXMa0DGIrDPhpC6
	WSZg8NVsOZasTJID/xeM1mDoe+Fwjl0eOiIqhBQh5PbmYVXpo0FoRPSBPgtjhr+WlviMYrnFd4G
	IZAZbAIoKahEOlNLAREauCAS8A4tOjDlvbiTRti+UDBlyQ5+7T+C2xiODFMnnfnVDzuSp9sfh7Y
	FrTxpZENXkQ==
X-Received: by 2002:a05:6000:40dc:b0:48d:e61d:68da with SMTP id ffacd0b85a97d-48e6e2fa50dmr24136852f8f.20.1793631168401;
        Mon, 02 Nov 2026 06:52:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm20266085f8f.23.2026.11.02.06.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:52:48 -0800 (PST)
Message-ID: <cbf60391-ebd5-4e3d-b38d-45b8d86d1574@suse.com>
Date: Mon, 2 Nov 2026 15:52:47 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: drain external refs before freeing a failed-init
 module
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pasic@linux.ibm.com, =wintera@linux.ibm.com
References: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/26 10:39 AM, Mahanta Jambigi wrote:
> When a module's __init makes it externally reachable (e.g. by registering a
> protocol family or a bus driver) and a later __init step fails, do_init_module()
> frees the module while callers that entered through that interface and called
> try_module_get() may still be executing module text.
> 
> The normal unload path in try_stop_module() refuses to proceed while
> module_refcount() is non-zero. The init-failure path has no such check and races
> to free_module() immediately after synchronize_rcu().
> 
> Fix it by waiting for all external references to drain before calling
> free_module(). Add a per-module struct completion refs_gone inside the existing
> CONFIG_MODULE_UNLOAD block that is initialised in module_unload_init() and
> completed from module_put() when refcnt drops back to MODULE_REF_BASE and the
> module state is MODULE_STATE_GOING. The fail: path calls wait_for_completion()
> (guarded by the same #ifdef) after dropping the loader's own reference,
> replacing the previous implicit assumption that no external refs exist at that
> point.
> 
> Also move wake_up_all(&module_wq) to before the drain so that concurrent loaders
> blocked in module_patient_check_exists() are unblocked immediately once
> MODULE_STATE_GOING is visible, rather than after the drain completes.
> 
> Fixes: 1fb9341ac348 ("module: put modules in list much earlier.")
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> ---
> Link: https://lore.kernel.org/all/5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com/
>       [RFC] module: init-failure path can free a module with live
>       try_module_get() users
> 
>  include/linux/module.h |  2 ++
>  kernel/module/main.c   | 33 +++++++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0dee2ed02a2d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -562,6 +562,8 @@ struct module {
>  	void (*exit)(void);
> 
>  	atomic_t refcnt;
> +	/* Completed when refcnt drops to MODULE_REF_BASE on init failure. */
> +	struct completion refs_gone;

Having a per-module completion that is needed only during module loading
is a bit wasteful. I think a global waitqueue, similar to module_wq,
should be sufficient. This would also avoid the use-after-free condition
described in my next comment.

>  #endif
> 
>  #ifdef CONFIG_CONSTRUCTORS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c1b34dc1e89a..655c693bd8e2 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -655,6 +655,7 @@ static int module_unload_init(struct module *mod)
>  	 * refcnt == 0 means module is going.
>  	 */
>  	atomic_set(&mod->refcnt, MODULE_REF_BASE);
> +	init_completion(&mod->refs_gone);
> 
>  	INIT_LIST_HEAD(&mod->source_list);
>  	INIT_LIST_HEAD(&mod->target_list);
> @@ -956,6 +957,14 @@ void module_put(struct module *module)
>  		ret = atomic_dec_if_positive(&module->refcnt);
>  		WARN_ON(ret < 0);	/* Failed to put refcount */
>  		trace_module_put(module, _RET_IP_);
> +		/*
> +		 * If refcnt just dropped to MODULE_REF_BASE and the module is going
> +		 * away due to an init failure, all external references are gone. Wake
> +		 * any thread waiting in the init-failure drain path.
> +		 */
> +		if (ret == MODULE_REF_BASE &&
> +		    module->state == MODULE_STATE_GOING)
> +			complete(&module->refs_gone);

module_put() can run concurrently with delete_module(). The module might
be gone after the atomic_dec_if_positive() call so this logic could lead
to a use-after-free.

>  	}
>  }
>  EXPORT_SYMBOL(module_put);
> @@ -3206,16 +3214,36 @@ static noinline int do_init_module(struct module *mod)
>  fail_free_freeinit:
>  	kfree(freeinit);
>  fail:
> -	/* Try to protect us from buggy refcounters. */
>  	mod->state = MODULE_STATE_GOING;
>  	synchronize_rcu();
> +
> +	/*
> +	 * Unblock concurrent loaders waiting in module_patient_check_exists() on
> +	 * module_wq. finished_loading() returns true once state is GOING, so they
> +	 * can now proceed. Do this before the drain below so a failed init delays
> +	 * only this task, not every other loader that raced to load the same
> +	 * module.
> +	 */
> +	wake_up_all(&module_wq);

This wakes up only modules waiting in module_patient_check_exists().
However, most duplicate loads using the newer finit_module() syscall
wait in idempotent_wait_for_completion(). They should be woken up as
well, so at worst only the current load gets stuck waiting on its
references to drain.

> +
> +	/* Drop the loader's own reference taken in module_unload_init(). */
>  	module_put(mod);
> +
> +#ifdef CONFIG_MODULE_UNLOAD
> +	/*
> +	 * Wait for all external references taken before MODULE_STATE_GOING became
> +	 * visible to be released. module_put() completes refs_gone when refcnt
> +	 * drops to MODULE_REF_BASE. The hung-task detector will catch any module
> +	 * whose error path leaks a reference.
> +	 */
> +	wait_for_completion(&mod->refs_gone);
> +#endif
> +
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
>  	ftrace_release_mod(mod);
>  	free_module(mod);
> -	wake_up_all(&module_wq);
> 
>  	return ret;
>  }

-- 
Thanks,
Petr
