Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59438AC6A;
	Wed, 19 Aug 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156969; cv=none; b=TEPb5MfH2/0J2M5qCjRT5+Z+jvHXvNdypX7yiO/Zs/LPiLb1eNgvPiZ3whxJg9n2onkw3eDiZReX2SWOJFIr2dFV7ZxJPXP2/ccEwrRJPpjeOe73P4e4Lr0kdiHCMxX9UMD6JqTj8m0nJaEEhrgj/PM0B82pA3f47kx0wblQxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156969; c=relaxed/simple;
	bh=EMyKPnso3CwtM5fWkxY91QYA3svonXDGJFqOhkFsRWQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YWCYsaEn67GrRvh31w0NTWKdQq/Vua2/AkKyenvtikHcvxowtsPJU9RrUqfcL2yFRYvjnqdkLZ+2S3LSld/JlGGwEOg1meQqBWWZhGfCkuCrrByhApeU9hoqVf09Vr0kjeukjOj1olJ7aSRH4Fe+j3oNjz8hgnEc9TsgTi5jFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sy6YzwhY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sy6YzwhY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=yhqm2gd3OUOrLM3numVaJNibQOvWu36QavMvOKL7fiY=; b=sy6YzwhY6rArSkojS4kjVyhBGT
	y6HSjOhcCU73FaQGbG/YjCosEMlPezpPyBm43zm3VawGVPwHj7gWAXd61wU0v17XwgbsqRBZ0EhDL
	4XEiOIsSf091Rf1CYorZiimVkcLJuSeic3G6WA39pVJm2mvw5n/MxDVENKeOMzpLhGDGkusHL9+X9
	7GTdLJaOfcn5uYSSs2GmIqA5tGNGty/Ult3pHhOUWTGBgjyn4c3pGco7SW6h9XHbyjg7b/F/gfH+l
	bAzZBIO2aty5etDdV+mo3rhBS/MHTyPD2cddMTlGg44KwD0zxQiD+uAiDr39PWiVF2MVr7rayNCNX
	fqej+boQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwjAL-006BtD-Oq; Wed, 19 Aug 2026 18:29:25 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwjAK-00EYpN-FS; Wed, 19 Aug 2026 18:29:25 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwjAK-000000027JE-1oLu;
	Wed, 19 Aug 2026 18:29:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:29:24 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mptcp@lists.linux.dev
Subject: Re: [PATCH RFC v2 13/13] modpost: handle MODULE_SYSCTL_TABLE symbols
In-Reply-To: <20260819024854.392F71F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-13-d5a69dae5798@igalia.com>
 <20260819024854.392F71F000E9@smtp.kernel.org>
Message-ID: <10d22abac939ce0b2c8784cd84e9c073@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Double addition of `sym->st_value` causes `modpost` to read sysctl table pointers from incorrect offsets on ARM and other architectures utilizing `SHT_REL`.

The cross-compile tests had consistent output between e.g., ARM and
other architectures. I'll take a look later.

> - [Medium] The sysctl table entries processing aborts iteration upon encountering a relocation offset beyond the table's bounds, invalidly assuming ELF relocations are strictly sorted.

The cross-compile tests had consistent output among all architectures,
thus this doesn't seem to be a problem. Assuming that table entries
might have non-sequential/non-sorted relocations would probably incur
significant design changes, which doesn't seem worth it or required at
this point.

> - [Low] The string replacement loop in `do_sysctl_entry()` skips the character immediately following a '%' without bounds checking, leading to an out-of-bounds read.

Fixed.

> - [Low] The `entry_size` field parsed from the ELF file is used as a divisor without zero verification, allowing a malformed module to trigger a division-by-zero crash in `modpost`.

Fixed.

