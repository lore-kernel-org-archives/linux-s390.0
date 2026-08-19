Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACD2FF66A;
	Wed, 19 Aug 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156700; cv=none; b=KoUBDc7RZnfLS69wodpnnBH8LNKx4NxxYL0go2AQHUA3w31AyMu2VflkKM3ZdYxH6nZvqAdlQoZzrLYVUy3ZrHkzg8RQ1NYhyswrqSgpcttnWG9ejSiN/qsr5BhzX2NUlS8O8SI70xMFH4ZayI1/Pgqc77DqclO+RuJGmnyKfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156700; c=relaxed/simple;
	bh=tiUkh4CXcgWdb8T5QjHF78jxJUt0AICUL9u1PZGDpJU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pkUdH8G0lF7vbMJ5SwBbADAdn3XZ2sOUmLxQR/4OKX/U5RDGBsTJ3/oQZ098AOdFjKw3s7p/M+oyvdOqdY5wLlAJsV6O9muBPPAx7CuGLN3xMCl9lreONd0WVp4dc6Wtdqif/UFt5PS2iN6u3kQjHAWwyz+zsNd7ICfuufjIXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PD979zmA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PD979zmA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=ieH8yXwVQoecHWb1KauxcH1NWtDhTmFX9Ha642wE9dU=; b=PD979zmAMQvSR/X0nScgdA6RXG
	99oYYjuceAJ+2px8dVClqYbnckWNYMfg5kLb5sGA8xrCRevHaKnd4F4jz1VrVELJwe6gWxPxWLHvG
	rqp5W1iPjvO4UUdhOiGlk+hihGE5DNe5v38K6aOIOjzjfP9NVGR/d3oZbEURm05RS8Ka9tixVku0+
	kgdYCZgAMB49ksJwNtNNog3pXxiB+1Di+biqIsbnjyNXYQItZRxeuggXT9vzNwdODTaqjqBpEpM3T
	c/Nzm10baaANKWpjlm4auYOIlqT4rN1epduV82oe7438NmlQqcK4nelCXaTV/xLOhnSQG+E+94Fx2
	O7wK9OyA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj60-006Bn2-5N; Wed, 19 Aug 2026 18:24:56 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj5z-00EYVP-8F; Wed, 19 Aug 2026 18:24:56 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj5z-000000027F1-0r6f;
	Wed, 19 Aug 2026 18:24:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:24:55 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, mptcp@lists.linux.dev, Vasily Gorbik
 <gor@linux.ibm.com>, bpf@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/13] proc: add config option
 SYSCTL_MODULE_ALIASES
In-Reply-To: <20260819023701.5197B1F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-2-d5a69dae5798@igalia.com>
 <20260819023701.5197B1F000E9@smtp.kernel.org>
Message-ID: <253d5572bd8c3020775b61e8ac9eb675@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The Kconfig option `SYSCTL_MODULE_ALIASES` is introduced but never used in the codebase.

It's used in later patches; apparently not a problem.

> - [Low] Grammatical error in the Kconfig help text: 'This options adds' should be 'This option adds'.

Fixed.

> --
> 
> --- Patch [2]: [PATCH RFC v2 02/13] proc: add config option SYSCTL_MODULE_ALIASES ---
> commit 931fa1a5261f1467829ad7b64b387a4e318eb177
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> proc: add config option SYSCTL_MODULE_ALIASES
> 
> Add a config option for the 'sysctl:' module aliases feature.
> 
>> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
>> index 24f5a36f45df8..e6591ec4bcf0a 100644
>> --- a/fs/proc/Kconfig
>> +++ b/fs/proc/Kconfig
>> @@ -98,6 +98,19 @@ config SYSCTL
>>  	  building a kernel for install/rescue disks or your system is very
>>  	  limited in memory.
>> 
>> +config SYSCTL_MODULE_ALIASES
>> +	bool "'sysctl:' module aliases (EXPERIMENTAL)"
> 
> [Severity: Low]
> Is this config option fully implemented in this commit? The
> SYSCTL_MODULE_ALIASES option is being introduced here, but it doesn't look
> like CONFIG_SYSCTL_MODULE_ALIASES is referenced anywhere else in the C code,
> Makefiles, or scripts.
> 
>> +	depends on SYSCTL && MODULES
>> +	default n
>> +	help
>> +	  The /proc/sys files registered by a module do not exist until the
>> +	  module is loaded; meanwhile, userspace cannot find or access them.
>> +
>> +	  This options adds 'sysctl:*/<path>/<file>' module aliases for the
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the help text: "This options adds"
> should likely be "This option adds".
> 
>> +	  /proc/sys files registered by modules, so modules for nonexistent
>> +	  files can be loaded with 'modprobe sysctl:/proc/sys/<path>/<file>'
>> +	  by userspace when needed.

-- 
Mauricio
