Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192006;
	b=BSCbPSXyNTj1R8K9Ff/A/UffIMbf3QIKFJA1Ohmo33XNPMHKAv7t+hucMep5X+phUkpO
	 L/fdPuU8U3nUw/ImbjTWaxVWKfxysPknPPTNuy6aDQMHyuhMSrj4w87wN/4QRmQdsm+Sm
	 hZHgaHXhu18Yu31IG44n6gDJUzDP97UjHAnFgjBW+bxqptJVfh8EwyQGOoiJigG2NZM5E
	 OxP5Qf4Se6Jlyzopn8WCpipEyMvT3gyvyeKPn1TmkBeQs/FPF7TAYuVXTXCQfIEQZmN4e
	 Ewr3N5RZMhAoSA1M54US0L6VsrI1z3G4CTLt2LPXc01Ntz5zk87bLpiNLsABcbgHvlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192006;
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
	bh=jDiCL2p+DGO4vDl3jTBUIdV9E0lCov1HeZdKNXK4Qj0=;
	b=HJ8u7TAPZBtcT7HHpBLvG4xaE+YFMSIE6hlaXk4IlvnpuMlqtjk/fSQFX54Gs7V+dPzA
	 6qcXfGzbHmLARTv2BxD4gmXQWQtcbfZ2IAzs28wTurcFHQgHsjKKCorin7sTTCK8DX4ZY
	 /OdR+AbfY0rfGy+nFQjYDqh9NNFh46DKib3f5ngzo5HUjsX3N8v3K/emIsnrVx7YIZDWE
	 CrCuf8gBB+hoidywqN1FW08gb44sB2N1UTNqJGNlIs8uobxJ97Q6iQpfvGu9fMI942Sgb
	 f0xuuZQXLUtM8BTR91aNmG+s7eNDakcgOI4+Azfm5WRtB2YAPgJAS6Ij54kyvZJn/Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WnOc+3vj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.40
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF914606A32A;
	Fri, 20 Nov 2026 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF914606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WnOc+3vj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP8w4n+eGSsQz5/OvcE8sDU7HjNLT6uVq4E0CEutQkKoD+pjKWveiDM5RwH8B3UQ8g5vVzfmrjSvpiltdxyK30+OAwFRQ0r9l6vMBoaX7i9TF6Uzph7ZYhwdFMs43F1dRk3xIT+FPFITbQtRZYUR/rPk8jPt8wGnDpE4cOmyuUEZ0Huu0GiAclPalE5d1CQ7PgQvlft57itEq8CSpHMLWYkejWj9KhHmFOcBnbMcaszTzX615IgFbS5ATuNQvxKwUt496axKVIWHRYC0670jbyYo6OmgjR/UFQyZaugM74rl4RpXqGGYHErqebA4gADOKCeKHyG4Q/VPS3QwbiiRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDiCL2p+DGO4vDl3jTBUIdV9E0lCov1HeZdKNXK4Qj0=;
 b=O4Op7s/NsLhLtt1jJ4+SkDPPOd9L1MQFMXxT8q9vCsKWGaaUiJ8GWpciOFcuLWOAPlO5LqVE/KNj9mJHZPO8vddHyYBqdSraLGyh8czUy+Oxf88hOSpYDl27lkgdSqoMPi/mU3jc+2SHrGVoJiJPeYnwCwkhUOBEHAgkyPsIf/wnjeGeUh7CSMehQJH5RdrEf+19B4uDVMqwUEJ2B0JR12O+WVFgY5XT8OVqKjToF+W/zLCVUprb8mmcUPGofANBaP0b0g6QLKBUQRePod2Tii6wyv4IGCnXL09AT1Kh5CKeQmhLbx92af1LSFjbVDT9Q2BFi3aviLimlqW3bwL+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDiCL2p+DGO4vDl3jTBUIdV9E0lCov1HeZdKNXK4Qj0=;
 b=WnOc+3vj36fhYJH1TYwOILzgiKcuyMViHnFCcgbsyGsOSDXhvASaLMxm9JoOVCM3hq5Nt8HmHdjJsHFd/2RGcn75KCnxRyir7cSGhDYO3sB1/1DHfGdy2palxiEyrvSakcIvSa9rWzJM9zFnXNKn8v0Tzl+Z5my/unDQUUqcbt9aqCDcEAbKWJHjmZjr451NhqiPsQZqA9vJwRFYL0jfF2n0GCXPYYIZDcrJnYLHx+YqG4mKbcvzR3RUcPmZWKcnUabv7JvuK9CJupmFPMqdJaU9l2Jgi6T8HPvsOmBajuo4SPRFFaZPKJk9xkG4YT6HG9AcQZ3dlnSkqYyy+00swg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 16:26:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:26:37 +0000
