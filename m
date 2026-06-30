Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E329D266
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807399; cv=fail; b=MKq+Pk8Y9QjWzrNze/8WANN12c422LBaJ3TCkemxwZbByU+X8BNQThllYkVPS3g9rrO/fqXnJJucq0LNzV7HkbwFRWn7i3vUpM24addt14Ka6QLgzlPCMDYj6PPL299uPTA0A5Gsh99/EL2SCyhsY64o2F6k7qL3ZnnBznKPoqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807399; c=relaxed/simple;
	bh=8ixM2KX9HVuryp+Nx5pqh6K7SW5d1y01mqwaWRS/kY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OCb8ensQgPWGiWIOMkpMeDWOhlta92tQwChQDUXwzXrNjaSdJZM27bR8SwZYJxucagUg2T1vNcG6eYOJ5XoKY1CjiXR3+JpjGE9vLllt/oPawRMPYAcWwmUNrBCwFeFE1Bd181LkDb/rzw++5OxE+tkqR4MRNhKUl9WbyRhqOeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LaHGuXnB; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LaHGuXnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3H8NHCw/RmXfezQGXMztvrCiztN96osyvf9HFEtyO6RUuK5eeLj90CUygqLeiI2nj1Ohgk0R4d4LXZnX3H7d9aWSp4Uj+hJEGByPDlVSOEahJC4ccZBNbaquRjqKx10G18BRoGUcBGapDUgAEnVkO5TO2K7SebypPFsZZ0mrb2EpnaIg8tQggIlPsD/AV0P5fCAXY1Wu/EU9gADztLQrliY4Rc6TLkeeDeKpWO1yECbgPuOUCSbGRtQ+/9GgSrlRg5RfRWT9ucQrnPmd8x6q3IhBIhb+j+eS05cjI5UOZTKu6iTZLQr5MPsw0q76RvgNyLga0zchZBMDx+mAjeZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKQWl+l2XaVOwegCSWCoBKhTPM0pH0mvM38FRdnJxKQ=;
 b=t75vjp2rz+/9WaiWjxoytPDYD5i0Viy/AA9Y9N374vqJ94xxLdlLAJuKiwksEvm+WrjGlVCRAwBkd3rp5D+yecuwwZevX7F9eVC8r2QEsqpBZWBDIzyHX2NRAfPZOnkTiieik+LDCnGuEbAh4rleA2O4XJi0ByPSYlhyiA/fFDl6gDqDCiE10Qi14Tfzur8Lwx+ChyDyYiCT4/Een5YaQ6KYK+ff+D2jvpZ37IlxwFOBktsy8zPhUq2SLCuf+ZUiHX6fNYpsUUxoXdBpJceASprCPgBWCNOopX9p0Ov68g/drnjx/qA/UXqoPKokiNeVW7AOumQHGZ0hBB83251x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKQWl+l2XaVOwegCSWCoBKhTPM0pH0mvM38FRdnJxKQ=;
 b=LaHGuXnByKf+JDTNiav5E+Xizq0akIvvb1rRu2X6HPLUpDsfNLJApXhRAb5BKX41QxzE/74H7o0mt9XiZegbi7YcH5U2Pu3qslN67NptO3kvURwJQvjx3CtoeHtLv216PRTW/buUmXQgxJGJQSSLv5Klsr9i+DyqRK8NwgcV/rw=
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 08:16:32 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::9e) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 08:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 08:16:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 03:16:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 01:16:31 -0700
Received: from [10.136.39.208] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 03:16:30 -0500
Message-ID: <45be33f3-0853-44e8-834b-ce52bf241fb5@amd.com>
Date: Tue, 30 Jun 2026 13:46:29 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
To: <sashiko-reviews@lists.linux.dev>
CC: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	<linux-s390@vger.kernel.org>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-4-kprateek.nayak@amd.com>
 <20260630050742.0BBB21F000E9@smtp.kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260630050742.0BBB21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8646c670-239a-4296-a0af-08ded67fe4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|13003099007|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QjVQMLtzJdyqIYDEREDljdXHKIAQ8ixNGUp6+3HNqGo2ZRBYD7VTPR3oB66S+4ShSmUNmfgCCzmtx+3wiwkBOgJbWSiqllejakJWe1o46v3LdRNfWm/CAHmnRRzUh/nLC6jYwUJfDheHQwIISt2lPrQMIQw1XPGa3KzleJzl1CvQxiGSbVHFAXrELz6mTthiQRwvh9YIvPQmEs7zlkc52VCvAR2vsqr4GUwyn+W7NhvKWTx4+6gb/QmgrjQPMFRN9+JrcKvZGm7IzPB8p03fHe9dY+32xCFEvyeDk8jozK6h8jbvL02Aleuu3hBL/QM2O6dATdK4McRQqyDhvi1wabkrjldd7Fk8JXDT85SgXwWoPUFKCGZQLx0IFLV4yiIy0TcUeZV/nQwAUMwBhbrOhyi6lhuaifUvAsP3a2ZfQlzY8FXGSoV9jCthV07vvVrymWQxBgkKCUjELHjjB+kGJRRd1OIY1Xfyt74y0qjkHkbmWgKUH5myGKYz6YBYSU+rucYixvczk5nTQlXL/CbnbflXfX8JxIZcqpfM+fYozr/g82OSTzMwEi4t7o8UxgOpN8k30G+wYxyjG8EguAjJLAxjhQG/YZOtP8KB4tTpED79dwAsyec3KCVmgD8YJtwgx2lfTBN+PQXMT75lYeKibQy4vaOen2JkJt+dK5SGjKYcghDOwboOH79yuRQJTxYGNbjRD9kkCf18Ez5v8Wy0OA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IsyDmfF9vFc687suBupwGhp9caQxLx7dOwUpdamgphKTdTSy3cC2ObrwtR6QNCewqaRv5fPe90CDJEWtVYclA2dIDXS3z2nlHnXccFQwQcFpTD1dwtLmwscLDg7ilt7PCPKha2Kf+o1Ob/jRyPUS5Nc8ODb84p3zt6cIIk3KtizpF37gmXr/oUCK4XGQDrBgjXMY57OChisO3DCRyRVls+5ejyfj8gA8ZCpRZGjJlMJF0J1qlQusTTWV3cXOlLtMQueLllkV0MQ6Xhc3FjdJNG7nPS3mQ0EWUTUJZoI4x5pj9368oYytFAGl6fs+Z9hrvs6c7zJGHIFBUhLNZCMd210FYHFxJ/8VBxQr99XSCAXiWe/8cW8FKv/BlhgC5PM/PKh+h/PsxIXHPMfo8ufqPVzAfdf5NMBzGnSae7buJJylgt5NNu9zEjlbWJyT+g//
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:16:32.3244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8646c670-239a-4296-a0af-08ded67fe4fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927

