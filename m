Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795191974;
	b=sn4C4jMSlLQy8hPwa8DjIQGrFK4Yk6prB5hxVbPcSnISLfMRKk7YD0YMU4Ls/UsfgA+r
	 CIbXxpBQTlR7wo6khFX8ASycmHF/fvE5vUmkjpfixIatikMtJ2kQ4rn7J497UCsn8ELi4
	 oE4ePvonaDjkO99hMaAYUT+1wZF0TShjNakLP3hKsvCH/VZJO4sRd0lLo7ITqZABy9pGl
	 WAdZG2oj8/rjLDVRrW8cBzndH/KgixQE+3muZ3gtTBg0aHeKMUgFyxtm5wmbx9313EsfO
	 CP09x8Hk/9EuNbStn3mJyF1o27y3OzsxrJipx8Nm9uHf4sC7KMPsj2S3M8UYeXyHQVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191974;
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
	bh=vKS/iM2nVL9PhooLH4dCW40smlNtl6BRn9buHx5Nl28=;
	b=v9uFyxNDK8DIdSEsubYEhbWSEkiRMWIP0FL62nQ4w5awNFeI6mijaozsVFJ4Cx/ddJwW
	 9jSXNhjlPSfk3ppfALt6rP1sbHCIKL6d/y5ss2BvPRz+mRgoWCAVrtCsl7RpcENyTmRID
	 SLqIo2xS16e5w+tFrrA6iAtYwY3inU5z4sNWB4Imb+nhbkzKt5r7mdj4sPEumn0YgiDHT
	 7wm5/fSERvckTgrO+I34bFHKt3Ds640rAyOWidzsWCw904l3KSMr0vtZXWuCW5Cge6Jjn
	 lW7RZG06/zlAY0VGJuyuPLqOpB4XRZ/Hm9QUKUfsMjAmGKwXDO3zL32bN3syOHsUsMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lWwHU6JD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.53
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3D606A334;
	Fri, 20 Nov 2026 16:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B3D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lWwHU6JD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqaxsylaw3Z7R3Y+N/tAvx0ReW+Gbj+Mj0IMNA+x1Et7XeZ3AMqj6p9D2GFYcZGSjx0DcU3vbrdXtXSxn8u8sVPWxN/3w8BI5yWz1N+C5d+q0+/g2ugj9nl28Y2jDgBi57ZTEyIHwYlnRVb/+wSAeWzY0snyH0TWpbFEUV5vckCLazd0DDvOn/pzfTsENhXEfXH+Nngqjx/dBkmfHkovHPQPNskncytP4VKq+b6QRp5l53WuUTd4J7c4zRROJTGRYXW5oFb3hWj0oLvD/jjHkLhrpu0mvmsJa5Ls0UGSuu9H6O8Rdw/JxKUghmOxksiDRrL3oG06GtnynmxhvZbT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKS/iM2nVL9PhooLH4dCW40smlNtl6BRn9buHx5Nl28=;
 b=ClVGWaW8CDBKjU4Gzua+sPC0vo3M8dSvBh1QXcVNToZZpWWAkfEu6XmEAk/rpOGa+jchTEfDOfjilSiurd5wO6avliHw9bIV3g02pOFGWosClq5KtUrIVZ4YRRiCw3pAl6SvE1EWM6iyZoGiCjD+C6+F+g+1xexXYTd0uGOLp/YlnuFIrNZA9KNnQwxv7xAXD+u1Du7FggAi6jyWl9P4J1skBshccaHJpuRXScRoo2qOkqYJvQ+Zd/ORey0DUsaJ9XCf1GZfYX87yj1eamf0BHFzU2MZ7irEDZPxgmZhhN0wYI6WLbmSnpA3kFCb/xlPHoYRLadOR5DDrT0cM5SfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKS/iM2nVL9PhooLH4dCW40smlNtl6BRn9buHx5Nl28=;
 b=lWwHU6JDkX4JIieQut4ynfCxYDhuivHoEHxalQaim7W9GWX5IT7Igez9EKmbSj6nQ/6LGcFW/0XIT3P8TCSH9rzimD3WhGjF4F91o/p2GCUEI4lNSZPJkqYoK4EKHN8nkOmscjuGNfO5ph5Q23ppEELv39j5nylYHZsQH8nfjxbabz7jQZ0mpQ0shMw8kYrYsgMdRmTGkXw/TFL+bBF3HCl9bQpDGrTZ054q+XhMc7VR02topmCZVuRIkDs2PAzDPXcbm6jPpavysrCnaS8BacFbw89Y+NwyYWTjVcqBpYYyffD9Xb061+rWVRvWCWB80XtSg3iCltySZCb+zK4UUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 16:25:59 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:25:59 +0000
