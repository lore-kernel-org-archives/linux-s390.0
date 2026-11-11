Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794429585;
	b=F0WY84omcO/pTfg2k60I4+ZBcEJ+8+snXrrQH0MTFiZ8QN6eyI3i2c1iGC3akBt01BOB
	 QoM4a/9XDZedj9gaZ7nMj+DvSui+efpzpwFWTOuB/hvblNnZqrN09EfS0UfX+Y01K9sFc
	 +F7XZy4dDlT0mmsARilHMWAM5NVOdcLD2fLS51u+MOuW7aACDRS2/8ryRAl99kFxn9/Ob
	 cmKNpEKT/1lEThv2kzGgEi8CbskQ8n26QvC+diRy5uNZ50jXi4WqpybuYji6IFigKLxbU
	 IHOPocfo7cQP21Rg17X+zJPlFTwThgnTus9vQ1I7BG/gJnw32+tHEFIHEiqokKvQD+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429585;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vpFFUBef3ORhRhRHBmdSYeFTIBv896sR/I4WSwGYm5E=;
	b=G1Jl0Wn7EtWnffrr0JU4HKqKcCCuDujUG+eka7hubgpfbPFXWo/2r9sE7btQVQZGU5mp
	 13/d2vMpNfh1Bd08/MbA47uNx+5qB1fK6zNEVo+f+QnPlrDNRkf/jwy6TZyD7T9EkzGsS
	 qF0NPzJp1fSQFakY7Pwovf6qrvrx+9fEZoEeXijHsGTYELl8UsLFv6XYzFvl2ofWLjhHu
	 oZ2WGyqeVExyTd2yLsiOjvfTTUriqKez4p3mwibioOoohOcAkd55Ct4SZepD4yZfE82Pt
	 ggB4N6GopZ5YAce+enVZkGl6euvdmIAZeltUfEu44zJ74mV9FKFK3Tkqt2eUm4a3J2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qsd2Z4e6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.58
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE05606A32A;
	Wed, 11 Nov 2026 20:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE05606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qsd2Z4e6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de8iawACYRTwuFamji85i9tBZNTmIKu3P/Sfjd9jHPul9Ph28q+KrBKNTLnFnJ5a/2de69Z8oiZW8hmaOQm50O1tzrz888GvZx6OIekH4UQFOvLWimen+QgVCJrMob5Ant0x3bdFqNrekhVbmLspdZMt3F48OX3CmVG+j5ABbqyJ3UxGLqtqyfiRhnMu982pdbQdT3gOgXXFPyy//fqCF27xxupY81lH6lV8dmbdrh27fqnkiGxNI7wLOhyDriroQTRB4toV5AzZTNzLcBwFBHGeDeBAHKg4hRpuFhWVA1Uc5nGovbeh9f+XoiOS93jNzyj+79bGJ6BoPl58nVA5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpFFUBef3ORhRhRHBmdSYeFTIBv896sR/I4WSwGYm5E=;
 b=tu5xdihqn83bUtxz3ZmaMKutPpv3MncQEyCk6dSUg+7Hau1ArOUm+6xo5KAsJ59fVuOD1CNyvYHFgwHsBcxyG70wzf3EovBu78sLzfigD584Ti90OmMgelUFrC4hLf6DCBnurQ1XOH3/T+LAhSvjybp25OphToELROszUpxzt2HNN6uciet0bt8Q4Rlewwjzcl5ymVHzqENWXsAa2pycEszBnId0WJXsmj5uj61teuNZ1zkJ1cUtnro4NM32K230qc6tj9J+4/DNGG0IBT5/9Gr8iFkaE8U8iHUgTfwEk4Zh/s66fg20oYkiYLKhYQtpjEkDZBK7ussP7gcSPA+49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFFUBef3ORhRhRHBmdSYeFTIBv896sR/I4WSwGYm5E=;
 b=qsd2Z4e6QpJdugGmBQt34V6o/u2BUfVwze4ozq+tCH864fDBxAD8uApPpWLpN6mQYKkghX2OSYBjff954k91Q+e68k+OrwuPyxa2YEytSrDvoW7xSs+zjiXw711Qw1ttW5xwkXRz1LvWirgTa2jpkr3YJ8AE/wiXIYsr4rprQVF6eg8VseCUlud6L6bA60S6KFhdoVisM7ygJjXE5CM8+dzQ92S0NURMBHSwIkhkonExaUmCz0vOD3gn1TYQBbTqhde4HZXgbYQCSldXd3bkbutciwc0ZD9/FL4HnxIuoPyZcLv8oMzadGsr9i84XweSZu9VxxdyRk5W/u9/PQ2v1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 20:37:32 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:37:32 +0000
