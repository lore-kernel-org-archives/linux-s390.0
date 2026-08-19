Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497B2FF66A;
	Wed, 19 Aug 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156715; cv=none; b=Bio4Lhp2qfYz6zTueXLQz+mURwWWHBodomZJSvTpo6MaL0ytbbkpsf+VTb1QN7J0JUjwObryZssQqzoxE9tSKYljkM/MIebRB9GrtU16to+E3uWFkqCaVHp2NdQ7hC1IxZpZ8dg64Yh/UBK24S+Zi0J2A4W8NCEpOO5/D//Hfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156715; c=relaxed/simple;
	bh=8qxjmvUM2di0IfzyUDAvYCI+xTZvZatirM1EJzDQzVE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NAvroN45/oz3Kjx4f4rKcdYfquV+XgIMWE7HaDYJs39k07wofZ8LlwsoIfjpKZlUD1l0m7pB6YbUkFyaAA7teOELLjSly9eTy9xSC/qTDNL4yUbYW91/orjvcttzfw4M80pStr4ysZ/khQrCIGKbElThYL8iwCTF6B1ZhLlWqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=osjdMuP7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="osjdMuP7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=by5XecmrKO/JDJiisrHHs4GKvEuGPmvAEUy879BKKw4=; b=osjdMuP7J+f7cddyUx/G2hec8t
	nfUZbeRNSZP7SPbSCi6rUYGavfqj6NJLMAqjib01guKJgtvAhPOFhJ6N5dLv7eGmTg0qRTHAsXY+f
	nKFifp+9VohcJe5FSSfN0cZJiwY1rGHVmlfvPaSHdBFAYB0zIdjqJ1N+117gA379k42XyBVlHI+Pb
	LSEeJIJI9kXwe1wXbH2lEnJ3FChfH9HaZpOSMpr0UVmdzzHHYwpIhFVD1GSXkEJyfpy3/ancUQoSW
	r6U7vwGtOmTRzB4TbuxXv+OwrVOp3SR/1LSYbAwD5+1QUDN/czyRyIc9Ud7nrIHMUmyJQUYNhQFgy
	6+O9g+og==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj6E-006BnS-PZ; Wed, 19 Aug 2026 18:25:10 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj6D-00EYXT-OI; Wed, 19 Aug 2026 18:25:10 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj6D-000000027FO-2vFW;
	Wed, 19 Aug 2026 18:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:25:09 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, bpf@vger.kernel.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH RFC v2 06/13] sysctl, net: add register_net_sysctl{_sz}()
 wrappers for MODULE_SYSCTL_TABLE
In-Reply-To: <20260819024054.DDB0E1F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-6-d5a69dae5798@igalia.com>
 <20260819024054.DDB0E1F000E9@smtp.kernel.org>
Message-ID: <aec70e5fe7da3cbe1d3b61e1fcebda2a@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] When `CONFIG_SYSCTL` is disabled, the build fails due to a preprocessor conflict where the newly introduced `register_net_sysctl_sz` macro expands inside its own fallback static inline function definition.

Fixed.

> --
> 
> --- Patch [6]: [PATCH RFC v2 06/13] sysctl, net: add register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE ---
> commit fad97277609904f7e692d6e11a61fdff7e4ff635
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> sysctl, net: add register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE
> 
> This commit replaces register_net_sysctl() and register_net_sysctl_sz() with
> macros that automatically use MODULE_SYSCTL_TABLE for existing callers. It
> renames the actual sysctl registration function to __register_net_sysctl_sz()
> and adds optional template arguments to support dynamically defined paths and
> tables.
> 
>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>> index e5ee673b9fcf8..2127049c71ced 100644
>> --- a/include/net/net_namespace.h
>> +++ b/include/net/net_namespace.h
> [ ... ]
>> @@ -520,13 +520,48 @@ void unregister_pernet_device(struct pernet_operations *);
>> 
>>  struct ctl_table;
>> 
>> -#define register_net_sysctl(net, path, table)	\
>> -	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
>> +/*
>> + * The register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE
>> + * automatically create symbols in sysctl registration sites.
> [ ... ]
>> + */
>> +#define _register_net_sysctl_sz(net, path, table, size, table_tmpl, path_tmpl)	\
>> +({										\
>> +	MODULE_SYSCTL_TABLE(path_tmpl, table_tmpl);				\
>> +	__register_net_sysctl_sz(net, path, table, size);			\
>> +})
>> +
>> +#define register_net_sysctl_sz(net, path, table, size, tmpl_args...)		\
>> +	_register_net_sysctl_sz(net, path, table, size,				\
>> +				__sysctl_table_tmpl_or_default(table,		\
>> +							       ## tmpl_args),	\
>> +				__sysctl_path_tmpl_or_default(path,		\
>> +							      ## tmpl_args))
>> +#define register_net_sysctl(net, path, table, tmpl_args...)			\
>> +	register_net_sysctl_sz(net, path, table,				\
>> +			       __sysctl_table_array_size(table, ## tmpl_args),	\
>> +			       ## tmpl_args)
>> +
>> +/* Helper macro for optional template arguments */
>> +#define __sysctl_table_array_size(table, tmpl_args...)	\
>> +	ARRAY_SIZE(__sysctl_table_tmpl_or_default(table, ## tmpl_args))
>> +
>>  #ifdef CONFIG_SYSCTL
>>  int net_sysctl_init(void);
>> -struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
>> -						const struct ctl_table *table,
>> -						size_t table_size);
>> +struct ctl_table_header *__register_net_sysctl_sz(struct net *net,
>> +						  const char *path,
>> +						  const struct ctl_table *table,
>> +						  size_t table_size);
>>  void unregister_net_sysctl_table(struct ctl_table_header *header);
>>  #else
>>  static inline int net_sysctl_init(void) { return 0; }
> 
> [Severity: Low]
> Does this commit break the build when CONFIG_SYSCTL is disabled?
> 
> Because register_net_sysctl_sz() is now defined as a macro unconditionally
> above, the fallback static inline function in this #else block:
> 
> static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
> 	const char *path, const struct ctl_table *table, size_t table_size)
> {
> 	return NULL;
> }
> 
> will cause a macro expansion conflict.
> 
> Should this static inline function be renamed to __register_net_sysctl_sz()
> to avoid expanding the macro in its own definition and to provide the fallback
> implementation needed by the new macro?

-- 
Mauricio
