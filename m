Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555331353B;
	Tue, 17 Mar 2026 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773724284; cv=fail; b=d7lvuugGossDc6+qMiDYAbkCMatgdbhaWtOYjxaCmXorO5zDDYJm+eHRGmxoDkGSAQj0Y4oSVCWrc+GrbCMvpSTvQQgnX3M9AfuS7HImGDPcOxJnTag1sFMK5qlEeVfAWNEapM0QOIiYjMk0h3ayZfmyj+pwlUkNS08v/Fx3lzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773724284; c=relaxed/simple;
	bh=ceBUGW/3hSDjyGrxrDHJ7TQQncA9axdfzWyTj/lEH/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H5xdSgCbKfREkaacHHHzQtwWe7C+GX9bJHVPnCAKuRqpsUEUnKg86kEZcWusuEMLtnZTis1WUKpeMwTYRka4JbLNK93Wff5H+VwPGsNlVI1C82dLyso3ssQBhbEpzz73lU7OOsZf0fOkfDVhQONbxYrAKpFW/LcVCrRygywB2oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IZ+iCho5; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IZ+iCho5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3tKj6OYJFvdFvZlFokm3uBq54fHJ89gdvCAQ1mibTJ0D4rL7xZyQHbMc/+AF92GKtyi7CoUAQyVLgiJHEjrv1Yw9Ct0EyBX+0D/000l4zSX+/J9PkN2xga55R4AZI/m+iY/LgYguGxdUsGavEeqcCIptHUs+LvBHuESvQf7JdUGl9XHEmmHZnZwrZqMsORIKvJ/L9oImr8cPzKgzEu/dxLYUaJE7WXiJJR3IAEIUv4k8eahx2CLgoJWKrWyKW2kD6uUhK1UbeV/gBBpPVD4U0WDjFWeo2Juxu2J92/QnFc4FP4yKOQ2VX1/4oPQUVm1uiMj2IpakGII5uh1QFfjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F43DsBW1DIz/ciaUzZxCRjd4DKLMY3Vf+jP/6z85oEE=;
 b=wxyMUNf8rStHUv3lLs1cNXhy6hkyRonNoQ5/zrkn6zCApTjrEJY8beo+G1vtcFYd8JWdE+ddjJC5BoRVEzRmcEcPlFluIwHPuwK4Cq9+pi3GvhpVqq1h8XFL/x88upUQuAg0WHq2XX1x6F9NFMf80cWVG4q9SJnbIvh01VXXLfCt3Jp8ELPaeosXcpLDtoyxlPdQiyNuAyIbuBCkkRTsCbqw7NrqRQS7rBTkmqk7JspBQeQx4GFMHQqRgr6eeByf4oBkmItAkgZEIgIXFjxVicKZZzD2PMKPAWRo+L+/gogp8vgzPK3ALZqsUbFufcvdFFgSLeWfuEkPAbd/aUO++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sifive.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F43DsBW1DIz/ciaUzZxCRjd4DKLMY3Vf+jP/6z85oEE=;
 b=IZ+iCho5Hsvd0qmKqSallyDgfYatTM+jf2Qze22okwn+i2Qqj4gnUMb7KcLK3HdE+f+HUZsZmv6F+Qi7Zb3C5dkZMPTPtv8v+cFLuUO7whD4nKjdwcRlUruNKyZ06TvVdrRH+SrmKa5r0Dd/5PLyHvl5/wlgwkMItfva0lHpMIg=
Received: from MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 05:11:17 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::9a) by MN2PR06CA0014.outlook.office365.com
 (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 05:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 05:11:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 00:11:16 -0500
Received: from [10.136.37.230] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 00:11:08 -0500
Message-ID: <9fa8ef20-1da2-48e3-a9d8-340a5106cea8@amd.com>
Date: Tue, 17 Mar 2026 10:41:07 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/7] futex: Use runtime constants for
 __futex_hash() hot path
