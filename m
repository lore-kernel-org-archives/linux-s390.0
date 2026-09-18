Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9871466B17;
	Fri, 18 Sep 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761547; cv=none; b=HpBZ4UQlCT8ADuDd4K3yT929e8zF3ScotXzU6xnqkltRPSxQ4f7SbZoA7kQRUssnHDPNMwuZjrmysjfO5o7JXlDkbr8Ruxq0RotlfaBdmoszUVNthPbN3J4NC4XjupTseSFmXlUpK7w1w6qxwl6Yh3WGlagqtoYrnn3aeGkflck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761547; c=relaxed/simple;
	bh=/4f16jk0w1SZlOazZG/EvX8VDTn9PFtJwde9AsBZ1oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGAvfo8V+rjYcrJGfv0pq8g3ogUiEJY3FD1p/XxdVsJIBY3HUoaFSItFouKXMmi/DPzy4RRlqJwc6OkM/54PrBqdVVE4E0oqItgCyaAeGtABPV7/SNTBNsH9+uJVVAZA0ARzLIuif17wopfvYfZq2i/vlG04ZlPo7Ga/GCzta98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=enFP9GrW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="enFP9GrW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=k+xIqsm9yQ1hNrqrX4cwXF5kuEUp8+h4riZn/pmeeOU=; b=enFP9GrW0aNsR1AnDePgll6kXa
	vIUTHl3x2i7bi0JOHfQhu/GOcv4bXVvs7H5FJfUcCgjOyeKGTjts+iY1Zvkws7+bj7Qysy9o3dwQp
	xRnQUwJYGvxW7K6ziJ/X2c4IGHstnPwpuLIWaPspZ6i2NvsdSv/1rckyjGt70edc8ML4QTeCAiLcl
	QTj7TgByRBDVHi0zdfzfoH8zLfAzXgfzAiiGDCO9uNWclsaKQAzFS3Q5hVrC+7tWPJz33DZbFXBjA
	5QKIVmcofx7BtJd1lIuoonuJ29TYG0eaWljjEEWJh0M7olZde1T4okg1Fc4blXbk4fy64HDParCMP
	bQHv07LQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7ejU-0046be-TI; Fri, 18 Sep 2026 21:58:52 +0200
Message-ID: <77321b17-c533-4287-9b05-98003959da70@igalia.com>
Date: Fri, 18 Sep 2026 16:58:50 -0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/13] scripts/syscall.tbl: Use the common table
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-3-f4cd8f8e3265@igalia.com>
 <6cd76fb4-0834-457c-8188-c68a507b6a6f@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <6cd76fb4-0834-457c-8188-c68a507b6a6f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/09/2026 03:34, Arnd Bergmann escreveu:
> On Fri, Sep 18, 2026, at 01:46, André Almeida wrote:
>> Remove some of the duplicated code by using the common syscall number
>> table.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   arch/arm64/tools/syscall_32.tbl | 69 -----------------------------------------
>>   scripts/Makefile.asm-headers    | 15 ++++-----
>>   scripts/syscall.tbl             | 69 -----------------------------------------
>>   3 files changed, 8 insertions(+), 145 deletions(-)
> 
> This somewhat desyncs the two copies of the arm32 table, which
> isn't great.
> 
>> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
>> index f1c3d287c14b..b09dbc8992c3 100644
>> --- a/scripts/Makefile.asm-headers
>> +++ b/scripts/Makefile.asm-headers
>> @@ -15,9 +15,10 @@ all:
>>
>>   src := $(srctree)/$(subst /generated,,$(obj))
>>
>> -syscall_abis_32  += common,32
>> -syscall_abis_64  += common,64
>> +syscall_abis_32  += clone3,common,32
>> +syscall_abis_64  += clone3,common,64
> 
> The clone3 variant is wrong on nios2 and openrisc, as they need the
> __clone3 version. These currently redirect it using a macro from
> syscall_table.c doing
> 
> #define sys_clone3 __sys_clone3
> 
> which will continue to work here, but I don't like how this is
> inconsistent between the architectures. Let's use either
> syscall_abis_* or a macro to pick the clone3 variant on
> all architectures, but not both.
> 
Ok, I have dropped the sys_clone3 macro and added clone3/__clone3 for 
the all archs that uses scripts/syscall.tbl for the next patch revision.
