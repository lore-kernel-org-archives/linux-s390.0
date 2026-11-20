Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188911;
	b=1aSK7Zp7L65RxN9OjbJRV5fNETsGpGnKlE0E/2FOz4G6Aqj19fhOi8D710kM6m6/zuMY
	 i9rMps7Hbx9HSlTKb5CnMbnM16/N6C2dtF26nMA6Myx0fAemaqCTJ04q8hoPoxB1h9a+2
	 xphaER/sqbi+jlCvGfmiCFzk1yDjLmtZG2wtCbpyy1MKPyUctZW0D+nd7dD5eUp6KF2Lc
	 wtL77fn/clEm+u3XpDRdTl61PlMBjcNSIKFikITb2+qF335idjdiujJi+CBJ52GbhyBR2
	 QTX1wqu6UizfgNuk6sYFih3uQMxkahZCQ70UQarfIGbFA+WiUuwvLzSDFD0eh9IhcoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188911;
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
	bh=pzJ5FaBnKq700uNv0cZWD3W5/BoQeKz+bkbPQH+4CL8=;
	b=xisswLc7qc+0I5cBRxEYGXyHZ78gA8SK9ETfsNrH2YKDuejmWTdVwKVKgWFWVsfvDtOv
	 y76LtEkhBMNheq1kDxYrbN+4hmqibFdNnWnoFt1fdQIvvCJjYsQcrQRYf5HaE/aidKjey
	 /uhwf8KqGk3SWma6BN7tHkpzRrGr+xOnfK/dNx+AHWT/fDgwjLQ/E0yl+iG3tKToMhDuK
	 oRjh3mjd/t5JwL90RcvqvviQtvp8iYjGHFuB2N3swdF701OTANZyVbGin6vLcLjSqOBqN
	 dsiEGGkwg3avvh0/8T/SJSx29SdN0S54qwfzEhqppRUBfysooG1uCfOIx5oGDkEFTPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sJUv1daV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.37
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C483606A320;
	Fri, 20 Nov 2026 15:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C483606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sJUv1daV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDzE7Et9rdRyskwzngrfaFicno9PqlATI3MMGFH8tTumHLABsGsbf/rSTyvY9N4xXAiyTD+A2iksjcg02grB8AbJGprfnPFSTG8s0JXGNleB75iaY3q3LuF0kPFbeuKdlnauI1XcjPcDNMfDf0eKCy6lN69B/lgQ7AOPtYynHsai3NETwRtJKRZ0hikvQYva43N983QxUmsh27mXGUjgT+Y8K0yKrL5PfRJ5kEsv49ohXJDTQO9S6AqVhRkAo5a69enr4tySzTWQB0DgbnPj+u7VNCfEFVmKI21vYnjlmILKYz+M0mTG4NkFZZkmh9fKqdIKD18ArvO84s6IPbtRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzJ5FaBnKq700uNv0cZWD3W5/BoQeKz+bkbPQH+4CL8=;
 b=MMxm7fYo78BEO+H54XcpLUl5SQ2kFAAyKXv1YCXaQj8qB3fcgaV4RTefs2RHSrfaj9gVHF3tXuoPxiEbKef8Csw+FCfvHRHSlsR5zvoDW+2owUfyYTwOj7yIrja25rR53ThVliIVENLXSVxd4inz7aWfwFhJmRDslG+G/kE/NvkrKs1ppeJwf+Se8uw1NAtzgEbZ/IyQrO7BmoukYSSvmiqIbI3R27FtOoyP+gM5G3tTE/q5n2X4h2BekA4+4VYyHIzVKIuLl5heHGpZQ2o4Rb+Z0Y9ec4D1HGntNmA83oqvnYgLYfccmaOFdBo2IZIEYQzLPH3eFjkfiEVpSxWu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzJ5FaBnKq700uNv0cZWD3W5/BoQeKz+bkbPQH+4CL8=;
 b=sJUv1daVYSQuAlYbLbstC4IDd4GdtnrNFI8udFy8b1e4TZPCU1ilh2On5X2gnncviA/XhpVlmtOUZ/1XZHnYTigt3se97CuA60GoE3tR0Db9c+/rHgwyIWAM6O+9D+yCLJNHav4CzcNVJF5Q+JVTOJ6BSkIDIxnq3bv849fp4wq0I+1KL0RhtRs4ePYaOiZSmunm+iu3aHzR9eX2FmgOwOQMTO5yDbV0hBQwx2lIPJsp4e3OUrffsy5y0pC9Su/U2WcD09qAL7xAKzihj1X8Sv9xddfliinPyPWtmDryoM5EqoC7eFaTcN1n5OVo388yVpTrMHlEDFnUojzn1TO/5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:35:03 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 15:35:03 +0000
Date: Fri, 20 Nov 2026 10:35:01 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU
 hotplug
