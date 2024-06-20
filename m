Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B724211;
	Thu, 20 Jun 2024 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856271; cv=none; b=llwnGYTXQnonv424wLfyoi6nUyT3t6Sn6ZIsHncNFKTjzLqBmQ+FPyUS6bI9+R8rO+PaaJruZTM33Izl190uxjjIKjt/A1jFhe36rV/bPC23B1MP+g8PxBnigEkxFuvH8bqxZVWIs0HzYtxoUONX1lYzO0unT5yWEw69Bkaxm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856271; c=relaxed/simple;
	bh=mphZe2lo3TH4YqNADWhRpYCXmcPjDl1FzAOCHJBNgLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rgOWl30WwmORLtdhK/V9W2QrOr8zZXB5MaFLYgNrCVZy2X2UnTWtmuIwmnnTbiGwXP1Lptlvg3xpwgMCuoRggguhIs5QlFfrAPO88u8fk40Wu573vxP/2Kn8Elh5Wuob7HZbDCQ3UMLhFuf1r7RnmmpM36n/okT+OAV5D6ttfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4RZS1JHmznWlM;
	Thu, 20 Jun 2024 11:59:28 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id B6DF9180087;
	Thu, 20 Jun 2024 12:04:23 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 12:04:23 +0800
Message-ID: <4e137bd6-845c-41d0-9c96-85b4170ebf6a@huawei.com>
Date: Thu, 20 Jun 2024 12:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
CC: Kees Cook <kees@kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-hardening@vger.kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Leonardo Bras <leobras@redhat.com>, Mark
 Brown <broonie@kernel.org>, <imbrenda@linux.ibm.com>,
	<pawan.kumar.gupta@linux.intel.com>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3> <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
 <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/6/18 18:45, Mark Rutland wrote:
> Hi Arnd,
> 
> On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
>>> On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
>>>> On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
>>>>> Since the offset would be bitwise ANDed with 0x3FF in
>>>>> add_random_kstack_offset(), so just remove AND operation here.
>>>>>
>>>>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>>>>
>>>> The comments in arm64 and x86 say that they're deliberately capping the
>>>> offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
>>>> value with 0x3FF.
>>>>
>>>> Maybe it's ok to expand that, but if that's the case the commit message
>>>> needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
>>>> x86), and those comments need to be updated accordingly.
>>>>
>>>> As-is, I do not think this patch is ok.
>>>
>>> Yeah, I agree: the truncation is intentional and tuned to the
>>> architecture.
>>
>> It may be intentional, but it's clearly nonsense: there is nothing
>> inherent to the architecture that means we have can go only 256
>> bytes instead of 512 bytes into the 16KB available stack space.
>>
>> As far as I can tell, any code just gets bloated to the point
>> where it fills up the available memory, regardless of how
>> much you give it. I'm sure one can find code paths today that
>> exceed the 16KB, so there is no point pretending that 15.75KB
>> is somehow safe to use while 15.00KB is not.
>>
>> I'm definitely in favor of making this less architecture
>> specific, we just need to pick a good value, and we may well
>> end up deciding to use less than the default 1KB. We can also
>> go the opposite way and make the limit 4KB but then increase
>> the default stack size to 20KB for kernels that enable
>> randomization.
> 
> Sorry, to be clear, I'm happy for this to change, so long as:
> 
> * The commit message explains why that's safe.
> 
>    IIUC this goes from 511 to 1023 bytes on arm64, which is ~3% of the
>    stack, so maybe that is ok. It'd be nice to see any rationale/analysis
>    beyond "the offset would be bitwise ANDed with 0x3FF".
> 
> * The comments in architecture code referring to the masking get
>    removed/updated along with the masking.
> 
> My complaint was that the patch didn't do those things.
> 

Sorry for that I don't adjust the comments in architecture code 
referring to the masking.
I've tested the stack entropy by applying this patch on arm64.
before:
Bits of stack entropy: 6
after:
Bits of stack entropy: 7
It seems the difference was minimal, so I didn't reflect it in the 
commit message. Now it appears that I missed some of the Kees's intentions.
Kees has resent the patch, and everything should be fine now.

Thanks!
Yuntao

> Mark.
