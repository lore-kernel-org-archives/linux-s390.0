Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C943D5656
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918647; cv=none; b=S417TJyCU5khbWTPaIgF3r7nyuYWTOPqPVUhQHzJNzmRul0XlRr+e9gNGv3cFhIbG2M/1Ms8LlxSR6OMamOpLxN3IPjyOMjtIysSPCUk6fpzmliLRcR/LePik4mACXiv0cKdAth0+5ATsFb0HNRJq2XI30jtWY8HPuZocFkIv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918647; c=relaxed/simple;
	bh=ioyjpTYahVnOWBhr/MamxD5RG95sppP+CU9ydVJYjSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SszGLdpQcOz3HUxGS4BkpSVPlxcWlsV2g/yCEAByEdNCCZLAejP4c6Ae0PO8RJnzcZvWtkdWpRQ3nr2sFiGjMhJgxGA/XBXAzGcY+dCPzk0osJGlZcrAjwPexr/WOt+vpU1ikfg2at50/09QnmOl4ifwLtfjFRFnhA9jfi6/DoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AATRDwSr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AATRDwSr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b8687630fso5902365e9.3
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787918635; x=1788523435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FUqt9t1EencF9nSDcvizzvehr/v/zWd6fGeSLy9Tio=;
        b=AATRDwSragpnbSvMRV3V2aGNoX6eztyoaD6Wg5X+ItIaz1ggOPcjM3pbPnjwWjMydY
         KV9sg8hfxy9k+fj2rVlfUsybgJEgypBeGSvi5/h289h/yftoa/y6ShygyAiZTpMyMA9y
         FmUb3nqXHBtrgXHtP6gI8D0RPt9j4EL+UXKy5WhDDAVr4yolTPV+gSs5xfTHU6zR3reL
         dd/qIuecjLffo6SbtZhTUAQG8VrO5bYwzwVR+VTLoTIxlt47DYvdvljJrRVyeq9aDWFx
         IaCstpZjUK5ByaWZRpv9u+WZuHDlnMDPi4g6sV2asQlnWE5yRLIFK0HNtO7oQFmmtdCl
         rYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787918635; x=1788523435;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FUqt9t1EencF9nSDcvizzvehr/v/zWd6fGeSLy9Tio=;
        b=m6b0LLJ9Bk/iji9CaWsyQgykUXL+yMNEMJcmAWjm0alMh6zjJ5Vd3ktpQ07YOA4PMV
         ye/0DGC9hnP2tT6eo/dbknHQ/mpLX96PvHESoN6tTe/J1JVWkCuuZAarbD2gKt/1f2Cs
         zpAj8Th3MT/AbPeBU+ZCBkn7JRGS61O0CmdZFOaPZzDhFIAEEuTNZ56r8vrHNPotK2JL
         purxRtGaaz8vzl2fF+33iCLk9MOFbiRti+xVgF64XnCAUXw9lTugDaqKoiIpQhfT6FmR
         mCGtYtgTI8pLrgEX9eZwbsREEVUpNIuahQOycUEOYo4kGzYMKSSNiUd75VzFjM1c9EIY
         cYtg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9r6wdY39uGdRr4YKdrz7w4pTv5tghL/rGIgUnWLFkOvQWEP/Gr70sN9PgXPPp7QKWyKh2rRaaPfnI@vger.kernel.org
X-Gm-Message-State: AFuF++mQkccF98qlLzmFvTHfSBSW5TO5oHMzqRnfizpKEece6l6jFg3L
	+VYS/XK1Nn6r4NSrTLDqv4Vq7hDfbdew+zMD5PDf0nK5eoUjbmllOsX31EINPU1n2Lg=
X-Gm-Gg: AR+sD12XL1sSkrlJZoRotlxtuEXEGpdegWuBfGdHGPbqK/1PumfivHaMd7+M2hloptE
	o0FrYcItnW7GI8qFxE6zbJaxeH/rSJLDNBDsuM4/9JXbEFf4hnxSk977IReZUCBQyNzv9cg+l/Y
	Tqn7OqAtAg2sHUDZae/eL/By49PnJm7Ed6CxQDTBjSIRmJVSN0ymJKjZU/P+T6AEBYDx73vpfjW
	ayxS6A/ny+4309J+GHeWwCsWoH4B71NqhAA/DdCg1G+J2uQcFPzzXhAH4NhhNfBB91nhBhmkZeI
	VZBqndKww5ywoPoK98wffmIKOo95aT+v/YOzd45zP2/3xw90WquH683LCx00flIol5rwud9BLu+
	i2pCEuJBIrR41pXvpbLBALM7gIBuX6xS/eZtHZVfU4uApkoAxPpgxfsf8bUJsfplZ9+2ReJatao
	5QDn0XgTL5cAkrOnEE1f00/u8dsuQGVSX+qcmQ8NR5CbRt7E7tVCzp+g2qJ5NneDA4vyqQK+k5g
	eiRL7I4JS0qQB3qCzrhGKMc
X-Received: by 2002:a05:600c:a418:b0:49b:9433:ea44 with SMTP id 5b1f17b1804b1-49b9433eb4dmr73573625e9.4.1787918635141;
        Fri, 28 Aug 2026 05:03:55 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm117554035e9.2.2026.08.28.05.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 05:03:54 -0700 (PDT)
