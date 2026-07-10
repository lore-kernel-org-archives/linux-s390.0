Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFF3358C6;
	Fri, 10 Jul 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671443; cv=fail; b=pGzApgAuQAqoTi/scL1rZgvZp9ue0rvREMtKBGJ4Ao2wvg9w8gylJTq6Mxv+42HPHi2R0nTSuChyICMgniNXKMbnEze00VJ7qYZ4C4mBeKoL4+vIO2Wt2BgsQlD2OT320dPo4rP+i5fsGz5iV6h8MrUlL/606uL1h/29smVdHDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671443; c=relaxed/simple;
	bh=VQMuaT8JLqvfdUsdV+BNt/Ude636eZA/TxsM82FiQS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rxL4DRp8nsGYRs0eTkx7MnSCUlTOjo8L5pI8FToTLDFGgY8hQUnz9DQFTf4vByOuRDnVTcom7x0BIOF1sJgod/fqTVASxBEHk7qIOkCGh1C46G5lJnezrFeXFut1HrsExmiM5fA3VxyIuA04Tn7APCGAR1pdksvsgFwJNVYgLbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2CsJejtt; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2CsJejtt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bADy4MyDlRtFS7Ey6zhS7/3ranOwzmkHDZMwLNpDFivy6cDI9k9xI/onzlKl/pyYyeGzvLfqH3F/x8BvfbXeCWdUHnTY3P9hHMGf83AhcP7CLXI2DU5wUsUkmyGIDmiP89GuTVXPcilsXYVlQs4JhSTJvtiaSH27bQDDfW2f6P3ngyb8GUShv3zgvmpJCbjYLhsmMuiD1mh4ohL1f4mMFMWuYaMpPaPBVagF+ZcTzXF10T5Kr+vkVnvw+RfVuASVa+ItRcdqmDCpTmiP/rmgy+Hnf/zkCzUFfGQQ0mkCPmgAnD+vmVofOwIgPuowgIxd/6uglDcptZKCL9DVNyprrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXOHSZK3138l5feHcf8tQrpnH6XzX3HFkUrrAbxwBf4=;
 b=SJKWY4xnsFFZrSrQRbWoL2ejWmjW2wn/fDKWSywaEly38uKoxdP76qcGjG3r1rm6HBLIv6tN8kZsA+lCvrzVzNbkGS15bQr2WsGbor3/jcThJzc8h5jOOptT87mUviiw7ZFoppRh0HDZuHDIa4/ScsC0OT2vlvhxkorcJVWAHWiYd+TeCIZ0PzVrAoqHXTZzoDkxlspnDqAGr6UWMiJOGH7ak9STCV7Chgg+NxgQacgSdqiPffFcElJdtcBWzafvFUG7Y5YbQGz3r02732mC7iFdKd/xnrXERI0XhSSzEuyg/bbxT59UO64CX9w4Px1IYHp/amqJWni1fimSJW0Bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXOHSZK3138l5feHcf8tQrpnH6XzX3HFkUrrAbxwBf4=;
 b=2CsJejtt2+4ndMVIgzhYdgnZ5q2vSQz52BTNmZD8cUh/wm23YNtEB34cZHChS1Aq+y2vXV08M3tgqOBVm4bbcVrOLVpSk/bTMSPw4iG87Dejfafit0I8PK9S+Ueq5JM0JDray3ApZ2Jo+A92G5phRQQY+VJC+c6TiIGbPxHB8tM=
