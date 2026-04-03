Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB73822BF;
	Fri,  3 Apr 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212531; cv=fail; b=XIPEV+d8o+7z0sMMCslfzQJXDsl8hI/j5UzzFBfC4clUDAZoZWixTvwL9/+lWnWYsWX5EaO1/nDXi3GXKUzmsiuCUg1PORWEwxKxSQmv2wGztwI7LHEJv1eyZwU3ucUR14YC9kaukSpG8ojJwdeM8pHyaxCPtAlmnOeUjnK9n/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212531; c=relaxed/simple;
	bh=SloC1Fr/zsyTVYLF2CrfohN9LKUBgYvEAkr0iQQqVnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g31VUWwQMFBinIMzQJSuAVS8o1QiHSImoEfOh+oa9vcApN+/dkzf4ZKXp2GcUbKIcYicTcxfBMWEGG6wWBc5rqR6HxdSA/uz2CqBjve1EzKUPB0GATHN8U6UVakn0QKkQgLqs6msp6GSX1BaSVdrZGQczbaeDwCqqyvay/t7SY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zgEf6OzH; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zgEf6OzH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxIp8ojWrNNfRn48Dr7m3omBiquhw+tqHl7Rd2aNY42hym2/ZQ8G9l282DOR0opYMSqLrSzKIrIkHd4Jk7M/cT/l74TZ/3/eObfFkFfTByjUBSJAiDe3JCoUl1XiXTkUEPexpoB9yThbsz2pYKYmjfUIyTURdRIeBciwThV2wnQu+IxI8c6DnZP6tXC1lK67IvAsd8AZL9htbDMSJdhotbI6Rjf565PWmaLhrQQbpQlpG5wRGDxSi4GYQTumwlQJ+yXUrmx1uR9GUPVMjJosSad2ZETCYUmSL+WvXqKqERQ7e+EGwIO55IcUuXOE9FnGQAcHMSAciVWJ9Kuvrw7gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d38J4vIbpN02+c8u81NFHNH9FKW5AkT9HjMUEevo/48=;
 b=HE5qVv11YZIEuDKF1TVeRk0SLUFYHVN5DaZshlqoydOYrWfoXyClM12LD9nYC0DhteOaHrTnWxCBgeiGYJc4UBY+jhaKV5cWi1O+EMh2aqklTORoKsrwNc+oGcCv6KzLFJ62oCLDWtixyk33ZnLFs7Als9HofLpLznqtYstGXULXroLZMJhWJIwyM536XOoSBgQbyvgjYKs3DEMqHw+ow1mE+zvFDun8FDmw2ksuHxgpX3yYPtp80JzhXGJxW8Mly3JvoQaRLxPindPgJjsWU/akJT5BgdtSehsd1XCHHNYvMh0BuopbncZjkDLugm+a4Gr/a2KxxznvJN4FKQNs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d38J4vIbpN02+c8u81NFHNH9FKW5AkT9HjMUEevo/48=;
 b=zgEf6OzHFiKHjhLYFx5k74bvLaB6LtxPnvRxuvsTSO6NXwR7W5k2zZGSPWCKCGvkk3Xkmw5ufsCz2F9gZDIU9/DS87S0/pMEayhCrZ/Iao8jigAB28pe2V0XtT+Vy7e2PbPOfWPlVJIu3HzFeXmijHNbrPGN4XB669JnynhKeow=
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 10:35:24 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8c) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 10:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 10:35:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 05:35:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 05:35:23 -0500
Received: from [10.136.42.52] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 05:35:17 -0500
Message-ID: <f47a0887-9890-44f3-8532-47b6afefe09d@amd.com>
Date: Fri, 3 Apr 2026 16:05:17 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] riscv/runtime-const: Introduce
 runtime_const_mask_32()