Message-ID: <8b6506a1-5bfc-4f9b-92fa-234c89afe9ad@suse.com>
Date: Fri, 28 Aug 2026 14:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Hidayath Khan <hidayath@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 8:13 AM, Mahanta Jambigi wrote:
> Hi Luis, Petr, Daniel, Sami, Aaron,
> 
> I'm writing to ask about what looks like a generic module-init failure
> lifetime problem in the module loader. I ran into it while working on
> the SMC networking module (net/smc/), but after several patch
> iterations, it seems the root issue may belong in kernel/module/main.c
> rather than in SMC itself. I'd appreciate your guidance on whether this
> reading is correct, and if so, what fix direction would be preferred.
> 
> THE ISSUE IN do_init_module()
> =============================
> 
> include/linux/module.h has a long-standing FIXME in module_is_live():
> 
>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>        aren't used before they (may) fail. But presently too much code
>        (IDE & SCSI) require entry into the module during init. */
>     static inline bool module_is_live(struct module *mod)
>     {
>         return mod->state != MODULE_STATE_GOING;
>     }
> 
> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
> can succeed once a module's __init is executing. If __init makes the
> module externally reachable partway through and then later fails, the
> failure path in do_init_module() appears to do:
> 
>     fail:
>         mod->state = MODULE_STATE_GOING;
>         synchronize_rcu();
>         module_put(mod);
>         ...
>         free_module(mod);
> 
> synchronize_rcu() waits for RCU readers, but not for threads that
> already obtained a module reference via try_module_get() and are still
> executing module text.
> 
> By contrast, the normal unload path in try_stop_module() refuses to
> proceed while the refcount is non-zero.
> 
> So the asymmetry seems to be that the normal unload path waits for
> references to drain, while the init-failure path does not.
> 
> A concrete race would look like:
> 
>   1. Module __init registers an externally reachable interface.
>   2. User space enters through that interface and try_module_get()
>      succeeds while the module is still COMING.
>   3. A later __init step fails.
>   4. do_init_module() frees the module.
>   5. The in-flight caller is still executing module text.
> 
> SMC AS A CONCRETE EXAMPLE
> =========================
> 
> In SMC, simply moving registration later does not appear to eliminate
> the window, because there are two separate registration points that can
> make the module reachable via socket():
> 
>   1. sock_register(&smc_sock_family_ops)
>      After this, socket(AF_SMC, ...) can succeed and reach
>      try_module_get() via __sock_create().
> 
>   2. smc_inet_init() -> inet_register_protosw()
>      After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
>      and again reach try_module_get().
> 
> Either registration point can succeed before a later init step fails.
> 
> This may not be specific to SMC; other protocol modules that become
> reachable during init, such as Bluetooth, may have similar exposure and
> appear worth auditing as well.
> 
> ON THE FIXME'S IDE/SCSI CONCERN
> ===============================
> 
> The FIXME mentions IDE and SCSI as reasons not to isolate modules
> during init.
> 
>   1. IDE was removed in Linux 5.14, so that half of the concern no
>      longer applies.
> 
>   2. SCSI still appears to self-reference during init
>      (scsi_device_get() -> try_module_get(hostt->module) during
>      scsi_scan_host()), so a blanket wait-for-refcount-to-drain
>      approach in the failure path may deadlock there.
> 
> Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
> -EBUSY, so the infrastructure for refusing callers during init already
> exists in some form.
> 
> QUESTIONS
> =========
> 
> First, is my reading of this init-failure refcount/lifetime asymmetry
> correct?

Your analysis looks correct to me.

> 
> If so, would one of the following directions be acceptable?
> 
>   1. An opt-in mechanism (for example, a module flag) for modules that
>      are safe to isolate during init and whose init-failure path should
>      wait for external references to drain.

In general, it is preferred if the module loader handles all modules in
the same way.

I would say that the module loader should wait for external references
to drain after an init failure for all modules and that it should be the
responsibility of individual modules to ensure that this wait eventually
completes. Excluding some modules would mean that the module loader
could still free them while they are in use by the kernel.

Before such a wait, the module loader should cancel all idempotent
module loads. This is especially important during boot when several
udevd workers may be trying to insert the same module. In that case,
a failed module init function should block only a single udevd task, so
that the system can still boot properly.

> 
>   2. Treating MODULE_STATE_COMING as non-live for normal
>      try_module_get() users, with some explicit escape hatch for the
>      remaining subsystems that genuinely need self-entry during init.

This might make sense, but the kernel currently has over 500 users of
try_module_get() so changing its semantics in this way would need to be
done very carefully.

I'm also not sure there is anything inherently wrong with calling
try_module_get() on a module while it is still executing its init
function. It must mean the module has reached a state in which it
properly initialized functionality to be registered with a specific
subsystem.

For instance, the __sock_create() function mentioned in your email
contains (simplified):

[...]
	if (rcu_access_pointer(net_families[family]) == NULL)
		request_module("net-pf-%d", family);

	rcu_read_lock();
	pf = rcu_dereference(net_families[family]);
	err = -EAFNOSUPPORT;
	if (!pf)
		goto out_release;

	if (!try_module_get(pf->owner))
		goto out_release;
[...]

Consider two tasks that both call socket(XYZ). The first one sees
net_families[family]==NULL and calls request_module(XYZ). The module
then starts loading and its init function calls sock_register(XYZ). At
this point, the second task can see that net_families[family]!=NULL, so
it skips request_module(XYZ) and calls try_module_get(pf->owner). If
that call newly fails because the module is still in
MODULE_STATE_COMING, it breaks the autoload functionality of
__sock_create().

The scheme would need to be changed to call request_module(XYZ) if
either net_families[family]==NULL or !try_module_get(pf->owner).

> 
> Any guidance on the preferred direction would be much appreciated.

Waiting for external references to drain after an init failure makes
sense to me. I'm less sure about changing the semantics of
try_module_get(), or whether strong_try_module_get() should instead be
exposed.

-- 
Thanks,
Petr