Received: from MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::8)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:17:17 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:52b:cafe::8a) by MN0P223CA0017.outlook.office365.com
 (2603:10b6:208:52b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Fri, 10 Jul 2026 08:17:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 03:17:16 -0500
Received: from [10.136.35.241] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 03:17:11 -0500
Message-ID: <650c7050-2a77-4415-b597-3bb39ccfb1e8@amd.com>
Date: Fri, 10 Jul 2026 13:47:10 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
To: Charlie Jenkins <thecharlesjenkins@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>, Alexandre
 Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-6-kprateek.nayak@amd.com>
 <178366995930.1208691.2993932866462893112.b4-review@b4>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <178366995930.1208691.2993932866462893112.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd8548-7dad-4237-4418-08dede5ba7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|11063799006|4143699003|5023799004|22082099003|56012099006|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	Q/9ktpJsUqU9YY6zkbyoOn1QUlbJ+/6RwN3a5/mkWn6etdYrVp1Xwp+3HQeSVP3DwNzktZfDBLO59E+NnE9xir8SKzrRrkqaq34aOKn0YbrYj2t+FcXATn/c2vJ2+LeB+zOtDHC/z9fMRd+ZDBBkNzALUKLzmooT71j7MLUzpwWWKQ4O/SJ/0PqAGPNUswbvpGh1IumXJXP/VXccbUbPHbN+NQf9h8pyrzNIcV/IRKCuEdbYtSTslgL6IciYD+u/JINXvijcgkznQx8qXYh3Vh5IYaU++GjQlpRYN5gJ1ogHi8c10wREkHZWmWkwA7q+slgQasvsYY/paW5q56Islubv3jw85tN5itm3F1/Va5tK89TfrN/hLJoqACcREaefetPxLXPb86eiD/XRgvs3jX/Qh2W8k92EvbkmFRK6XHQnxGadMATBABsx9rSAlHCTsn5z0E2clqlXbbBL9ztqinVoB7/tTA2cDQHCf3xNABV1OrXxZY6GniPl4WheQ8qIpeZ+iGbDbe3CZdS7r9kHlczkUX74c5/zsdwHk/rjBDX0eVwxfsamiJQ+3cyd3InsZ8IyjjPw0wCt71gK4Q607/PBiiHf0cGpiBWwfsgs8X/I81mo3uSsmeXOl9Jj1V4tLnPP7w15N1lkmsaEFG0g8xxtWPS7St2nqYdyf/JoM5MtYriGBwiSL4EvrN8NR/qv3MjZb3libzkv9wImUFVMeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(4143699003)(5023799004)(22082099003)(56012099006)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	60pdV8geNf2LGy6amrH9UHz4HB+liaHa8OSGHsqTNViw7oXQ249X9/AxDXEBPT7AnEg8ZdRXgUBHxlYACOmZQGYW87ZjV6+TxVG2cyOG9c6BLMYOjzC1nP5NQn4+PaREJZUZvfXdr4LeQyTIGNWLIB0s1nzxYg+tFD2DgvDdG/QwyaWMRLRdmp/g8tHkI78gp1Wv5qk45RzbrqP6uvgGImmtG7kRzs3ss/ovE+nC5lWeewQ3jD5vK//MvYhWHJDhi/Wjss3OJgLPR9ENljPxVLxOxqIqWT/pG2P07+arTG+p/07FfAyTOeuH4/eZ/Ze+VQtAWfXsRNAuX9b8wBnN+RpKYQs28YmfhsMpQsShvtAfykKsjTiQna8TYWCjVeYU6RJDQgpOZNJxgyf4yas6IuPaWqlJziwI9WM1hTrkuZGFRWs9pbuthM4acsYljNrq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:17:16.9680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd8548-7dad-4237-4418-08dede5ba7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816

Hello Charlie,

On 7/10/2026 1:22 PM, Charlie Jenkins wrote:
> [You don't often get email from thecharlesjenkins@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 30 Jun 2026 04:55:28 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> Futex hash computation requires a mask operation with read-only after
>> init data that will be converted to a runtime constant in the subsequent
>> commit.
>>
>> Introduce runtime_const_mask_32 to further optimize the mask operation
>> in the futex hash computation hot path. Since all the current use-cases
>> are of the form GENMASK(n, 0), with n > 0, following sequence:
> 
> I really appreciate you spending the time to do this, thank you!

My pleasure! And I really appreciate you taking time to review and test
this series. Thanks a ton for that!

> 
>>
>>
>> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
>> index 1ce02605d2e4..dbf96c937dbb 100644
>> --- a/arch/riscv/include/asm/runtime-const.h
>> +++ b/arch/riscv/include/asm/runtime-const.h
>> @@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
>> [ ... skip 24 lines ... ]
>> +     BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
>> +
>> +     __runtime_fixup_shift(where, 32 - width);
>> +     __runtime_fixup_shift(where + 4, 32 - width);
>> +}
>> +
> 
> It would be "optimal" to use an andi when the mask is <=11 bits since
> andi can fit an 11 bit mask. What you have is good enough but I'll leave
> my stab at doing the andi patching here in case you want to apply it.
> 
> From 9e5527aaddd464783af795aacdb6d094e11cc31e Mon Sep 17 00:00:00 2001
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Date: Thu, 9 Jul 2026 23:18:09 -0700
> Subject: [PATCH] riscv: Optimize __runtime_fixup_mask for masks with <= 11
>  bits

Peter seems to have merged the v5 series in his tree but If you could give
your S-o-b, I can throw in a commit log, some testing along with a few
cosmetic modifications, and send it for official review on top of
queue:locking/core ;-)

