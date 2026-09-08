Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66E533594
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869475; cv=none; b=q849yGAwSRl4SG2EKBbpSHjXhYRxmD5ECIe+isNuq1TzSuYcCFyW1zzrLX0YKFhFnT2c1SUGmZHZVmr8C2QtecwaIcvK1XdZEpkwburWOfrbkOSTwPlJ+wQnXWEeTrPRqlKSmc7MK9qv9+R1pnDVqGH3B7yWuvPKKpxXbFkbmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869475; c=relaxed/simple;
	bh=mlMBJVkGekTwfc/d7j0y6RTfUgXm9izZZ7ZBU2yIX3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG8J8HnDva1NRjoITwaZSZoIlnCeUVC5g+HL5k1b3FQn9XIRuqrLkzbDx0dlqw29oxmhT3pq8VlDm8sNfq85p7uIE2stJiVBpNxWdecDDURXMkUXUOHRv9dlSPZ4pvotfrVmTGTm4sdRzPf3NlwZ23LWTjZgoDBzwwc6zERB8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BxQYXoal; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BxQYXoal"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1677c91969so453301366b.1
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869462; x=1789474262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTfnI3dp+d0/TG/Khs2JVLg9UCJ0wepa2hj2cOspexQ=;
        b=BxQYXoalHux0OFHMoBQ5da/zUkwbG0Ra+1UXUBuTSHF8N0lX0KO6LgNnA/kn4u3NWo
         Um7WGzk0EA+QCxKd2kERU/JOr8+PaPOZ/wK9Fx7UVz4gjPbhatupwZ23kS8RT1iGx4ke
         FxosajLyOeeQof3KuWE7jFVU6LbLgOjcQ/HviJRvdNT6UJSXfMdDkO2xIrstb2Da4aD0
         ZP9SVmTBTYdND0bRzhmrcs2pdkO+tW9cNzcOoG1VVoVZr1WeL7XA3hwyrBrHLPqSqhpx
         q7nSuXGHSjclb8AtvlvPljiLMRa767m6QLp+mtPT/0mNVrXR+k8y3/AIQUo3AGqaVfWb
         0WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869462; x=1789474262;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTfnI3dp+d0/TG/Khs2JVLg9UCJ0wepa2hj2cOspexQ=;
        b=Z/+mbxyup7fDu2iEy2e4xeYuZDexlHZJdXmESdfvY5UdnauSbiapiiOh1V7mKhk6Wl
         wWRmnygp8Z0xwtCyz2t5SFPGL5A6znANxxpbXI6KSGLRkk1/ONXrlGzx5bY/c/vF9LMT
         ev3Jr6x+CwcJElxI0g9P6qMqbXRw8uxQv/c36hhqQUe/KP18ZyD6wrUMVQNQpiRG9Dmt
         7YI2nfgdIoi+onDL9xw5kC94eNs3ja6+ecIEHWA5kdnQRH+CYxVc3TUM+WBMEKWO3VTq
         Vc+Njd9lCgdBVuSovI6FeAt4MVlX9hHkhq81qyF9DrDN+kj45iFCE5L/AIeFFHtb7RDg
         nqNw==
X-Forwarded-Encrypted: i=1; AKwUvBxoXBZ//F2OMIf5af2OG3OtIk9gca8R0JqmdmxkuUsibBvftMsJ2IpqJZ+N0qPViiy03ghQohCx8/6V@vger.kernel.org
X-Gm-Message-State: AFuF++mNUfBgXW3tw6HkLmd/GbYZk4M7eiPpcQQfbDpGdSMVrw+54GIx
	k0WaFjrXFr09WXeB8RJxWFmc0ctoVoCSQrwMVzNIV5d9bq1FiW7Vzp4zVUl/gPRq1iY=
X-Gm-Gg: AYBFou23DlysPwS1daQ8Ui4h7eUrC41aHw3y1BT9RHlN0xq017aL2soFNlEqWqHOoAQ
	wreGHYGdXuTC7NAINRa9I/rM3e5coRBXCtKGpjyiX7igRByeH3l2vSjMW+yJ6B3YolByG4KeqpY
	ZYuyHV2SMX65bl/ZYLntprFu1esXwZ/x2Hpz7CVAiyC2slHOgcdPfkz411/dLDK/2Wc3NNOxDEN
	NwGFPE2GyhebtuerMx4iSlEwtbpqiFyhPrRfGOjrlvKuETSj+fNct9E4svaDjt8EfiVON2jHIRH
	dPh0X/sJcPCcV1a0+NbINCDth33SJLyauINe4mFJChHujuHWtYV6EIVR9nb4trRtRU9/faFkwt5
	88T7qVOraAy5Ymlrctsto9sffSniVEFaF6qCvE2IRFWzNZTBj0dVZZkTRZO43p6jge07WEfcW29
	w/s0IOphUI0I0YX1O6A08Kjjcr5LdZhlrQj1V/RhIJCFg7yJcQq57tHlzBvFqzn6Ee+/RI1yvYk
	/EhW1S6eA931XBBMDd61cmZ31Kvxjfc2LNlmstCyIB2CELldqN0LdEbkBNP5Vesw/wBD1IOjglD
	F/0PIpTOufVnJCkpWhlrnqzkad4lzA==
