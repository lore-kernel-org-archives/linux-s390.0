Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B791486E6A;
	Wed, 19 Aug 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156751; cv=none; b=XiSwnURxgeMIAXPPQQLgG+6WhYy6AHz2QjH8RydJAfkS+LzV93WAPfOhwlItu318SxPorVj4YfS/+ERH4Z/HNOcaOuGhWqgwFpyXlD995ZBHMBXIZMOERCjct/SHGCSH83Xh4BqobNpylutiZ2tOp6taIokjTr3kUsVTlJ5YjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156751; c=relaxed/simple;
	bh=APA0y0Sh1/n2jOo6OfMzEac2yykX9OLErHBCLIVl4DQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Jk82GnKUFMniyU54UluSzioW4NbhW9QqFzNDYQ8yl2AB8dqWCsMuY7ColdxlPZdQWzOY61X5QkemBHczxJ0yVtB1DpNp85SRkV+tWKLuUC9rAODg8QsEIej/hKDdo4ANTa4Zc/dZWgBZS2JmB5NzxDoQRLZ47Gyl9gHH/OSzAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PRmqeKIU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PRmqeKIU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=DfNixDkq550yzQ3zxwaw2hwQw/y2D5dTU2n9xlcvBx4=; b=PRmqeKIURkHUTjkBFw477cryw0
	ztISeM8q5BX2UujzsnoAOGiGLCX79ww8PELa/uL5gYd7eBG50K2wXwH1KEA6uE7Zjd2NdHiODUet5
	85iqFATnHb2ZNVkudr8u84mHW8NT05h9XpxgtnoLcRjxwx/bCWBfah/HqPBGmjEp6/6UlewbbVeQP
	r9C0PHS53CTZ9eNqOKgIWCnbbkc8d/VptmfgM5FNW+XQN2igix1QTh+hpy9QmCL9EBG47yFfvzKJu
	wbQotENNtKeXAh8imm582qbJqcABUsm28pt4sw9qZbkmF3LCS76W4yg+zFRpmhMUDVyhAbIjm+in/
	zwCbu/zw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj6q-006BoU-0K; Wed, 19 Aug 2026 18:25:48 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj6o-00EYbF-UB; Wed, 19 Aug 2026 18:25:47 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj6o-000000027GR-3hT8;
	Wed, 19 Aug 2026 18:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:25:46 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH RFC v2 07/13] sysctl, net: update
 register_net_sysctl{_sz}() callers with template arguments
In-Reply-To: <20260819024803.6ECC11F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-7-d5a69dae5798@igalia.com>
 <20260819024803.6ECC11F000E9@smtp.kernel.org>
Message-ID: <e93b91328d6500df3f4dbb5ec91ace9c@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Syntax error and implicit function declaration when CONFIG_SYSCTL is disabled due to macro collision.
> - [Low] The `__UNIQUE_ID` macro is used without arguments in `__MODULE_SYSCTL_TABLE_NAME`, preventing it from generating a unique identifier.

Both fixed previously.

> --
> 
> --- Patch [7]: [PATCH RFC v2 07/13] sysctl, net: update register_net_sysctl{_sz}() callers with template arguments ---
> commit 35e3405d9382d3cfe84c302ce928023b61da151b
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> sysctl, net: update register_net_sysctl{_sz}() callers with template arguments
> 
> Update most callers with dynamic table/path to use template arguments.
> 
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index 1349c0eedb642..bdd67dd879d24 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -12,6 +12,7 @@
>>   */
>> 
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#define SYSCTL_MODULE_ALIASES_UNIQUE_ID
> 
> [Severity: Low]
> When SYSCTL_MODULE_ALIASES_UNIQUE_ID is defined here, the macro
> __MODULE_SYSCTL_TABLE_NAME(table) in include/linux/sysctl.h expands to
> __mod_device_table(sysctl, __UNIQUE_ID).
> 
> Since __UNIQUE_ID is a function-like macro requiring a prefix argument, does
> omitting the parentheses prevent it from being expanded by the preprocessor?
> Could this create identical literal symbol names for all instances in a module
> and defeat the uniqueness mechanism?
> 
>> 
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
> [ ... ]
>> @@ -3910,11 +3911,15 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>>  	      BUG();
>>  	}
>> 
>> -	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
>> -		p_name, dev_name_source);
>> +#define path_template "net/%s/neigh/%s"
>> +	snprintf(neigh_path, sizeof(neigh_path), path_template,
>> +		 p_name, dev_name_source);
>>  	t->sysctl_header = register_net_sysctl_sz(neigh_parms_net(p),
>>  						  neigh_path, t->neigh_vars,
>> -						  neigh_vars_size);
>> +						  neigh_vars_size,
>> +						  neigh_sysctl_template.neigh_vars,
>> +						  path_template);
> 
> [Severity: Low]
> Does this call to register_net_sysctl_sz() cause a build failure when
> CONFIG_SYSCTL is disabled?
> 
> It looks like register_net_sysctl_sz is globally defined as a macro, which
> unconditionally expands over the static inline fallback definition in
> include/net/net_namespace.h, producing invalid C syntax. Additionally, would
> this macro expand to __register_net_sysctl_sz(), which lacks a stub in the
> !CONFIG_SYSCTL path, causing implicit function declaration errors?
> 
>> +#undef path_template
>>  	if (!t->sysctl_header)
>>  		goto free;

-- 
Mauricio