Date: Wed, 11 Nov 2026 15:37:31 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
Message-ID: <avTSC2r61uht9oFK@yury>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2a9e64-e8ff-45cd-6393-08df40339c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|261028144727099003|4143699003|11063799006|261022105027099003|56012099006|261022075727099003|261026140227099003|261026121527099003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b/u0G0e7uwhApBEBNOijjHLDlqcqRQtPOOIyDa1cVniPiaoFluzGmou88GrTX1ybEqKWvX4KbuPCsODeNSFN1epgnh+nXu7EjeL/Ydx5//snIuVR5DLXl8hxr2xITQaF2O3uthzijy6hFt7ePbtDoFLu7LG1Bb7mHfawb3bc8NAjydmEsZC2I3qoDimssdr99Q+m/k+MP8dNngmCw3RxwRAz3c0jg0wE//pfz+e102VmjoYMRBwoP7kQJmXf0zev79FY75DCZAnbPWAYRCkhsSnVI2qwkt2V6JtXvnVX4nSKIzcIdABEqlvWyj3WiOPsOPPvL2ZKZ7D/NrSQ2VpFD+iR9x50dcIx3xuDy3a4GUcwDUSeXfMVaFQryvNZsU+426irPX2Gb/ENGKRCHcFZ+ruF1UH3CYl52qn2Z9oVt6nl0UmDQRqvQR/IWr0QYb0dnThcWSmRDu682/jH6Fxg98+mnXRtWj1V9TgQ9ylWdSENbPV89JvF8BlAIFhdv6idI3GbxPqb5Ly+b64HPWQslGG9ne8u8OZiOGP2r9B19tm8vs+CBazFBH41HLC8fVLwZRYWGZ95MDZf4mtLPDa7ioicaTb4KbXoAVjIwBDmam+yQUR7OCDvJeq8spiX4xObsBD53Dplw4RcZ1d1ROusyuxbAth0eDbIsJ5STtDv8qc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(261028144727099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaf1dn3EpjUUehIlz4laOaepTzUAjNCpC1smEIin5uxjxOlQZ6ZqudhZfm7a?=
 =?us-ascii?Q?P3gvc/IAkykDzJmVG0cfS80ZihlPlWiHzHeQSrI9Z0sPu65y/Sc6nAQjR1rK?=
 =?us-ascii?Q?Hr/IpO8NNlJVQ46YdW5wQX5Hzw/PtdidtkrVHmSOaPsRYmMK65Ey+ud4C+ZS?=
 =?us-ascii?Q?LuR9nn5/by78UjV9fOh4i8dAydOoYr4ohUhJ5ncr/BPeC2/xNdotuyjczDr7?=
 =?us-ascii?Q?vu0Ub9oZ2NAgClf4yW8cC0yHrcWAxsnquiBQ/4k7/sroXRhCHQQjXzco038W?=
 =?us-ascii?Q?iVcffhoy2wlOnMYqYMDD/HChzme+KwvFWwBmAwvZOEmJ3r72ctv/U9pi+Yr6?=
 =?us-ascii?Q?m2s5oVN4MHOG6lBqo9+vH3ngelQPkeONjIq6fZ2YYvI35h1dmbBmxRy+0zCz?=
 =?us-ascii?Q?BJM2VGmh8HA1bcXEd7fLyZQajRH48A5h4S/40BwEB1Hhp2lQiyGlOXnTtPrE?=
 =?us-ascii?Q?NQVDSzMdT4QISSYF9Ywcb2qrx1R7IDTKG4pmcqEvMouffvlkqIIV1bXR51kM?=
 =?us-ascii?Q?I5Wnpmytg2eXfb+EvxS5AhI07KwNrZbNx6pdWYyWm4Zasn7Ev/iGPs4crViO?=
 =?us-ascii?Q?+yEJ3WmJF2EqXqUMrEigdWlQpw7L5D1LEslvM1TEmxY9rKr+e38+CFqaSbuY?=
 =?us-ascii?Q?Nu5Wp/jGev/+hCi5EzWiR1aAIw3J9D00g+c4+x49n5GCyoaVhGr2Wn/3SniO?=
 =?us-ascii?Q?81niCyuPmjzSc5KH1txvOwUZHdmkZiYPjkcvLc9BAn3h3wlMQ0W87h68960n?=
 =?us-ascii?Q?Q0uopWZAkyqXRjAHvA83YFDXvKvQCa0QIrrc9+ye+I9bj5UoLsrKRX0IJHIQ?=
 =?us-ascii?Q?wxdiYBI/fZFNzcEIXZxUE23aRyec9dllhnJzsD2PFS8Ndmbq3dyv3ARsdbYE?=
 =?us-ascii?Q?/4JkMAd7wN6PekJgXT06uj6c1TWlPZDv7zLWLMeY9wyytgpmrkiolQYsbM3M?=
 =?us-ascii?Q?yWeAtsOoAGK0znhqx843Xb/iCzIh7wUUOvFC3SCgUIpLJez7qZ6elPpzl61p?=
 =?us-ascii?Q?071N6yIIE4UcfeO1f1BLrYC6Rx1G5qcHeRxIgCDufvP82CXzVlsrI1t96PMY?=
 =?us-ascii?Q?cafKP9ta9pt4MK7iLJSI4Wv5u7Os1dnS1+n4SdRxwFOXAhs8JJv3h8qriSYv?=
 =?us-ascii?Q?K10dy5f7fRcyh25gvOIaFJbzmQhs7JXqLiHYOe4uYBJ/BEGsBcCGpMVRuORe?=
 =?us-ascii?Q?9sACS9djdXtsz2j3ajXRt0Bi+LtLpm1EPYNrfqIhi4rikis/vN1QfassqiQ0?=
 =?us-ascii?Q?+ys6MYk6nczNj4dOOdYvdTm3ziKoVSXyMh2zRdfix77GryXkyabCBUcxnXPa?=
 =?us-ascii?Q?gHXsTc7vXnplcSXglpjkdKtKj4DEmkvXKJLDIbr/D2CM0mx4Ea04BblGCih9?=
 =?us-ascii?Q?PyfcYIp1YwH07r87X9hTktjfx4cKnbDKNbysmhyVLU8oID0hZ0fn7Yap3XvC?=
 =?us-ascii?Q?dU2P1V/IzojRHzM++icDE5Xnuy/IRFmKHEHc5czC4yJ4+pwFi2d+dSLpDRCY?=
 =?us-ascii?Q?LW1+XpZ7H2U6kfiayhy8/oEvMkUJPrWnIJ4i5hwvDZmtTh/ZK4vrr63iYBCL?=
 =?us-ascii?Q?lRLhgu3B+zeTpQC5hCYkXn5V/LJ31Ytv8H+tIuvfPTIRxAJOkMJje0m/umgb?=
 =?us-ascii?Q?tJ4VsNRXw0I9tDzEctHevESD+weFYW8NtAkDQgqf8r2cZd2BcE7Rr9DeF3Hp?=
 =?us-ascii?Q?k+DrY4qPNLPu2g69G+EWO63FAOUICm4CkrglGbjIidR0zkdWPJLVZLaDOdu1?=
 =?us-ascii?Q?uj+O7I0GCeMOauqCuUkiKS3eM3GqXefFkYJimelgw+lP08Flx017?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2a9e64-e8ff-45cd-6393-08df40339c83
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:37:32.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSqsdXiehB9k4oPFQDdgCKF1DwlXlY3XWpNPSvHXaI6dnMV7NchS1rzP9VGZkkTddkbLX+GfylMjCA31TMvozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