Date: Fri, 20 Nov 2026 11:26:35 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
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
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
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
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
Message-ID: <awB0uzaEEIuEb92m@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
 <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
 <awBub4wgnTnsqL7i@yury>
 <20261120160957.GA2668564@noisy.programming.kicks-ass.net>
 <awB0lRGLJnKli7jE@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awB0lRGLJnKli7jE@yury>
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: e9591a8c-78f8-4d2f-0679-08df47230cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lKJwBnZaSpcMqoOBMb59GvZIdgG1Vyh9Or5PyB94Jf9qKTO+3VFYMbGSr/DjAnA5bQMdFpVox5PuxkOPO3xm0AHKgrdklzlq187TL/0ZI4xjc/ogl7S5z+ThNa/0IYWOQ/BorFrF6zQUo8cA2b9fuONDfscWyHzN8FGAaf20g5O5zrn36Z1aCAQkAxhsjCQ4KD50ZK/jc9231F/0TlfMl/JLcRceKRcvMl/8iUgwPDhjl3MBsRRwsAKpS/8eTkF9u7a3mqUVorHjsIJn+xtcNyjGHA469NPQM9OEtxyl4uHT2NYu8eRctenBfzo+3lS9GdSznaFB7xciQfEW0NJvEDWMGPAb54lPSDpmJYygfglR9e/LmJesW/CguDBleKl5f+28gxUouDfFqJDMQWn+SZpFRpiTlZE+zfd2cfLzwhIItEnvXh6lEyO15Q0noEwJbghqVrfxmxbCCF3dewbNWWrrayDec3BXIIxABOABSxIuBsRRf+bXoAePGTgJdW5KQT6LpYC2nAihTfrHhJ13U66BmVrRptZr6yewaO1U4S25dbmeU/x/5AnNQlmNirEvl3gQsDBoLIxkkWpOBGZ71EgBJZ9kPdgk9ZyrE5cadhbRISNIZAK6dt6Zb0Itwt26Ip6jKq3cx09wNSfXk92PNVSq8gshkPvA2YxhMc6C3QY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYbCs+KwnfHnkUPqAqiWU5cbvPwk3NcsdyoCAHoDeK6iIxOBqtGZC2l22yxS?=
 =?us-ascii?Q?HvZl9h9DhCUgZzHKA6Y643LyNOVEKR4VdWdOOdKuNwQXb4PR5L8bYr+HUTOI?=
 =?us-ascii?Q?cSe6rnNzT3btj5rx9t3qJADr/urPitWWtmAla3DcyxfUXNpsn30U966mz+He?=
 =?us-ascii?Q?/YreY86eyg3b1LicGgrep/MuieMQ1EG8PNimRXNlP3jvlFBrkCgWwCLfS81o?=
 =?us-ascii?Q?GpWJSUeDXKDXdUXBr7c/SWTLZ2RZ6pGgMlIuMI62TY/yUacFJ8UsbkG2SYPr?=
 =?us-ascii?Q?o9khpVuSmcWW1aSzpqKKJdRnPdaRxIR9LJY/i+VXioN9sEiyCI/V31VGw/bK?=
 =?us-ascii?Q?rkTve75f5tR6LoLCITk8CCCsDkl8HUal6SY8vOC7Ql2kwgaeAidADLGkyWsM?=
 =?us-ascii?Q?wf3T2Z+AFwkLmQBt5i4EWqVJl/KNLeAxM5siDTdYMLrlix8Kmr4f/mNllAsC?=
 =?us-ascii?Q?WQXy+5l0twsx78SsSpU2gBfE7z8zkaKw5uy3v0fpV/rFiaTl1SRRRgfTBfym?=
 =?us-ascii?Q?56dZsSeFhUJvSCqczP0eVtOCCICGWHqpAP3eDJyG5p+hONSZ21Jy8/1lQO/k?=
 =?us-ascii?Q?KHHQ2PNge3v1ze72bfhOxtrQoKvF2PTOKkgucQYPK3+2f9k7dQhky39nlVT9?=
 =?us-ascii?Q?2MPznSI0SJZm6Xw6HPDMhs2CDfqs5JBO/zCLAE5I1mAV5m0g90Zhcckk96WL?=
 =?us-ascii?Q?W/fBTyCGZ63sKwqRAEdN6m27TwHtqFeIaHt2FDjKLxr9GhfjSourU4c97870?=
 =?us-ascii?Q?uSvLjDiw8bAuKTFzW715q7xJMrKPKeT+pCJWYjV3hzufdHxAEs/d7Z/CgLS7?=
 =?us-ascii?Q?48NeXueWi8xXAZ8RB5umt4udSchlEx6OruCQaCjeIfcniquhDk5uFxGOAqVg?=
 =?us-ascii?Q?zUKQst3A3nLK4MM0RTzPJU1bAjlZVlTJcMEexvAOL+iVWEcg/OEwsSQ51Gd+?=
 =?us-ascii?Q?gsQW+nCiNWEm4X+gnE6Q0dHX2CvvozDCEZCh9pCI4K43NltjOMbTppIvXO2t?=
 =?us-ascii?Q?x/0LItlkuOGi4aJrubybtoumrnvdulPk3rZmT+GDVTiVwhMLr8uWGT+Y6AIV?=
 =?us-ascii?Q?KrApiYPwdhVpczVuZ1ti6WIRPR8tV09159ajvIhFoH00SASQweSc6IAKy9Ya?=
 =?us-ascii?Q?WcSyUSDNFr6qJVuNGX7lBWTW/lw4ZFcj8j8RvSMy3XQw1e/1IwCMo8Z1lVr5?=
 =?us-ascii?Q?ttpTlOjsPpbxGJp6E7yeBLwjiq7a3ai10V8PavIC2mEmhkd+7YqowO11prNS?=
 =?us-ascii?Q?wxsM3doBW+VTG78kqyjRuA5vBAPVxIj0kMaJ6UONru8hj4/YntPRVOCL/SKh?=
 =?us-ascii?Q?djVEGiksjnqaCMrxHibOVzBdU4SwPC+hi/r+uavB7wMjQx9MZEHQ+X1JExfU?=
 =?us-ascii?Q?e+HxqZbJzqi74hsy8sSqYMKj57Fu49tShEwlIc19gwWMNcTsukdm29bjXriH?=
 =?us-ascii?Q?WrUzLuSyizv5k/xWmWgzDP7YIm3Og6aYhVWL6DfGolKtUNcbOCPdSmojjoCp?=
 =?us-ascii?Q?JwSW3qykiPYrydMd84v821DBcl81M1Pd+mxsiSgZve8THSuVwqYlHkrjluec?=
 =?us-ascii?Q?yO3PQAWcvJcZEqS6zTgfjGWZhRVYnn0aAXEwP1cV6oAXEv6c20geq5G+t/hH?=
 =?us-ascii?Q?nggYJF39mOaLz8RvFrO8NkcnEv9hHjNDaTBtEprNSbzwPKXvBsi1sApFQl/0?=
 =?us-ascii?Q?zleZTdg2fRTul7MMynIfNDQ0eTjZiBK8Uuz5Ox7UZyorCuljC0cwr7D3yuk2?=
 =?us-ascii?Q?+ACmtOsOGM+2ojd56B0qZqhT8oQx+0dZ3LaC5xiicSKpOYO5feU3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9591a8c-78f8-4d2f-0679-08df47230cbf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:26:37.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjRraDULBIAr3lFXXYsL05NYKgP+XwXpHxhY1K6kre1EPS4uZHsJ4942QyUBiB6hfIFsEKCXivt9mFc8tS0YCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

On Fri, Nov 20, 2026 at 11:25:57AM -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 05:09:57PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2026 at 10:59:43AM -0500, Yury Norov wrote:
> > > On Fri, Nov 20, 2026 at 04:38:51PM +0100, Peter Zijlstra wrote:
> > > > On Fri, Nov 13, 2026 at 01:42:56PM -0500, Yury Norov wrote:
> > > > > Serializing preferred mask updates still lets competing policy drivers
> > > > > repeatedly override each other's selections.
> > > > 
> > > > Competing controllers is not going to happen.
> > > 
> > > That's the purpose of this patch. You can't stop people writing
> > > alternative controllers,
> > 
> > Why not? As I said last time; the whole scheme is co-operative, it
> > relies on all guests doing the same thing.
> 
> The whole scheme is co-operative so far. I'm experimenting with
> cgroups right now to teach the host to catch and punish cheaters.
> 
> Throttling may be driven by a different type of control signal,
> like [1] does for overheating, or a mix of signals.
> 
> Even for the current steal time scheme, one may want to implement
> their own controller, for example built into their driver.

[1] https://lore.kernel.org/all/20261117022542.863028-1-ynorov@nvidia.com/
