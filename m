Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E80283FE5;
	Wed, 19 Aug 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156742; cv=none; b=PU2Qcq2XqJdjXLq29Q7aLRIcz0RI9MjvgnodltTF8z/ye5VN4ONyHb8YsnP+sZzefVW+F/GxCeTx0AYr1hgIB+s6YpV7r8G8BwrN76XIpVgB/mrVu5awiJO/pFjfUhln0Kr8Z3nywrYd5aon25WddlbEo/rBYqGFfDyhCztfusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156742; c=relaxed/simple;
	bh=d4FdmMdthtOm0xpVhJmw4sxQ4QnmlWT5Jhikl3W2UbQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UHGkKF+evnFsoEeSCN/D+q6mx/2GpRLq8B+pQONBhgUsceiSb3U1FnjxPSSU1tzy4uA+n+n4QBJ4yue+kKYW1e5XfeQaY3vyqQFaIdXF+aG/oFKYRXfA71yG9lXy7ufgfQHbd3ujXZqP34zW5TPnS4pGB6uK8OZUwL3CqkEQFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gJQY6Swo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gJQY6Swo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=6rvuvxyz9Gaqgy4aBWCYOJVahBBjGh0EWxWrJiubrcs=; b=gJQY6SwoWLIr5e/Xx8LhtnVS3O
	WJjOiulfadPgrLk7KHRFGhhzsQH2iHMltSaLzRUHFdRZo72glvKLHmQCa22HjVwydwT/ZJwTX/c/o
	dG+bxgwVbkhGC65kYRwxPpkP498H/7U4zDzMtQd/DzgDi81qBFu3vSKPydEv3eL99ylFcsZV3sGRX
	AuunZQD5GrFuFnJdIMWiq0/YoC9XHSF1BUhCEW5ASTUVdq8USRZcVgQgPOr0PZfT4FTeSGOFe7/AS
	RSdCAc3wD1AtevqiQEoHw1O6Y+3H7+2HVqSegIULfsvL6Gok79pp3TVcubBq+0rGuJj2oQHPahMz2
	PzkUKLvQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj6g-006BoG-Ul; Wed, 19 Aug 2026 18:25:38 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj6g-00EYaW-05; Wed, 19 Aug 2026 18:25:38 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj6f-000000027G4-3yRT;
	Wed, 19 Aug 2026 18:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:25:37 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, bpf@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH RFC v2 04/13] sysctl: add register_sysctl() wrapper for
 MODULE_SYSCTL_TABLE
In-Reply-To: <20260819024437.87E5E1F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-4-d5a69dae5798@igalia.com>
 <20260819024437.87E5E1F000E9@smtp.kernel.org>
Message-ID: <16f235f38612f57d670db10cd630bde0@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The macro `__UNIQUE_ID` is used without an argument in `__MODULE_SYSCTL_TABLE_NAME`, preventing its expansion.

Fixed.

> - [Low] Dangling trailing backslash on the last line of the `register_sysctl` macro definition.

Fixed.

> --
> 
> --- Patch [4]: [PATCH RFC v2 04/13] sysctl: add register_sysctl() wrapper for MODULE_SYSCTL_TABLE ---
> commit 5518fc079c95785ae760d86da6be17693ac8aeea
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> sysctl: add register_sysctl() wrapper for MODULE_SYSCTL_TABLE
> 
> Add a MODULE_SYSCTL_TABLE call into register_sysctl() for existing callers
> to automatically use it.
> 
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 6960fe22c50bf..7e05fafd5544e 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -335,8 +335,58 @@ struct ctl_table_root {
>>  #define MODULE_SYSCTL_TABLE(path, table)
>>  #endif
> 
> [Severity: Medium]
> Does this code prevent __UNIQUE_ID from being expanded correctly?
> 
> Looking at __MODULE_SYSCTL_TABLE_NAME in include/linux/sysctl.h:
> 
> #define __MODULE_SYSCTL_TABLE_NAME(table) \
>         __mod_device_table(sysctl, __UNIQUE_ID)
> 
> Since __UNIQUE_ID is a function-like macro that requires an argument, using it
> without parentheses prevents preprocessor expansion. This results in the
> literal string being used to construct the symbol name, which defeats the
> purpose of generating a unique identifier and could cause symbol redefinition
> errors if MODULE_SYSCTL_TABLE is used multiple times.
> 
>> -#define register_sysctl(path, table)	\
>> -	register_sysctl_sz(path, table, ARRAY_SIZE(table))
>> +/*
>> + * The register_sysctl() wrapper for the MODULE_SYSCTL_TABLE macro
> 
> [ ... ]
> 
>> +#define _register_sysctl(path, table, table_tmpl, path_tmpl)			\
>> +({										\
>> +	MODULE_SYSCTL_TABLE(path_tmpl, table_tmpl);				\
>> +	register_sysctl_sz(path, table, ARRAY_SIZE(table));			\
>> +})
>> +
>> +#define register_sysctl(path, table, tmpl_args...)				\
>> +	_register_sysctl(path, table,						\
>> +			 __sysctl_table_tmpl_or_default(table, ## tmpl_args),	\
>> +			 __sysctl_path_tmpl_or_default(path, ## tmpl_args))	\
> 
> [Severity: Low]
> Is this trailing backslash intended?
> 
> The trailing backslash on the last line of the register_sysctl macro
> definition will unnecessarily consume the empty line that follows it.
> 
>> +
>> +/* Helper macros for optional template arguments */

-- 
Mauricio
