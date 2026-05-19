Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166873DA7D2;
	Tue, 19 May 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176050; cv=fail; b=us7uwSkzK0SeyBAYS1Lk5oxlWiiEkbQX6utlKKwG5ZbY2kecBI/+rvKta99HEzLviieeJy70Ny99TRU0tJzyIowG2sjCnU9jOdxXXAsO7faVhEmGImY/MJE5qIVtW5fEHcTCSuUE9VJNPI3SYAljoSmtcY1NYXR1YdWp8/o2Ueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176050; c=relaxed/simple;
	bh=3ldHNJHeQa+lI6iSCnT//e7Nx2liO10mESuachUwi9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NYtYQBRjyTHHxmLLmf3m7WuRtKwneRrXA3DCPTrWiyqkUZsZ/nMmnRbcXdY20V2c4YSkfdKpR9EkRXjsSS8bxU+1qMRZ9R5vAUL33aI2eUyygpoIp8lhIKLoOLDPJaA6a0VGb2Lx7EvyE9ykt6+5qMzuRIma09prVTn2k+4zeww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=idWob8U5; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="idWob8U5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ9+ncGSM1WT2uORQmOVqHastnfhz8oZzylQ1gi8FqPTTWPXrdH+UuhX5Jksb4pnC1blAOSQksPkPgWFkzKiukB3xTzjKC5dSo7oJMuy9iIzHf99Kix+3JxA0eHpgJ+8ebGqyhL7+LRLkRJU+DdnLjIEfMGp4XnQp2fV8GMaiMT54Amr8/+pj7uytJCqKPMwIw9OJSG6GNrddRNvHuU4B5X9NJPDYUQdav//AyH3MfOtZPnwysPvmzHlTJksm27lgR+fNRp8R1FMUSwDRrsxWsiCDwc7qtFKrZMcMbUb3Q0AFnuD1dg7gR1yRJ9+ef8BLQV9nXo2gcaW6sBUX8iB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci93Zw1K7y2nw/A70fF71O8U4kqQoydrN4M1ada4NKM=;
 b=L5rmaMvevK7Q1gOSyKsqq5SjiFxxo13KcBHS51gNtye34WyFmex1dTIpHQakN+me6aBXN9wMkT5IMfw4wZPub621yQHnJzJbcaSzFv/tfCM5r3lgA5N5RE2H+tUGjXkZVLQ7oPtI/btUgygmhK7v2KPoGV5qUriqQwJIPLsLaww/iS7+y1y4FBcqZUtvNERKG9J7BFHXWxeEnhCmnZi2X9KIYoWxuFhL817vwi7QLN2ZuucmEVwsHL8GBWlyf4DsHAcGWsjwCrCQaT8tY4tC3oQ/IMWk6Rbsk3BtB6cuZPjx0ULEp/5QTG8Kj0rE4xoilYKGidIrzgNzmyAEIlqArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci93Zw1K7y2nw/A70fF71O8U4kqQoydrN4M1ada4NKM=;
 b=idWob8U5rhsLcEeX/OBPWT/QjTw69GD3G/nu5GHYjAnQbQCIMCuTIWHxVg4rM8fXsRUxRC1MgssFYwAuZRIkUaOVvSGITkulfnVS37db8pYLe2it8UkRFKJhsROrID22/4od4laojdTVWoEqoVjkKvxUmRurkUzZ5bDJc0EAXXo=
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:34:05 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::9a) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 07:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 07:34:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 02:34:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 00:34:04 -0700
Received: from [10.136.36.105] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 02:33:59 -0500
Message-ID: <e3d4c90f-6778-4df1-beef-245e256ff386@amd.com>
Date: Tue, 19 May 2026 13:03:53 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
	<guoren@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>,
	Charles Mirabile <cmirabil@redhat.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-6-kprateek.nayak@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260430094730.31624-6-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ab358d-5da3-414e-d336-08deb579012c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|4143699003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aAu/Ba48gVsgrIekzsCD1NOOLQrJG2Ek2MNbAg2fXfkFkUFi/AaVma/q+y1eWlmDYBXa5Caulfg+zGjQbiezHAC7u479xDjXfh4NCoyqZvt+gYv23wSO00S4Fnt8/XM8Wd1OxB3YJItKUC4IC/CoetnFTKaEODEjkczZlZOkvvzVkBIxFMONaenHMObbTZCsH+/Qsue1W2cwAcMOj03zOD53trH+BJlYLqzUmMXSQrjphlBtMX1dB6y9f7duRHoESxIcffS+yxCqOGvIB0XF0KSu3/JxPKT5I0fBC9fsny5Bd6EIWu/t4N36x7GQRpED8vtQF27FW9bSd1Qbw6XgECceMuYLDkdLijQ6yC5Q62SJwP1YYV6b9GI4jEIFUKZHs+v1UTSTwsfDY4cX69g3ji/uCn/3tyiKa7pmewh4ConICHeiH+1Q1VeVRX6fZjngxmuGCn6YNzBpQ98P/VXi5aaA4w18Q/X9USQOY/Chnsb0KMoRt9zc46hiusyc/IsTmF//2Pbj80HnjVF8UusZpTfYh6sPac21fZFMrcDyRPivv1iNrlBwMmtd4KcLQm3HNDPmOWLzz2o1BDQ3cTVsurlG4PIr+LQ2UiCSceHdmSD5eErpFuQEOj640pmTzvl0tMi3Y1kvvfGTXVm/VwsyfZlO+ien1rqH255zqN4hQtqD1LDe0a4SwGQBZ02MMs8qOpe+HUJMRG9nE4gUtkOqeo1WczQkQRNMd1R0Y8OZN8A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(4143699003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zykerzUCvjwG21a2da7SukRSYRhhT+lnmOJhKjAXNVhpbFKJYOyiKrZQsovANXJGvK9VBfjzmOh85OojB5VZXfv5plxqrDirfj3kpt3f8M8BH2qyc3NwohsjAayAgu/QiK6u8H7YDVMdaNRZ/3VBK7UXirngNJ2rq3lfeKvNyNynqYvMpF3RtrGBLLbERGWGDHsRJ9QN6YufUKWQ4jDmceIj7gFuKz9PkzjgnrObWAkfG7g++R54wgEJETYgdux4M5MszXWF+BYXMErajVqe34JY2HsuGBAx4zenph0Whzlnafes6PhBVvaFKniUfzaYuKBSDDEqjJ5vR2pfbJC1ItMet1jKd5DF7yyYDJ1sE7U2vDuWaJS92Zhce7OlqE69x6+aA2tQPNxq3jwsMW+nC7fSyqabgNObCnmgy1xNPih1cEIKa4KtSNSmsHQNkYTX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:34:04.8215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ab358d-5da3-414e-d336-08deb579012c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503

