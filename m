Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A83515F6;
	Wed, 19 Aug 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156766; cv=none; b=ChKVe2hoUdy7JKFPFT1CCNB9kaVwAeIDk6PKKvx1OztA+mlTAlGCs/3H+QZLRTkPhm+A+IPXy9+fhbENuf+ihY8OE3QFhh6jjKLo1nvL6pkQHxgb5oLw2V6SfPPYsCgaG9DknauKkh3ruOBQeuk36SF13ppqOJY/VGUy61yF3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156766; c=relaxed/simple;
	bh=GRC+AsBbQTKpT20sTVsNN4fmntUm185V1dttY25FveI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BLr8KhxGBh7ZyP6s98Xd4tC+Q3ZVFKOk+B7h0OpcMpP3nliXXW6sXrXbkL68Jo/TsKolb0FB7xTrhkdFVM5wNwoYSMdtNOrv/xS+NaJR6sarjYOgJZC4GfxsHB/jkRVavdg7RaVC4M09L8goU14YOCAcpRKdAcI6GG6hJsm7n+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pBHr+X/C; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pBHr+X/C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=RbFyeba0ncl6pHDcIloDhb/TokSF02n8VJcj2OpB7Tw=; b=pBHr+X/CPPhtV6N4/65ZRIhtFO
	D6t51UQBYVmyQrzrTWDBwRgCbnQ7gTI66WZLZJaG0FLxwY9tVJlgkwgydXp3XTizapZSr3GTOJ427
	tde+FBq3Wwr55kQZCGVtBzJBeKyAgOU8G5fFOuAzfnh15zkt7KEJ9+sd5QqCiuOR2bxKuDIhdV8/W
	JQpH39bZ1qbo4cy4NPKr2KFz4EqZQZW+YsfDypZVvLYBAWvIOrEB0l2P+HK/Gv1xpGE0qKx9hZbaA
	Fvgq7HFiGDzSBuSKR6FeIQlM/NQKONYANk8nhVBqG5QT6xbN0a+6R26mW7h1crQLs+ptvwPX0JVpe
	KLgMvdTg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj74-006Bp3-88; Wed, 19 Aug 2026 18:26:02 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj72-00EYcA-Ql; Wed, 19 Aug 2026 18:26:02 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj72-000000027Gi-3HEZ;
	Wed, 19 Aug 2026 18:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:26:00 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org,
 bpf@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 mptcp@lists.linux.dev, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH RFC v2 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
In-Reply-To: <20260819024055.91F891F00A3A@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-3-d5a69dae5798@igalia.com>
 <20260819024055.91F891F00A3A@smtp.kernel.org>
Message-ID: <602c77077b1497d9270874d96432b081@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] The file2alias.c handler for sysctl device tables is entirely missing from the patch, resulting in no module aliases being generated.

This is handled in a later patch.

> - [High] `__UNIQUE_ID` is used without arguments, preventing its expansion and causing redefinition compiler errors.

Fixed.

> - [High] Pointers in device table structs cannot be dereferenced by modpost without relocation resolution.
> - [High] modpost cannot parse `struct ctl_table` due to randomized layout and nested pointers.
> - [High] Macro generates a single struct, but modpost expects a NULL-terminated array.

These are handled in later patches.

> - [Medium] The MODULE_SYSCTL_TABLE macro silently accepts pointers instead of arrays, resulting in an invalid table_size.

Fixed.

Note: this case has been checked during design, and it fails due to
pointers not being constant but used as static initializers (must be
constant); however, there's indeed a exposure with constant pointers
(e.g., 'static const struct ctl_table *const ptr' -- not seen in
practice, but theoretically possible).