Message-ID: <awBopXdhgUatAU9d@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-5-ynorov@nvidia.com>
 <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com>
 <av8oy9v9eLTL0dw8@yury>
 <38f8999a-f3e1-486f-870b-25710462308e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f8999a-f3e1-486f-870b-25710462308e@linux.ibm.com>
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS2PR12MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4ce023-ae7d-44b0-6b83-08df471bd831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261026140227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gbNsNo6hLboMpWkRLQjjh2AiNT6KAedFUrUjWuMuR1lhdzUQvLKCuYYD/J4CHOTlsV4LW6tmcCoivEs2i2MKMU00wTvcV1ivj9qjem+WUclREJ4KL3HYeEch3aAmH6CHnaXLTF29qXXVb0gLCQBXh+lIReaccfUWKHyRExB95H4yhS9q6BTQUOpOS+syxJVW+Nbx0hGiQ/dMj+GNUpc30H+zG7d3KYKTaTdLTm4ABpHlN9FkNoKrTC5sgF+C28ld3XP7qUb9yFv6+hjXSGQDaIHuT4zVd2/m0JjMyg2MkQw7W2eCCKMUqAfAf9668VtXoZ1pVx+ilUj5i+5YiuAYBi6SnipG66xFxcmeEBSxEw3mvhQrZy+9c+FsAKe/HsgvA0e1WIOSVPsX5CFeUn3wEKCkt2XcYesKKreYh3dTgE9DbhgK3EhzcPL04MoEe6tOS+FOOYaiwG6jf1hKNfvh2sNBQj04UNpA+2Yqf9eJsGpJ2jx303falJt7EPpZHYxh4sdPUEXSY7AkPfjHxVdyh7YorZ0UurQgkQJdW5fn0WCnvaEbcaUD79PEQC5fu9ZSluSaTrZLHAXkkNSsLJcNn+OxNBNAcvO7ot12v/4PW0kwZEtbGXjhizXPU9sP/ThVcN5TKLgYv//kjxjL3ixO1OrHRp6OlUf7e5StfR6+rkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5zrW6pFt8HkQl5Tg83MgGjYVJ3dSP8yetWT6iy9omUWhAxVKIyQdrl2gaQw?=
 =?us-ascii?Q?DQkaWrU2WyrKoLSX/WjnYMt2l1qmJvI1FKzIfg/Wts/S7Na5QyCmcyIQB6my?=
 =?us-ascii?Q?OxDuhRqrUhqiDvLmYrTKrwyf6UG1xI+CnkFtbLiqJX3HZxZlrnj+Orv2qyUI?=
 =?us-ascii?Q?ugaWiUXPLKM48EBx9/9wcKKG5d8lvbPUxoZcZikt+rsnRfh7YMhLXqds5eQY?=
 =?us-ascii?Q?U4eBcQttQVz9wFIiu95Qagr8tSSkYQNXXS8DRvmTO2XjbRYiww8F/5mUOx1e?=
 =?us-ascii?Q?TppWrVB1e8hce8yXxZZXH34ZMVbmPVFAXpbfXfPTbVKTwk452rQRAObOFooA?=
 =?us-ascii?Q?a6v96wjBE9Ba++9y5IylBmQlAQsDuNVkc5sQ43OvqNcnT72avbmL/WTEkr7C?=
 =?us-ascii?Q?q0GT8DzeR/2Hc8lNhfesoKG6cboS2WBz2G62UCLuRpPejqyMAgO/W1C5bOXy?=
 =?us-ascii?Q?/pgowhsfYYvmIQGUu3YZEQyj3r5zzpu/HU2fVbxb6YGxWJpDSg0+wnEuMt0N?=
 =?us-ascii?Q?PTi9sW3nOKh/w0at7UbkSHwR/13lH4Q/I/d9uygMHtuiPaLXrUTzFk/CsNrw?=
 =?us-ascii?Q?48DlaSYsaj3cOQQWdqQ6AQUtGPncvF5Dv2jtM6uPV7K4nfRGF3DpgcKmca9C?=
 =?us-ascii?Q?OksYs68qEL6aFjSJ4Re184nqadgUHRmVcskuKorIM1MwYBcVBWOI8vp4iNkl?=
 =?us-ascii?Q?6mPS72rNVvTe4yD01R7HAD4Fo6fPJj6icp9nYZ/xD8JbDriVGvLJkEMinc39?=
 =?us-ascii?Q?NJitSwnYyS9gG27eaJ4I38qP5BCzL+etFL3zTbsYOCuSl0m05eKqToe7A4f8?=
 =?us-ascii?Q?Z7PmJavIbOQD8j9n8VoyyXoTePTeieRRw7IkKGOBHYJn1uopWrY4CEoLOF3D?=
 =?us-ascii?Q?EOidYoGu8pjHTvcffcKH+DqWbyFR6QbAkExia4CUItQeW+63LeySxz7YQW54?=
 =?us-ascii?Q?vkabl78vyzyqDHNeoMZMQJOFv3Ko7coxndrmctKkMCcdNQr/mAmn89ff/W3D?=
 =?us-ascii?Q?xsiUNi5bHWgHpsmxNr5rjUMBoKqgNEfcQowN6eU3PiYUKlJmPVBJFFYHGd4D?=
 =?us-ascii?Q?0m6LFcemPqB9RSJ6USZ9JPlYWQYUFMIuy2Pelrze+EAP7ZaViqCI0Z43bLdf?=
 =?us-ascii?Q?8pHSignmorFcMv0WKQXog5wjXiuIncm26+2xUcbSAo7GYMqCRIwIKEkADfFL?=
 =?us-ascii?Q?Y8mMMp6YfLPDs7KZIEMrhhScwQBz74vdIVhhYThVJSP4zwHj4JISRtoBP3MU?=
 =?us-ascii?Q?q2GEjb9n/Rhq7cs5lwi4KJu19lHZe31avQA02YqCOhc4B2C0WagnWhkoSwl2?=
 =?us-ascii?Q?mUsQGQYHehcGVsqr3wn3U3NctfqCa+1WFXVqJDwLi/vqIK8Y/P21zBnvLRQt?=
 =?us-ascii?Q?x/b4yrwUx7fJo8Auo86o8Z+/puWYwAySNp9pjkVo173zVtxhV6I6jZdL5C6b?=
 =?us-ascii?Q?Ge8WpPG/n2JgPz0s+AJseRP2vPn8tK4vpUA1uJpJniIlIrCnYqb4Y7gYU/jJ?=
 =?us-ascii?Q?jfUnM9NHnp+GO86+pnXQmg7V0Bc+hSLSR9RdsU/paLl/KJqBC9LAHjKoV7W5?=
 =?us-ascii?Q?RrImXUPHd/+1hn4eR4s/VHc1h02KynT6TpQd1ONAnTNkL5sqkRHsbK4PmDKr?=
 =?us-ascii?Q?rXHqrhJV1c0/KstdfgE0JSrJeJsfWXhiWSEHuLJtqwAwrpIZP6u9rOe5AbxS?=
 =?us-ascii?Q?ignMR/ax5zuVVVLoKVUukh6iYB68mq4zQXucrnwbgj3hz+hP17CVTVOQi4Q7?=
 =?us-ascii?Q?iGqBaSFmbinBSvZHbW+zwtTwDCfFGFsjPbLVU5TfdMKRRi1sCWK+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4ce023-ae7d-44b0-6b83-08df471bd831
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:35:03.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib2Ps/3MTkej0l+Y5PfQrA2giL2W+FDrhd54mC01iU50MgnkXq26xpxgJfEKrP+ClEmc2UJVuH653jLSff8z/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637

