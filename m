Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E338472;
	Mon, 12 Oct 2026 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771651; cv=fail; b=CYDtFdN0OsJTrl7cFuR4NW3Boxc7G0+G3bOGaxSMjsITT1H7WTqdijMXkyMeKJszG5iNOVd2qd+5W5v3i5Z46ieXl7BROmCuGoVNoe+ob4MCgxYPaU/vcSiHwhwXiYrow5zY3Ead+Bs2+ZMPnHcaJ4FFuyH55wbI+1H88Ns0NaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771651; c=relaxed/simple;
	bh=IRAFds+CvaeaeUjLV9SjFdfM7Fsn9On8V9e2LYld7CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOGhmUOjFdSpUjBbmDh51iwFvqJ6qBA5FsnrAP3slv2r3VCFJmNj4g4XYOX6NUUromrk84umMePvNMzMEOUTtRLOo1kvKheOKLNUQzKsNqaIw3L6muRHRz1Qng4gUunDx+V/bPxZcHbwdiNuvq9xs1cUABsdKITBMDH0EeMxzp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCIKESSe; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCIKESSe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjiJyE4oBixCXBJ71q8nNpUWxhVVNK+6xA5GIvCry1OMIo3vP5wainuOoAqWDL5oFWSc5MkLU2o4/jknaLksw3ZsrzulUpuRNOYhnNEFBlZLCMjHed+nq+O26Jhvd3uXuWXGmaURZB0Ko55TuMGzi8GT4macjlUz+e01asvkiM3+naKGEZOQpaKIweqFb7NuGIp5uSNmO3dlK4VbdMgP6BI0udYDTBXk8xcUR89UaoDJ8UfGda5UVVEMig9AIpvo0s3H4qbnkVBuC/Sb+XRg/po5KZ3cmR86YFphDIXCV/q/PccfhvQW/QeyCVK/DwrhW1Z/em06fHZ6ftkYHbfPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IS2zb749TnbguDxAdOqQAlQ2h/ai1/MCN8zs0xG4Ik=;
 b=X/0EHToI0G/FLLuo0ljSg/wVAiK1ouu4oUZ2+LP9Has07oKKnvbmEvDwcppgfBALPhC428sfux6ymN1R0aLMvxyBJlZTi7LzOz6uGrx2RYlEndzWOAAO6KMWklPFEjutxl61iXweWSEt/esMi/wmKpEuKcmr0w/S7g8fqnDU198tr+F3GDqdAOUk+8/BIG4X8nAjjV17qQ+tyDik1Kq9s4//4Mm2FKueC19bvXsF2LdJ9EJSCKhcJnxfOxnjAMkFUTquRJIMR+AwJ9Nay89NpJp0PhGOs6rsYwL6U1lySx6vsoAleLLUm/ojEk+pPs56hcCKOTo72YSoHqGddxikbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IS2zb749TnbguDxAdOqQAlQ2h/ai1/MCN8zs0xG4Ik=;
 b=gCIKESSeYvgY6mGz/Bih7CY32wcmGzhpD/MfJC0eZwhGNAiFnzzJTEHmCQ6UXnheo4wMJWn1g2swm+q144gYOljDLkKXv4jIdfHpe7mHwFaPvt9ZAIp+GPExkWTWk3mbWS4qJq63B0q8cGwRYxzNZ5xpHejgGMU7lP76dqtM3WA=