> --
> 
> --- Patch [3]: [PATCH RFC v2 03/13] sysctl, mod_devicetable: add macro MODULE_SYSCTL_TABLE ---
> commit 4b00a2bf658ca058127bbaaa61c3c168a3a4574c
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> sysctl, mod_devicetable: add macro MODULE_SYSCTL_TABLE
> 
> This commit adds the MODULE_SYSCTL_TABLE macro to emit a struct
> module_sysctl_table variable containing pointers to a sysctl table's path
> and entries. It also adds the necessary struct definitions and field
> offsets for modpost integration.
> 
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index a397213bedace..818a4a53448db 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
> 
> [ ... ]
> 
>> @@ -78,4 +78,11 @@ struct cpu_feature {
>>  	__u16	feature;
>>  };
>> 
>> +struct module_sysctl_table {
>> +	kernel_ulong_t path;
>> +	kernel_ulong_t table;
> 
> [Severity: High]
> Does modpost know how to read these external pointers?
> 
> Modpost's file2alias.c extracts raw bytes from the struct and typically
> does not resolve relocations to dereference .rodata or .data pointers. Will
> this prevent modpost from actually reading the path or table strings/data
> from unlinked ELF object files (.o)?
> 
>> +	__u16 table_size;
>> +	__u16 entry_size;
>> +};
>> +
>>  #endif /* LINUX_MOD_DEVICETABLE_H */
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index e5d7226ab6f5a..6960fe22c50bf 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
> 
> [ ... ]
> 
>> @@ -293,6 +293,48 @@ struct ctl_table_root {
>>  	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
>>  };
>> 
>> +/*
>> + * Creates a symbol so file2alias.c can find the sysctl table.
>> + *
>> + * MODULE_SYSCTL_TABLE() is the sysctl equivalent of MODULE_DEVICE_TABLE(),
>> + * with pointers to a sysctl table's path and entries, and table/entry sizes.
>> + *
>> + * The parameters 'path' and 'table' must be static (e.g., string literal or
>> + * static char[]; static struct ctl_table[]) as both are used as initializer
>> + * elements for a static struct variable.
>> + *
>> + * The generated symbol name contains 'table' by default. However, if 'table'
>> + * is a struct field (contains '.' or '->'), in order to avoid syntax errors,
>> + * define the macro SYSCTL_MODULE_ALIASES_UNIQUE_ID.
>> + *
>> + * Define the macro SYSCTL_MODULE_ALIASES_DISABLE to disable this.
>> + */
>> +#if defined(CONFIG_SYSCTL_MODULE_ALIASES) && defined(MODULE) &&			\
>> +    !defined(SYSCTL_MODULE_ALIASES_DISABLE)
>> +
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +
>> +#if defined(SYSCTL_MODULE_ALIASES_UNIQUE_ID)
>> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
>> +	__mod_device_table(sysctl, __UNIQUE_ID)
> 
> [Severity: High]
> Does this use of __UNIQUE_ID work correctly without an argument?
> 
> Since __UNIQUE_ID is a function-like macro, using it without parentheses
> prevents its expansion. This could result in the preprocessor treating it
> as a literal token, generating a variable name like ...__sysctl____UNIQUE_ID
> and causing redefinition errors if invoked multiple times in the same file.
> 
>> +#else
>> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
>> +	__mod_device_table(sysctl, table)
>> +#endif
>> +
>> +#define MODULE_SYSCTL_TABLE(path, table)					\
>> +	static struct module_sysctl_table __used				\
>> +		__MODULE_SYSCTL_TABLE_NAME(table) = {				\
> 
> [Severity: High]
> Will this work with modpost's do_table() logic?
> 
> This macro generates a single struct instance, but modpost expects all
> __mod_device_table symbols to point to an array terminated by an all-zero
> element. Scanning this single struct could cause a build-time
> "not terminated with a NULL entry" error when it sees non-zero bytes.
> 
>> +			(kernel_ulong_t) path,					\
>> +			(kernel_ulong_t) table,					\
> 
> [Severity: High]
> If modpost attempts to parse struct ctl_table through this pointer, how does
> it handle a randomized struct layout?
> 
> Since struct ctl_table can be marked with __randomize_layout when
> CONFIG_RANDSTRUCT is enabled, a host tool like modpost cannot reliably extract
> information from these entries without having the field offsets explicitly
> exported in devicetable-offsets.c.
> 
>> +			(u16) sizeof(table),					\
> 
> [Severity: Medium]
> Can this silently evaluate to a pointer size instead of the array size?
> 
> If a pointer to a ctl_table is passed instead of a static array, sizeof(table)
> evaluates to the pointer size, leading to an incorrect table size being
> emitted. Could this be protected using __must_be_array(table)?
> 
>> +			(u16) sizeof(const struct ctl_table)			\
>> +		}
>> +#else
>> +#define MODULE_SYSCTL_TABLE(path, table)
>> +#endif
>> +
>>  #define register_sysctl(path, table)	\
>>  	register_sysctl_sz(path, table, ARRAY_SIZE(table))
>> 
>> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
>> index b4178c42d08f5..e3b8855e6ebcf 100644
>> --- a/scripts/mod/devicetable-offsets.c
>> +++ b/scripts/mod/devicetable-offsets.c
> 
> [ ... ]
> 
>> @@ -284,5 +284,11 @@ int main(void)
>>  	DEVID(coreboot_device_id);
>>  	DEVID_FIELD(coreboot_device_id, tag);
>> 
>> +	DEVID(module_sysctl_table);
> 
> [Severity: High]
> Where is the file2alias.c handler for sysctl device tables?
> 
> The commit message mentions this symbol will be handled by file2alias.c,
> but the patch does not appear to add the corresponding entry in the
> devtable[] array to actually parse the new struct. Will this result in
> no module aliases being generated at all?
> 
>> +	DEVID_FIELD(module_sysctl_table, path);
>> +	DEVID_FIELD(module_sysctl_table, table);
>> +	DEVID_FIELD(module_sysctl_table, table_size);
>> +	DEVID_FIELD(module_sysctl_table, entry_size);
>> +
>>  	return 0;
>>  }

-- 
Mauricio