On Tue, Nov 10, 2026 at 04:15:31PM +1300, Maxim Kuvyrkov wrote:
> > On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
> > 
> > The preferred CPU mask currently lets the steal governor reduce vCPU
> > demand when physical CPUs are contended. This series adds manual control,
> > opening more use cases.
> > 
> > For example, setting CPUs aside for selected fair tasks at runtime while
> > steering other fair tasks toward the remaining CPUs.
> 
> Hi Yury,
> 
> I've been trying to do this with crutches in user-space for a long time.  Thanks for implementing this in the kernel, and with a convenient user interface.
> 
> > 
> > A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
> > whose affinity includes preferred CPUs are steered away, while tasks
> > whose allowed CPUs contain no preferred CPU can still run there. The CPU
> > stays online, task affinity is preserved, and the selection can be
> > reversed without rebooting:
> > 
> >    # rmmod steal_governor
> >    # echo 0 > /sys/devices/system/cpu/cpu3/preferred
> >    # taskset -c 3 ./my_workload
> >    # echo 1 > /sys/devices/system/cpu/cpu3/preferred
> 
> My use-case (being a compiler optimization engineer) is to pin benchmarks to specific cores, and stop the system from using those cores even when the cores are idle.  This prevents L1/L2 cache pollution and makes performance numbers more stable.

Hi Maxim,

Thank you for the feedback.

I agree, this trick with pinning a workload to an non-preferred CPU
looks promising for benchmarking purposes, and probably for more.

I'm going to split this series to the cleanup and follow-up parts.
In the follow-up, I'll focus on this writable interface. I'll keep
you in CC there.

Thanks,
Yury