Received: from CY8P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::10)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 02:20:44 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:6b:cafe::e) by CY8P222CA0019.outlook.office365.com
 (2603:10b6:930:6b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 02:20:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 02:20:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:20:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:20:38 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 11 Oct 2026 21:20:31 -0500
Message-ID: <91a1bbf9-0409-408f-bedf-a5414be4d1a2@amd.com>
Date: Mon, 12 Oct 2026 07:50:25 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
To: Mete Durlu <meted@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
	Chen Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
 <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2a92ea-c84a-42ab-ce6c-08df28076b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|36860700016|1800799024|10067099003|22082099003|18002099003|921020|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HmtDj/4B8qxEAX9mScbcfsTQ6fArSAJ+XYsmMiTGqQNBipuMlodvZLBMycfn3Fzpy6TD0N09DZHautRaf6dsvVFvxeGh9LqcwNCbXTYX544Y+irK6CMObDa+B49nS0BQRiLuqQ25K77wlTQuc3Dd8uFsNGjlG0Y9OZPSGzprgWIS5dPgg3ZAgj6EfjapHf96KZvl7InKiy+QiPVeklrR3r72mJ+Ki5kigB5/F6zQodgwXkGAmaCgQ6KKCnRm/JgPwBznOeB08lw+jF80lKxIC56K9YXTAS4tmXkceTZIm9V7ZLKerKMs7mBv3EbIMZyHhMQMKD/ZdhGxDaAWVEo3scWYsSpSkNJGXzp9f2lcqzU3esQf2n98bI3Ysh3Nhgvd9otyPWs9n4YrFxQF0/GVQAGagdmr4eyV3qovvuJLLqUSYq/cSDPuLFg3XBpATmhEDf/oDFyy9v/iclQkHlMxPoXFWrngDvC5dEDCYhVRkUYo+544ekvcsjjb1n/i9fj1rydGrdgkJOPY0N17vSGWNEE3BC38oktpIg+InD0Zg7D+AhJDaDt0TunxAMKX/aKj0ttOkaTagHoDahmhZ7jF2CtEYFvJ22mYAGa22EjgC79obbqkMEkZDABCksTFqBGocE9IBiSVGTEnkvy0qW7W2IYLhm8bcHOFWBmw5HAHimE+yrN+d/HZrliCa5eC9y+2wLEZZEH+7uGyB5iLXORslvxw7PpMyZ3vjsE1OYyDjNjMaaRresoOf5GzeVxYlM1T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tbryS9J7ew9vgONnMPsBMAyt9IqFcxoStBzef1+0CeylkZNpnw/dOhMHh6hWJULl5Ks0+Fx7OaVtBrCnlIuRrxSqsP6M73p8UpiagR6M3iIxjr/9em/qvsEKj9nlDeCtN5MujxambkTrN4r3e80N5oqMqCrmzRTUeGASCcK3OsKsKmQ2PyKZ41DREb/Ytb1me/elKhDvKP5RpKdMwwnX2/xyHb/7nyGwUjnqVjq7NvvNr54l92ajdKL04HC06DpxLhW8zgfEUcx8fTsm2m25T/+FiPFVWoadLPe52H1EsPOKsDFNHS02q+AXu7zkhkOBACWrKN1UKlSjzXEXMZj+SBUCYd74xNpCwhBRvAxCSCy6m2+EJpKu0ehSOs4BZHTbgtZdqFj6LY5UniUlA0eyOiqPgZJVM5JYNl7WYXKIyOlzTx4dRfY8RKadDSjIH8Fz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 02:20:44.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a92ea-c84a-42ab-ce6c-08df28076b5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

Hello Mete,

On 10/7/2026 3:49 PM, Mete Durlu wrote:
> On 01/10/2026 21:28, K Prateek Nayak wrote:
>> When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
>> already parses the set of socket present on the system.
>>
>> Use the socket_info to configure the sparsebitmask (sbm) properties for
>> the system - namely the number of sockets and maximum threads in a
>> socket instance.
>>
>> arch_sbm_cpu_instance_id() traverses all socket instances to find
>> a matching CPU which is not optimal but instance ID is only checked
>> when the CPU is coming online. Since this is a rare event, the
>> inefficiency is tolerable.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Build tested with LKP's s390 randconfig with QEMU cmdline:
>>
>>    qemu-system-s390x \
>>    -cpu max \
>>    -smp 2 \
>>    -m 2048 \
>>    -kernel ./arch/s390/boot/vmlinux  \
>>    -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
>>    -nographic
>>
>> Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
>> actual spasemask setting is only build tested at the moment.
>>
>> XXX: Any way around this using cross-compile and QEMU?
>> ---
>>   arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
>> index 1377c6f3f670..80dc51f5ce6f 100644
>> --- a/arch/s390/kernel/topology.c
>> +++ b/arch/s390/kernel/topology.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/cpu.h>
>> +#include <linux/sbm.h>
>>   #include <linux/smp.h>
>>   #include <linux/mm.h>
>>   #include <linux/nodemask.h>
>> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
>>       return tl_core->pp != POLARIZATION_HRZ;
>>   }
> 
> topology_init_early() is called once during early boot and never again.
> Considering that s390's topology can change during runtime this
> implementation won't work as sbm won't be able to adapt.
> On s390 max_threads_per_instance can change during runtime.
> 
> Like sashiko pointed out, this approach also does not consider
> any newly added cpus.
> 
> IMHO, there is a slight redesign required so that smb_set_topology()
> and smb_init() can be called each time a topology rebuild is necessary.

So based on my limited understanding, doesn't store_topology() populate
the mask for the entire system on s390? Are you saying that can change
or that stsi() may return a partial topology for only the online CPUs?

Since s390 default enables hotplug, I couldn't easily grep the hotplug
bits so please forgive if I missed something.

-- 
Thanks and Regards,
Prateek