To: Samuel Holland <samuel.holland@sifive.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, "H. Peter
 Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Charlie Jenkins <charlie@rivosinc.com>, Charles Mirabile
	<cmirabil@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Jisheng
 Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Arnd
 Bergmann <arnd@arndb.de>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-8-kprateek.nayak@amd.com>
 <f25ed5b8-e785-414a-b13e-85c1a787665d@sifive.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <f25ed5b8-e785-414a-b13e-85c1a787665d@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: de3a01ff-9094-4428-b186-08de83e39e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qJ+qfHkyDhpuyR+nI64b1GyuVhK0vG8KRwSbX554heKAtoHgAY02m50fp6/lgVgDm1XFrifv/OIyRigELP8YJukqJ/qwUWwZWz1jCeT+EgWtjbcWxXA5A9Em/1JJclv3nKzU+uLjiWp2ZdnH6Kwrw0fzk5Ags7ch1TqZDa08wlZbv1UwKaXuzM7UHJnosk28VVwfd3afidYtnZiOpW3giZ7PnVGZtWhmsx5NrQ37fpzRyOlFHLSWUqv8xjnrvrINTziXw8sCiiKRqc6QLIwAQm0PYlAYWLQ17+8yWYIboptjCmTTBiqXH6U5FmlK5lR4pC2IZ3G1g/VdB0+e5QRUefCeUX+gsFAjWXNT4/HfRw3nAFAr9vK2LhHvU2JYanzRip6DVr95HCnWRs6iEGhiYlI+21NuyQI4H/4jsuoTiEFD7fPSn3zCGxzrwLzxPez4mAG/vkqfpMyBQ9XD44KCe1m9uxVhX7VqUr3WduRVEDceAwCjjUVviXjyJfK2rA8zoUxsew89gwXBZIrLXhIlGwUR/Y0g7ExCgyNxtf2fdBB3bnLD0BUqezwkIUqrsG8+54kTuzU1tG+ueAtjbl8DtVv8WuSzdzmP8ufrZMYFSfCnHV7xuzaEgfjOH6FuU2P54MNLH2YVWHBz55p43Uf+t3aaLIIvgYePt0f7XcSChpSMQufoA+TxINCM12hJG/XtjLER7NbsFEN1/sukMLZGFi2VN429sz985PfToBY8nMSZtgowo/feYm4bZdi4kOANcDokOHPTp53mVHNs3dF0fQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LgMejL8HVi51SFtSNVzhPWyVNfVnUQ/Ufp6pUMOJ7lcTSAOt/UGXndRmRIKero3m8FyRmUBRkyogQ65C5FfK6tvJNL+8Y163Lr53Z8ae54tYOvcDqB5Pslkw8vxB4x75BI5/zk4ndW3JFg5V6ru6GYrzWGSadnZiB8tH6ZZPXG5LsC5cPzRJsYp0mS9rdIBwqSHFEWBYGjZv3YAPwE/vagABUCcU+oP0DvqtTSij1ylS+RzKBO6GVsPyQi3sDotFTHrsSfVaXFAZToUVDEw2PCWP8m5RP+Zd8G2ZDjgWGJBb4hDpHYBKQx8XNereiVhBDSMFT1ujliXrUMQhYNJWPgMXy4SSygdh/lx4cTMhYT0CDn2CHr1rBuq+zfwLYLBzbfzDzxeKMuqEqXdDRiu4DL5fGV2CaexHHgWtooZINsFp1sjS/iGRNeCyCMxqqbRB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:11:16.9497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3a01ff-9094-4428-b186-08de83e39e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439

Hello Samuel,

On 3/17/2026 8:36 AM, Samuel Holland wrote:
>> @@ -1913,7 +1909,7 @@ int futex_hash_allocate_default(void)
>>        *   16 <= threads * 4 <= global hash size
>>        */
>>       buckets = roundup_pow_of_two(4 * threads);
>> -     buckets = clamp(buckets, 16, futex_hashmask + 1);
>> +     buckets = clamp(buckets, 16, __futex_mask + 1);
>>
>>       if (current_buckets >= buckets)
>>               return 0;
>> @@ -1983,10 +1979,19 @@ static int __init futex_init(void)
>>       hashsize = max(4, hashsize);
>>       hashsize = roundup_pow_of_two(hashsize);
>>  #endif
>> -     futex_hashshift = ilog2(hashsize);
>> +     __futex_mask = hashsize - 1;
>> +     __futex_shift = ilog2(hashsize);
> 
> __futex_mask is always a power of two minus 1, in other words all low bits set.
> Would it be worth using an n-bit zero extension operation instead of an
> arbitrary 32-bit mask? This would use fewer instructions on some architectures:
> for example a single ubfx on arm64 and slli+srli on riscv.

Sure that works for __futex_mask but runtime_const_mask_32() should be
generic enough to handle any mask, no?

Currently, the __futex_hash() with futex_hashmask ends up being:


  # ./include/linux/jhash.h:139:          __jhash_final(a, b, c);
          xor     a4,a4,a3        # tmp350, tmp353, tmp334
  ...
  # kernel/futex/core.c:449:      return &futex_queues[node][hash & futex_hashmask];
          lla     a3,.LANCHOR0    # tmp361,
  # kernel/futex/core.c:449:      return &futex_queues[node][hash & futex_hashmask];
          ld      a5,0(a3)                # __futex_data.hashmask, __futex_data.hashmask
  ...
  # kernel/futex/core.c:449:      return &futex_queues[node][hash & futex_hashmask];
          and     a5,a5,a4        # tmp358, tmp367, __futex_data.hashmask


which isn't too far from what runtime_const_mask_32() implements
where "lla + ld" sequence gets replaced by the "lui + addi"
sequence to load the immediate.

Sure it can be better here since we know the bitmask is of the form
GENMASK(N,0) but IMO runtime_const_mask_32() should generally work
for all masks.

Now, runtime_const_mask_lower_32(val, nbits) may be a better suited
API name for that purpose.

If there is enough interest, I'll go back to the drawing board and
go that route for v2 for arm64 and riscv.

-- 
Thanks and Regards,
Prateek