X-Received: by 2002:a17:907:e013:20b0:c28:ebc7:9e67 with SMTP id a640c23a62f3a-c28ebc79ed4mr328134766b.45.1788869461543;
        Tue, 08 Sep 2026 05:11:01 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036674sm619593866b.8.2026.09.08.05.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 05:11:01 -0700 (PDT)
Message-ID: <90d4523b-70e7-44a2-9c8b-107f1087c18a@suse.com>
Date: Tue, 8 Sep 2026 14:10:59 +0200
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
 <8b6506a1-5bfc-4f9b-92fa-234c89afe9ad@suse.com>
 <37021811-78ac-4bdd-ab59-62fb089850f3@linux.ibm.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <37021811-78ac-4bdd-ab59-62fb089850f3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/31/26 12:00 PM, Mahanta Jambigi wrote:
> On 28/08/26 5:33 pm, Petr Pavlu wrote:
>> On 8/24/26 8:13 AM, Mahanta Jambigi wrote:
>>> Hi Luis, Petr, Daniel, Sami, Aaron,
>>>
>>> I'm writing to ask about what looks like a generic module-init failure
>>> lifetime problem in the module loader. I ran into it while working on
>>> the SMC networking module (net/smc/), but after several patch
>>> iterations, it seems the root issue may belong in kernel/module/main.c
>>> rather than in SMC itself. I'd appreciate your guidance on whether this
>>> reading is correct, and if so, what fix direction would be preferred.
>>>
>>> THE ISSUE IN do_init_module()
>>> =============================
>>>
>>> include/linux/module.h has a long-standing FIXME in module_is_live():
>>>
>>>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>>>        aren't used before they (may) fail. But presently too much code
>>>        (IDE & SCSI) require entry into the module during init. */
>>>     static inline bool module_is_live(struct module *mod)
>>>     {
>>>         return mod->state != MODULE_STATE_GOING;
>>>     }
>>>
>>> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
>>> can succeed once a module's __init is executing. If __init makes the
>>> module externally reachable partway through and then later fails, the
>>> failure path in do_init_module() appears to do:
>>>
>>>     fail:
>>>         mod->state = MODULE_STATE_GOING;
>>>         synchronize_rcu();
>>>         module_put(mod);
>>>         ...
>>>         free_module(mod);
>>>
>>> synchronize_rcu() waits for RCU readers, but not for threads that
>>> already obtained a module reference via try_module_get() and are still
>>> executing module text.
>>>
>>> By contrast, the normal unload path in try_stop_module() refuses to
>>> proceed while the refcount is non-zero.
>>>
>>> So the asymmetry seems to be that the normal unload path waits for
>>> references to drain, while the init-failure path does not.
>>>
>>> A concrete race would look like:
>>>
>>>   1. Module __init registers an externally reachable interface.
>>>   2. User space enters through that interface and try_module_get()
>>>      succeeds while the module is still COMING.
>>>   3. A later __init step fails.
>>>   4. do_init_module() frees the module.
>>>   5. The in-flight caller is still executing module text.
>>>
>>> SMC AS A CONCRETE EXAMPLE
>>> =========================
>>>
>>> In SMC, simply moving registration later does not appear to eliminate
>>> the window, because there are two separate registration points that can
>>> make the module reachable via socket():
>>>
>>>   1. sock_register(&smc_sock_family_ops)
>>>      After this, socket(AF_SMC, ...) can succeed and reach
>>>      try_module_get() via __sock_create().
>>>
>>>   2. smc_inet_init() -> inet_register_protosw()
>>>      After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
>>>      and again reach try_module_get().
>>>
>>> Either registration point can succeed before a later init step fails.
>>>
>>> This may not be specific to SMC; other protocol modules that become
>>> reachable during init, such as Bluetooth, may have similar exposure and
>>> appear worth auditing as well.
>>>
>>> ON THE FIXME'S IDE/SCSI CONCERN
>>> ===============================
>>>
>>> The FIXME mentions IDE and SCSI as reasons not to isolate modules
>>> during init.
>>>
>>>   1. IDE was removed in Linux 5.14, so that half of the concern no
>>>      longer applies.
>>>
>>>   2. SCSI still appears to self-reference during init
>>>      (scsi_device_get() -> try_module_get(hostt->module) during
>>>      scsi_scan_host()), so a blanket wait-for-refcount-to-drain
>>>      approach in the failure path may deadlock there.
>>>
>>> Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
>>> -EBUSY, so the infrastructure for refusing callers during init already
>>> exists in some form.
>>>
>>> QUESTIONS
>>> =========
>>>
>>> First, is my reading of this init-failure refcount/lifetime asymmetry
>>> correct?
>>
>> Your analysis looks correct to me.
>>
>>>
>>> If so, would one of the following directions be acceptable?
>>>
>>>   1. An opt-in mechanism (for example, a module flag) for modules that
>>>      are safe to isolate during init and whose init-failure path should
>>>      wait for external references to drain.
>>
>> In general, it is preferred if the module loader handles all modules in
>> the same way.
>>
>> I would say that the module loader should wait for external references
>> to drain after an init failure for all modules and that it should be the
>> responsibility of individual modules to ensure that this wait eventually
>> completes. Excluding some modules would mean that the module loader
>> could still free them while they are in use by the kernel.
>>
>> Before such a wait, the module loader should cancel all idempotent
>> module loads. This is especially important during boot when several
>> udevd workers may be trying to insert the same module. In that case,
>> a failed module init function should block only a single udevd task, so
>> that the system can still boot properly.
>>
> Thank you for the clear direction. I agree with both points — uniform
> handling for all modules, and unblocking concurrent loaders before the
> drain wait. Below is the proposed change with the rationale for each
> step. Proposed change to the fail: path in do_init_module().
> 
> fail_free_freeinit:
> 	kfree(freeinit);
> fail:
> 	/*
> 	 * Mark dying so try_module_get() fails for all new callers.
> 	 * synchronize_rcu() ensures this is visible on all CPUs before
> 	 * we proceed; no new references can be taken after this point.
> 	 */
> 	mod->state = MODULE_STATE_GOING;
> 	synchronize_rcu();