Hello folks,

On 4/30/2026 3:17 PM, K Prateek Nayak wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
> 
>   lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
>   addi  a0, a0, 0x678     # lower 12 bits
>   and   a1, a1, a0        # a1 = a1 & a0
> 
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. The final (__ret & val) operation
> is intentionally placed outside of asm block to allow compilers to
> further optimize it if possible.
> 
> __runtime_fixup_ptr() already patches a "lui + addi" sequence which has
> been reused to patch the same sequence for __runtime_fixup_mask().
> 
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Gentle ping! I believe this is only missing Acks for the RISC-V bits.
Any and all feedback are welcome. If you have concerns with Sashiko's
comments, I'll answer them below:

> ---
> changelog v3..v4:
> 
> o Reverted back to using __ret as the macro variable to prevent
>   collision with local varaibles at callsite. (Sashiko)
> 
> o Separated out the & operation to prevent any confusion with operator
>   precedence id "val" is an expression. (Sashiko)
> ---
>  arch/riscv/include/asm/runtime-const.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> index 1ce02605d2e43..684641cb0fe82 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -159,6 +159,23 @@
>  	__ret;							\
>  })
>  
> +#define runtime_const_mask_32(val, sym)					\
> +({									\
> +	u32 __ret;							\

>> Could this local variable shadow a variable from the caller? If the caller
>> passes an expression for val that includes a variable named __ret, the
>> inner declaration will shadow it, causing the macro to silently ignore the
>> caller's value and unconditionally return the mask itself.

The "__ret" variable naming has been standard format for all the
runtime constant macros and any future usage with a "__ret" already
defined in the scope would fail build when compiled with -Werror for
variable redeclaration.


> +	asm_inline(".option push\n\t"					\
> +		".option norvc\n\t"					\
> +		"1:\t"							\
> +		"lui	%[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"		\
> +		"addi	%[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t"	\

>> Does using addi here violate the RISC-V psABI for 32-bit types on RV64?

The immediate will be patched before the first usage and these only exist
as place holders here for code generation. Patching sequence will handle
it correctly and this is no different than a runtime_const_ptr() patching.

> +		".option pop\n\t"					\
> +		".pushsection runtime_mask_" #sym ",\"a\"\n\t"		\
> +		".long 1b - .\n\t"					\
> +		".popsection"						\
> +		: [__ret] "=r" (__ret));				\
> +	__ret &= val; /* Allow compiler to optimize & operation. */	\

>> Is it safe to expand val without parentheses here? If a complex expression
>> with lower precedence operators is passed as val, it might alter the
>> evaluation order and introduce unexpected runtime behavior.

&= has the lowest precedence with evaluation from right to left so this
shouldn't pose a problem but if required I can add a parenthesis around
the (val) and resend these bits if there are concerns still.

> +	__ret;								\
> +})
> +
>  #define runtime_const_init(type, sym) do {			\
>  	extern s32 __start_runtime_##type##_##sym[];		\
>  	extern s32 __stop_runtime_##type##_##sym[];		\
> @@ -262,6 +279,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
>  	mutex_unlock(&text_mutex);
>  }
>  
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +	__runtime_fixup_32(where, where + 4, val);
> +	__runtime_fixup_caches(where, 2);
> +}
> +
>  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
>  				       unsigned long val, s32 *start, s32 *end)
>  {

For the final review comment on the core futex bits:

>> Can evaluating the runtime constant immediately after initialization cause a
>> boot regression?

The runtime constants are patched before the first usage and the patching
function introduces sufficient barriers to ensure the following reads
don't see the placeholders and in-order commits will always ensure that
Read After Write hazards are dealt with correctly w.r.t. patching on
BSP.

-- 
Thanks and Regards,
Prateek