> --
> 
> --- Patch [13]: [PATCH RFC v2 13/13] modpost: handle MODULE_SYSCTL_TABLE symbols ---
> commit 75e261ee7e3ce69bb021a98d7b4574fdc959ec34
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> modpost: handle MODULE_SYSCTL_TABLE symbols
> 
> Update file2alias.c to handle 'mod_devicetable' symbols with type 'sysctl'.
> The key operation is to iterate over relocation entries and add module aliases
> for each entry.
> 
>> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
>> index 8d36c74dec2d5..797cfc2f478e2 100644
>> --- a/scripts/mod/file2alias.c
>> +++ b/scripts/mod/file2alias.c
>> @@ -1531,6 +1531,231 @@ static const struct devtable devtable[] = {
> 
> [ ... ]
> 
>> +// Looks like: sysctl:*/path/procname
>> +static void do_sysctl_entry(const char *procname, const char *path,
>> +			    struct module *mod)
>> +{
>> +	const char *src;
>> +	char *dst, buf[256], *end = buf + sizeof(buf) - 1; /* -1 for NUL byte */
>> +
>> +	/* Replace '%s' from path template with '*' for wildcard in modprobe. */
>> +	for (src = path, dst = buf; *src && dst < end; src++, dst++)
>> +		*dst = (*src == '%') ? (src++, '*') : *src;
> 
> [Severity: Low]
> Does this loop advance past the end of the string if the path ends exactly
> with a '%' character?
> 
> If *src is '%', the inline ternary operator does a src++. Then the loop's
> update step does another src++, which would skip the NUL terminator and lead
> to an out-of-bounds read on the next iteration.
> 
>> +	*dst = '\0';
>> +
>> +	module_alias_printf(mod, false, "sysctl:*/%s/%s", buf, procname);
>> +}
> 
> [ ... ]
> 
>> +static bool do_sysctl_entries(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Sym *sym,
>> +			      Elf_Addr r_offset, Elf_Addr r_addend, void *data)
>> +{
>> +	struct sysctl_entries *sysctl_entries = (struct sysctl_entries *) data;
>> +
>> +	/* Skip until .table starts */
>> +	if (r_offset < sysctl_entries->table_offset)
>> +		return false;
>> +
>> +	/* Stop after .table ends */
>> +	if (r_offset >= sysctl_entries->table_offset + sysctl_entries->table_size)
>> +		return true;
> 
> [Severity: Medium]
> Is it safe to assume that relocation entries in the ELF section are strictly
> sorted by r_offset?
> 
> By returning true here, the loop over relocation entries is aborted. The ELF
> specification does not guarantee strict sorting by offset. If a linker emits
> an out-of-order relocation entry earlier in the section but pointing past the
> table, could this prematurely abort the traversal and miss valid entries?
> 
>> +
>> +	/* Check for alignment with an array entry (.procname at offset zero) */
>> +	if ((r_offset - sysctl_entries->table_offset) % sysctl_entries->entry_size == 0) {
> 
> [Severity: Low]
> Can entry_size be zero here?
> 
> Since entry_size is parsed directly from the ELF module, a malformed module
> with a size of 0 could trigger a division-by-zero crash in modpost.
> 
>> +
>> +		/* The symbol for .procname points to a string */
>> +		const char *procname = (const char *)
>> +				       sym_get_data_addend(elf, sym, r_addend);
> 
> [ ... ]
> 
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index d18a87b882a67..10eb7273cdd81 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -340,6 +340,13 @@ void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
>>  				      sym->st_value);
>>  }
>> 
>> +void *sym_get_data_addend(const struct elf_info *info, const Elf_Sym *sym,
>> +			  Elf_Addr r_addend)
>> +{
>> +	return sym_get_data_by_offset(info, get_secindex(info, sym),
>> +				      sym->st_value + r_addend);
>> +}
> 
> [Severity: High]
> Does this result in adding sym->st_value twice on architectures like ARM
> that use SHT_REL?
> 
> In for_each_reloc(), r_addend is calculated using addend_rel(). On ARM,
> addend_rel() already returns the instruction value plus sym->st_value.
> 
> If sym->st_value is added again here (and in the manual table_offset
> calculation in do_sysctl_table()), modpost will read from the wrong
> offset, silently failing to extract .procname and missing the module
> aliases.

-- 
Mauricio
