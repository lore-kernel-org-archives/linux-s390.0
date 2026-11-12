Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494262;
	b=nqQrqUcyshRPggdsv/Uvr3pXWlaUpgIvxccV4hcyNrpCzVqDI93HYmEVYl3uOONBV1wm
	 4HcUSR0RrTPe0vANLb2uSorUwXSHMLJCcfqt6ZEobCJpZ/r0IwJHkE5J5Ba+Aefh4r/AM
	 25PIoB+XLYTpYdRZyE1kM3TEuFxxHbFv5DXrmiKFELyRkuvoacd/cxgx5f/oGl4julfBg
	 BFWQx0L9lH3M85bYsvgvaO0u7l6YEgVGv+Wc4Yy2Lv7vkM6/MrKbFR7qxHDemkECZN9ux
	 /UnrLm36mmxYhqMEttyv3BUtANfDIdZeLeh7L2keAstWNiwl5wfXIqRPzbw9kXWSNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494262;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=N2sxZgU9VMgKrCmPeJoteByBoH/V9b4GoWqupbGXeDI=;
	b=3HS0sGjTVNItrJWL/ZwdwV/T0qfWK4cyYGRQYkVWK5RIB6oOL2Me1fqd/om8BFrBBYZw
	 Mc3DsjQL9/1AHZucINNHo0gqBUsLzDIlH+tfNBW7FiJJ0WxH4oue8c7CSoQfpCWWDPN4d
	 ZaYKxjfZQqJt5R4Ol1AQ7R0u1pzjQJ1vDdXVreGrcrwnq62GaFLbqOF6iMkISQ/jz+Sji
	 Wfn7Sa7lz0vl1Tpu8m6EX2p1tM7V54hfUU4qU8zN/vr9jNNeTmWQkUpqiWLBbzFwu0+gv
	 LMbgMaHev7LdfzcbLKQoEExADbdPuRcvb8z7Hsnz4M+2WSArOvEXGjq5ouhlaxDcD0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="nJA67h/P";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C306606A31C;
	Thu, 12 Nov 2026 14:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C306606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nJA67h/P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=N2sxZgU9VMgKrCmPeJoteByBoH/V9b4GoWqupbGXeDI=; t=1794494260; x=2109854260; 
	b=nJA67h/P5Ean9s8I2686q80jHlq8egA6rn53yg8RE+NOjkwzMg0TnO/tU+NzmBXmqRcqtnUzRtc
	kJFuS6UTknGmXmeoLa8hVnzECQfE1GRXhBx37yOunzDKLWzoBptP/XDEnfYEmNGBEpiVu9x58WAOi
	jP2dVW1oadlkdv8Ym8oqHFhvnnvvIjw+omsYYI/uV9FcjdAJPIly1lT5PZZYE2zB5tIF5/EGpbena
	XchYBC9ZlXrviWaX1oA2JWbsgNPvs7glalvb992OF+noT8CpDghTQcg20pfVH34+m7ikMTiGLdUkO
	Wl9/vHPVyBFPU9ZrMl/q/3kfm1T1hFN2vWRg==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xRVvc-009aPf-1X; Thu, 12 Nov 2026 15:37:28 +0100
Message-ID: <e3910a18-dc28-470f-be2f-6a6d568ba7e3@igalia.com>
Date: Thu, 12 Nov 2026 11:37:33 -0300
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
Subject: Re: [PATCH v9 09/15] syscalls: Add an option for offsetting the
 common table
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-9-8d1275885d9c@igalia.com>
 <0cfb4dbf-f3e2-4ceb-ab89-0453ae59793d@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <0cfb4dbf-f3e2-4ceb-ab89-0453ae59793d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 12/11/2026 11:07, Arnd Bergmann escreveu:
> On Thu, Nov 5, 2026, at 21:05, André Almeida wrote:
>> To better support architectures that doesn't share the same syscall
>> numbers, but have them in the same sequence, add an new option to offset
>> the common syscall table numbers by a value. This make it possible to reuse
>> the common syscall table for alpha.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> Changes from v4:
>>   - I was reusing the logic from --offset to apply the --common-offset, but
>>   the logic is different: --offset does a string concat, and --common-offset
>>   does a addition to the number
> 
> I don't understand why this should be different here.
> 
>      Arnd

This how --offset is used, from arch/mips/kernel/syscalls/Makefile:

       cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@

The effect of this is that the string "__NR_Linux +" will be added to 
every syscall number in the unistd header, e.g.:

#define __NR_file_setattr (__NR_Linux + 469)
#define __NR_listns (__NR_Linux + 470)
#define __NR_rseq_slice_yield (__NR_Linux + 471)

...

Now, for --common-offset, from arch/alpha/kernel/syscalls/Makefile:

       cmd_systbl = $(CONFIG_SHELL) $(systbl) \
		   --common-tbl $(systbl_common) --common-offset 110 \
		   --abis $(abis) $< $@

That means that 110 will be added to the syscall number itself:

#define __NR_file_setattr 579
#define __NR_listns 580
#define __NR_rseq_slice_yield 581

So one option does a string concat, the other option really does a sum 
operation. If I had used --offset 110, the result would be

#define __NR_file_setattr (110 + 469)
#define __NR_listns (110 + 470)
#define __NR_rseq_slice_yield (110 + 471)

Thanks!
	André