Hello,

On 6/30/2026 10:37 AM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Calling `__fls(val)` before `BUG_ON(!val)` invokes undefined behavior for `val == 0`, potentially allowing the compiler to optimize away the safety check.
> - [Low] The commit message incorrectly references `amd64` instead of `arm64` and misspells `density`.
> --
> 
> commit e9b79c78d336baf757f7578713831df9b1c4c1b9
> Author: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> arm64/runtime-const: Introduce runtime_const_mask_32()
> 
> This patch introduces runtime_const_mask_32 to optimize the mask operation
> in the futex hash computation hot path using the UBFX instruction. It also
> adds __runtime_fixup_mask to patch the 32-bit mask in the asm block once
> the mask is known.
> 
> Link: https://developer.arm.com/documentation/ddi0602/2026-03/Base-Instructions/ [1]
> Link: https://lore.kernel.org/lkml/20260430094730.31624-4-kprateek.nayak@amd.com/ [2]
> 
>> instruction is used for amd64 to improve instruction dinsity and
>> performance.
> 
> [Severity: Low]
> This isn't a bug, but there are a couple of typos here. Should "amd64" be
> "arm64", and "dinsity" be "density"?

Ah! Yes. Sorry about that. I'll wait for a while for more comments and
spin a v5.1 if necessary to fix those typos.

> 
>> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
>> index 838145bc289d2..371c9a4bc2d4b 100644
>> --- a/arch/arm64/include/asm/runtime-const.h
>> +++ b/arch/arm64/include/asm/runtime-const.h
> [ ... ]
>> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
>> +{
>> +     unsigned int width = __fls(val) + 1;
>> +     __le32 *p = where;
>> +     u32 insn;
>> +
>> +     /*
> [ ... ]
>> +      */
>> +     BUG_ON(!val || width > 32 || (GENMASK(width - 1, 0) != val));
> 
> [Severity: Medium]
> Does evaluating __fls(val) before the BUG_ON(!val) check invoke undefined
> behavior if val is 0?
> 
> Looking at __fls(), it uses __builtin_clzl(word) which is undefined when
> the argument is 0:
> 
> include/asm-generic/bitops/builtin-__fls.h:__fls() {
>     return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
> }
> 
> Could the compiler use Value Range Propagation to assume val is non-zero
> due to the __fls() call, and silently optimize away the !val safety guard?

How does that work? "width" is calculated as __fls(val) so why would the
compiler make assumption on the possible values of "val" based on that call
alone?

I suppose you are referring to an issue like
https://gcc.gnu.org/pipermail/gcc/2023-November/242808.html but that is
-O3 and under normal circumstances, the propagation is stopped if the
compiler believes there is possibility of undefined behavior:
https://github.com/gcc-mirror/gcc/blob/7ebc766bdbc8584699acb3f8fd30b2c393923c06/gcc/gimple-range-op.cc#L937-L944

That said, I can fix it in the next version to always check for 0 before
__fls().

-- 
Thanks and Regards,
Prateek