> 
> ---
>  arch/riscv/include/asm/insn.h          |  2 ++
>  arch/riscv/include/asm/runtime-const.h | 29 ++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index c3005573e8c9..0a34cd7305d0 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -141,6 +141,7 @@
>  #define RVG_OPCODE_JALR                0x67
>  #define RVG_OPCODE_JAL         0x6f
>  #define RVG_OPCODE_SYSTEM      0x73
> +#define RVG_OPCODE_ANDI                0x13
>  #define RVG_SYSTEM_CSR_OFF     20
>  #define RVG_SYSTEM_CSR_MASK    GENMASK(12, 0)
> 
> @@ -175,6 +176,7 @@
>  #define RVG_FUNCT3_BGE         0x5
>  #define RVG_FUNCT3_BLTU                0x6
>  #define RVG_FUNCT3_BGEU                0x7
> +#define RVG_FUNCT3_ANDI                0x7
> 
>  /* parts of funct3 code for C extension*/
>  #define RVC_FUNCT3_C_BEQZ      0x6
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> index dbf96c937dbb..24a9b13081f7 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -9,6 +9,7 @@
>  #include <asm/asm.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/insn.h>
>  #include <asm/insn-def.h>
>  #include <linux/memory.h>
>  #include <asm/text-patching.h>
> @@ -302,8 +303,32 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
>          */
>         BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> 
> -       __runtime_fixup_shift(where, 32 - width);
> -       __runtime_fixup_shift(where + 4, 32 - width);
> +       /*
> +        * A riscv 'andi' instruction can fit an 11 bit immediate, so the mask
> +        * can be directly applied. Otherwise fall back to SRLI + SLLI.
> +        */
> +       if (width < 11) {
> +               __le16 *parcel = where;
> +               u32 insn;
> +               __le32 res, nop;
> +
> +               insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> +
> +               /* Replace the slli/slliw with an andi */
> +               insn &= 0x000fcf80;
> +               insn |= val << 20 | RV_ENCODE_FUNCT3(ANDI) | RVG_OPCODE_ANDI;
> +
> +               res = cpu_to_le32(insn);
> +               /* Replace the srli/srliw with a nop */
> +               nop = cpu_to_le32(RISCV_INSN_NOP4);
> +               mutex_lock(&text_mutex);
> +               patch_text_nosync(where, &res, sizeof(insn));
> +               patch_text_nosync(where + 4, &nop, sizeof(insn));
> +               mutex_unlock(&text_mutex);
> +       } else {
> +               __runtime_fixup_shift(where, 32 - width);
> +               __runtime_fixup_shift(where + 4, 32 - width);
> +       }
>  }
> 
>  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> --
> 2.54.0
> 
> 
> I would prefer including this, but I am happy to approve this
> regardless.

Ack! I'll keep it as an optimization on top to retain your attribution.

> 
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Thank you again!

-- 
Thanks and Regards,
Prateek