The comment is somewhat misleading. The code invokes synchronize_rcu()
to wait for any existing RCU readers to finish before proceeding, making
sure that all new readers now observe the GOING state.

> 
> 	/* Drop the loader's own reference taken in module_unload_init(). */
> 	module_put(mod);
> 
> 	/*
> 	 * Unblock concurrent loaders before blocking on the drain below,
> 	 * so that a failed init delays only this task, not every udevd
> 	 * worker that raced to load the same module.
> 	 *
> 	 * Two dedup paths exist:
> 	 *
> 	 * - finit_module path: losers of the inode race sleep in
> 	 *   idempotent_wait_for_completion(). They are unblocked by
> 	 *   idempotent_complete() in idempotent_init_module(), which
> 	 *   runs as do_init_module() returns — before we reach here.
> 	 *   No action needed.

This looks incorrect. Since this code is added in do_init_module(),
idempotent_complete() has not yet been invoked.

> 	 *
> 	 * - init_module path: callers sleep in module_patient_check_exists()
> 	 *   on module_wq waiting for finished_loading(), which returns
> 	 *   true once state == MODULE_STATE_GOING. wake_up_all() kicks
> 	 *   them loose immediately.
> 	 */
> 	*wake_up_all*(&module_wq);
> 
> 	/*
> 	 * Drain async workers scheduled during __init (e.g. SCSI async
> 	 * scan). MODULE_STATE_GOING is visible everywhere, so workers
> 	 * that have not yet called try_module_get() will fail cleanly.
> 	 * Workers already holding a reference complete and release it
> 	 * naturally. Must run before free_module() regardless of
> 	 * async_probe_requested.
> 	 */
> 	*async_synchronize_full*();
> 
> 	/*
> 	 * Wait for references taken before MODULE_STATE_GOING became
> 	 * visible. refcnt is monotonically decreasing from here; the
> 	 * loop terminates provided the module's error path pairs every
> 	 * __module_get() with a module_put(). The hung-task detector
> 	 * catches violations.
> 	 */
> 	while (*module_refcount*(mod) != 0)
> 		msleep(10);

I think that instead of repeatedly polling the module refcount, it would
be better for this code to sleep and for module_put() to wake it when
the refcount drops to 0. This could be implemented using either the
existing module_wq, a separate wait queue or a per-module completion.

-- 
Thanks,
Petr