On Fri, Nov 20, 2026 at 02:08:59PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 11/19/26 10:20 PM, Yury Norov wrote:
> > On Thu, Nov 19, 2026 at 11:52:19AM +0530, Shrikanth Hegde wrote:
> > > 
> > > 
> > > On 11/14/26 12:12 AM, Yury Norov wrote:
> > > > Steal governor is not safe against a concurrent CPU hotplug operation
> > > > because it can change active and preferred cpumasks during the governor
> > > > sampling.
> > > > 
> > > > To address the race, the governor would take the cpus_write_lock(). But
> > > > that may be impractical for the loadable module.
> > > > 
> > > > Instead, implement the following locking policy:
> > > > 
> > > >    - if the code takes cpus_write_lock(), it's enough to write-access
> > > >      the preferred cpumask;
> > > >    - if the code takes cpus_read_lock(), it must also take
> > > >      cpu_preferred_mutex in order to modify the preferred mask.
> > > > 
> > > > The core scheduler and hotplug paths already modify the preferred cpumask
> > > > under the cpus_write_lock(), so no change in core logic is required.
> > > > 
> > > > This provides a common update protocol for multiple policy drivers
> > > > without requiring writers to take the broader CPU hotplug write lock.
> > > > 
> > > 
> > > This is also necessary if there are multiple writers outside of core hotplug No?
> > > So should it go with the write interface series?
> > 
> > The race is real, and it's already there, so this is the fix for an
> > existing functionality.
> 
> At current, if there is hotplug, core takes cpus_write_lock to modify
> active/preferred which makes governor to wait.
> 
> If the governor is modifying the preferred mask it is taking the read lock
> which makes the hotplug core to wait before modifying active/preferred masks.
> 
> And there are no other infra modifying the preferred mask.
> Could you please explain where is race currently?

Initially, both masks contain CPUs {0,1}. No cpus_read_lock() held.
Steal ratio is within thresholds, so neither update helper runs.

Governor worker                         CPU hotplug
---------------                         -----------
preferred_cpus_valid():
  cpumask_empty(cpu_preferred_mask)
    -> false

  cpumask_subset(cpu_preferred_mask,
                 cpu_active_mask):
    load preferred word -> {0,1}

                                        cpus_write_lock()
                                        sched_cpu_deactivate(1):
                                          set_cpu_preferred(1, false)
                                          /* preferred={0} */
                                          set_cpu_active(1, false)
                                          /* active={0} */
                                        cpus_write_unlock()

    load active word -> {0}
    /* {0,1} is not a subset of {0} */
    return false

/* Useless and misleading */
restore_preferred_to_active();

/* Skips schedule_delayed_work(). */
return 