Date: Fri, 20 Nov 2026 11:25:57 -0500
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
Message-ID: <awB0lRGLJnKli7jE@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
 <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
 <awBub4wgnTnsqL7i@yury>
 <20261120160957.GA2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120160957.GA2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e49374e0-9fc3-47e5-2420-08df4722f60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	C2FK0Az/RF4oyl9J5RV8mb4ytJFR56oP3e+CYsohQypgrN/aiLojwXN1Vq1gxUQwXqpMe5tb+/S6W1H3TSgVuY3yRS9NKBCG66MqbbfXEeCOQl72Y94NCp+OElkoAC4/vkSgC/yPaDIuq9qD7W0CeSinFR3kB7hkuVQhbgE182+hUfQoybCTsZuWsW8wD4Q29JsjoWI3DNu8lxyckqwuBzVMdyBp/P5+0qc38ZNkQmCkJnF6Fa7n1GS4OFx8j/E8V8W5np5i65qDAKj4CU2Pqcsal6yODnlPYHJ9n6TJ4UUOObHQEH2WTOXvo8z0LUDOlHVk77SVk3DFq61aJgzLA4KvQbzeAcSzj0hFFT0pxbvtDyXIMhgwn+Y1h1cCLgcMCrArSpDIZI3xgrqVCZaIh09wtUYzDVZvMLPsA+GxG26Zb+QJEFBbw0srU3tNL0YFu9tU8tLrqddMwQVHh1PCcEthfE5gG9pO6usychaNRdRnu6x2TQd8xE5EcOcbzXhqLr1FGCV+3nEevl/bfSUUTMQZ4qrHmIR35aHBgcRd1kBzZMc9n4YXXf1RcE7Aw6n+wgUDQxkTlT7hI/MqJLSPVe6HfkpelAwacc5k0xzvsPBbiFS+5A/cWQj3gUJ8psEvWOzphyiUH24L2SLj1noQ0CmbIvukOqCLW1N4mi7YDbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09mNe5VwOV61fDdpAK4ihRnMVFdyyeld1fNL4Se1VYVAf9DMXPgcf27TIcWF?=
 =?us-ascii?Q?7fvLmNXkdho8O7SxjX863nao6KvzZQ2I045T0TFk8ssVRqXHga77RFr7ivje?=
 =?us-ascii?Q?2p+9iiwmxCjJMy+usGwtg8xjQGW7zXzWou2JQBZCjPPk0+DhO6s+PwYPWbFd?=
 =?us-ascii?Q?JiRWIl5jZOZc3xsfRBndc1yaS6dvKIvEMYkvYL6Q4+Ee9/oFBUE/tsbwwh/L?=
 =?us-ascii?Q?CHk8gBwnWa1a1cvGmDEBzOnck5F5lvyDSHYfL3npdRQx1gpympvQTVzPyAN0?=
 =?us-ascii?Q?cHD0tPURjpe73aCZx1J01WEflRdHR+aiir0RKRIMe8LioCyBwiZiCGQPw3mA?=
 =?us-ascii?Q?WCPxsUxo8n2pzKyKQfgC2RZwFVrdmMpYuhBUjR2gesrWsznFJH/zZgVGJLkK?=
 =?us-ascii?Q?k2SmtAZdB3sXW1kOdMUffEJmyMYtGIyxhMsWiarsEk+QnJs098MbLEAPpcOR?=
 =?us-ascii?Q?mrqmx9pvYtCK/+QBack5SG3Fat5TUIx5XMv5ioUshTJBZKU8IzN8RzE3qgI4?=
 =?us-ascii?Q?kl5mT4mUhtMiL2c3iSM5HczbkW3LB1/OYKBWMjsk5PFaxthwAvDwkwaWJa2C?=
 =?us-ascii?Q?g9W0KRBpPxHeWdkeGg/8nbn3Yib4NZ7o8UcF7Pre0BeEsbKCRRO4Kx3+05au?=
 =?us-ascii?Q?WA5VMdZJh/iieBmtdWZtLJdBHHwYyMFxPTV/Ax5rpnUaFMwIAfVwuN8P1tBY?=
 =?us-ascii?Q?DvsqrfnWvOdhgRqqMEXPaCTHKVk2qNFdshExUU1meymuE1v+rqlyDF/iEEoE?=
 =?us-ascii?Q?fWUvpwr+W3hTl5qBXlWN/8LfOazBe6nw8gjGR4USBpeyEK1zPljWvj0pWm3K?=
 =?us-ascii?Q?KJYroC/xujgVRJ0UHb8gOJzzyIsRYru+4T6r9140vGuE3CM4w2svZlcKaVoB?=
 =?us-ascii?Q?kYrZF/x1o0Jlc0tJ/WfqrXORNVpm2weN66fWw/0ZcVr28XUr6yjKwJqvsnrH?=
 =?us-ascii?Q?U2YKTPFKMpLbXRUsVA/rvHX1Nx5+LshOOiDcXIGe9gji4sZGfqTCQqOE5Dkx?=
 =?us-ascii?Q?6UGhAaigD+/QIMVLnm9eJ0SS1tFcTXi/cyshICObIrG1dHx4M5ni1PAJ1qRW?=
 =?us-ascii?Q?gXt+PstgisDBT0hVBPmcjtuf8jOEYnTHhZE5bsr1JFc4JxjKBiq+c9uxen1Z?=
 =?us-ascii?Q?aMdnzDgjm/ES/9/Xg1NYrwShYNVdelNQUhq3I7FsT4N6VEMmPCHyEy16H1Sh?=
 =?us-ascii?Q?bslCJyqqjBK5bxpWSmznbxm7aza5OENhWK2sKVjC8gpmNhLPkMeOEeKXehoI?=
 =?us-ascii?Q?VujHWQtRGjrG5AuL7KZnJGcURrPRpY/G8O4o8lCAq7d1R/j3AI+XeYgV1HBd?=
 =?us-ascii?Q?1xWmJLx7Zj/LdV54B5I7OSNVRuMdcDOtfhXwHbRbseeSTR6q+jFhT1ole+lV?=
 =?us-ascii?Q?h+W4qoh5Ch4OsYG8uHZItw5EF1HCgc0xKzdkjuZSJTjaROweZacG8kTO4kRL?=
 =?us-ascii?Q?R+fGUSjZftFGgeiXFbxsnWcbOJZ1Py2vcXqlLnx82a34oMY/R1Rgs9XBFDR7?=
 =?us-ascii?Q?ReW6EDoHRxQVfo100Ud2t+jnzI01U8yz8yHbcf5zRKTY7YVBa+/6heIpcbtM?=
 =?us-ascii?Q?5uUnaby+PnM+gygqY39UHF9WTTEPoBofCUOOED2tn5mVjElitSANbCytab2c?=
 =?us-ascii?Q?SNGOU+Yx17uPuye11tEg5rdlClVBsos6/YS894PhXV1Inq9caKc36kHRp3cy?=
 =?us-ascii?Q?eI95lFrTAaNWv3+COTSp+3ux+gtsy740TWHfob1lubkqsPKK7LnWz3WV/ZMw?=
 =?us-ascii?Q?QWXtjl0A/AUl+F2BmQh0WHXrtkoY7v1VyjIOUWgGpJnlccTeVEaU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49374e0-9fc3-47e5-2420-08df4722f60f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:25:59.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uti28Pn4b3FsCoHDpg1otnX4LJkvMVPo9aj0p2Z0xWIlnSQGvUX2uWs/3a1id1qsOPR90NpjMqhWEpb6rwUeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

On Fri, Nov 20, 2026 at 05:09:57PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 10:59:43AM -0500, Yury Norov wrote:
> > On Fri, Nov 20, 2026 at 04:38:51PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 13, 2026 at 01:42:56PM -0500, Yury Norov wrote:
> > > > Serializing preferred mask updates still lets competing policy drivers
> > > > repeatedly override each other's selections.
> > > 
> > > Competing controllers is not going to happen.
> > 
> > That's the purpose of this patch. You can't stop people writing
> > alternative controllers,
> 
> Why not? As I said last time; the whole scheme is co-operative, it
> relies on all guests doing the same thing.

The whole scheme is co-operative so far. I'm experimenting with
cgroups right now to teach the host to catch and punish cheaters.

Throttling may be driven by a different type of control signal,
like [1] does for overheating, or a mix of signals.

Even for the current steal time scheme, one may want to implement
their own controller, for example built into their driver.