To: Guo Ren <guoren@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland
	<samuel.holland@sifive.com>, David Laight <david.laight.linux@gmail.com>,
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>, Charles Mirabile
	<cmirabil@redhat.com>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
 <20260402112250.2138-5-kprateek.nayak@amd.com>
 <CAJF2gTSDg7JWHGS5E_OQWibFRTrY5bUuoOntmVE-MCt+FawLZw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAJF2gTSDg7JWHGS5E_OQWibFRTrY5bUuoOntmVE-MCt+FawLZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: c67fabcf-ab63-4042-3b6c-08de916cb6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uGxkNcIYsP8URIGhr8oyfnt4Ya7neAH2Nu2OcpvwJvSdSO4VlfJ1KPeUNdCiIeLag+en8ZjE//GnZlkTERg+i40oAD8KG/DPhHCPAWnpvMbo8o7MHXsDOQc8BvfDF0HCpffbhjOTBF7Kn/qH+PFhV9h88ubQk909AZdsWb8viRByTmirAFljybxyukWe+Em9SFLfctyFpKKHFeeZkZvxJYlUyD5fdizXpw8MEtwQ9welk/1OsPI57VA2rtSPnBozXCw2H7v8rWgKOs3dX7mKruCntAuZ6cIHG0Ny6TcouhhCssHH7muU5PmRBmhIYq7pE+jbZV+6jIQF44BLq9TO1T/c3d3lfUNeTQoZNd87zK4LOGg2Ko0jVSnj5mlVRtI5Jn1SYjPEISg9/Dc9t1IRvaCVRMBlMtXp0j1YKIuS+UVgvZBsz6W3hkdvQjpFW9HEkHXUrIv0MkowX0deL6XUEltirCBzUdno/PIqlI576rhtCcJUQY7lzICfhgpRbJFnlb8cQz8eCEnlgo5JSqCvdCFLnLLPYJ0cBnLKN75NUk1EgDHwGydxbDrqUPldm+6DyctrriDhc1jzOpEcJNJ46RhCBUiz31JOADSpkq3ntlru3QHWN+2s0+DGugt3O8Mmxq53X0e5x9LMJZc+w4YGT/tdFBtfGjJirkSZ9evG/XhjLBN5SFxqpG29OjtaHLH53Bn3Vowavrke2AZS4ERiSCOZlMA7i6l8F4Q/BUdbm7yiTUndoLriXycytAKtwzDo0cv+7kSznCDXXkC8PPphVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cGo79a3cdQZijKQ5Xa0PAb7253vIwKEgxHxqFIt1zuu6GeumzdRVrByezb5vCrJv3qYCdCRb5OhGsR/7AnbfX1238zWWnHDwFKsMI3sDyKXs6rhSJPceJEkP8hK27SrCsG5PW2gar4P5grpxP9z54EBbA136ERPpDmQ8n2kf8RFOl67P7TyUSVfOncZQ/s/Yw3CLUAnvFfs1gKYIs6AW+gc3YW4y4eFXl5Aa9k8M91A/uyWYLfp8qHFbRfmJwA8hwBUMjowWtZCbPwE78zI4lE62X7g867XCHGvJhJZiVPi7rPkBtcL/VmZL8xMN7ZiD5m65Jp+YExINz2Lgw2xLMx0xlFtpTdXdiNi7jWoJ6xi+bwqUyWLiYI1hL8dTT/dR5gGFVwCUAMYWLMe7YgL8/eunvkIGhxW3myJHeurkc918TzhBLeyuFsNjqOVBjyzA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:35:24.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67fabcf-ab63-4042-3b6c-08de916cb6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

Hello Guo,

On 4/3/2026 3:12 PM, Guo Ren wrote:
>> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
>> index d766e2b9e6df..85efba8ecf12 100644
>> --- a/arch/riscv/include/asm/runtime-const.h
>> +++ b/arch/riscv/include/asm/runtime-const.h
>> @@ -153,6 +153,22 @@
>>         __ret;                                                  \
>>  })
>>
>> +#define runtime_const_mask_32(val, sym)                                \
>> +({                                                             \
>> +       u32 __mask;                                             \
>> +       asm_inline(".option push\n\t"                           \
>> +               ".option norvc\n\t"                             \
>> +               "1:\t"                                          \
>> +               "lui    %[__mask],0x89abd\n\t"                  \
>> +               "addi   %[__mask],%[__mask],-0x211\n\t"         \
> Ref include/uapi/linux/reboot.h:
> #define LINUX_REBOOT_CMD_CAD_ON 0x89ABCDEF
> 
> #define RUNTIME_MAGIC 0x89ABCDEF
> 
> "lui %[__mask], %%hi(RUNTIME_MAGIC)\n\t"
> "addi %[__mask], %[__mask], %%lo(RUNTIME_MAGIC)\n\t"

Ack! I'll clean it up in the next version while also fixing the
stuff that Sashiko reported.

Thanks a ton for taking a look at the series.

> 
> 
>> +               ".option pop\n\t"                               \
>> +               ".pushsection runtime_mask_" #sym ",\"a\"\n\t"  \
>> +               ".long 1b - .\n\t"                              \
>> +               ".popsection"                                   \
>> +               : [__mask] "=r" (__mask));                      \
>> +       (__mask & val);                                         \
>> +})
-- 
Thanks and Regards,
Prateek

